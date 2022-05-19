// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.7;
contract todoContract {
    enum priority {LOW, MEDIUM, HIGH}
    struct TodoStr {
        bool status;
        string text;
        priority pr;
    }
    TodoStr[] public todos;
    error todoCustomErrors(address caller, string errror);
    address public owner;
    constructor(bool status, string memory text, priority pr){
        owner = msg.sender;
        addTodo({
            status: status,
            text: text,
            pr: pr
        });
    }
    
    modifier onlyOwner(string memory source){ 
        if(msg.sender != owner){
            // string(bytes.concat(bytes("Only owner can "), bytes(source), bytes(" to the list")))
            revert todoCustomErrors(msg.sender, string(abi.encodePacked("Only owner can ", source, " to the list")));
        }
        _;
    }

    function addTodo(bool status, string memory text, priority pr) public onlyOwner("add"){
        TodoStr memory todo = TodoStr({
            status: status,
            text: text,
            pr: pr
        });
        todos.push(todo);
    }

    function updateText(uint _idx, string calldata _text) public onlyOwner("update") returns(bool success, string memory errorMessage) {
        if(_idx >= todos.length || _idx < 0){
            success = false;
            errorMessage = "Index out of bounds";
        }
        else {
            todos[_idx].text = _text;
            success = true;
        }
    }

    function getTodosNum() public view returns (uint num) {
        num = todos.length;
    }

    function toggleStatus(uint _idx) public onlyOwner("toggle") returns(bool success, string memory errorMessage){
        if(_idx >= todos.length || _idx < 0){
            success = false;
            errorMessage = "Index out of bounds";
        }
        else {
            todos[_idx].status = !todos[_idx].status;
            success = true;
        }
    }

}
