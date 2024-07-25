// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {DonateWeb3Factory} from "../src/DonateWeb3Factory.sol";

contract DonateScript is Script {
    function setUp() public {}

    function run() public {
        uint256 deployPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployPrivateKey);

        new DonateWeb3Factory();

        vm.stopBroadcast();
    }
}
