// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
contract EtherWallet {
    address payable public immutable owner;
    constructor () {
        owner = payable(msg.sender);
    }
    receive() external payable {}
    function withdraw(uint ammount) external payable {
        require(msg.sender == owner, "caller is not owner");
        owner.transfer(ammount);
    }
    function getBalance() external view returns(uint){
        return address(this).balance;
    }
}
