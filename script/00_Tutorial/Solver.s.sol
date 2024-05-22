pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";

interface ITutorial {
    function callMe() external;
}

contract Solver is Script {

    uint256 user = vm.envUint("PRIVATE_KEY");
    
    function run() public {
        vm.startBroadcast(user);
        ITutorial tutorial = ITutorial(vm.envAddress("CONTRACT"));
        tutorial.callMe();
        vm.stopBroadcast();
    }
}