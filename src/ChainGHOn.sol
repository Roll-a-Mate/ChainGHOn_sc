// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title ChainGHOn_Ethereum_SmartContract
 */
import {IPool} from "@aave/core-v3/contracts/interfaces/IPool.sol";
import {IPriceOracle} from "@aave/core-v3/contracts/interfaces/IPriceOracle.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./utils/IspTokenDebt.sol";

import { LinkTokenInterface } from "@chainlink/contracts/src/v0.8/interfaces/LinkTokenInterface.sol";
import { IRouterClient } from "@chainlink/contracts-ccip/src/v0.8/ccip/interfaces/IRouterClient.sol";
import { Client } from "@chainlink/contracts-ccip/src/v0.8/ccip/libraries/Client.sol";

import { StringConverter } from "./utils/StringConverter.sol";

contract ChainGHOn is Ownable, StringConverter {

    address constant ghoToken = 0xc4bF5CbDaBE595361438F8c6a187bDc330539c60;
    address constant aavePoolProxy = 0x6Ae43d3271ff6888e7Fc43Fd7321a503ff738951;
    address constant USDC = 0x94a9D9AC8a22534E3FaCa9F4e7F2E2cf85d5E4C8;

    mapping(address => uint256) collateralValueInWETH;

    mapping(address => uint256) totalOfGHOMinted;

    mapping(address => mapping(address => uint256)) totalOfGHOMintedByDelegate;

    // for reference go to https://docs.chain.link/ccip/supported-networks/v1_2_0/testnet
    address constant i_router = 0x0BF3dE8c5D3e8A2B34D2BEeB17ABfCeBaf363A59;
    address constant i_link = 0x779877A7B0D9E8603169DdbD7836e478b4624789;

    // destinationChainSelector for AVAX fuji is 14767482510784806043
    uint64 constant destinationChainSelector = 14767482510784806043;

    address AVAXReceiverContractAddress = address(0);
                                                    // GHO-StableDebtToken-Aave  
    IspTokenDebt interfaceDebtToken = IspTokenDebt(0xdCA691FB9609aB814E59c62d70783da1c056A9b6);

    event CollateralDeposit(
        address indexed sender, 
        uint256 amount, 
        uint256 totalOfCollateralDeposited
    );
    event MintedGHO(
        address indexed sender, 
        uint256 amount, 
        uint256 totalOfGHOMinted
    );
    event GHODelegate(
        address indexed sender, 
        uint256 amount,
        address indexed delegate
    );

    event Withdrawal(
        address indexed receiver, 
        uint256 amount, 
        uint256 totalOfCollateralDeposited
    );

    constructor(
        address initialOwner
    ) Ownable(initialOwner) {}

    function setReceiverAvaxAddress(address _receiverAddress) public onlyOwner {
        AVAXReceiverContractAddress = _receiverAddress;
    }

    function depositCollateral(uint256 _amount)
        external
    {

        if (_amount == 0) {
            revert();
        }
        IERC20(USDC).transferFrom(msg.sender, address(this), _amount);

        IERC20(USDC).approve(address(aavePoolProxy), _amount);

        IPool(aavePoolProxy).supply(USDC, _amount, address(this), 0);
        collateralValueInWETH[msg.sender] += _amount;
        emit CollateralDeposit(msg.sender, _amount, collateralValueInWETH[msg.sender]);
    }
    
    function withdrawCollateral(address _sender, uint256 _amount) public onlyOwner {
        IPool(aavePoolProxy).withdraw(USDC, _amount, _sender);
        emit Withdrawal(_sender, _amount, collateralValueInWETH[_sender]);
    }

    function mintGHOToAvax(uint256 _amount) public {
        if (_amount == 0 || collateralValueInWETH[msg.sender] < _amount) {
            revert();
        }
       
        IPool(aavePoolProxy).borrow(ghoToken, _amount, 2, 0, address(this));
        totalOfGHOMinted[msg.sender] += _amount;
        //bridgeMint(msg.sender, _amount);
        emit MintedGHO(msg.sender, _amount, totalOfGHOMinted[msg.sender]);
    }

    function delegateGHO(uint256 _amount, address sender) public {
        if (_amount <= 0 || collateralValueInWETH[sender] < _amount) {
            revert();
        }
        interfaceDebtToken.approveDelegation(address(this), _amount);
        emit GHODelegate(sender, _amount, msg.sender);
    }

    function repayForGHO(uint256 _amount, address sender) public {
        if (_amount <= 0) {
            revert();
        }
        IERC20(ghoToken).transferFrom(msg.sender, address(this), _amount);
        IPool(aavePoolProxy).repay(ghoToken, _amount, 2, sender);
    }

    /*function bridgeMint(address _ownerTokens, uint256 numberOfTokens) private {


        string memory dataToSend = string(
            abi.encodePacked(
                "=",
                addressToString(_ownerTokens),
                ",",
                uintToString(numberOfTokens),
                "|",
                "0x0000000"
                ",",
                addressToString(msg.sender),
                ",",
                uintToString(msg.value),
                "="
            )
        );

        // all the logic to send the action on ccip
        Client.EVM2AnyMessage memory message = Client.EVM2AnyMessage({
            receiver: abi.encode(AVAXReceiverContractAddress),
            data: abi.encodeWithSignature("ccipSetMint(string)", dataToSend),
            tokenAmounts: new Client.EVMTokenAmount[](0),
            extraArgs: Client._argsToBytes(Client.EVMExtraArgsV1({gasLimit: 600_000, strict: false})),
            feeToken: i_link
        });

        uint256 fees = IRouterClient(i_router).getFee(destinationChainSelector, message);

        if (fees > LinkTokenInterface(i_link).balanceOf(address(this))) {
            revert();
        }

        LinkTokenInterface(i_link).approve(i_router, fees);

        /*bytes32 messageId = *//*IRouterClient(i_router).ccipSend(destinationChainSelector, message);
    }*/

    function seeCollateralValue(address _sender) public view returns (uint256) {
        return collateralValueInWETH[_sender];
    }

    function seeTotalOfGHOMinted(address _sender) public view returns (uint256) {
        return totalOfGHOMinted[_sender];
    }

    function seeTotalOfGHODeledated(address _sender, address _delegate) public view returns (uint256) {
        return totalOfGHOMintedByDelegate[_sender][_delegate];
    }

    function seeWhatIsTheAddressOfTheReceiverContract() public view returns (address) {
        return AVAXReceiverContractAddress;
    }
    
}
