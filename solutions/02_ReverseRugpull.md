## CHALLENGE

You came across this newly launched project promising high APR. Upon taking a closer look at the source code, it is clear to you that this is an obvious rugpull. But... maybe you can turn this around?


## WINNING CONDITION

The owner loses funds when trying to pull the rug.


## SOLUTION

You have to call `deposit()` with 1 wei and send 8.9 ethers through the `transfer()` token to unbalance the `newShares` calculations: `newShares = (amount * currentShares) / currentBalance;`
This becomes unbalanced because the currentShares is low and the currentBalance is very high, so when the division is made, it returns `0`.