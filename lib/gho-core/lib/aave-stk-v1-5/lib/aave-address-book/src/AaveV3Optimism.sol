// SPDX-License-Identifier: MIT
// AUTOGENERATED - DON'T MANUALLY CHANGE
pragma solidity >=0.6.0;

import {IPoolAddressesProvider, IPool, IPoolConfigurator, IAaveOracle, IPoolDataProvider, IACLManager, ICollector} from './AaveV3.sol';

library AaveV3Optimism {
  IPoolAddressesProvider internal constant POOL_ADDRESSES_PROVIDER =
    IPoolAddressesProvider(0xa97684ead0e402dC232d5A977953DF7ECBaB3CDb);

  IPool internal constant POOL = IPool(0x794a61358D6845594F94dc1DB02A252b5b4814aD);

  IPoolConfigurator internal constant POOL_CONFIGURATOR =
    IPoolConfigurator(0x8145eddDf43f50276641b55bd3AD95944510021E);

  IAaveOracle internal constant ORACLE = IAaveOracle(0xD81eb3728a631871a7eBBaD631b5f424909f0c77);

  IPoolDataProvider internal constant AAVE_PROTOCOL_DATA_PROVIDER =
    IPoolDataProvider(0x69FA688f1Dc47d4B5d8029D5a35FB7a548310654);

  IACLManager internal constant ACL_MANAGER =
    IACLManager(0xa72636CbcAa8F5FF95B2cc47F3CDEe83F3294a0B);

  address internal constant ACL_ADMIN = 0x7d9103572bE58FfE99dc390E8246f02dcAe6f611;

  address internal constant COLLECTOR = 0xB2289E329D2F85F1eD31Adbb30eA345278F21bcf;

  ICollector internal constant COLLECTOR_CONTROLLER =
    ICollector(0xA77E4A084d7d4f064E326C0F6c0aCefd47A5Cb21);

  address internal constant DEFAULT_INCENTIVES_CONTROLLER =
    0x929EC64c34a17401F460460D4B9390518E5B473e;

  address internal constant DEFAULT_A_TOKEN_IMPL_REV_1 = 0xa5ba6E5EC19a1Bf23C857991c857dB62b2Aa187B;

  address internal constant DEFAULT_VARIABLE_DEBT_TOKEN_IMPL_REV_1 =
    0x81387c40EB75acB02757C1Ae55D5936E78c9dEd3;

  address internal constant DEFAULT_STABLE_DEBT_TOKEN_IMPL_REV_1 =
    0x52A1CeB68Ee6b7B5D13E0376A1E0E4423A8cE26e;

  address internal constant EMISSION_MANAGER = 0x048f2228D7Bf6776f99aB50cB1b1eaB4D1d4cA73;

  address internal constant POOL_ADDRESSES_PROVIDER_REGISTRY =
    0x770ef9f4fe897e59daCc474EF11238303F9552b6;

  address internal constant WETH_GATEWAY = 0x76D3030728e52DEB8848d5613aBaDE88441cbc59;

  address internal constant SWAP_COLLATERAL_ADAPTER = 0xBC2Ff189e0349Ca73D9b78c172FC2B40025abE2a;

  address internal constant RATES_FACTORY = 0xDd81E6F85358292075B78fc8D5830BE8434aF8BA;

  address internal constant REPAY_WITH_COLLATERAL_ADAPTER =
    0x66d340EB9D3dCe0f78e813E2F991B7CE54a1a28c;

  address internal constant LISTING_ENGINE = 0x7A9A9c14B35E58ffa1cC84aB421acE0FdcD289E3;

  address internal constant WALLET_BALANCE_PROVIDER = 0xBc790382B3686abffE4be14A030A96aC6154023a;

  address internal constant UI_POOL_DATA_PROVIDER = 0xbd83DdBE37fc91923d59C8c1E0bDe0CccCa332d5;

  address internal constant UI_INCENTIVE_DATA_PROVIDER = 0x6F143FE2F7B02424ad3CaD1593D6f36c0Aab69d7;

  address internal constant L2_ENCODER = 0x9abADECD08572e0eA5aF4d47A9C7984a5AA503dC;
}

library AaveV3OptimismAssets {
  address internal constant DAI_UNDERLYING = 0xDA10009cBd5D07dd0CeCc66161FC93D7c9000da1;

  address internal constant DAI_A_TOKEN = 0x82E64f49Ed5EC1bC6e43DAD4FC8Af9bb3A2312EE;

  address internal constant DAI_V_TOKEN = 0x8619d80FB0141ba7F184CbF22fd724116D9f7ffC;

  address internal constant DAI_S_TOKEN = 0xd94112B5B62d53C9402e7A60289c6810dEF1dC9B;

  address internal constant DAI_ORACLE = 0x8dBa75e83DA73cc766A7e5a0ee71F656BAb470d6;

  address internal constant DAI_INTEREST_RATE_STRATEGY = 0xA9F3C3caE095527061e6d270DBE163693e6fda9D;

  address internal constant LINK_UNDERLYING = 0x350a791Bfc2C21F9Ed5d10980Dad2e2638ffa7f6;

  address internal constant LINK_A_TOKEN = 0x191c10Aa4AF7C30e871E70C95dB0E4eb77237530;

  address internal constant LINK_V_TOKEN = 0x953A573793604aF8d41F306FEb8274190dB4aE0e;

  address internal constant LINK_S_TOKEN = 0x89D976629b7055ff1ca02b927BA3e020F22A44e4;

  address internal constant LINK_ORACLE = 0xCc232dcFAAE6354cE191Bd574108c1aD03f86450;

  address internal constant LINK_INTEREST_RATE_STRATEGY =
    0xeE1BAc9355EaAfCD1B68d272d640d870bC9b4b5C;

  address internal constant USDC_UNDERLYING = 0x7F5c764cBc14f9669B88837ca1490cCa17c31607;

  address internal constant USDC_A_TOKEN = 0x625E7708f30cA75bfd92586e17077590C60eb4cD;

  address internal constant USDC_V_TOKEN = 0xFCCf3cAbbe80101232d343252614b6A3eE81C989;

  address internal constant USDC_S_TOKEN = 0x307ffe186F84a3bc2613D1eA417A5737D69A7007;

  address internal constant USDC_ORACLE = 0x16a9FA2FDa030272Ce99B29CF780dFA30361E0f3;

  address internal constant USDC_INTEREST_RATE_STRATEGY =
    0x41B66b4b6b4c9dab039d96528D1b88f7BAF8C5A4;

  address internal constant WBTC_UNDERLYING = 0x68f180fcCe6836688e9084f035309E29Bf0A2095;

  address internal constant WBTC_A_TOKEN = 0x078f358208685046a11C85e8ad32895DED33A249;

  address internal constant WBTC_V_TOKEN = 0x92b42c66840C7AD907b4BF74879FF3eF7c529473;

  address internal constant WBTC_S_TOKEN = 0x633b207Dd676331c413D4C013a6294B0FE47cD0e;

  address internal constant WBTC_ORACLE = 0xD702DD976Fb76Fffc2D3963D037dfDae5b04E593;

  address internal constant WBTC_INTEREST_RATE_STRATEGY =
    0xeE1BAc9355EaAfCD1B68d272d640d870bC9b4b5C;

  address internal constant WETH_UNDERLYING = 0x4200000000000000000000000000000000000006;

  address internal constant WETH_A_TOKEN = 0xe50fA9b3c56FfB159cB0FCA61F5c9D750e8128c8;

  address internal constant WETH_V_TOKEN = 0x0c84331e39d6658Cd6e6b9ba04736cC4c4734351;

  address internal constant WETH_S_TOKEN = 0xD8Ad37849950903571df17049516a5CD4cbE55F6;

  address internal constant WETH_ORACLE = 0x13e3Ee699D1909E989722E753853AE30b17e08c5;

  address internal constant WETH_INTEREST_RATE_STRATEGY =
    0xeE1BAc9355EaAfCD1B68d272d640d870bC9b4b5C;

  address internal constant USDT_UNDERLYING = 0x94b008aA00579c1307B0EF2c499aD98a8ce58e58;

  address internal constant USDT_A_TOKEN = 0x6ab707Aca953eDAeFBc4fD23bA73294241490620;

  address internal constant USDT_V_TOKEN = 0xfb00AC187a8Eb5AFAE4eACE434F493Eb62672df7;

  address internal constant USDT_S_TOKEN = 0x70eFfc565DB6EEf7B927610155602d31b670e802;

  address internal constant USDT_ORACLE = 0xECef79E109e997bCA29c1c0897ec9d7b03647F5E;

  address internal constant USDT_INTEREST_RATE_STRATEGY =
    0x41B66b4b6b4c9dab039d96528D1b88f7BAF8C5A4;

  address internal constant AAVE_UNDERLYING = 0x76FB31fb4af56892A25e32cFC43De717950c9278;

  address internal constant AAVE_A_TOKEN = 0xf329e36C7bF6E5E86ce2150875a84Ce77f477375;

  address internal constant AAVE_V_TOKEN = 0xE80761Ea617F66F96274eA5e8c37f03960ecC679;

  address internal constant AAVE_S_TOKEN = 0xfAeF6A702D15428E588d4C0614AEFb4348D83D48;

  address internal constant AAVE_ORACLE = 0x338ed6787f463394D24813b297401B9F05a8C9d1;

  address internal constant AAVE_INTEREST_RATE_STRATEGY =
    0xeE1BAc9355EaAfCD1B68d272d640d870bC9b4b5C;

  address internal constant sUSD_UNDERLYING = 0x8c6f28f2F1A3C87F0f938b96d27520d9751ec8d9;

  address internal constant sUSD_A_TOKEN = 0x6d80113e533a2C0fe82EaBD35f1875DcEA89Ea97;

  address internal constant sUSD_V_TOKEN = 0x4a1c3aD6Ed28a636ee1751C69071f6be75DEb8B8;

  address internal constant sUSD_S_TOKEN = 0xF15F26710c827DDe8ACBA678682F3Ce24f2Fb56E;

  address internal constant sUSD_ORACLE = 0x7f99817d87baD03ea21E05112Ca799d715730efe;

  address internal constant sUSD_INTEREST_RATE_STRATEGY =
    0xA9F3C3caE095527061e6d270DBE163693e6fda9D;

  address internal constant OP_UNDERLYING = 0x4200000000000000000000000000000000000042;

  address internal constant OP_A_TOKEN = 0x513c7E3a9c69cA3e22550eF58AC1C0088e918FFf;

  address internal constant OP_V_TOKEN = 0x77CA01483f379E58174739308945f044e1a764dc;

  address internal constant OP_S_TOKEN = 0x08Cb71192985E936C7Cd166A8b268035e400c3c3;

  address internal constant OP_ORACLE = 0x0D276FC14719f9292D5C1eA2198673d1f4269246;

  address internal constant OP_INTEREST_RATE_STRATEGY = 0xeE1BAc9355EaAfCD1B68d272d640d870bC9b4b5C;

  address internal constant wstETH_UNDERLYING = 0x1F32b1c2345538c0c6f582fCB022739c4A194Ebb;

  address internal constant wstETH_A_TOKEN = 0xc45A479877e1e9Dfe9FcD4056c699575a1045dAA;

  address internal constant wstETH_V_TOKEN = 0x34e2eD44EF7466D5f9E0b782B5c08b57475e7907;

  address internal constant wstETH_S_TOKEN = 0x78246294a4c6fBf614Ed73CcC9F8b875ca8eE841;

  address internal constant wstETH_ORACLE = 0x698B585CbC4407e2D54aa898B2600B53C68958f7;

  address internal constant wstETH_INTEREST_RATE_STRATEGY =
    0x6BA97468e2e6a3711a6DD05F0075d48E878c910e;
}