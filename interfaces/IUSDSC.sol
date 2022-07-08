// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface IUSDSC is IERC20 {

    event PriceFeedAddressChanged(address _priceFeedAddress);
    
}