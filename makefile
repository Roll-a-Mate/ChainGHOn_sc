-include .env

.PHONY: all

DEFAULT_ANVIL_KEY := 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80

help:
	@echo ""
	@echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ChainGHOn Protocol░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░"
	@echo ""
	@echo "-----------------------=Deployers for testnets ChainGHOn=------------------------"
	@echo "  make deployInEthTest      deploy the protocol part for Ethereum Sepolia testnet"
	@echo "  make deployInAvaxTest     deploy the protocol part for Avalanche Fuji testnet"
	@echo "  make deployFull           deploy all the protocol in the testnets"
	@echo "---------------------------------------------------------------------------------"
	@echo ""

	
all: clean remove install update build 

install:
	@echo "Installing libraries"
	@npm install
	@forge compile

format :; forge fmt

anvil :
	@echo "Starting Anvil, remember use another terminal to run tests"
	@anvil -m 'test test test test test test test test test test test junk' --steps-tracing

NETWORK_ARGS := --rpc-url http://localhost:8545 --private-key $(DEFAULT_ANVIL_KEY) --broadcast

ETH_SEPOLIA_TESTNET_ARGS := --rpc-url $(RPC_URL_ETH_SEPOLIA) --private-key $(PRIVATE) --broadcast --verify --etherscan-api-key $(API_KEY_ETH) -vvvv
ARB_GOERLI_TESTNET_ARGS := --rpc-url $(RPC_URL_ARB_GOERLI) --private-key $(PRIVATE) --broadcast --verify --etherscan-api-key $(API_KEY_ARB) -vvvv
AVAX_FUJI_TESTNET_ARGS := --rpc-url $(RPC_URL_AVAX_FUJI) --private-key $(PRIVATE) --broadcast --verify --verifier-url 'https://api.routescan.io/v2/network/testnet/evm/43113/etherscan' --etherscan-api-key "verifyContract" -vvvv
MATIC_MUMBAI_TESTNET_ARGS := --rpc-url $(RPC_URL_MATIC_MUMBAI) --private-key $(PRIVATE) --broadcast --verify --etherscan-api-key $(API_KEY_MATIC) -vvvv


compile:
	forge compile

deployInEthTest:
	@echo "██████████████████████████████░Deploying in Eth testnet░███████████████████████████"
	@forge script script/DeployProtocol.s.sol:DeployProtocol $(ETH_SEPOLIA_TESTNET_ARGS)
	@echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░"
	@echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░"
deployInAvaxTest:
	@echo "██████████████████████████████░Deploying in Avax testnet░██████████████████████████"
	@forge script script/DeployProtocol.s.sol:DeployProtocol $(AVAX_FUJI_TESTNET_ARGS)
	@echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░"
	@echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░"

deployFull:
	@echo "██████████████████████████████░Deploying in Eth testnet░███████████████████████████"
	@forge script script/DeployProtocol.s.sol:DeployProtocol $(ETH_SEPOLIA_TESTNET_ARGS)
	@echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░"
	@echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░"
	@echo "██████████████████████████████░Deploying in Avax testnet░██████████████████████████"
	@forge script script/DeployProtocol.s.sol:DeployProtocol $(AVAX_FUJI_TESTNET_ARGS)
	@echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░"
	@echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░"