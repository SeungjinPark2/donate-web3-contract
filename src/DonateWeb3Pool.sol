// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract DonateWeb3Pool is Ownable {
    mapping(address => uint256) public donorToValue;
    address[] donorList;
    uint256 public totalDonation;

    constructor(address initialOwner) Ownable(initialOwner) {}

    event DonateLog(address indexed donor, uint256 amount);

    function withdraw() external onlyOwner {
        (bool succeed, ) = payable(this.owner()).call{value: totalDonation}("");
        require(succeed, "failed to withdraw");
        totalDonation = 0;
    }

    function donate() external payable {
        require(msg.value > 0, "zero balance is not allowed");
        if (donorToValue[msg.sender] == 0) {
            donorList.push(msg.sender);
        }
        donorToValue[msg.sender] += msg.value;
        totalDonation += msg.value;

        emit DonateLog(msg.sender, msg.value);
    }

    function getDonorList() external view returns (address[] memory) {
        return donorList;
    }
}
