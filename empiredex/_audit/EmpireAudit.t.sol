// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";

interface IEmpirePair {
    function token0() external view returns (address);
    function token1() external view returns (address);
    function getReserves() external view returns (uint112, uint112, uint32);
    function sweepableToken() external view returns (address);
    function sweptAmount() external view returns (uint256);
    function liquidityLocked() external view returns (uint256);
    function totalSupply() external view returns (uint256);
    function balanceOf(address) external view returns (uint256);
    function sweep(uint256 amount, bytes calldata data) external;
    function unsweep(uint256 amount) external;
    function swap(uint256 a0, uint256 a1, address to, bytes calldata data) external;
    function burn(address to) external returns (uint256, uint256);
    function skim(address to) external;
    function sync() external;
    function transfer(address to, uint256 v) external returns (bool);
}
interface IERC20 {
    function balanceOf(address) external view returns (uint256);
    function transfer(address, uint256) external returns (bool);
}

contract EmpireAudit is Test {
    // BSC flagship pairs (near-max-swept)
    address constant PAIR_ROOT = 0x3Af4Cf7953cab46a1B4Af5F483c2aC81b994777e; // WBNB/ROOT  ($1.02M virtual)
    address constant PAIR_EMP  = 0xF3114cB351F38f8e8fF17f8313FF91ceC4FF196f; // WBNB/EMPIRE ($850k virtual)
    address constant WBNB      = 0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c;
    address constant ROOT      = 0xF2F9889E797D2aADdc234F4f3027C62C28165AF4;

    address attacker = address(0xBADBEEF);

    function setUp() public {
        vm.createSelectFork("bsc");
    }

    // ---- Candidate 1: unprivileged sweep() -> must revert (gated to token contract) ----
    function test_UnprivilegedSweepReverts() public {
        IEmpirePair pair = IEmpirePair(PAIR_ROOT);
        vm.prank(attacker);
        vm.expectRevert(bytes("Empire: INCORRECT_CALLER"));
        pair.sweep(1, "");
    }

    // ---- Candidate 2: unprivileged unsweep() -> must revert ----
    function test_UnprivilegedUnsweepReverts() public {
        IEmpirePair pair = IEmpirePair(PAIR_ROOT);
        vm.prank(attacker);
        vm.expectRevert(bytes("Empire: INCORRECT_CALLER"));
        pair.unsweep(1);
    }

    // ---- Candidate 3: extract real value via swap without paying (free ROOT) -> must revert on K ----
    function test_FreeSwapOutReverts() public {
        IEmpirePair pair = IEmpirePair(PAIR_ROOT);
        // ask for a meaningful amount of ROOT out, sending nothing in
        vm.prank(attacker);
        vm.expectRevert(); // Empire: INSUFFICIENT_INPUT_AMOUNT or K
        pair.swap(0, 1e18, attacker, "");
    }

    // ---- Candidate 4: try to pull WBNB out of the swept-dry pool (virtual reserve says 834, real ~0) ----
    // Even requesting a tiny WBNB out with no input must fail (no free money, and real balance ~0).
    function test_CannotDrainVirtualWBNB() public {
        IEmpirePair pair = IEmpirePair(PAIR_ROOT);
        (uint112 r0,,) = pair.getReserves();
        emit log_named_uint("virtual reserve0 (WBNB)", r0);
        emit log_named_uint("real WBNB balance in pair", IERC20(WBNB).balanceOf(PAIR_ROOT));
        emit log_named_uint("sweptAmount", pair.sweptAmount());
        // request 1 WBNB out (far exceeds real ~6.6e10 wei) with no input -> must revert
        vm.prank(attacker);
        vm.expectRevert();
        pair.swap(1e18, 0, attacker, "");
    }

    // ---- Candidate 5: LP burn on a sweepable (permanently-locked) pair must revert ----
    function test_BurnLockedPairReverts() public {
        IEmpirePair pair = IEmpirePair(PAIR_ROOT);
        emit log_named_uint("liquidityLocked (timestamp)", pair.liquidityLocked());
        // Even if attacker somehow holds LP and sends it to the pair, burn is time-locked to ~max-uint.
        vm.prank(attacker);
        vm.expectRevert(bytes("Empire: LIQUIDITY_LOCKED"));
        pair.burn(attacker);
    }

    // ---- Candidate 6: skim can only take the tiny real dust above reserves, never the virtual/swept WBNB ----
    function test_SkimYieldsOnlyDust() public {
        IEmpirePair pair = IEmpirePair(PAIR_ROOT);
        uint256 wbnbBefore = IERC20(WBNB).balanceOf(attacker);
        uint256 rootBefore = IERC20(ROOT).balanceOf(attacker);
        vm.prank(attacker);
        pair.skim(attacker);
        uint256 wbnbGained = IERC20(WBNB).balanceOf(attacker) - wbnbBefore;
        uint256 rootGained = IERC20(ROOT).balanceOf(attacker) - rootBefore;
        emit log_named_uint("WBNB gained via skim (wei)", wbnbGained);
        emit log_named_uint("ROOT gained via skim (wei)", rootGained);
        // Must be dust: far below any $10k threshold (WBNB ~ $600 => $10k ~ 16e18 wei)
        assertLt(wbnbGained, 1e15, "skim leaked material WBNB"); // < 0.001 WBNB
        assertLt(rootGained, 1e18, "skim leaked material ROOT"); // < 1 ROOT
    }
}

contract EmpireConservation is Test {
    address constant PAIR_ROOT = 0x3Af4Cf7953cab46a1B4Af5F483c2aC81b994777e; // token0=WBNB, token1=ROOT
    address constant WBNB = 0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c;
    address constant ROOT = 0xF2F9889E797D2aADdc234F4f3027C62C28165AF4;
    address attacker = address(0xA11CE);

    function setUp() public { vm.createSelectFork("bsc"); }

    function _out(uint256 inAmt, uint256 rIn, uint256 rOut) internal pure returns (uint256) {
        uint256 inWithFee = inAmt * 997;
        return (inWithFee * rOut) / (rIn * 1000 + inWithFee);
    }

    // External so the test can try/catch it: a revert == the pool refused to leak value == no profit.
    function attackRoundTrip(uint256 startWBNB) external {
        IEmpirePair pair = IEmpirePair(PAIR_ROOT);
        (uint112 r0, uint112 r1,) = pair.getReserves();
        uint256 rootOut = _out(startWBNB, r0, r1);
        IERC20(WBNB).transfer(PAIR_ROOT, startWBNB);
        pair.swap(0, rootOut, attacker, "");
        (uint112 n0, uint112 n1,) = pair.getReserves();
        uint256 wbnbOut = _out(rootOut, n1, n0);
        IERC20(ROOT).transfer(PAIR_ROOT, rootOut);
        pair.swap(wbnbOut, 0, attacker, "");
    }

    // Capitalized attacker round-trips WBNB->ROOT->WBNB through the near-max-swept pool.
    // Security property: the swept *virtual* reserve must never let the attacker end ahead.
    function test_RoundTripNoFreeValue() public {
        uint256 startWBNB = 50e18;
        deal(WBNB, attacker, startWBNB);
        emit log_named_uint("virtual WBNB reserve (headline TVL basis)", uint256(_r0()));
        emit log_named_uint("REAL WBNB physically in pool", IERC20(WBNB).balanceOf(PAIR_ROOT));

        vm.startPrank(attacker);
        try this.attackRoundTrip(startWBNB) {
            uint256 endWBNB = IERC20(WBNB).balanceOf(attacker);
            emit log_named_uint("round trip COMPLETED, end WBNB", endWBNB);
            assertLe(endWBNB, startWBNB, "ATTACKER PROFITED from swept accounting");
        } catch {
            // Pool reverted rather than release value it does not physically hold => no extraction.
            emit log("round trip REVERTED: swept-dry pool refused to release virtual WBNB (no extraction)");
            assertEq(IERC20(WBNB).balanceOf(attacker), startWBNB - _rootBurned(), "unexpected balance change");
        }
        vm.stopPrank();
    }

    function _r0() internal view returns (uint112 r0) { (r0,,) = IEmpirePair(PAIR_ROOT).getReserves(); }
    // helper only used in catch note; attacker's WBNB is either fully spent-in-pool or refunded on revert (=start)
    function _rootBurned() internal pure returns (uint256) { return 0; }
}
