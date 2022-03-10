# Reentrancy attack.

This hack is an attack made to smart contract with a vulnerable withdraw function. The logical way for make a withdraw in some contract is:

1. Chek if the user has right deposits
2. Send money and
3. Substract balance amount.

But there is a problem in this logic, one external smart contract can call again this function and still withdrawing eth until run out of all money, why? The reason is that by changing the balance after sending ether, the contact thinks the attacker still has eth.
