// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title ChainGHOn_Ethereum_SmartContract
 */
import {IPool} from "@aave/core-v3/contracts/interfaces/IPool.sol";
import {IPriceOracle} from "@aave/core-v3/contracts/interfaces/IPriceOracle.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {Client} from "@chainlink/contracts-ccip/src/v0.8/ccip/libraries/Client.sol";
import {IRouterClient} from "@chainlink/contracts-ccip/src/v0.8/ccip/interfaces/IRouterClient.sol";
//import {LinkTokenInterface} from "@chainlink/contracts/src/v0.8/interfaces/LinkTokenInterface.sol";
/**
 * @title Chainghon.ETHS
 * @dev @aave/periphery-v3 rewards, ui data provider, incentive data provider, wallet balance provider and WETH gateway.
 *
 */
// import "@aave/periphery-v3/contracts/misc/WalletBalanceProvider.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ChainGHOn_Ethereum is Ownable {

    address constant ghoToken = 0xc4bF5CbDaBE595361438F8c6a187bDc330539c60;
    address constant aavePoolProxy = 0x0562453c3DAFBB5e625483af58f4E6D668c44e19;
    address constant USDC = 0x94a9D9AC8a22534E3FaCa9F4e7F2E2cf85d5E4C8;

    mapping(address => uint256) collateralValueInWETH;

    mapping(address => uint256) totalOfGHOMinted;

    mapping(address => mapping(address => uint256)) totalOfGHOMintedByDelegate;

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
    event MintedGHOWithDelegate(
        address indexed sender, 
        uint256 amount,
        address indexed delegate,
        uint256 totalOfGHODelegatedByTheSender
    );

    event Withdrawal(
        address indexed receiver, 
        uint256 amount, 
        uint256 totalOfCollateralDeposited
    );

    constructor(address initialOwner) Ownable(initialOwner) {}

    /**
     * @dev Deposits wrapped ETH (WETH) into the contract to be used as collateral. 
     * @param _amount The amount of wrapped ETH (WETH) to deposit in wei into the contract.
     */
    function depositCollateral(uint256 _amount)
        external
    {
        //solo wrapped eth
        //require(_amount > 0, "Amount Error");
        if (_amount == 0) {
            revert();
        }
        IERC20(USDC).approve(address(this), _amount);
        //IERC20(USDC).transferFrom(msg.sender, address(this), _amount);
        IPool(aavePoolProxy).supply(USDC, _amount, address(this), 0);
        collateralValueInWETH[msg.sender] += _amount;
        emit CollateralDeposit(msg.sender, _amount, collateralValueInWETH[msg.sender]);
    }
    /*
    function withdrawCollateral(address _sender, uint256 _amount) public onlyOwner {
        // we need get the collateral value
        //require(_asset = asset, "Asset error");
        IPool(aavePoolProxy).withdraw(USDC, _amount, _sender);
        emit Withdrawal(_sender, _amount, collateralValueInWETH[_sender]);
    }

    function mintGHO(uint256 _amount, address sender) public {
        //ver que el amount sea mayor a 0 y que tenga el collateral necesario para mintear(borrow)
        if (_amount == 0 || collateralValueInWETH[sender] < _amount) {
            revert();
        }
        IPool(aavePoolProxy).borrow(ghoToken, _amount, 1, 0, address(this));
        totalOfGHOMinted[sender] += _amount;
        emit MintedGHO(sender, _amount, totalOfGHOMinted[sender]);
    }

    function mintAndDelegateGHO(uint256 _amount, address sender) public {
        //ver que el amount sea mayor a 0 y que tenga el collateral necesario para mintear(borrow)
        if (_amount <= 0 || collateralValueInWETH[sender] < _amount) {
            revert();
        }
        IPool(aavePoolProxy).borrow(ghoToken, _amount, 1, 0, address(this));
        totalOfGHOMintedByDelegate[sender][msg.sender] += _amount;
        emit MintedGHOWithDelegate(sender, _amount, msg.sender, totalOfGHOMintedByDelegate[sender][msg.sender]);
    }

    function repayForGHO(uint256 _amount, address sender) public returns (uint256) {
        // here we need to make the validation of the collateral value from signature/merkle tree
        //require(_amount > 0, "Amount Error");
        if (_amount <= 0) {
            revert();
        }
        ERC20(ghoToken).transferFrom(msg.sender, address(this), _amount);
        IPool(aavePoolProxy).repay(ghoToken, _amount, 2, sender);
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


    /*
    function sendMessagePayLINK(uint64 _destinationChainSelector, address _receiver, string calldata _text)
        external
        onlyOwner
        returns (bytes32 messageId)
    {
        // Create an EVM2AnyMessage struct in memory with necessary information for sending a cross-chain message
        Client.EVM2AnyMessage memory evm2AnyMessage = _buildCCIPMessage(_receiver, _text, address(s_linkToken));

        // Initialize a router client instance to interact with cross-chain router
        IRouterClient router = IRouterClient(this.getRouter());

        // Get the fee required to send the CCIP message
        uint256 fees = router.getFee(_destinationChainSelector, evm2AnyMessage);

        if (fees > s_linkToken.balanceOf(address(this))) {
            revert NotEnoughBalance(s_linkToken.balanceOf(address(this)), fees);
        }

        // approve the Router to transfer LINK tokens on contract's behalf. It will spend the fees in LINK
        s_linkToken.approve(address(router), fees);

        // Send the CCIP message through the router and store the returned CCIP message ID
        messageId = router.ccipSend(_destinationChainSelector, evm2AnyMessage);

        // Emit an event with message details
        emit MessageSent(messageId, _destinationChainSelector, _receiver, _text, address(s_linkToken), fees);

        // Return the CCIP message ID
        return messageId;
    }*/
}
