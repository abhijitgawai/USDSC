// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

interface IPriceFeed {
    // -- Events ---
    event LastGoodPriceUpdated(uint _lastGoodPrice);
    event PriceAggregatorAddressChanged(address _priceAggregatorAddress);

    // ---Function---
    function fetchPrice() external view returns (uint);
}