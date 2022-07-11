// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

import "../../interfaces/IPriceFeed.sol";
import "../../interfaces/IUSDSC.sol";
import "../../interfaces/IMainPool.sol";
import "../../interfaces/IBUSD.sol";

contract MainPool is IMainPool, Ownable {

    IPriceFeed public priceFeed;
    IUSDSC public usdsc;
    IBUSD public busd;

    uint256 public bnbusdscFee = 1e18;

    function setAddresses(
        address _priceFeedAddress,
        address _usdscAddress,
        address _busdAddress
    )
        external
        onlyOwner
    {

        priceFeed = IPriceFeed(_priceFeedAddress);
        usdsc = IUSDSC(_usdscAddress);
        busd = IBUSD(_busdAddress);

        emit PriceFeedAddressChanged(_priceFeedAddress);
        emit USDSCAddressChanged(_usdscAddress);
        emit BUSDAddressChanged(_busdAddress);
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
        uint256 _usdscToTranfer = ( msg.value*priceFeed.fetchPrice() * (100e18 - bnbusdscFee) ) / (100e36);
        require(usdsc.balanceOf(address(this)) > _usdscToTranfer , "Not Enough USDSC available");
        usdsc.transfer(msg.sender, _usdscToTranfer);
    }

    function swapUsdscToBnb(uint256 _usdscAmount) external override {
        usdsc.transferFrom(msg.sender, address(this), _usdscAmount);
        uint256 _bnbToTransfer = ( _usdscAmount * (100e18 - bnbusdscFee) ) / (priceFeed.fetchPrice() * 100 ) ;
        payable(msg.sender).call{ value: _bnbToTransfer }("");

    }

    function swapBnbToUsdsc(uint256 _usdscAmount) external override view returns (uint256) {
        return (_usdscAmount * 100e36) / (priceFeed.fetchPrice() * (100e18 - bnbusdscFee) );
    }

    function getStablility() public view returns (uint256) {
        return 1.21e18;
    }

    function swapUsdscToBusd(uint256 _usdscAmount) external override {
        usdsc.transferFrom(msg.sender, address(this), _usdscAmount);

        uint256 _busdToTransfer = getStablility() <= 1.2e18 ? _usdscAmount : (_usdscAmount * 1.05e18)/1e18;
        busd.transfer(msg.sender, _busdToTransfer);
    }

}