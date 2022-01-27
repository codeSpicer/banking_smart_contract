// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

contract bank {
    address owner;

    struct user {
        string name;
        uint256 balance;
        bool exists;
    }

    mapping(address => user) public Users;

    constructor() {
        owner = msg.sender;
    }

    function register(string memory _name) public {
        Users[msg.sender] = user(_name, 0, true);
    }

    function deposit(address _receiver) external payable {
        require(msg.value > 0 && Users[msg.sender].exists);
        Users[_receiver].balance += msg.value;
    }

    function withdraw(uint256 _amount, address payable _receiver) external {
        require(_amount > 0 && _amount <= Users[msg.sender].balance);
        _receiver.transfer(_amount);
        Users[msg.sender].balance -= _amount;
    }

    function transfer(address payable _to) external {}
}
