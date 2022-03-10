//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Safevictim {
    event deposited(address _user, uint256 _amount);
    event withdrawed(address _user, uint256 _amount);

    bool internal reentrancyGuard;
    mapping(address => uint256) public userBalance;

    modifier noReentrancy() {
        require(!reentrancyGuard, "No re-entrancy");
        reentrancyGuard = true;
        _;
        reentrancyGuard = false;
    }

    function deposit() external payable {
        require(msg.value > 0);
        userBalance[msg.sender] += msg.value;
        emit deposited(msg.sender, msg.value);
    }

    function withdraw() external {
        require(userBalance[msg.sender] > 0);
        uint256 amount = userBalance[msg.sender];
        userBalance[msg.sender] = 0;

        (bool sent, ) = msg.sender.call{value: amount}("");
        require(sent, "Failed.");
        emit withdrawed(msg.sender, amount);
    }
}
