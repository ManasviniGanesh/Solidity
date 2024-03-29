// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


contract Counter {
    uint public count;

    function inc() external {
        count +=1;
    }

    function dec() external {
        count -=1;
    }

    function destroy() external {
        selfdestruct(payable(address(this)));
    }
}
