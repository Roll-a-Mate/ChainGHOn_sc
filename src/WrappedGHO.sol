// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract WrappedGHO is ERC20, ERC20Burnable, AccessControl, ERC20Permit {
    bytes32 public constant OWNER_ROLE = keccak256("OWNER_ROLE");
    bytes32 public constant CHAINLINK_ROLE = keccak256("CHAINLINK_ROLE");

    bool private _isRecieverContractAddressSet = false;
    address private recieverContractAddress;

    struct metadataTokenMint {
        address ownerOfTokens;
        bool canMintToken;
        string signature;
        uint256 cuantityOfTokens;
    }

    mapping(address => metadataTokenMint) internal mapTokenMint;

    modifier onlyOwner() {
        if (!hasRole(OWNER_ROLE, msg.sender)) {
            revert();
        }
        _;
    }

    modifier onlyCCIP() {
        if (!hasRole(CHAINLINK_ROLE, msg.sender)) {
            revert();
        }
        _;
    }

    constructor(address owner) ERC20("Wrapped GHO", "GHO.w") ERC20Permit("Wrapped GHO") {
        _grantRole(OWNER_ROLE, owner);
    }

    function setReceiverAddress(address _receiverAddress) public onlyOwner {
        if (_isRecieverContractAddressSet) {
            revert();
        }
        _grantRole(CHAINLINK_ROLE, _receiverAddress);
        recieverContractAddress = _receiverAddress;
        _isRecieverContractAddressSet = true;
    }

    function mint(address to) public {
        if (!mapTokenMint[to].canMintToken) {
            revert();
        }
        uint256 amount = mapTokenMint[to].cuantityOfTokens;
        _mint(to, amount);
    }

    function ccipSetMint(address _owner, uint256 _cuantityOfTokens, string memory _signature) public onlyCCIP {
        mapTokenMint[_owner].ownerOfTokens = _owner;
        mapTokenMint[_owner].canMintToken = true;
        mapTokenMint[_owner].signature = _signature;
        mapTokenMint[_owner].cuantityOfTokens = _cuantityOfTokens;
    }
}
