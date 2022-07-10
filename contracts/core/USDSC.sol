// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";


import "../../interfaces/IUSDSC.sol";
import "../../interfaces/IPriceFeed.sol";


contract USDSC is IUSDSC, Ownable, ERC20("USDSC  Coin", "USDSC") {

    IPriceFeed public priceFeed;

    uint256 public bnbusdscFee = 1e18;

    function setAddresses(
        address _priceFeedAddress
    )
        external
        onlyOwner
    {

        priceFeed = IPriceFeed(_priceFeedAddress);

        emit PriceFeedAddressChanged(_priceFeedAddress);

    }

    function setBnbUsdscFee(
        uint256 _bnbusdscFee
    )
        external
        onlyOwner
    {
        require(100 < _bnbusdscFee &&  100e18 >= _bnbusdscFee, "USDSC: bnbusdscFee not in limit");
        bnbusdscFee = _bnbusdscFee;

        emit BnbUsdscFeeChanged(_bnbusdscFee);

    }


    receive() external payable {
        _mint(msg.sender, ( msg.value*priceFeed.fetchPrice() * (100e18 - bnbusdscFee) ) / (100e36)  );
    }

    function swapUsdscToBnb() external override {
        
    }

    function swapBnbToUsdsc(uint256 _usdscAmount) external override view returns (uint256) {
        return (_usdscAmount * 100e36) / (priceFeed.fetchPrice() * (100e18 - bnbusdscFee) );
    }

}