// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
contract MessageCon {
    event Message (address indexed from, address indexed to, string text);
    function sendMessage(address to, string calldata text) external {
        emit Message(msg.sender, to, text);
    }
}
