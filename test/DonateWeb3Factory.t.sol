// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {DonateWeb3Factory} from "../src/DonateWeb3Factory.sol";

contract DonateWeb3FactoryTest is Test {
    DonateWeb3Factory public factory;
    address public creator = address(111);

    function setUp() public {
        factory = new DonateWeb3Factory();
    }

    function test_CreatePool() public {
        vm.prank(creator);
        address poolAddr = factory.createPool();

        assertEq(factory.addressToPool(creator), poolAddr);
        assertEq(factory.pools(0), poolAddr);
        assertEq(factory.poolCount(), 1);
    }

    function testFail_CreatrPool() public {
        vm.prank(creator);
        factory.createPool();
        vm.prank(creator);
        factory.createPool();
    }
}
