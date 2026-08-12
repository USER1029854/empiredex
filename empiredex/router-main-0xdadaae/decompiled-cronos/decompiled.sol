// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

/// @title            Decompiled Contract
/// @author           Jonathan Becker <jonathan@jbecker.dev>
/// @custom:version   heimdall-rs v0.9.2
///
/// @notice           This contract was decompiled using the heimdall-rs decompiler.
///                     It was generated directly by tracing the EVM opcodes from this contract.
///                     As a result, it may not compile or even be valid solidity code.
///                     Despite this, it should be obvious what each function does. Overall
///                     logic should have been preserved throughout decompiling.
///
/// @custom:github    You can find the open-source decompiler here:
///                       https://heimdall.rs

contract DecompiledContract {
    uint256 public constant factory = 36105369479179084578288331048029013545440310045;
    uint256 public constant WETH = 528071396673765721415711800160976244447603961379;
    uint256 public constant escrow = 325216499869722313191714189066520875703130980351;
    
    
    /// @custom:selector    0x7ff36ab5
    /// @custom:signature   swapExactETHForTokens(uint256 arg0, address[] arg1, address arg2, uint256 arg3) public payable returns (bytes memory)
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    /// @param              arg1 ["uint256", "bytes32", "int256"]
    /// @param              arg2 ["address", "uint160", "bytes20", "int160"]
    /// @param              arg3 ["uint256", "bytes32", "int256"]
    function swapExactETHForTokens(uint256 arg0, address[] arg1, address arg2, uint256 arg3) public payable returns (bytes memory) {
        require(!arg1 > 0xffffffffffffffff);
        require(!(arg1) > 0xffffffffffffffff);
        require(arg2 == (address(arg2)));
        require(!arg3 < block.timestamp);
        require(0 < (arg1));
        require(!(((0 + ((0x04 + arg1) + 0x20)) + 0x20) - (0 + ((0x04 + arg1) + 0x20))) < 0x20);
        require((0 + (arg1 + 0x20)) == (address(0 + (arg1 + 0x20))));
        require(address(0 + (arg1 + 0x20)) == 0x5c7f8a570d578ed84e63fdfa7b1ee72deae1ae23);
        uint256 var_a = var_a + (0x20 + (0x20 * (arg1)));
        require(!var_a.length < 0x02);
        require(!var_a.length > 0xffffffffffffffff);
        var_a = var_a + (0x20 + (0x20 * var_a.length));
        require(!var_a.length, "EmpireRouter: INSUFFICIENT_OUTPUT_AMOUNT");
        var_c = msg.data[4:4];
        require(!(0 < (var_a.length - 0x01)), "EmpireRouter: INSUFFICIENT_OUTPUT_AMOUNT");
        require((var_a.length - 0x01) < var_a.length, "EmpireRouter: INSUFFICIENT_OUTPUT_AMOUNT");
        require(!(var_f < arg0), "EmpireRouter: INSUFFICIENT_OUTPUT_AMOUNT");
        var_h = 0x28;
        require(address(0x5c7f8a570d578ed84e63fdfa7b1ee72deae1ae23).code.length);
        (bool success, bytes memory ret0) = address(0x5c7f8a570d578ed84e63fdfa7b1ee72deae1ae23).{ value: var_c }deposit(); // call
        require(0 < (arg1));
        require(!(((0 + ((0x04 + arg1) + 0x20)) + 0x20) - (0 + ((0x04 + arg1) + 0x20))) < 0x20);
        require((0 + (arg1 + 0x20)) == (address(0 + (arg1 + 0x20))));
        require(0x01 < (arg1));
        require(!(((0x20 + ((0x04 + arg1) + 0x20)) + 0x20) - (0x20 + ((0x04 + arg1) + 0x20))) < 0x20);
        require((0x20 + (arg1 + 0x20)) == (address(0x20 + (arg1 + 0x20))));
        require(!(address(0 + (arg1 + 0x20))) == (address(0x20 + (arg1 + 0x20))));
        require(address(0 + (arg1 + 0x20)) < (address(0x20 + (arg1 + 0x20))));
        require(address(0 + (arg1 + 0x20)));
        var_a = var_h + (0x20 + var_a);
        address var_s = address(keccak256(var_t));
        require(address(0x5c7f8a570d578ed84e63fdfa7b1ee72deae1ae23).code.length);
        (bool success, bytes memory ret0) = address(0x5c7f8a570d578ed84e63fdfa7b1ee72deae1ae23).{ value: 0 ether }Unresolved_a9059cbb(var_s); // call
        var_a = var_a + (uint248(ret0.length + 0x1f));
        require(!((var_a + ret0.length) - var_a) < 0x20);
        require(var_a.length == var_a.length);
        require(var_a.length);
        var_a = var_a + (0x20 + (0x20 * (arg1)));
        var_c = msg.data[36:36];
        require(!0 < (var_a.length - 0x01));
        return abi.encodePacked(0x20, var_a.length);
        require(!(address(var_c)) == (address(var_y)));
        require(address(var_c) < (address(var_y)));
        require(address(var_c));
        require(!(address(var_c)) == (address(var_y)));
        require(address(var_c) < (address(var_y)));
        require(address(var_c));
        var_a = 0x28 + (0x20 + var_a);
        require(address(keccak256(var_t)).code.length);
        (bool success, bytes memory ret0) = address(keccak256(var_t)).getReserves(); // staticcall
        var_a = var_a + (uint248(ret0.length + 0x1f));
        require(!((var_a + ret0.length) - var_a) < 0x60);
        require(var_a.length == (uint112(var_a.length)));
        require(var_t == (uint112(var_t)));
        require(var_z == (uint32(var_z)));
        require(address(var_c) == (address(var_c)), "EmpireLibrary: INSUFFICIENT_INPUT_AMOUNT");
        require(var_c > 0, "EmpireLibrary: INSUFFICIENT_INPUT_AMOUNT");
        require(!(uint112(var_t) > 0), "ds-math-mul-overflow");
        require(uint112(var_a.length) > 0, "ds-math-mul-overflow");
        require(!0x03e5, "ds-math-mul-overflow");
        require(!0x03e5, "ds-math-mul-overflow");
        require(!(uint112(var_a.length)), "ds-math-mul-overflow");
        require(uint112(var_a.length), "ds-math-mul-overflow");
        require((0 * (uint112(var_a.length))) / (uint112(var_a.length)) == 0, "ds-math-mul-overflow");
        require(!0x03e8, "ds-math-add-overflow");
        require(!0x03e8, "ds-math-add-overflow");
        require(!(0 < 0), "ds-math-add-overflow");
        require(0, "ds-math-mul-overflow");
        require(0x03e8, "ds-math-mul-overflow");
        require(((uint112(var_t) * 0x03e8) / 0x03e8) == (uint112(var_t)), "ds-math-mul-overflow");
    }
    
    /// @custom:selector    0x38ed1739
    /// @custom:signature   swapExactTokensForTokens(uint256 arg0, uint256 arg1, address[] arg2, address arg3, uint256 arg4) public returns (bytes memory)
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    /// @param              arg1 ["uint256", "bytes32", "int256"]
    /// @param              arg2 ["uint256", "bytes32", "int256"]
    /// @param              arg3 ["address", "uint160", "bytes20", "int160"]
    /// @param              arg4 ["uint256", "bytes32", "int256"]
    function swapExactTokensForTokens(uint256 arg0, uint256 arg1, address[] arg2, address arg3, uint256 arg4) public returns (bytes memory) {
        require(!arg2 > 0xffffffffffffffff);
        require(!(arg2) > 0xffffffffffffffff);
        require(arg3 == (address(arg3)));
        require(!arg4 < block.timestamp);
        uint256 var_a = var_a + (0x20 + (0x20 * (arg2)));
        uint256 var_b = (arg2);
        require(!var_a.length < 0x02);
        require(!var_a.length > 0xffffffffffffffff);
        var_a = var_a + (0x20 + (0x20 * var_a.length));
        require(!var_a.length, "EmpireRouter: INSUFFICIENT_OUTPUT_AMOUNT");
        var_c = msg.data[4:4];
        require(!(0 < (var_a.length - 0x01)), "EmpireRouter: INSUFFICIENT_OUTPUT_AMOUNT");
        require((var_a.length - 0x01) < var_a.length, "EmpireRouter: INSUFFICIENT_OUTPUT_AMOUNT");
        require(!(var_f < arg1), "EmpireRouter: INSUFFICIENT_OUTPUT_AMOUNT");
        var_h = 0x28;
        require(0 < (arg2));
        require(!(((0 + ((0x04 + arg2) + 0x20)) + 0x20) - (0 + ((0x04 + arg2) + 0x20))) < 0x20);
        require((0 + (arg2 + 0x20)) == (address(0 + (arg2 + 0x20))));
        require(0 < (arg2));
        require(!(((0 + ((0x04 + arg2) + 0x20)) + 0x20) - (0 + ((0x04 + arg2) + 0x20))) < 0x20);
        require((0 + (arg2 + 0x20)) == (address(0 + (arg2 + 0x20))));
        require(0x01 < (arg2));
        require(!(((0x20 + ((0x04 + arg2) + 0x20)) + 0x20) - (0x20 + ((0x04 + arg2) + 0x20))) < 0x20);
        require((0x20 + (arg2 + 0x20)) == (address(0x20 + (arg2 + 0x20))));
        require(!(address(0 + (arg2 + 0x20)) == (address(0x20 + (arg2 + 0x20)))), "TransferHelper::transferFrom: transferFrom failed");
        require(address(0 + (arg2 + 0x20)) < (address(0x20 + (arg2 + 0x20))), "TransferHelper::transferFrom: transferFrom failed");
        require(address(0 + (arg2 + 0x20)), "TransferHelper::transferFrom: transferFrom failed");
        var_a = var_h + (0x20 + var_a);
        var_a = 0x55 + (0x20 + var_a);
        var_a = 0x60 + (0x24 + var_a);
        require(!(0 > var_a.length), "TransferHelper::transferFrom: transferFrom failed");
        (bool success, bytes memory ret0) = address(0 + (arg2 + 0x20)).transfer(0);
        require(ret0.length == 0, "TransferHelper::transferFrom: transferFrom failed");
        var_a = var_a + (0x20 + (0x20 * (arg2)));
        var_c = msg.data[36:36];
        require(!0 < (var_a.length - 0x01));
        return abi.encodePacked(0x20, var_a.length);
        require(!var_ae);
        require(!((0x80 + var_ae) - 0x80) < 0x20);
        require(var_b == var_b);
        require(var_b, "TransferHelper::transferFrom: transferFrom failed");
        var_a = var_a + (uint248(ret0.length + 0x3f));
        if (!var_a.length) {
        }
        require(!(address(var_c)) == (address(var_ah)));
        require(address(var_c) < (address(var_ah)));
        require(address(var_c));
        require(!(address(var_c)) == (address(var_ah)));
        require(address(var_c) < (address(var_ah)));
        require(address(var_c));
        var_a = 0x28 + (0x20 + var_a);
        require(address(keccak256(var_t)).code.length);
        (bool success, bytes memory ret0) = address(keccak256(var_t)).getReserves(); // staticcall
        var_a = var_a + (uint248(ret0.length + 0x1f));
        require(!((var_a + ret0.length) - var_a) < 0x60);
        require(var_a.length == (uint112(var_a.length)));
        require(var_t == (uint112(var_t)));
        require(var_ai == (uint32(var_ai)));
        require(address(var_c) == (address(var_c)), "EmpireLibrary: INSUFFICIENT_INPUT_AMOUNT");
        require(var_c > 0, "EmpireLibrary: INSUFFICIENT_INPUT_AMOUNT");
        require(!(uint112(var_t) > 0), "ds-math-mul-overflow");
        require(uint112(var_a.length) > 0, "ds-math-mul-overflow");
        require(!0x03e5, "ds-math-mul-overflow");
        require(!0x03e5, "ds-math-mul-overflow");
        require(!(uint112(var_a.length)), "ds-math-mul-overflow");
        require(uint112(var_a.length), "ds-math-mul-overflow");
        require((0 * (uint112(var_a.length))) / (uint112(var_a.length)) == 0, "ds-math-mul-overflow");
        require(!0x03e8, "ds-math-add-overflow");
        require(!0x03e8, "ds-math-add-overflow");
        require(!(0 < 0), "ds-math-add-overflow");
        require(0, "ds-math-mul-overflow");
        require(0x03e8, "ds-math-mul-overflow");
        require(((uint112(var_t) * 0x03e8) / 0x03e8) == (uint112(var_t)), "ds-math-mul-overflow");
    }
    
    /// @custom:selector    0xd06ca61f
    /// @custom:signature   getAmountsOut(uint256 arg0, address[] arg1) public returns (bytes memory)
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    /// @param              arg1 ["uint256", "bytes32", "int256"]
    function getAmountsOut(uint256 arg0, address[] arg1) public returns (bytes memory) {
        require(!arg1 > 0xffffffffffffffff);
        require(!(arg1) > 0xffffffffffffffff);
        require(!((var_a + ((arg1 * 0x20) + 0x20)) < var_a) | ((var_a + ((arg1 * 0x20) + 0x20)) > 0xffffffffffffffff));
        uint256 var_a = var_a + ((arg1 * 0x20) + 0x20);
        require(!0 < (arg1));
        require((0x20 + (arg1)) == (address(0x20 + (arg1))));
        require(!var_a.length < 0x02);
        require(!var_a.length > 0xffffffffffffffff);
        var_a = var_a + (0x20 + (0x20 * var_a.length));
        require(!var_a.length);
        var_d = msg.data[4:4];
        require(!0 < (var_a.length - 0x01));
        return abi.encodePacked(0x20, var_a.length);
        require(!(address(var_d)) == (address(var_g)));
        require(address(var_d) < (address(var_g)));
        require(address(var_d));
        require(!(address(var_d)) == (address(var_g)));
        require(address(var_d) < (address(var_g)));
        require(address(var_d));
        var_a = 0x28 + (0x20 + var_a);
        require(address(keccak256(var_o)).code.length);
        (bool success, bytes memory ret0) = address(keccak256(var_o)).getReserves(); // staticcall
        var_a = var_a + (uint248(ret0.length + 0x1f));
        require(!((var_a + ret0.length) - var_a) < 0x60);
        require(var_a.length == (uint112(var_a.length)));
        require(var_o == (uint112(var_o)));
        require(var_p == (uint32(var_p)));
        require(address(var_d) == (address(var_d)), "EmpireLibrary: INSUFFICIENT_INPUT_AMOUNT");
        require(var_d > 0, "EmpireLibrary: INSUFFICIENT_INPUT_AMOUNT");
        require(!(uint112(var_o) > 0), "ds-math-mul-overflow");
        require(uint112(var_a.length) > 0, "ds-math-mul-overflow");
        require(!0x03e5, "ds-math-mul-overflow");
        require(!0x03e5, "ds-math-mul-overflow");
        require(!(uint112(var_a.length)), "ds-math-mul-overflow");
        require(uint112(var_a.length), "ds-math-mul-overflow");
        require((0 * (uint112(var_a.length))) / (uint112(var_a.length)) == 0, "ds-math-mul-overflow");
        require(!0x03e8, "ds-math-add-overflow");
        require(!0x03e8, "ds-math-add-overflow");
        require(!(0 < 0), "ds-math-add-overflow");
        require(0, "ds-math-mul-overflow");
        require(0x03e8, "ds-math-mul-overflow");
        require(((uint112(var_o) * 0x03e8) / 0x03e8) == (uint112(var_o)), "ds-math-mul-overflow");
    }
    
    /// @custom:selector    0xbaa2abde
    /// @custom:signature   Unresolved_baa2abde(address arg0) public pure
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    function Unresolved_baa2abde(address arg0) public pure {
        require(arg0 == (address(arg0)));
    }
    
    /// @custom:selector    0x5b0d5984
    /// @custom:signature   Unresolved_5b0d5984(address arg0) public pure
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    function Unresolved_5b0d5984(address arg0) public pure {
        require(arg0 == (address(arg0)));
    }
    
    /// @custom:selector    0x85f8c259
    /// @custom:signature   getAmountIn(uint256 arg0, uint256 arg1, uint256 arg2) public pure
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    /// @param              arg1 ["uint256", "bytes32", "int256"]
    /// @param              arg2 ["uint256", "bytes32", "int256"]
    function getAmountIn(uint256 arg0, uint256 arg1, uint256 arg2) public pure {
        require(arg0 > 0, "ds-math-mul-overflow");
        require(!(arg1 > 0), "ds-math-mul-overflow");
        require(arg2 > 0, "ds-math-mul-overflow");
        require(!arg0, "ds-math-mul-overflow");
        require(arg0, "ds-math-mul-overflow");
        require(((arg1 * arg0) / arg0) == arg1, "ds-math-mul-overflow");
    }
    
    /// @custom:selector    0xf305d719
    /// @custom:signature   Unresolved_f305d719(address arg0) public pure
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    function Unresolved_f305d719(address arg0) public pure {
        require(arg0 == (address(arg0)));
    }
    
    /// @custom:selector    0x2b567f20
    /// @custom:signature   Unresolved_2b567f20(address arg0) public pure
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    function Unresolved_2b567f20(address arg0) public pure {
        require(arg0 == (address(arg0)));
    }
    
    /// @custom:selector    0x02751cec
    /// @custom:signature   Unresolved_02751cec(address arg0) public pure
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    function Unresolved_02751cec(address arg0) public pure {
        require(arg0 == (address(arg0)));
    }
    
    /// @custom:selector    0xaf2979eb
    /// @custom:signature   Unresolved_af2979eb(address arg0) public pure
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    function Unresolved_af2979eb(address arg0) public pure {
        require(arg0 == (address(arg0)));
    }
    
    /// @custom:selector    0x18cbafe5
    /// @custom:signature   swapExactTokensForETH(uint256 arg0, uint256 arg1, address[] arg2, address arg3, uint256 arg4) public
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    /// @param              arg1 ["uint256", "bytes32", "int256"]
    /// @param              arg2 ["uint256", "bytes32", "int256"]
    /// @param              arg3 ["address", "uint160", "bytes20", "int160"]
    /// @param              arg4 ["uint256", "bytes32", "int256"]
    function swapExactTokensForETH(uint256 arg0, uint256 arg1, address[] arg2, address arg3, uint256 arg4) public {
        require(!arg2 > 0xffffffffffffffff);
        require(!(arg2) > 0xffffffffffffffff);
        require(arg3 == (address(arg3)));
        require(!arg4 < block.timestamp);
        require((arg2 + 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (arg2));
        require(!(((0x20 * (arg2 + 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff)) + ((0x04 + arg2) + 0x20) + 0x20) - ((0x20 * (arg2 + 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff)) + ((0x04 + arg2) + 0x20))) < 0x20);
        require((0x20 * (arg2 + 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff)) + (arg2 + 0x20) == (address((0x20 * (arg2 + 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff)) + (arg2 + 0x20))));
        require(address((0x20 * (arg2 + 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff)) + (arg2 + 0x20)) == 0x5c7f8a570d578ed84e63fdfa7b1ee72deae1ae23);
        uint256 var_a = var_a + (0x20 + (0x20 * (arg2)));
        require(!var_a.length < 0x02);
        require(!var_a.length > 0xffffffffffffffff);
        var_a = var_a + (0x20 + (0x20 * var_a.length));
        require(!var_a.length, "EmpireRouter: INSUFFICIENT_OUTPUT_AMOUNT");
        var_c = msg.data[4:4];
        require(!(0 < (var_a.length - 0x01)), "EmpireRouter: INSUFFICIENT_OUTPUT_AMOUNT");
        require((var_a.length - 0x01) < var_a.length, "EmpireRouter: INSUFFICIENT_OUTPUT_AMOUNT");
        require(!(var_f < arg1), "EmpireRouter: INSUFFICIENT_OUTPUT_AMOUNT");
        var_h = 0x28;
        require(0 < (arg2));
        require(!(address(var_c)) == (address(var_k)));
        require(address(var_c) < (address(var_k)));
        require(address(var_c));
        require(!(address(var_c)) == (address(var_k)));
        require(address(var_c) < (address(var_k)));
        require(address(var_c));
        var_a = var_h + (0x20 + var_a);
        require(address(keccak256(var_t)).code.length);
        (bool success, bytes memory ret0) = address(keccak256(var_t)).getReserves(); // staticcall
        var_a = var_a + (uint248(ret0.length + 0x1f));
        require(!((var_a + ret0.length) - var_a) < 0x60);
        require(var_a.length == (uint112(var_a.length)));
        require(var_t == (uint112(var_t)));
        require(var_u == (uint32(var_u)));
        require(address(var_c) == (address(var_c)), "EmpireLibrary: INSUFFICIENT_INPUT_AMOUNT");
        require(var_c > 0, "EmpireLibrary: INSUFFICIENT_INPUT_AMOUNT");
        require(!(uint112(var_t) > 0), "ds-math-mul-overflow");
        require(uint112(var_a.length) > 0, "ds-math-mul-overflow");
        require(!0x03e5, "ds-math-mul-overflow");
        require(!0x03e5, "ds-math-mul-overflow");
        require(!(uint112(var_a.length)), "ds-math-mul-overflow");
        require(uint112(var_a.length), "ds-math-mul-overflow");
        require((0 * (uint112(var_a.length))) / (uint112(var_a.length)) == 0, "ds-math-mul-overflow");
        require(!0x03e8, "ds-math-add-overflow");
        require(!0x03e8, "ds-math-add-overflow");
        require(!(0 < 0), "ds-math-add-overflow");
        require(0, "ds-math-mul-overflow");
        require(0x03e8, "ds-math-mul-overflow");
        require(((uint112(var_t) * 0x03e8) / 0x03e8) == (uint112(var_t)), "ds-math-mul-overflow");
    }
    
    /// @custom:selector    0x1a794389
    /// @custom:signature   Unresolved_1a794389(address arg0) public pure
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    function Unresolved_1a794389(address arg0) public pure {
        require(arg0 == (address(arg0)));
    }
    
    /// @custom:selector    0xfb3bdb41
    /// @custom:signature   swapETHForExactTokens(uint256 arg0, address[] arg1, address arg2, uint256 arg3) public payable returns (bytes memory)
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    /// @param              arg1 ["uint256", "bytes32", "int256"]
    /// @param              arg2 ["address", "uint160", "bytes20", "int160"]
    /// @param              arg3 ["uint256", "bytes32", "int256"]
    function swapETHForExactTokens(uint256 arg0, address[] arg1, address arg2, uint256 arg3) public payable returns (bytes memory) {
        require(!arg1 > 0xffffffffffffffff);
        require(!(arg1) > 0xffffffffffffffff);
        require(arg2 == (address(arg2)));
        require(!arg3 < block.timestamp);
        require(0 < (arg1));
        require(!(((0 + ((0x04 + arg1) + 0x20)) + 0x20) - (0 + ((0x04 + arg1) + 0x20))) < 0x20);
        require((0 + (arg1 + 0x20)) == (address(0 + (arg1 + 0x20))));
        require(address(0 + (arg1 + 0x20)) == 0x5c7f8a570d578ed84e63fdfa7b1ee72deae1ae23);
        uint256 var_a = var_a + (0x20 + (0x20 * (arg1)));
        require(!var_a.length < 0x02);
        require(!var_a.length > 0xffffffffffffffff);
        var_a = var_a + (0x20 + (0x20 * var_a.length));
        require(!var_a.length, "EmpireRouter: EXCESSIVE_INPUT_AMOUNT");
        var_c = msg.data[4:4];
        require((var_a.length - 0x01) < var_a.length, "EmpireRouter: EXCESSIVE_INPUT_AMOUNT");
        require(!(0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff + var_a.length), "EmpireRouter: EXCESSIVE_INPUT_AMOUNT");
        require(!(var_c > msg.value), "EmpireRouter: EXCESSIVE_INPUT_AMOUNT");
        require(address(0x5c7f8a570d578ed84e63fdfa7b1ee72deae1ae23).code.length);
        (bool success, bytes memory ret0) = address(0x5c7f8a570d578ed84e63fdfa7b1ee72deae1ae23).{ value: var_c }deposit(); // call
        require(0 < (arg1));
        require(!(((0 + ((0x04 + arg1) + 0x20)) + 0x20) - (0 + ((0x04 + arg1) + 0x20))) < 0x20);
        require((0 + (arg1 + 0x20)) == (address(0 + (arg1 + 0x20))));
        require(0x01 < (arg1));
        require(!(((0x20 + ((0x04 + arg1) + 0x20)) + 0x20) - (0x20 + ((0x04 + arg1) + 0x20))) < 0x20);
        require((0x20 + (arg1 + 0x20)) == (address(0x20 + (arg1 + 0x20))));
        require(!(address(0 + (arg1 + 0x20))) == (address(0x20 + (arg1 + 0x20))));
        require(address(0 + (arg1 + 0x20)) < (address(0x20 + (arg1 + 0x20))));
        require(address(0 + (arg1 + 0x20)));
        var_a = 0x28 + (0x20 + var_a);
        address var_r = address(keccak256(var_s));
        require(address(0x5c7f8a570d578ed84e63fdfa7b1ee72deae1ae23).code.length);
        (bool success, bytes memory ret0) = address(0x5c7f8a570d578ed84e63fdfa7b1ee72deae1ae23).{ value: 0 ether }Unresolved_a9059cbb(var_r); // call
        var_a = var_a + (uint248(ret0.length + 0x1f));
        require(!(((var_a + ret0.length) - var_a) < 0x20), "TransferHelper::safeTransferETH: ETH transfer failed");
        require(var_a.length == var_a.length, "TransferHelper::safeTransferETH: ETH transfer failed");
        require(var_a.length, "TransferHelper::safeTransferETH: ETH transfer failed");
        var_a = var_a + (0x20 + (0x20 * (arg1)));
        var_c = msg.data[36:36];
        require(!(0 < (var_a.length - 0x01)), "TransferHelper::safeTransferETH: ETH transfer failed");
        require(!(msg.value > (var_c)), "TransferHelper::safeTransferETH: ETH transfer failed");
        var_a = var_a + 0x20;
        require(!(0 > var_a.length), "TransferHelper::safeTransferETH: ETH transfer failed");
        (bool success, bytes memory ret0) = address(msg.sender).transfer(msg.value - (var_c));
        require(ret0.length == 0, "TransferHelper::safeTransferETH: ETH transfer failed");
        return abi.encodePacked(0x20, var_a.length);
        require(((0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff + var_a.length) - 0x01) < var_a.length);
        require((0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff + var_a.length) < var_a.length);
        require(!(address(var_ac)) == (address(var_ad)));
        require(address(var_ac) < (address(var_ad)));
        require(address(var_ac));
        require(!(address(var_ac)) == (address(var_ad)));
        require(address(var_ac) < (address(var_ad)));
        require(address(var_ac));
        var_a = 0x28 + (0x20 + var_a);
        require(address(keccak256(var_s)).code.length);
        (bool success, bytes memory ret0) = address(keccak256(var_s)).getReserves(); // staticcall
        var_a = var_a + (uint248(ret0.length + 0x1f));
        require(!((var_a + ret0.length) - var_a) < 0x60);
        require(var_a.length == (uint112(var_a.length)));
        require(var_s == (uint112(var_s)));
        require(var_ae == (uint32(var_ae)));
        require(address(var_ac) == (address(var_ac)), "ds-math-mul-overflow");
        require((0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff + var_a.length) < var_a.length, "ds-math-mul-overflow");
        require(var_ad > 0, "ds-math-mul-overflow");
        require(!(uint112(var_s) > 0), "ds-math-mul-overflow");
        require(uint112(var_a.length) > 0, "ds-math-mul-overflow");
        require(!(var_ad), "ds-math-mul-overflow");
        require(var_ad, "ds-math-mul-overflow");
        require(uint112(var_s) * (var_ad) / (var_ad) == (uint112(var_s)), "ds-math-mul-overflow");
    }
    
    /// @custom:selector    0x1f00ca74
    /// @custom:signature   getAmountsIn(uint256 arg0, address[] arg1) public returns (bytes memory)
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    /// @param              arg1 ["uint256", "bytes32", "int256"]
    function getAmountsIn(uint256 arg0, address[] arg1) public returns (bytes memory) {
        require(!arg1 > 0xffffffffffffffff);
        require(!(arg1) > 0xffffffffffffffff);
        require(!((var_a + ((arg1 * 0x20) + 0x20)) < var_a) | ((var_a + ((arg1 * 0x20) + 0x20)) > 0xffffffffffffffff));
        uint256 var_a = var_a + ((arg1 * 0x20) + 0x20);
        require(!0 < (arg1));
        require((0x20 + (arg1)) == (address(0x20 + (arg1))));
        require(!var_a.length < 0x02);
        require(!var_a.length > 0xffffffffffffffff);
        var_a = var_a + (0x20 + (0x20 * var_a.length));
        require(!var_a.length);
        var_d = msg.data[4:4];
        require((var_a.length - 0x01) < var_a.length);
        require(!0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff + var_a.length);
        return abi.encodePacked(0x20, var_a.length);
        require(((0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff + var_a.length) - 0x01) < var_a.length);
        require((0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff + var_a.length) < var_a.length);
        require(!(address(var_g)) == (address(var_h)));
        require(address(var_g) < (address(var_h)));
        require(address(var_g));
        require(!(address(var_g)) == (address(var_h)));
        require(address(var_g) < (address(var_h)));
        require(address(var_g));
        var_a = 0x28 + (0x20 + var_a);
        require(address(keccak256(var_p)).code.length);
        (bool success, bytes memory ret0) = address(keccak256(var_p)).getReserves(); // staticcall
        var_a = var_a + (uint248(ret0.length + 0x1f));
        require(!((var_a + ret0.length) - var_a) < 0x60);
        require(var_a.length == (uint112(var_a.length)));
        require(var_p == (uint112(var_p)));
        require(var_q == (uint32(var_q)));
        require(address(var_g) == (address(var_g)), "ds-math-mul-overflow");
        require((0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff + var_a.length) < var_a.length, "ds-math-mul-overflow");
        require(var_h > 0, "ds-math-mul-overflow");
        require(!(uint112(var_p) > 0), "ds-math-mul-overflow");
        require(uint112(var_a.length) > 0, "ds-math-mul-overflow");
        require(!(var_h), "ds-math-mul-overflow");
        require(var_h, "ds-math-mul-overflow");
        require(uint112(var_p) * (var_h) / (var_h) == (uint112(var_p)), "ds-math-mul-overflow");
    }
    
    /// @custom:selector    0x2195995c
    /// @custom:signature   Unresolved_2195995c(address arg0) public pure
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    function Unresolved_2195995c(address arg0) public pure {
        require(arg0 == (address(arg0)));
    }
    
    /// @custom:selector    0x054d50d4
    /// @custom:signature   getAmountOut(uint256 arg0, uint256 arg1, uint256 arg2) public pure returns (uint256)
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    /// @param              arg1 ["uint256", "bytes32", "int256"]
    /// @param              arg2 ["uint256", "bytes32", "int256"]
    function getAmountOut(uint256 arg0, uint256 arg1, uint256 arg2) public pure returns (uint256) {
        require(arg0 > 0, "ds-math-mul-overflow");
        require(!(arg1 > 0), "ds-math-mul-overflow");
        require(arg2 > 0, "ds-math-mul-overflow");
        require(!0x03e5, "ds-math-mul-overflow");
        require(!0x03e5, "ds-math-mul-overflow");
        require(!arg2, "ds-math-mul-overflow");
        require(arg2, "ds-math-mul-overflow");
        require(((0 * arg2) / arg2) == 0, "ds-math-mul-overflow");
        require(!0x03e8, "ds-math-add-overflow");
        require(!0x03e8, "ds-math-add-overflow");
        require(!(0 < 0), "ds-math-add-overflow");
        require(0, "ds-math-mul-overflow");
        return (0 * arg2) / 0;
        require(0x03e8, "ds-math-mul-overflow");
        require(((arg1 * 0x03e8) / 0x03e8) == arg1, "ds-math-mul-overflow");
    }
    
    /// @custom:selector    0x8803dbee
    /// @custom:signature   swapTokensForExactTokens(uint256 arg0, uint256 arg1, address[] arg2, address arg3, uint256 arg4) public returns (bytes memory)
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    /// @param              arg1 ["uint256", "bytes32", "int256"]
    /// @param              arg2 ["uint256", "bytes32", "int256"]
    /// @param              arg3 ["address", "uint160", "bytes20", "int160"]
    /// @param              arg4 ["uint256", "bytes32", "int256"]
    function swapTokensForExactTokens(uint256 arg0, uint256 arg1, address[] arg2, address arg3, uint256 arg4) public returns (bytes memory) {
        require(!arg2 > 0xffffffffffffffff);
        require(!(arg2) > 0xffffffffffffffff);
        require(arg3 == (address(arg3)));
        require(!arg4 < block.timestamp);
        uint256 var_a = var_a + (0x20 + (0x20 * (arg2)));
        uint256 var_b = (arg2);
        require(!var_a.length < 0x02);
        require(!var_a.length > 0xffffffffffffffff);
        var_a = var_a + (0x20 + (0x20 * var_a.length));
        require(!var_a.length, "EmpireRouter: EXCESSIVE_INPUT_AMOUNT");
        var_c = msg.data[4:4];
        require((var_a.length - 0x01) < var_a.length, "EmpireRouter: EXCESSIVE_INPUT_AMOUNT");
        require(!(0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff + var_a.length), "EmpireRouter: EXCESSIVE_INPUT_AMOUNT");
        require(!(var_c > arg1), "EmpireRouter: EXCESSIVE_INPUT_AMOUNT");
        require(0 < (arg2));
        require(!(((0 + ((0x04 + arg2) + 0x20)) + 0x20) - (0 + ((0x04 + arg2) + 0x20))) < 0x20);
        require((0 + (arg2 + 0x20)) == (address(0 + (arg2 + 0x20))));
        require(0 < (arg2));
        require(!(((0 + ((0x04 + arg2) + 0x20)) + 0x20) - (0 + ((0x04 + arg2) + 0x20))) < 0x20);
        require((0 + (arg2 + 0x20)) == (address(0 + (arg2 + 0x20))));
        require(0x01 < (arg2));
        require(!(((0x20 + ((0x04 + arg2) + 0x20)) + 0x20) - (0x20 + ((0x04 + arg2) + 0x20))) < 0x20);
        require((0x20 + (arg2 + 0x20)) == (address(0x20 + (arg2 + 0x20))));
        require(!(address(0 + (arg2 + 0x20)) == (address(0x20 + (arg2 + 0x20)))), "TransferHelper::transferFrom: transferFrom failed");
        require(address(0 + (arg2 + 0x20)) < (address(0x20 + (arg2 + 0x20))), "TransferHelper::transferFrom: transferFrom failed");
        require(address(0 + (arg2 + 0x20)), "TransferHelper::transferFrom: transferFrom failed");
        var_a = 0x28 + (0x20 + var_a);
        var_a = 0x55 + (0x20 + var_a);
        var_a = 0x60 + (0x24 + var_a);
        require(!(0 > var_a.length), "TransferHelper::transferFrom: transferFrom failed");
        (bool success, bytes memory ret0) = address(0 + (arg2 + 0x20)).transfer(0);
        require(ret0.length == 0, "TransferHelper::transferFrom: transferFrom failed");
        var_a = var_a + (0x20 + (0x20 * (arg2)));
        var_c = msg.data[36:36];
        require(!0 < (var_a.length - 0x01));
        return abi.encodePacked(0x20, var_a.length);
        require(!var_ad);
        require(!((0x80 + var_ad) - 0x80) < 0x20);
        require(var_b == var_b);
        require(var_b, "TransferHelper::transferFrom: transferFrom failed");
        var_a = var_a + (uint248(ret0.length + 0x3f));
        if (!var_a.length) {
        }
        require(((0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff + var_a.length) - 0x01) < var_a.length);
        require((0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff + var_a.length) < var_a.length);
        require(!(address(var_ag)) == (address(var_ah)));
        require(address(var_ag) < (address(var_ah)));
        require(address(var_ag));
        require(!(address(var_ag)) == (address(var_ah)));
        require(address(var_ag) < (address(var_ah)));
        require(address(var_ag));
        var_a = 0x28 + (0x20 + var_a);
        require(address(keccak256(var_s)).code.length);
        (bool success, bytes memory ret0) = address(keccak256(var_s)).getReserves(); // staticcall
        var_a = var_a + (uint248(ret0.length + 0x1f));
        require(!((var_a + ret0.length) - var_a) < 0x60);
        require(var_a.length == (uint112(var_a.length)));
        require(var_s == (uint112(var_s)));
        require(var_ai == (uint32(var_ai)));
        require(address(var_ag) == (address(var_ag)), "ds-math-mul-overflow");
        require((0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff + var_a.length) < var_a.length, "ds-math-mul-overflow");
        require(var_ah > 0, "ds-math-mul-overflow");
        require(!(uint112(var_s) > 0), "ds-math-mul-overflow");
        require(uint112(var_a.length) > 0, "ds-math-mul-overflow");
        require(!(var_ah), "ds-math-mul-overflow");
        require(var_ah, "ds-math-mul-overflow");
        require(uint112(var_s) * (var_ah) / (var_ah) == (uint112(var_s)), "ds-math-mul-overflow");
    }
    
    /// @custom:selector    0xad615dec
    /// @custom:signature   quote(uint256 arg0, uint256 arg1, uint256 arg2) public pure returns (uint256)
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    /// @param              arg1 ["uint256", "bytes32", "int256"]
    /// @param              arg2 ["uint256", "bytes32", "int256"]
    function quote(uint256 arg0, uint256 arg1, uint256 arg2) public pure returns (uint256) {
        require(arg0 > 0, "ds-math-mul-overflow");
        require(!(arg1 > 0), "ds-math-mul-overflow");
        require(arg2 > 0, "ds-math-mul-overflow");
        require(!arg2, "ds-math-mul-overflow");
        require(arg2, "ds-math-mul-overflow");
        require(((arg0 * arg2) / arg2) == arg0, "ds-math-mul-overflow");
        require(arg1, "ds-math-mul-overflow");
        return (arg0 * arg2) / arg1;
        require(!arg2, "ds-math-mul-overflow");
        require(arg1, "EmpireLibrary: INSUFFICIENT_LIQUIDITY");
        return 0 / arg1;
    }
    
    /// @custom:selector    0xe8e33700
    /// @custom:signature   Unresolved_e8e33700(address arg0) public pure
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    function Unresolved_e8e33700(address arg0) public pure {
        require(arg0 == (address(arg0)));
    }
    
    /// @custom:selector    0xb6f9de95
    /// @custom:signature   swapExactETHForTokensSupportingFeeOnTransferTokens(uint256 arg0, address[] arg1, address arg2, uint256 arg3) public payable
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    /// @param              arg1 ["uint256", "bytes32", "int256"]
    /// @param              arg2 ["address", "uint160", "bytes20", "int160"]
    /// @param              arg3 ["uint256", "bytes32", "int256"]
    function swapExactETHForTokensSupportingFeeOnTransferTokens(uint256 arg0, address[] arg1, address arg2, uint256 arg3) public payable {
        require(!arg1 > 0xffffffffffffffff);
        require(!(arg1) > 0xffffffffffffffff);
        require(arg2 == (address(arg2)));
        require(!arg3 < block.timestamp);
        require(0 < (arg1));
        require(!(((0 + ((0x04 + arg1) + 0x20)) + 0x20) - (0 + ((0x04 + arg1) + 0x20))) < 0x20);
        require((0 + (arg1 + 0x20)) == (address(0 + (arg1 + 0x20))));
        require(address(0 + (arg1 + 0x20)) == 0x5c7f8a570d578ed84e63fdfa7b1ee72deae1ae23);
        require(address(0x5c7f8a570d578ed84e63fdfa7b1ee72deae1ae23).code.length);
        (bool success, bytes memory ret0) = address(0x5c7f8a570d578ed84e63fdfa7b1ee72deae1ae23).{ value: msg.value }deposit(); // call
        require(0 < (arg1));
        require(!(((0 + ((0x04 + arg1) + 0x20)) + 0x20) - (0 + ((0x04 + arg1) + 0x20))) < 0x20);
        require((0 + (arg1 + 0x20)) == (address(0 + (arg1 + 0x20))));
        require(0x01 < (arg1));
        require(!(((0x20 + ((0x04 + arg1) + 0x20)) + 0x20) - (0x20 + ((0x04 + arg1) + 0x20))) < 0x20);
        require((0x20 + (arg1 + 0x20)) == (address(0x20 + (arg1 + 0x20))));
        require(!(address(0 + (arg1 + 0x20))) == (address(0x20 + (arg1 + 0x20))));
        require(address(0 + (arg1 + 0x20)) < (address(0x20 + (arg1 + 0x20))));
        require(address(0 + (arg1 + 0x20)));
        uint256 var_d = 0x28 + (0x20 + var_d);
        address var_l = address(keccak256(var_m));
        require(address(0x5c7f8a570d578ed84e63fdfa7b1ee72deae1ae23).code.length);
        (bool success, bytes memory ret0) = address(0x5c7f8a570d578ed84e63fdfa7b1ee72deae1ae23).{ value: 0 ether }Unresolved_a9059cbb(var_l); // call
        var_d = var_d + (uint248(ret0.length + 0x1f));
        require(!((var_d + ret0.length) - var_d) < 0x20);
        require(var_d.length == var_d.length);
        require(var_d.length);
        require((arg1 + 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (arg1));
    }
    
    /// @custom:selector    0x4a25d94a
    /// @custom:signature   swapTokensForExactETH(uint256 arg0, uint256 arg1, address[] arg2, address arg3, uint256 arg4) public
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    /// @param              arg1 ["uint256", "bytes32", "int256"]
    /// @param              arg2 ["uint256", "bytes32", "int256"]
    /// @param              arg3 ["address", "uint160", "bytes20", "int160"]
    /// @param              arg4 ["uint256", "bytes32", "int256"]
    function swapTokensForExactETH(uint256 arg0, uint256 arg1, address[] arg2, address arg3, uint256 arg4) public {
        require(!arg2 > 0xffffffffffffffff);
        require(!(arg2) > 0xffffffffffffffff);
        require(arg3 == (address(arg3)));
        require(!arg4 < block.timestamp);
        require((arg2 + 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (arg2));
        require(!(((0x20 * (arg2 + 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff)) + ((0x04 + arg2) + 0x20) + 0x20) - ((0x20 * (arg2 + 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff)) + ((0x04 + arg2) + 0x20))) < 0x20);
        require((0x20 * (arg2 + 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff)) + (arg2 + 0x20) == (address((0x20 * (arg2 + 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff)) + (arg2 + 0x20))));
        require(address((0x20 * (arg2 + 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff)) + (arg2 + 0x20)) == 0x5c7f8a570d578ed84e63fdfa7b1ee72deae1ae23);
        uint256 var_a = var_a + (0x20 + (0x20 * (arg2)));
        require(!var_a.length < 0x02);
        require(!var_a.length > 0xffffffffffffffff);
        var_a = var_a + (0x20 + (0x20 * var_a.length));
        require(!var_a.length, "EmpireRouter: EXCESSIVE_INPUT_AMOUNT");
        var_c = msg.data[4:4];
        require((var_a.length - 0x01) < var_a.length, "EmpireRouter: EXCESSIVE_INPUT_AMOUNT");
        require(!(0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff + var_a.length), "EmpireRouter: EXCESSIVE_INPUT_AMOUNT");
        require(!(var_c > arg1), "EmpireRouter: EXCESSIVE_INPUT_AMOUNT");
        require(0 < (arg2));
        require(((0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff + var_a.length) - 0x01) < var_a.length);
        require((0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff + var_a.length) < var_a.length);
        require(!(address(var_j)) == (address(var_k)));
        require(address(var_j) < (address(var_k)));
        require(address(var_j));
        require(!(address(var_j)) == (address(var_k)));
        require(address(var_j) < (address(var_k)));
        require(address(var_j));
        var_a = 0x28 + (0x20 + var_a);
        require(address(keccak256(var_t)).code.length);
        (bool success, bytes memory ret0) = address(keccak256(var_t)).getReserves(); // staticcall
        var_a = var_a + (uint248(ret0.length + 0x1f));
        require(!((var_a + ret0.length) - var_a) < 0x60);
        require(var_a.length == (uint112(var_a.length)));
        require(var_t == (uint112(var_t)));
        require(var_u == (uint32(var_u)));
        require(address(var_j) == (address(var_j)), "ds-math-mul-overflow");
        require((0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff + var_a.length) < var_a.length, "ds-math-mul-overflow");
        require(var_k > 0, "ds-math-mul-overflow");
        require(!(uint112(var_t) > 0), "ds-math-mul-overflow");
        require(uint112(var_a.length) > 0, "ds-math-mul-overflow");
        require(!(var_k), "ds-math-mul-overflow");
        require(var_k, "ds-math-mul-overflow");
        require(uint112(var_t) * (var_k) / (var_k) == (uint112(var_t)), "ds-math-mul-overflow");
    }
    
    /// @custom:selector    0x5c11d795
    /// @custom:signature   swapExactTokensForTokensSupportingFeeOnTransferTokens(uint256 arg0, uint256 arg1, address[] arg2, address arg3, uint256 arg4) public
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    /// @param              arg1 ["uint256", "bytes32", "int256"]
    /// @param              arg2 ["uint256", "bytes32", "int256"]
    /// @param              arg3 ["address", "uint160", "bytes20", "int160"]
    /// @param              arg4 ["uint256", "bytes32", "int256"]
    function swapExactTokensForTokensSupportingFeeOnTransferTokens(uint256 arg0, uint256 arg1, address[] arg2, address arg3, uint256 arg4) public {
        require(!arg2 > 0xffffffffffffffff);
        require(!(arg2) > 0xffffffffffffffff);
        require(arg3 == (address(arg3)));
        require(!arg4 < block.timestamp);
        require(0 < (arg2));
        require(!(((0 + ((0x04 + arg2) + 0x20)) + 0x20) - (0 + ((0x04 + arg2) + 0x20))) < 0x20);
        require((0 + (arg2 + 0x20)) == (address(0 + (arg2 + 0x20))));
        require(0 < (arg2));
        require(!(((0 + ((0x04 + arg2) + 0x20)) + 0x20) - (0 + ((0x04 + arg2) + 0x20))) < 0x20);
        require((0 + (arg2 + 0x20)) == (address(0 + (arg2 + 0x20))));
        require(0x01 < (arg2));
        require(!(((0x20 + ((0x04 + arg2) + 0x20)) + 0x20) - (0x20 + ((0x04 + arg2) + 0x20))) < 0x20);
        require((0x20 + (arg2 + 0x20)) == (address(0x20 + (arg2 + 0x20))));
        require(!(address(0 + (arg2 + 0x20)) == (address(0x20 + (arg2 + 0x20)))), "TransferHelper::transferFrom: transferFrom failed");
        require(address(0 + (arg2 + 0x20)) < (address(0x20 + (arg2 + 0x20))), "TransferHelper::transferFrom: transferFrom failed");
        require(address(0 + (arg2 + 0x20)), "TransferHelper::transferFrom: transferFrom failed");
        uint256 var_c = ((0x28 + (0x20 + var_d)) - var_d) - 0x20;
        uint256 var_d = 0x28 + (0x20 + var_d);
        var_d = 0x55 + (0x20 + var_d);
        var_d = 0x60 + (0x24 + var_d);
        require(!(0 > var_d.length), "TransferHelper::transferFrom: transferFrom failed");
        (bool success, bytes memory ret0) = address(0 + (arg2 + 0x20)).transfer(0);
        require(ret0.length == 0, "TransferHelper::transferFrom: transferFrom failed");
        require((arg2 + 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (arg2));
        require(!var_v);
        require(!((0x80 + var_v) - 0x80) < 0x20);
        require(var_c == var_c);
        var_d = var_d + (uint248(ret0.length + 0x3f));
        require(!var_d.length, "TransferHelper::transferFrom: transferFrom failed");
        require(!var_d.length, "TransferHelper::transferFrom: transferFrom failed");
    }
    
    /// @custom:selector    0x791ac947
    /// @custom:signature   swapExactTokensForETHSupportingFeeOnTransferTokens(uint256 arg0, uint256 arg1, address[] arg2, address arg3, uint256 arg4) public view
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    /// @param              arg1 ["uint256", "bytes32", "int256"]
    /// @param              arg2 ["uint256", "bytes32", "int256"]
    /// @param              arg3 ["address", "uint160", "bytes20", "int160"]
    /// @param              arg4 ["uint256", "bytes32", "int256"]
    function swapExactTokensForETHSupportingFeeOnTransferTokens(uint256 arg0, uint256 arg1, address[] arg2, address arg3, uint256 arg4) public view {
        require(!arg2 > 0xffffffffffffffff);
        require(!(arg2) > 0xffffffffffffffff);
        require(arg3 == (address(arg3)));
        require(!arg4 < block.timestamp);
        require((arg2 + 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) < (arg2));
        require(!(((0x20 * (arg2 + 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff)) + ((0x04 + arg2) + 0x20) + 0x20) - ((0x20 * (arg2 + 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff)) + ((0x04 + arg2) + 0x20))) < 0x20);
        require((0x20 * (arg2 + 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff)) + (arg2 + 0x20) == (address((0x20 * (arg2 + 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff)) + (arg2 + 0x20))));
        require(address((0x20 * (arg2 + 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff)) + (arg2 + 0x20)) == 0x5c7f8a570d578ed84e63fdfa7b1ee72deae1ae23, "EmpireRouter: INVALID_PATH");
        require(0 < (arg2), "EmpireRouter: INVALID_PATH");
    }
    
    /// @custom:selector    0xded9382a
    /// @custom:signature   Unresolved_ded9382a(address arg0) public pure
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    function Unresolved_ded9382a(address arg0) public pure {
        require(arg0 == (address(arg0)));
    }
}