// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.19;

import { WrappedGHO } from "./WrappedGHO.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import { CCIPReceiver } from "@chainlink/contracts-ccip/src/v0.8/ccip/applications/CCIPReceiver.sol";
import { Client } from "@chainlink/contracts-ccip/src/v0.8/ccip/libraries/Client.sol";
import { DecodeMsgSig } from "./utils/DecodeMsgSig.sol";

contract Receiver is CCIPReceiver, DecodeMsgSig, Ownable  {
    error SetupAlreadyDone();
    error NotFullySetup();
    error NotSender();

    WrappedGHO GHOw;
    
    address ChainGHOnEthereumAddress;

    // receiving from ethereum sepolia (16015286601757825753)
    uint64 constant sourceChainId = 16015286601757825753;
    
    modifier checkIfIsSenderIsTreasuryAndWrapper(
        address _sender, 
        uint64 _chainId
    ) {
        if(_sender != ChainGHOnEthereumAddress || _chainId != sourceChainId) {
            revert NotSender();
        }
        _;
    }

    constructor(
        address _initialOwner,
        address _router, 
        address payable _GHOwAddress
    ) CCIPReceiver(_router) Ownable(_initialOwner) {
        GHOw = WrappedGHO(_GHOwAddress);
    }

    function setupChainGHOnContract(
        address _ChainGHOnEthereumAddress
    ) external onlyOwner {
        ChainGHOnEthereumAddress = _ChainGHOnEthereumAddress;
    }

   function _ccipReceive(
        Client.Any2EVMMessage memory message
    ) 
        internal 
        checkIfIsSenderIsTreasuryAndWrapper(
            abi.decode(message.sender, (address)),
            message.sourceChainSelector
        )
        override
    {   
        (
            string [] memory dataForVariables,
        ) = decodeSignatureMsgToString("=",",",message.data,2);
        
        address ownerOfTokens = convertStringToAddress(dataForVariables[0]);
        
        (uint256 numberTokens,) = convertStringToUint(dataForVariables[1]);
        
        GHOw.ccipSetMint(
            ownerOfTokens, 
            numberTokens
        );
    }

    function seeWhoIsTheSender() public view returns(address, uint64) {
        return (ChainGHOnEthereumAddress, sourceChainId);
    }
}