// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
contract TestDelegateCall {
    uint8 public number;
    address public sender;
    uint public value;
    uint private nonDelegateVarsBelowOnly;

    function setVars(uint8 _x) external payable {
        number = _x**8;
        sender = msg.sender;
        value = msg.value;
    }
}
contract DelegateCall {
    uint8 public number;
    address public sender;
    uint public value;
    function setVarsEncodeWithSig(address _contractAdd, uint8 _x) external payable {
        (bool success, ) = _contractAdd.delegatecall(abi.encodeWithSignature("setVars(uint8)", _x));
        require(success, "delegatecall failed @ sign");
    }
    function setVarsEncodeWithSelector(address _contractAdd, uint8 _x) external payable {
        (bool success, ) = _contractAdd.delegatecall(abi.encodeWithSelector(TestDelegateCall.setVars.selector, _x));
        require(success, "delegatecall failed @ selector");
    }
}
