// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface IUSDSC is IERC20 {

    event PriceFeedAddressChanged(address _priceFeedAddress);

    event BnbUsdscFeeChanged(uint256 _bnbusdscFee);

    // Functions 
    function swapUsdscToBnb() external;

    function swapBnbToUsdsc(uint256 _usdscAmount) external view returns(uint256);
    
}