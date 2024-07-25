// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./DonateWeb3Pool.sol";

contract DonateWeb3Factory {
    mapping(address => address) public addressToPool;
    address[] public pools;
    uint256 public poolCount;

    function createPool() external returns (address) {
        require(addressToPool[msg.sender] == address(0), "pool already exists!");

        address poolAddr = address(new DonateWeb3Pool(msg.sender));
        addressToPool[msg.sender] = poolAddr;

        pools.push(poolAddr);
        poolCount++;

        return poolAddr;
    }
}
