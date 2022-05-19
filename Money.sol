// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
contract Money {
    address payable public immutable owner; 
    event Log(address from, address to, uint ammount, string data);
    constructor () payable {
        owner = payable(msg.sender);
    }
    receive() external payable{
        emit Log(msg.sender, owner, msg.value, "");
    }
    fallback() external payable{
        emit Log(msg.sender, owner, msg.value, string(msg.data));
    }
    function deposit() external payable {
        emit Log(msg.sender, owner, msg.value, "deposit");
    } 
    function getBalance() external view returns(uint balance){
        balance = address(this).balance;
    }

    function sendViaTransfer(address payable to) external payable {
        to.transfer(10);
        emit Log(msg.sender, to, 10, "sendViaTransfer");
    }

    function sendViaSend(address payable to) external payable {
        bool success = to.send(100);
        require(success, "send failed");
        emit Log(msg.sender, to, 100, "sendViaSend");
    }

    function sendViaCall(address payable to) external payable {
        // 38714 gas 
        (bool success, bytes memory data) = to.call{value: 341}("2500");
        require(success, "call failed");
        emit Log(msg.sender, to, 341, string(bytes.concat("sendViaCall: ", data)));
    }

}
