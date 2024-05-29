pragma solidity ^0.8.20;

import {console} from "forge-std/console.sol";
import {Script} from "forge-std/Script.sol";

contract IsSolved is Script {
    function run() external view {
        address user = vm.envAddress("USER");

        if (user.balance >= 100 ether) {
            console.log("is-solved:true");
        } else {
            console.log("is-solved:false");
        }
    }
}