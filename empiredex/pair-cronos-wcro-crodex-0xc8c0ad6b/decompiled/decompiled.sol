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
    string public constant name = "Empire LP";
    uint256 public constant factory = 36105369479179084578288331048029013545440310045;
    uint256 public constant decimals = 18;
    string public constant symbol = "EMP-LP";
    
    mapping(bytes32 => bytes32) storage_map_a;
    uint256 public liquidityLocked;
    address public token0;
    uint256 public price1CumulativeLast;
    uint256 public sweptAmount;
    uint256 public empireLockTime;
    uint256 public price0CumulativeLast;
    bytes public getReserves;
    address public sweepableToken;
    mapping(bytes32 => bytes32) storage_map_b;
    uint256 public totalSupply;
    bool public empirePairType;
    address public token1;
    uint256 public kLast;
    bytes32 store_d;
    
    event Approval(address, address, uint256);
    event Swept(uint256);
    event Sync(uint112, uint112);
    event Transfer(address, address, uint256);
    event Unswept(uint256);
    
    /// @custom:selector    0xd505accf
    /// @custom:signature   permit(address arg0, address arg1, uint256 arg2, uint256 arg3, uint8 arg4, bytes32 arg5, bytes32 arg6) public payable
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    /// @param              arg1 ["address", "uint160", "bytes20", "int160"]
    /// @param              arg2 ["uint256", "bytes32", "int256"]
    /// @param              arg3 ["uint256", "bytes32", "int256"]
    /// @param              arg4 ["bool", "uint8", "bytes1", "int8"]
    /// @param              arg5 ["uint256", "bytes32", "int256"]
    /// @param              arg6 ["uint256", "bytes32", "int256"]
    function permit(address arg0, address arg1, uint256 arg2, uint256 arg3, uint8 arg4, bytes32 arg5, bytes32 arg6) public payable {
        require(!arg3 < block.timestamp);
        var_a = this.code[10512:10594];
        address var_b = address(arg0);
        var_c = 0x03;
        storage_map_a[var_b] = storage_map_a[var_b] + 0x01;
        uint256 var_k = var_k + 0xe0;
        require(!block.chainid == 0x19);
        require(var_c);
        require(!(address(var_w)), "Empire: INVALID_SIGNATURE");
        require(address(var_w) == (address(arg0)), "Empire: INVALID_SIGNATURE");
        var_b = address(arg1);
        storage_map_a[var_b] = arg2;
        emit Approval(address(arg0), address(arg1), arg2);
        require(!(!address(var_w)), "Empire: INVALID_SIGNATURE");
        var_b = address(arg1);
        var_c = keccak256(var_b);
        storage_map_a[var_b] = arg2;
        emit Approval(address(arg0), address(arg1), arg2);
        var_x = 0x20;
        var_a = this.code[10594:10676];
        var_k = 0x40 + var_k;
        var_k = var_k + 0xc0;
        require(var_c);
    }
    
    /// @custom:selector    0x23b872dd
    /// @custom:signature   transferFrom(address arg0, address arg1, uint256 arg2) public payable returns (bool)
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    /// @param              arg1 ["address", "uint160", "bytes20", "int160"]
    /// @param              arg2 ["uint256", "bytes32", "int256"]
    function transferFrom(address arg0, address arg1, uint256 arg2) public payable returns (bool) {
        var_a = msg.sender;
        require(0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff == storage_map_b[var_a], "ds-math-sub-underflow");
        var_a = address(arg0);
        require(!((storage_map_b[var_a] - arg2) > storage_map_b[var_a]), "ds-math-sub-underflow");
        var_a = address(arg0);
        storage_map_b[var_a] = storage_map_b[var_a] - arg2;
        var_a = address(arg1);
        require(!((storage_map_b[var_a] + arg2) < storage_map_b[var_a]), "ds-math-add-overflow");
        var_a = address(arg1);
        storage_map_b[var_a] = storage_map_b[var_a] + arg2;
        emit Transfer(address(arg0), address(arg1), arg2);
        return 0x01;
    }
    
    /// @custom:selector    0x022c0d9f
    /// @custom:signature   Unresolved_022c0d9f(uint256 arg0, uint256 arg1, address arg2, uint256 arg3) public payable
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    /// @param              arg1 ["uint256", "bytes32", "int256"]
    /// @param              arg2 ["address", "uint160", "bytes20", "int160"]
    /// @param              arg3 ["uint256", "bytes32", "int256"]
    function Unresolved_022c0d9f(uint256 arg0, uint256 arg1, address arg2, uint256 arg3) public payable {
        require(!arg3 > 0x0100000000);
        require(0x01 == store_d, "Empire: TRANSFER_FAILED");
        store_d = 0x02;
        require(arg0, "Empire: TRANSFER_FAILED");
        require(arg0, "Empire: TRANSFER_FAILED");
        require(!(arg0 < (uint112(getReserves))), "Empire: TRANSFER_FAILED");
        require(arg1 < (uint112(getReserves / 0x010000000000000000000000000000)), "Empire: TRANSFER_FAILED");
        require(address(token0) == (address(arg2)), "Empire: TRANSFER_FAILED");
        require(!(address(arg2) == (address(token1))), "Empire: TRANSFER_FAILED");
        require(!arg0, "Empire: TRANSFER_FAILED");
        uint256 var_a = 0x40 + var_a;
        var_a = var_a + 0x64;
        require(var_a.length < 0x20, "Empire: TRANSFER_FAILED");
        (bool success, bytes memory ret0) = address(token0).{ value: 0 ether }adfepixw(); // call
        require(ret0.length == 0, "Empire: TRANSFER_FAILED");
        require(!arg1);
        require(!arg3);
        address var_k = address(msg.sender);
        uint256 var_q = 0;
        require(address(arg2).code.length);
        (bool success, bytes memory ret0) = address(arg2).{ value: var_q ether }Unresolved_f05ffd30(var_k); // call
        require(!(address(sweepableToken)) == (address(token0)));
        var_k = address(this);
        require(address(token0).code.length);
        (bool success, bytes memory ret0) = address(token0).Unresolved_70a08231(var_k); // staticcall
        require(!(ret0.length < 0x20), "ds-math-add-overflow");
        require(!((0 + var_a.length) < 0), "ds-math-add-overflow");
        var_k = address(this);
        require(address(token0).code.length);
        (bool success, bytes memory ret0) = address(token0).Unresolved_70a08231(var_k); // staticcall
        require(!ret0.length < 0x20);
        require(!var_r);
        require(!var_r < 0x20);
        var_a = var_a + (uint248(ret0.length + 0x3f));
        require(!var_a.length, "Empire: TRANSFER_FAILED");
        require(!var_a.length, "Empire: TRANSFER_FAILED");
    }
    
    /// @custom:selector    0x60d780ee
    /// @custom:signature   initialize(address arg0, address arg1, uint8 arg2, uint256 arg3) public payable
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    /// @param              arg1 ["address", "uint160", "bytes20", "int160"]
    /// @param              arg2 ["bool", "uint8", "bytes1", "int8"]
    /// @param              arg3 ["uint256", "bytes32", "int256"]
    function initialize(address arg0, address arg1, uint8 arg2, uint256 arg3) public payable {
        require(0x06530550a48f990360dfd642d2132354a144f31d == msg.sender, "Empire: FORBIDDEN");
        token0 = (uint96(token0)) | (address(arg0));
        token1 = (uint96(token1)) | (address(arg1));
        require(!(bytes1(arg2) > 0x03), "Empire: FORBIDDEN");
        require(bytes1(arg2) == 0, "Empire: FORBIDDEN");
        liquidityLocked = arg3;
        require(!(bytes1(arg2) > 0x03), "Empire: FORBIDDEN");
        empirePairType = (bytes1(arg2) * 0x01) | (uint248(empirePairType));
        require(!(bytes1(arg2) > 0x03), "Empire: FORBIDDEN");
        require(!(bytes1(arg2) == 0x02), "Empire: FORBIDDEN");
        sweepableToken = (address(arg0)) | (uint96(sweepableToken));
        empireLockTime = arg3;
        require(!(bytes1(arg2) > 0x03), "Empire: FORBIDDEN");
        require(!(bytes1(arg2) == 0x03), "Empire: FORBIDDEN");
        sweepableToken = (address(arg1)) | (uint96(sweepableToken));
        empireLockTime = arg3;
        empireLockTime = arg3;
        empireLockTime = arg3;
    }
    
    /// @custom:selector    0xae84637f
    /// @custom:signature   unsweep(uint256 arg0) public payable
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    function unsweep(uint256 arg0) public payable {
        require(0x01 == store_d, "Empire: INCORRECT_CALLER");
        store_d = 0x02;
        require(!(address(token0) == msg.sender), "Empire: INCORRECT_CALLER");
        require(!(address(token1) == msg.sender), "Empire: INCORRECT_CALLER");
        require(address(token1) == msg.sender, "Empire: INCORRECT_CALLER");
        uint256 var_e = 0x60 + var_e;
        var_f = this.code[10475:10512];
        var_e = var_e + 0x84;
        require(var_e.length < 0x20, "Empire: TRANSFER_FAILED");
        (bool success, bytes memory ret0) = address(sweepableToken).{ value: 0 ether }adfepixw(); // call
        require(ret0.length == 0, "Empire: TRANSFER_FAILED");
        require(!((sweptAmount - arg0) > sweptAmount), "ds-math-sub-underflow");
        sweptAmount = sweptAmount - arg0;
        emit Unswept(arg0);
        store_d = 0x01;
        require(!var_q);
        require(!var_q < 0x20);
        var_e = var_e + (uint248(ret0.length + 0x3f));
        require(!var_e.length, "Empire: TRANSFER_FAILED");
        require(!var_e.length, "Empire: TRANSFER_FAILED");
        require(address(sweepableToken) == (address(token1)), "Empire: INCORRECT_CALLER");
    }
    
    /// @custom:selector    0x7ecebe00
    /// @custom:signature   nonces(address arg0) public view returns (uint256)
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    function nonces(address arg0) public view returns (uint256) {
        address var_b = address(arg0);
        return storage_map_a[var_b];
    }
    
    /// @custom:selector    0x095ea7b3
    /// @custom:signature   approve(address arg0, uint256 arg1) public payable returns (bool)
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    /// @param              arg1 ["uint256", "bytes32", "int256"]
    function approve(address arg0, uint256 arg1) public payable returns (bool) {
        var_a = address(arg0);
        storage_map_b[var_a] = arg1;
        emit Approval(address(msg.sender), address(arg0), arg1);
        return 0x01;
    }
    
    /// @custom:selector    0xa9059cbb
    /// @custom:signature   transfer(address arg0, uint256 arg1) public payable returns (bool)
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    /// @param              arg1 ["uint256", "bytes32", "int256"]
    function transfer(address arg0, uint256 arg1) public payable returns (bool) {
        address var_a = address(msg.sender);
        require(!((storage_map_b[var_a] - arg1) > storage_map_b[var_a]), "ds-math-sub-underflow");
        var_a = address(msg.sender);
        storage_map_b[var_a] = storage_map_b[var_a] - arg1;
        var_a = address(arg0);
        require(!((storage_map_b[var_a] + arg1) < storage_map_b[var_a]), "ds-math-add-overflow");
        var_a = address(arg0);
        storage_map_b[var_a] = storage_map_b[var_a] + arg1;
        emit Transfer(address(msg.sender), address(arg0), arg1);
        return 0x01;
    }
    
    /// @custom:selector    0xbc25cf77
    /// @custom:signature   skim(address arg0) public payable
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    function skim(address arg0) public payable {
        require(0x01 == store_d);
        store_d = 0x02;
        require(!(address(sweepableToken)) == (address(token0)));
        address var_b = address(this);
        require(address(token0).code.length);
        (bool success, bytes memory ret0) = address(token0).Unresolved_70a08231(var_b); // staticcall
        require(!(ret0.length < 0x20), "ds-math-add-overflow");
        require(!((0 + var_c.length) < 0), "ds-math-add-overflow");
        require(!((0 + var_c.length) - (uint112(getReserves)) > (0 + var_c.length)), "ds-math-sub-underflow");
        uint256 var_c = 0x40 + var_c;
        var_c = var_c + 0x64;
        require(var_c.length < 0x20, "Empire: TRANSFER_FAILED");
        (bool success, bytes memory ret0) = address(token0).{ value: 0 ether }adfepixw(); // call
        require(ret0.length == 0, "Empire: TRANSFER_FAILED");
        require(!var_q);
        require(!var_q < 0x20);
        var_c = var_c + (uint248(ret0.length + 0x3f));
        require(!var_c.length, "Empire: TRANSFER_FAILED");
        require(!var_c.length, "Empire: TRANSFER_FAILED");
        var_b = address(this);
        require(address(token0).code.length);
        (bool success, bytes memory ret0) = address(token0).balanceOf(var_b); // staticcall
        require(!ret0.length < 0x20);
    }
    
    /// @custom:selector    0x6a627842
    /// @custom:signature   mint(address arg0) public payable
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    function mint(address arg0) public payable {
        require(0x01 == store_d);
        store_d = 0x02;
        require(!(address(sweepableToken)) == (address(token0)));
        address var_b = address(this);
        require(address(token0).code.length);
        (bool success, bytes memory ret0) = address(token0).Unresolved_70a08231(var_b); // staticcall
        require(!(ret0.length < 0x20), "ds-math-add-overflow");
        require(!((0 + var_c.length) < 0), "ds-math-add-overflow");
        require(!(address(sweepableToken)) == (address(token1)));
        var_b = address(this);
        require(address(token1).code.length);
        (bool success, bytes memory ret0) = address(token1).Unresolved_70a08231(var_b); // staticcall
        require(!(ret0.length < 0x20), "ds-math-add-overflow");
        require(!((0 + var_c.length) < 0), "ds-math-add-overflow");
        require(!((0 + var_c.length) - (uint112(getReserves)) > (0 + var_c.length)), "ds-math-sub-underflow");
        require(!((0 + var_c.length) - (uint112(getReserves / 0x010000000000000000000000000000)) > (0 + var_c.length)), "ds-math-sub-underflow");
        require(address(0x06530550a48f990360dfd642d2132354a144f31d).code.length);
        (bool success, bytes memory ret0) = address(0x06530550a48f990360dfd642d2132354a144f31d).feeTo(); // staticcall
        require(!(ret0.length < 0x20), "ds-math-mul-overflow");
        require(!(address(var_c.length)), "ds-math-mul-overflow");
        require(!kLast, "ds-math-mul-overflow");
        require(!(uint112(getReserves / 0x010000000000000000000000000000)), "ds-math-mul-overflow");
        require(uint112(getReserves / 0x010000000000000000000000000000), "ds-math-mul-overflow");
        require(uint112(getReserves) * (uint112(getReserves / 0x010000000000000000000000000000)) / (uint112(getReserves / 0x010000000000000000000000000000)) == (uint112(getReserves)), "ds-math-mul-overflow");
        require(!(uint112(getReserves) * (uint112(getReserves / 0x010000000000000000000000000000)) > 0x03), "ds-math-sub-underflow");
        require(!(((uint112(getReserves) * (uint112(getReserves / 0x010000000000000000000000000000)) / 0x02) + 0x01) < (uint112(getReserves) * (uint112(getReserves / 0x010000000000000000000000000000)))), "ds-math-sub-underflow");
        require((uint112(getReserves) * (uint112(getReserves / 0x010000000000000000000000000000)) / 0x02) + 0x01, "ds-math-sub-underflow");
        require(0x02, "ds-math-sub-underflow");
        require(!((uint112(getReserves) * (uint112(getReserves / 0x010000000000000000000000000000)) / ((uint112(getReserves) * (uint112(getReserves / 0x010000000000000000000000000000)) / 0x02) + 0x01) + ((uint112(getReserves) * (uint112(getReserves / 0x010000000000000000000000000000)) / 0x02) + 0x01) / 0x02) < ((uint112(getReserves) * (uint112(getReserves / 0x010000000000000000000000000000)) / 0x02) + 0x01)), "ds-math-sub-underflow");
        require(!(kLast > 0x03), "ds-math-sub-underflow");
        require(!(((kLast / 0x02) + 0x01) < kLast), "ds-math-sub-underflow");
        require((kLast / 0x02) + 0x01, "ds-math-sub-underflow");
        require(0x02, "ds-math-sub-underflow");
        require(!(((kLast / ((kLast / 0x02) + 0x01)) + ((kLast / 0x02) + 0x01) / 0x02) < ((kLast / 0x02) + 0x01)), "ds-math-sub-underflow");
        require(!(((uint112(getReserves) * (uint112(getReserves / 0x010000000000000000000000000000)) / 0x02) + 0x01) > ((kLast / 0x02) + 0x01)), "ds-math-sub-underflow");
        require(!(((uint112(getReserves) * (uint112(getReserves / 0x010000000000000000000000000000)) / 0x02) + 0x01) - ((kLast / 0x02) + 0x01) > ((uint112(getReserves) * (uint112(getReserves / 0x010000000000000000000000000000)) / 0x02) + 0x01)), "ds-math-sub-underflow");
        require(!(((uint112(getReserves) * (uint112(getReserves / 0x010000000000000000000000000000)) / 0x02) + 0x01) - ((kLast / 0x02) + 0x01)), "ds-math-mul-overflow");
        require(((uint112(getReserves) * (uint112(getReserves / 0x010000000000000000000000000000)) / 0x02) + 0x01) - ((kLast / 0x02) + 0x01), "ds-math-mul-overflow");
        require((totalSupply * (((uint112(getReserves) * (uint112(getReserves / 0x010000000000000000000000000000)) / 0x02) + 0x01) - ((kLast / 0x02) + 0x01))) / (((uint112(getReserves) * (uint112(getReserves / 0x010000000000000000000000000000)) / 0x02) + 0x01) - ((kLast / 0x02) + 0x01)) == totalSupply, "ds-math-mul-overflow");
        require(!0x05, "ds-math-add-overflow");
        require(!0x05, "ds-math-add-overflow");
        require(!((0 + ((kLast / 0x02) + 0x01)) < 0), "ds-math-add-overflow");
        require(0 + ((kLast / 0x02) + 0x01), "ds-math-add-overflow");
        require(!((totalSupply * (((uint112(getReserves) * (uint112(getReserves / 0x010000000000000000000000000000)) / 0x02) + 0x01) - ((kLast / 0x02) + 0x01))) / (0 + ((kLast / 0x02) + 0x01))), "ds-math-add-overflow");
        require(!((totalSupply + ((totalSupply * (((uint112(getReserves) * (uint112(getReserves / 0x010000000000000000000000000000)) / 0x02) + 0x01) - ((kLast / 0x02) + 0x01))) / (0 + ((kLast / 0x02) + 0x01)))) < totalSupply), "ds-math-add-overflow");
        if (totalSupply) {
        }
        require(0x05, "ds-math-mul-overflow");
        require(((((uint112(getReserves) * (uint112(getReserves / 0x010000000000000000000000000000)) / 0x02) + 0x01) * 0x05) / 0x05) == ((uint112(getReserves) * (uint112(getReserves / 0x010000000000000000000000000000)) / 0x02) + 0x01), "ds-math-mul-overflow");
        if ((kLast / ((kLast / 0x02) + 0x01)) + ((kLast / 0x02) + 0x01) / 0x02) {
            if (0x02) {
                if (!((uint112(getReserves) * (uint112(getReserves / 0x010000000000000000000000000000)) / 0x02) + 0x01) > kLast) {
                }
                if (!kLast) {
                }
                require((kLast / ((kLast / 0x02) + 0x01)) + ((kLast / 0x02) + 0x01) / 0x02);
                require(0x02);
            }
            require(!kLast > 0x03);
        }
        var_b = address(this);
        require(address(token1).code.length);
        (bool success, bytes memory ret0) = address(token1).Unresolved_70a08231(var_b); // staticcall
        require(!ret0.length < 0x20);
    }
    
    /// @custom:selector    0x70a08231
    /// @custom:signature   balanceOf(address arg0) public view returns (uint256)
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    function balanceOf(address arg0) public view returns (uint256) {
        address var_b = address(arg0);
        return storage_map_a[var_b];
    }
    
    /// @custom:selector    0xfff6cae9
    /// @custom:signature   sync() public payable
    function sync() public payable {
        require(0x01 == store_d);
        store_d = 0x02;
        require(!(address(sweepableToken)) == (address(token0)));
        address var_b = address(this);
        require(address(token0).code.length);
        (bool success, bytes memory ret0) = address(token0).Unresolved_70a08231(var_b); // staticcall
        require(!(ret0.length < 0x20), "ds-math-add-overflow");
        require(!((0 + var_c.length) < 0), "ds-math-add-overflow");
        require(!(address(sweepableToken)) == (address(token1)));
        var_b = address(this);
        require(address(token1).code.length);
        (bool success, bytes memory ret0) = address(token1).Unresolved_70a08231(var_b); // staticcall
        require(!(ret0.length < 0x20), "ds-math-add-overflow");
        require(!((0 + var_c.length) < 0), "ds-math-add-overflow");
        if ((0 + var_c.length) > 0xffffffffffffffffffffffffffff) {
            require((0 + var_c.length) > 0xffffffffffffffffffffffffffff, "Empire: OVERFLOW");
            require(!((0 + var_c.length) > 0xffffffffffffffffffffffffffff), "Empire: OVERFLOW");
            require(!(uint32(block.timestamp - (getReserves / 0x0100000000000000000000000000000000000000000000000000000000))), "Empire: OVERFLOW");
            require(!(uint32(block.timestamp - (getReserves / 0x0100000000000000000000000000000000000000000000000000000000))), "Empire: OVERFLOW");
            getReserves = (uint32(block.timestamp) * 0x0100000000000000000000000000000000000000000000000000000000) | (uint224((0x010000000000000000000000000000 * (uint112(0 + var_c.length))) | (address(uint112(0 + var_c.length) | (address(getReserves))))));
            emit Sync(uint112((uint32(uint32(block.timestamp)) * 0x0100000000000000000000000000000000000000000000000000000000) | (uint224((0x010000000000000000000000000000 * (0 + var_c.length)) | (address((0 + var_c.length) | (address(getReserves))))))), uint112((uint32(uint32(block.timestamp)) * 0x0100000000000000000000000000000000000000000000000000000000) | (uint224((0x010000000000000000000000000000 * (0 + var_c.length)) | (address((0 + var_c.length) | (address(getReserves)))))) / 0x010000000000000000000000000000));
            store_d = 0x01;
            require(!(uint32(block.timestamp - (getReserves / 0x0100000000000000000000000000000000000000000000000000000000))), "Empire: OVERFLOW");
            require(uint112(getReserves), "Empire: OVERFLOW");
            getReserves = (uint32(block.timestamp) * 0x0100000000000000000000000000000000000000000000000000000000) | (uint224((0x010000000000000000000000000000 * (uint112(0 + var_c.length))) | (address(uint112(0 + var_c.length) | (address(getReserves))))));
            emit Sync(uint112((uint32(uint32(block.timestamp)) * 0x0100000000000000000000000000000000000000000000000000000000) | (uint224((0x010000000000000000000000000000 * (0 + var_c.length)) | (address((0 + var_c.length) | (address(getReserves))))))), uint112((uint32(uint32(block.timestamp)) * 0x0100000000000000000000000000000000000000000000000000000000) | (uint224((0x010000000000000000000000000000 * (0 + var_c.length)) | (address((0 + var_c.length) | (address(getReserves)))))) / 0x010000000000000000000000000000));
            store_d = 0x01;
            require(!(uint112(getReserves / 0x010000000000000000000000000000)), "Empire: OVERFLOW");
        }
        var_b = address(this);
        require(address(token1).code.length);
        (bool success, bytes memory ret0) = address(token1).balanceOf(var_b); // staticcall
        require(!ret0.length < 0x20);
    }
    
    /// @custom:selector    0xdd62ed3e
    /// @custom:signature   allowance(address arg0, address arg1) public view returns (uint256)
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    /// @param              arg1 ["address", "uint160", "bytes20", "int160"]
    function allowance(address arg0, address arg1) public view returns (uint256) {
        address var_b = address(arg0);
        var_b = address(arg1);
        return storage_map_a[var_b];
    }
    
    /// @custom:selector    0x89afcb44
    /// @custom:signature   burn(address arg0) public payable
    /// @param              arg0 ["address", "uint160", "bytes20", "int160"]
    function burn(address arg0) public payable {
        require(0x01 == store_d, "Empire: LIQUIDITY_LOCKED");
        store_d = 0x02;
        require(!(block.timestamp < liquidityLocked), "Empire: LIQUIDITY_LOCKED");
        require(!(address(sweepableToken)) == (address(token0)));
        address var_b = address(this);
        require(address(token0).code.length);
        (bool success, bytes memory ret0) = address(token0).Unresolved_70a08231(var_b); // staticcall
        require(!(ret0.length < 0x20), "ds-math-add-overflow");
        require(!((0 + var_e.length) < 0), "ds-math-add-overflow");
        require(!(address(sweepableToken)) == (address(token1)));
        var_b = address(this);
        require(address(token1).code.length);
        (bool success, bytes memory ret0) = address(token1).Unresolved_70a08231(var_b); // staticcall
        require(!(ret0.length < 0x20), "ds-math-add-overflow");
        require(!((0 + var_e.length) < 0), "ds-math-add-overflow");
        require(address(0x06530550a48f990360dfd642d2132354a144f31d).code.length);
        (bool success, bytes memory ret0) = address(0x06530550a48f990360dfd642d2132354a144f31d).feeTo(); // staticcall
        require(!(ret0.length < 0x20), "ds-math-mul-overflow");
        require(!(address(var_e.length)), "ds-math-mul-overflow");
        require(!kLast, "ds-math-mul-overflow");
        require(!(uint112(getReserves / 0x010000000000000000000000000000)), "ds-math-mul-overflow");
        require(uint112(getReserves / 0x010000000000000000000000000000), "ds-math-mul-overflow");
        require(uint112(getReserves) * (uint112(getReserves / 0x010000000000000000000000000000)) / (uint112(getReserves / 0x010000000000000000000000000000)) == (uint112(getReserves)), "ds-math-mul-overflow");
        require(!(uint112(getReserves) * (uint112(getReserves / 0x010000000000000000000000000000)) > 0x03), "ds-math-sub-underflow");
        require(!(((uint112(getReserves) * (uint112(getReserves / 0x010000000000000000000000000000)) / 0x02) + 0x01) < (uint112(getReserves) * (uint112(getReserves / 0x010000000000000000000000000000)))), "ds-math-sub-underflow");
        require((uint112(getReserves) * (uint112(getReserves / 0x010000000000000000000000000000)) / 0x02) + 0x01, "ds-math-sub-underflow");
        require(0x02, "ds-math-sub-underflow");
        require(!((uint112(getReserves) * (uint112(getReserves / 0x010000000000000000000000000000)) / ((uint112(getReserves) * (uint112(getReserves / 0x010000000000000000000000000000)) / 0x02) + 0x01) + ((uint112(getReserves) * (uint112(getReserves / 0x010000000000000000000000000000)) / 0x02) + 0x01) / 0x02) < ((uint112(getReserves) * (uint112(getReserves / 0x010000000000000000000000000000)) / 0x02) + 0x01)), "ds-math-sub-underflow");
        require(!(kLast > 0x03), "ds-math-sub-underflow");
        require(!(((kLast / 0x02) + 0x01) < kLast), "ds-math-sub-underflow");
        require((kLast / 0x02) + 0x01, "ds-math-sub-underflow");
        require(0x02, "ds-math-sub-underflow");
        require(!(((kLast / ((kLast / 0x02) + 0x01)) + ((kLast / 0x02) + 0x01) / 0x02) < ((kLast / 0x02) + 0x01)), "ds-math-sub-underflow");
        require(!(((uint112(getReserves) * (uint112(getReserves / 0x010000000000000000000000000000)) / 0x02) + 0x01) > ((kLast / 0x02) + 0x01)), "ds-math-sub-underflow");
        require(!(((uint112(getReserves) * (uint112(getReserves / 0x010000000000000000000000000000)) / 0x02) + 0x01) - ((kLast / 0x02) + 0x01) > ((uint112(getReserves) * (uint112(getReserves / 0x010000000000000000000000000000)) / 0x02) + 0x01)), "ds-math-sub-underflow");
        require(!(((uint112(getReserves) * (uint112(getReserves / 0x010000000000000000000000000000)) / 0x02) + 0x01) - ((kLast / 0x02) + 0x01)), "ds-math-mul-overflow");
        require(((uint112(getReserves) * (uint112(getReserves / 0x010000000000000000000000000000)) / 0x02) + 0x01) - ((kLast / 0x02) + 0x01), "ds-math-mul-overflow");
        require((totalSupply * (((uint112(getReserves) * (uint112(getReserves / 0x010000000000000000000000000000)) / 0x02) + 0x01) - ((kLast / 0x02) + 0x01))) / (((uint112(getReserves) * (uint112(getReserves / 0x010000000000000000000000000000)) / 0x02) + 0x01) - ((kLast / 0x02) + 0x01)) == totalSupply, "ds-math-mul-overflow");
        require(!0x05, "ds-math-add-overflow");
        require(!0x05, "ds-math-add-overflow");
        require(!((0 + ((kLast / 0x02) + 0x01)) < 0), "ds-math-add-overflow");
        require(0 + ((kLast / 0x02) + 0x01), "ds-math-add-overflow");
        require(!((totalSupply * (((uint112(getReserves) * (uint112(getReserves / 0x010000000000000000000000000000)) / 0x02) + 0x01) - ((kLast / 0x02) + 0x01))) / (0 + ((kLast / 0x02) + 0x01))), "ds-math-add-overflow");
        require(!((totalSupply + ((totalSupply * (((uint112(getReserves) * (uint112(getReserves / 0x010000000000000000000000000000)) / 0x02) + 0x01) - ((kLast / 0x02) + 0x01))) / (0 + ((kLast / 0x02) + 0x01)))) < totalSupply), "ds-math-add-overflow");
        require(0x05, "ds-math-mul-overflow");
        require(((((uint112(getReserves) * (uint112(getReserves / 0x010000000000000000000000000000)) / 0x02) + 0x01) * 0x05) / 0x05) == ((uint112(getReserves) * (uint112(getReserves / 0x010000000000000000000000000000)) / 0x02) + 0x01), "ds-math-mul-overflow");
        if ((kLast / ((kLast / 0x02) + 0x01)) + ((kLast / 0x02) + 0x01) / 0x02) {
            if (0x02) {
                if (!((uint112(getReserves) * (uint112(getReserves / 0x010000000000000000000000000000)) / 0x02) + 0x01) > kLast) {
                }
                if (!kLast) {
                }
                require((kLast / ((kLast / 0x02) + 0x01)) + ((kLast / 0x02) + 0x01) / 0x02);
                require(0x02);
            }
            require(!kLast > 0x03);
        }
        var_b = address(this);
        require(address(token1).code.length);
        (bool success, bytes memory ret0) = address(token1).Unresolved_70a08231(var_b); // staticcall
        require(!ret0.length < 0x20);
    }
    
    /// @custom:selector    0xd2ae9a0d
    /// @custom:signature   Unresolved_d2ae9a0d(uint256 arg0, uint256 arg1) public payable
    /// @param              arg0 ["uint256", "bytes32", "int256"]
    /// @param              arg1 ["uint256", "bytes32", "int256"]
    function Unresolved_d2ae9a0d(uint256 arg0, uint256 arg1) public payable {
        require(!arg1 > 0x0100000000);
        require(0x01 == store_d, "Empire: INCORRECT_CALLER");
        store_d = 0x02;
        require(!(address(token0) == msg.sender), "Empire: INCORRECT_CALLER");
        require(!(address(token1) == msg.sender), "Empire: INCORRECT_CALLER");
        require(address(token1) == msg.sender, "Empire: INCORRECT_CALLER");
        require(address(msg.sender).code.length);
        (bool success, bytes memory ret0) = address(msg.sender).totalSupply(); // staticcall
        require(!(ret0.length < 0x20), "ds-math-add-overflow");
        require(!(uint112(getReserves)), "ds-math-add-overflow");
        require(uint112(getReserves), "ds-math-add-overflow");
        require((var_e.length - (uint112(getReserves / 0x010000000000000000000000000000))) * (uint112(getReserves)) / (uint112(getReserves)) == (var_e.length - (uint112(getReserves / 0x010000000000000000000000000000))), "ds-math-add-overflow");
        require(!0x03e8, "ds-math-add-overflow");
        require(!0x03e8, "ds-math-add-overflow");
        require(!((0 + (var_e.length - (uint112(getReserves / 0x010000000000000000000000000000)))) < 0), "ds-math-add-overflow");
        require(0 + (var_e.length - (uint112(getReserves / 0x010000000000000000000000000000))), "ds-math-add-overflow");
        require(!((sweptAmount + arg0) < sweptAmount), "ds-math-add-overflow");
        require(!((sweptAmount + arg0) > (uint112(getReserves) - ((var_e.length - (uint112(getReserves / 0x010000000000000000000000000000))) * (uint112(getReserves)) / (0 + (var_e.length - (uint112(getReserves / 0x010000000000000000000000000000))))))), "Empire: INCORRECT_SWEEP_AMOUNT");
        sweptAmount = sweptAmount + arg0;
        uint256 var_e = 0x40 + var_e;
        var_e = var_e + 0x64;
        require(var_e.length < 0x20, "Empire: TRANSFER_FAILED");
        (bool success, bytes memory ret0) = address(sweepableToken).{ value: 0 ether }adfepixw(); // call
        require(ret0.length == 0, "Empire: TRANSFER_FAILED");
        uint256 var_n = arg0;
        uint256 var_r = 0;
        require(address(msg.sender).code.length);
        (bool success, bytes memory ret0) = address(msg.sender).{ value: var_r ether }Unresolved_11d7ed82(var_n); // call
        emit Swept(arg0);
        store_d = 0x01;
        require(!var_s);
        require(!var_s < 0x20);
        var_e = var_e + (uint248(ret0.length + 0x3f));
        var_p = arg0;
        uint256 var_v = 0;
        require(address(msg.sender).code.length);
        (bool success, bytes memory ret0) = address(msg.sender).{ value: var_v ether }Unresolved_11d7ed82(var_p); // call
        emit Swept(arg0);
        store_d = 0x01;
        require(!var_e.length, "Empire: TRANSFER_FAILED");
        require(!var_e.length, "Empire: TRANSFER_FAILED");
        require(0x03e8, "ds-math-mul-overflow");
        require(((uint112(getReserves / 0x010000000000000000000000000000) * 0x03e8) / 0x03e8) == (uint112(getReserves / 0x010000000000000000000000000000)), "ds-math-mul-overflow");
        require(address(sweepableToken) == (address(token1)), "Empire: INCORRECT_CALLER");
        require(address(msg.sender).code.length);
        (bool success, bytes memory ret0) = address(msg.sender).totalSupply(); // staticcall
        require(!ret0.length < 0x20);
    }
}