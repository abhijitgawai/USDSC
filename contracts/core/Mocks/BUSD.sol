// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";

import "../../../interfaces/IBUSD.sol";


contract BUSD is ERC20("BUSD Coin", "BUSD") {

    address public usdscAddress;

    constructor(address _usdscAddress) {
        usdscAddress = _usdscAddress;
        _mint(usdscAddress, 1000e18);

    }

}