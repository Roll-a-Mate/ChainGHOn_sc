// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";

import { ChainGHOn_Ethereum } from "../src/ChainGHOn_Ethereum.sol";


contract DeployProtocol is Script {


    address adminAddress = 0xF11f8301C76F46733d855ac767BE741FFA9243Bd;


    function run() public {
        vm.startBroadcast(adminAddress);

        if (block.chainid == 11155111){ //if is sepolia eth
            console2.log("deployin in ETH sepolia");

            ChainGHOn_Ethereum chainGHOn_Ethereum = new ChainGHOn_Ethereum(
                adminAddress,
                0x0BF3dE8c5D3e8A2B34D2BEeB17ABfCeBaf363A59,
                0x779877A7B0D9E8603169DdbD7836e478b4624789
            );

            console2.log("ChainGHOn_Ethereum deployed at address: ", address(chainGHOn_Ethereum));

        } else if (block.chainid ==  43113){ //if is fuji avax
            console2.log("deployin in AVAX fuji");
            revert();
        } else {
            console2.log("Error: chain not supported in the protocol");
            revert();
        }
        
        
    }
}
