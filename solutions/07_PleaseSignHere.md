## CHALLENGE

An on-chain petition has been launched pursuing the full shutdown of the Ethereum blockchain. You cannot let this happen! But what weight does your single vote have on the final outcome? You need to find another way and stop this petition.


## WINNING CONDITION

Finish the petition.


## SOLUTION

`owner` and `isFinished` global variables share storage slot `0`, because `owner` is 20 bytes long and `isFinished` only 1, so they both fit in the 32 bytes slot.
When calling `signReject()` function with an invalid signature, the signer will result in `address(0)`, therefore assigning the `slot` variable inside `writeStatus()` function to 0 and as we called `signReject()` and not `signSupport()`, `isSupport` will be false, assigning the storage slot 0 = 0.
After this, we can call `initialize()` because the `owner` variable is again `address(0)` and `finishPetition()`, completing the challenge.