# DEX-token contract — CRODEX (Cronos)

- **Address:** `0xc83859C413a6bA5ca1620cD876c7E33a232c1C34`
- **Chain:** Cronos
- **Explorer:** https://cronoscan.com/address/0xc83859C413a6bA5ca1620cD876c7E33a232c1C34
- **On-chain `symbol()`:** `CRODEX` (matches EmpireDEX docs' "CRODEX" ticker; this is the CREATE2 vanity-address deployment shared with EMPIRE(BSC)/FDEX(Fantom)/ADEX(Avalanche)/PDEX(Polygon)/XDEX(xDai) — same address, independent per-chain state)
- **Contract type:** `Empire` — the chain-native LGE ("Liquidity Generation Event") + fair-launch token contract (`ERC20` + `Ownable`), same family as `Empire.sol` in the `Prism-Network-io/empiredex` GitHub repo, compiled per-chain with that chain's wrapped-native-coin address and the same team/treasury constants hard-coded in.
- **Discovered via:** this address appears as `token1` in `../pair-cronos-wcro-crodex-0xc8c0ad6b/` (a $10k+ included pair), and independently as the multi-chain CREATE2 token address published in `empire-dex.readthedocs.io/en/latest/empire_token.html` and `multichain.html`.

## Why this contract is included (it is not one of the 10 threshold pairs)

Most instances of this same multi-chain token contract were checked and **dropped** for holding under $10k in un-claimed LGE proceeds (BSC ~$4,422, Avalanche ~$36, xDai ~$42 — see the main README's "Dropped contracts" section). The **Cronos instance is different**: it still directly holds (`balanceOf`, i.e. literal ERC-20 custody, not merely influence) **65,728.07 of the 66,284.09 total LP tokens (99.16%) of its own `WCRO/CRODEX` pair** (`../pair-cronos-wcro-crodex-0xc8c0ad6b/`), i.e. almost the entire liquidity pool's LP supply for that pair has never been claimed out of the launch contract.

- LP tokens held (raw): `65728074165824007115393` (`../_evidence/custody_check.json`, key `CRODEX/WCRO-CRONOS`)
- Pair LP total supply (raw): `66284089946230686708596`
- Share held: **99.1612%**
- Underlying pair TVL: $61,706.73 (`../pair-cronos-wcro-crodex-0xc8c0ad6b/NOTES.md`)
- **Value controlled by this token contract via its LP holding: ≈ $61,189.11**
- Also holds 247.90 of its own CRODEX supply (self-`balanceOf`, the unclaimed 2.5% LGE bonus-token allocation), worth a few dollars at current pricing — immaterial on its own.

**This is a "controls" relationship, not additional TVL** — the $61,189 is a subset of the $61,706.73 already counted in the `WCRO/CRODEX` pair's own balance (the underlying WCRO/CRODEX reserves physically sit in the pair contract; this token contract merely holds the LP-token claim on ~99% of them). It is **not added again** to this review's coverage sum, but it is reported here because it demonstrates exactly the kind of "deprecated/stale, still holding funds" contract this review was asked to catch beyond what DefiLlama's pool-level TVL tracking would surface on its own: DefiLlama has no visibility into *who* holds a pair's LP tokens, only into the pair's own reserves.

## Role / callable-surface classification

**funded-but-inert** (from the perspective of this specific holding — this contract is not being actively drained or actively administering the LP it holds; the LP simply sits unclaimed) with an **admin/owner-callable surface** for its own token-level operations (see below), and **user-callable** `claim()` for the LGE participants it still owes tokens/LP to.

## Verification status: DECOMPILED-heimdall

No free/keyless Cronos explorer API was reachable from this environment (see the main README's COULD-NOT-ENUMERATE section). Decompiled with `heimdall-rs v0.9.2` → `./decompiled/decompiled.sol` + `./decompiled/abi.json`. This is a machine decompilation of the deployed bytecode, not verified source; cross-referenced against the `Empire.sol` source obtained from the `Prism-Network-io/empiredex` GitHub repository (same author/project) for interpretation, but that GitHub source is **not** itself a verification of this specific bytecode and is not presented as such.

## Key functions (per the `Empire.sol` reference source / decompiled selectors)

Owner-gated (`onlyOwner`, current `owner()` = `0xf8F595b5Fd17D4c64f5DfE5ed4c32B8e15e198FD` per live `owner()` read — **not renounced**):
- `beginLGE(factory)` — starts the 14-day fundraise, creates the native-coin pair
- `complete()` — ends the sale, splits 4%/3%/3% fees to team/omniscia/marketing, mints 6000 tokens as LP against the raised native coin, deposits it into the pair, mints team/bonus/reward-treasury allocations
- `extractFutureRewards(address to, uint amount)` — moves tokens out of `REWARD_TREASURY`'s pre-minted allocation, no timelock
- `sweep(uint amount, bytes data)` / `unsweep(uint amount)` — calls the paired `EmpirePair`'s sweep mechanism (see `../pair-cronos-wcro-crodex-0xc8c0ad6b/NOTES.md`)

User-callable:
- `deposit()` (payable, only during the sale window) / `claim()` — this is the function LGE participants who never claimed would still need to call to withdraw their pro-rata LP + bonus tokens out of this contract
- Standard ERC-20 `transfer`/`transferFrom` (both apply a 0.1% burn fee unless one side is the token's own native-coin pair)

## Proxy relationships

None — not upgradeable (EIP-1967 slots empty, spot-checked on this exact address).

## Dependencies / external calls

- The paired `EmpirePair` contract (`../pair-cronos-wcro-crodex-0xc8c0ad6b/`) — `mint`/`sweep`/`unsweep`
- The chain's wrapped-native-coin contract (WCRO) — `deposit`/`transfer`
- Hard-coded team/treasury addresses (EOAs, out of scope for this contract inventory): `empireTeam 0x5ABBd94bb0561938130d83FdA22E672110e12528`, `omnisciaTeam 0x21cfe244fEe27Dcf77c9555A24075fdf0930d656`, `marketingTeam 0xA581289F88A2cC9D40ad990F5773c9e6973bc756`, `REWARD_TREASURY 0x3F9B7da1d832199b2dD23670F2623193636f2e88`
