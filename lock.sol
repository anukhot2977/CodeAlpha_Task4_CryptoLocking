// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Lock {

    address public owner;
    uint public unlockTime;

    constructor(uint _unlockTime) payable {
        require(_unlockTime > block.timestamp, "Future time required");
        owner = msg.sender;
        unlockTime = _unlockTime;
    }

    function deposit() public payable {}

    function withdraw() public {
        require(block.timestamp >= unlockTime, "Still locked");
        require(msg.sender == owner, "Not owner");

        payable(owner).transfer(address(this).balance);
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}