// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";

import { ChainGHOn } from "../src/ChainGHOn.sol";

import {WrappedGHO} from "../src/WrappedGHO.sol";
import {Receiver} from "../src/Receiver.sol";


contract DeployProtocol is Script {


    address adminAddress = 0xf8b414eFD8CB72097edAb449CeAd5dB10Fc12d99;


    function run() public {
        vm.startBroadcast(adminAddress);

        if (block.chainid == 11155111){ //if is sepolia eth
            console2.log("deployin in ETH sepolia");

            ChainGHOn chainGHOn = new ChainGHOn(
                adminAddress,
                0x0BF3dE8c5D3e8A2B34D2BEeB17ABfCeBaf363A59,
                0x779877A7B0D9E8603169DdbD7836e478b4624789
            );

            console2.log("ChainGHOn deployed at address: ", address(chainGHOn));

        } else if (block.chainid ==  43113){ //if is fuji avax
            console2.log("deployin in AVAX fuji");
            WrappedGHO wrappedGHO = new WrappedGHO(adminAddress);
            Receiver receiver = new Receiver(
                adminAddress,
                0xF694E193200268f9a4868e4Aa017A0118C9a8177,
                payable(address(wrappedGHO))
            );
            console2.log("WrappedGHO deployed at address: ", address(wrappedGHO));
            console2.log("Receiver deployed at address: ", address(receiver));
        } else {
            console2.log("Error: chain not supported in the protocol");
            revert();
        }
        
        
    }
}
