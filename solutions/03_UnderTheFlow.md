## CHALLENGE

The devs have told you that the standard ERC20 implementation wastes lots of gas with unnecessary events, storage reads and writes, and other inefficiencies. They have developed an improved version of the standard ERC20 contract called ImprovedERC20 that saves gas by removing these inefficiencies and doing only the important checks.


## WINNING CONDITION

Get a token balance.


## SOLUTION

Prior to the 0.8.0 solidity version, contracts needed to use a library like OpenZeppelin's SafeMath to avoid integer overflows. The contract `ImprovedERC20` uses the 0.7.0 solidity version without any checks, so it's vulnerable to them.
The line `require(allowance[_from][msg.sender] - _value > 0, "Insufficient allowance");` is the problem as it overflows when passing any value > 0, letting the rest of the function execute without issues.