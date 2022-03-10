//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract victim {
    event deposited(address _user, uint256 _amount);
    event withdrawed(address _user, uint256 _amount);

    mapping(address => uint256) public userBalance;

    function deposit() external payable {
        require(msg.value > 0);
        userBalance[msg.sender] += msg.value;
        emit deposited(msg.sender, msg.value);
    }

    function withdraw() external {
        require(userBalance[msg.sender] > 0);
        uint256 amount = userBalance[msg.sender];
        (bool sent, ) = msg.sender.call{value: amount}("");
        require(sent, "Failed.");

        userBalance[msg.sender] = 0;
        emit withdrawed(msg.sender, amount);
    }
}
