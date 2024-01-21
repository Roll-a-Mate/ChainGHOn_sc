// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.19;

/**
                       ______                __
   ____ _____ ___     / ____/___ _____ ___  / /
  / __ `/ __ `__ \   / /_  / __ `/ __ `__ \/ / 
 / /_/ / / / / / /  / __/ / /_/ / / / / / /_/  
 \__, /_/ /_/ /_/  /_/    \__,_/_/ /_/ /_(_)   
/____/                                         
   ___          _                 
  / _ \___ ____(_)__ _  _____ ____
 / , _/ -_) __/ / -_) |/ / -_) __/
/_/|_|\__/\__/_/\__/|___/\__/_/                                               
 *  @title Original Chain gm Fam! contract deployer
 *  @author jistro.eth && Ariutokintumi.eth
 *  @dev This contract is used to receive the calls from the original chain
 *       by chainlink's CCIP and send it to the gmFam contract
 */

import { WrappedGHO } from "./WrappedGHO.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import { CCIPReceiver } from "@chainlink/contracts-ccip/src/v0.8/ccip/applications/CCIPReceiver.sol";
import { Client } from "@chainlink/contracts-ccip/src/v0.8/ccip/libraries/Client.sol";
import { DecodeMsgSig } from "./utils/DecodeMsgSig.sol";

contract ReceiverNewChain is CCIPReceiver, DecodeMsgSig, Ownable  {
    error SetupAlreadyDone();
    error NotFullySetup();
    error NotSender();

    WrappedGHO GHOw;
    
    address TreasuryAndWrapperOriginalChainAddress;
    uint64 sourceChainId;
    bool isFullySetup = false;

    modifier checkIfIsSenderIsTreasuryAndWrapper(
        address _sender, 
        uint64 _chainId
    ) {
        if(_sender != TreasuryAndWrapperOriginalChainAddress || _chainId != sourceChainId) {
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

    function setupTreasuryAndWrapperAddressOriginalChain(
        address _TreasuryAndWrapperOriginalChainAddress,
        uint64 _sourceChainId
    ) external onlyOwner {
        if(isFullySetup) {
            revert SetupAlreadyDone();
        }
        TreasuryAndWrapperOriginalChainAddress = _TreasuryAndWrapperOriginalChainAddress;
        sourceChainId = _sourceChainId;
        isFullySetup = true;
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
            uint256 whereIsSignedMetadata
        ) = decodeSignatureMsgToString("=",",",message.data,2);
        
        address ownerOfTokens = convertStringToAddress(dataForVariables[0]);
        
        (uint256 numberTokens,) = convertStringToUint(dataForVariables[1]);
        
        GHOw.ccipSetMint(
            ownerOfTokens, 
            numberTokens,
            dataForVariables[whereIsSignedMetadata]
        );
    }

    function seeWhoIsTheSender() public view returns(address, uint64) {
        return (TreasuryAndWrapperOriginalChainAddress, sourceChainId);
    }

    function isReceiverFullySetup() public view returns(bool) {
        return isFullySetup;
    }
}