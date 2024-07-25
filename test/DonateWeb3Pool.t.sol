// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {DonateWeb3Pool} from "../src/DonateWeb3Pool.sol";

contract DonateWeb3PoolTest is Test {
    DonateWeb3Pool public donateWeb3Pool;
    address public ownerAddr = address(111);
    address[3] public donors = [address(222), address(333), address(444)];

    event DonateLog(address indexed donor, uint256 amount);

    function setUp() public {
        donateWeb3Pool = new DonateWeb3Pool(ownerAddr);
        for (uint256 i = 0; i < 3; i++) {
            vm.deal(donors[i], 1 ether);
        }
    }

    // fail because donor should donate more than 0
    function testFail_Donate() public {
        vm.prank(donors[0]);
        donateWeb3Pool.donate();
    }

    function test_Donate() public {
        // vm setting
        vm.prank(donors[0]);
        // topic1, topic2, topic3, data
        vm.expectEmit(true, false, false, true);

        uint256 balance = 1000;
        emit DonateLog(donors[0], balance);

        // call function
        donateWeb3Pool.donate{value: balance}();

        address donor = donateWeb3Pool.getDonorList()[0];

        // assertion
        assertGt(address(donateWeb3Pool).balance, 0);
        assertEq(donateWeb3Pool.donorToValue(donors[0]), balance);
        assertEq(donor, donors[0]);
        assertEq(donateWeb3Pool.totalDonation(), balance);
    }

    // fail because sender is not owner
    function testFail_Withdraw() public {
        vm.prank(donors[1]);
        donateWeb3Pool.withdraw();
    }

    function test_Withdraw() public {
        // donate setup
        vm.prank(donors[0]);
        uint256 balance = 1000;
        donateWeb3Pool.donate{value: balance}();

        // withdraw start
        vm.prank(ownerAddr);
        donateWeb3Pool.withdraw();

        assertEq(ownerAddr.balance, balance);
        assertEq(donateWeb3Pool.totalDonation(), 0);
        assertEq(address(donateWeb3Pool).balance, 0);
    }
}
