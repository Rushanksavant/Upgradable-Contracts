// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.7;

// Proxy
contract implementationProxy {
    uint public a;
    uint public b;

    address owner;
    address implementation;

    constructor() {
        owner = msg.sender;
    }

    function implementationAdd(address _add) external {
        require(msg.sender == owner, "Not allowed");

        implementation = _add;
    }

    fallback() payable external {
        implementation.delegatecall(msg.data);
    }
}


// Implementation
contract Implementation {
    uint public a;
    uint public b;

    function setVar(uint _a, uint _b) external {
        a= _a;
        b= _b;
    } 

    function add() external {
        a = a+b;
    }

}


// Proxy caller
contract User {

    address public proxy;

    function setProxy(address _add) external {
        proxy= _add;
    }

    function varChange(uint _a, uint _b) external {
        proxy.call(
      abi.encodeWithSelector(
        bytes4(keccak256("setVar(uint256,uint256)")), _a, _b
      )
    );        
    }

    function addVar() external {
        proxy.call(
            abi.encodeWithSelector(
            bytes4(keccak256("add()"))
        ));
    }
}

