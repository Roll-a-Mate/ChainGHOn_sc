// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";

import { ChainGHOn } from "../src/ChainGHOn.sol";

import {WrappedGHO} from "../src/WrappedGHO.sol";
import {Receiver} from "../src/Receiver.sol";


contract DeployProtocol is Script {


    address adminAddress = 0xF11f8301C76F46733d855ac767BE741FFA9243Bd;


    function run() public {
        vm.startBroadcast(adminAddress);

        if (block.chainid == 11155111){ //if is sepolia eth
            console2.log("deployin in ETH sepolia");

            ChainGHOn chainGHOn = new ChainGHOn(
                adminAddress
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
