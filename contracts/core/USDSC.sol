// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";


import "../../interfaces/IUSDSC.sol";


contract USDSC is IUSDSC, Ownable, ERC20("USDSC  Coin", "USDSC") {

    uint256 internal initialized;

    function Initialize(address _mainPool) external onlyOwner {
        require(initialized == 0, "USDSC: Contract Already initialized");
        _mint(_mainPool, 1000000000000e18);
        initialized = 1;
    }
}