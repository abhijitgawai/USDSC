// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface IMainPool {

    // Events

    event PriceFeedAddressChanged(address _priceFeedAddress);
    event USDSCAddressChanged(address _usdscAddress);
    event BUSDAddressChanged(address _busdAddress);

    event BnbUsdscFeeChanged(uint256 _bnbusdscFee);

    // Functions 

    function swapUsdscToBnb(uint256 _usdscAmount) external;

    function swapBnbToUsdsc(uint256 _usdscAmount) external view returns(uint256);

    // function getStablility() public view returns (uint256);

    function swapUsdscToBusd(uint256 _usdscAmount) external;
    
}