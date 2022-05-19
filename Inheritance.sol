// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
contract ParentA {
    uint public x;
    constructor(uint _x){
        x = _x;
    }
    function foo() public pure virtual returns(string memory){
        return "Foo-A";
    }
    function bar() external pure returns(string memory){
        return "Bar-A";
    }
}
contract ParentB {
    uint public y;
    constructor(uint _y){
        y = _y;
    }
    function foo() public pure virtual returns(string memory){
        return "Foo-B";
    }
    function baz() external pure returns(string memory){
        return "Baz-B";
    }
}
contract Child is ParentA, ParentB{
    uint public z;
    constructor(uint _x, uint _y, uint _z) ParentA(_x) ParentB(_y) {
        z = _z;
    }
    function foo() public pure override(ParentA, ParentB) returns(string memory) {
        return string(bytes.concat(bytes(ParentA.foo()), bytes(" "), bytes(ParentB.foo())));
    }
}
contract ChildDummy1 is ParentA, ParentB{
    uint public z;
    constructor(uint _y, uint _z) ParentA(2) ParentB(_y) {
        z = _z;
    }
    function foo() public pure override(ParentA, ParentB) returns(string memory) {
        // return bytes.concat(ParentA.foo(), ParentB.foo());
        return "Child";
    }
}
