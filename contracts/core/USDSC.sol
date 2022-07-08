// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";


import "../../interfaces/IUSDSC.sol";
import "../../interfaces/IPriceFeed.sol";


contract USDSC is IUSDSC, Ownable, ERC20("USDSC  Coin", "USDSC") {

    IPriceFeed public priceFeed;

    function setAddresses(
        address _priceFeedAddress
    )
        external
        onlyOwner
    {

        priceFeed = IPriceFeed(_priceFeedAddress);

        emit PriceFeedAddressChanged(_priceFeedAddress);

    }


    receive() external payable {
        _mint(msg.sender, (msg.value*priceFeed.fetchPrice()/1e18));
    }
    

}