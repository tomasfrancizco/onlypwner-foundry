## CHALLENGE

This is your chance to win big! Though, it seems like the house has an unfair advantage. Who knows whether they participate themselves, while knowing the winning number beforehand... Do you take the risk?


## WINNING CONDITION

Drain the contract of its funds.


## SOLUTION

The `Multicall` contract lets the user make multiple calls in one transaction by sending an array of bytes. A malicious user can take advantage of this by calling the `bet(uint256,address)` function several times and only send 1 ether. Then, they can withdraw the ether by calling `void()` from each address.