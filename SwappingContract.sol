 // SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract TokenSwap {
    address public owner;
    IERC20 public tokenA;
    IERC20 public tokenB;

    event TokensSwapped(address sender, uint256 amountA, uint256 amountB);
  
constructo(address _tokenA, address _tokenB) {
        owner = msg.sender;
        tokenA = IERC20(_tokenA);
        tokenB = IERC20(_tokenB);
    }






    modifier onlyOwner() {
       require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    function swapTokens(uint256 amountA, uint256 amountB) external {
        // Ensure the sender has approved the contract to spend their tokens
        require(tokenA.transferFrom(msg.sender, address(this), amountA), "Failed to transfer tokenA");
        require(tokenB.transferFrom(msg.sender, address(this), amountB), "Failed to transfer tokenB");

        // Emit an event to log the swap
        emit TokensSwapped(msg.sender, amountA, amountB);
    }

    // Owner can withdraw any remaining tokens from the contract
    function withdrawTokens(address token, uint256 amount) external onlyOwner {
        IERC20(token).transfer(owner, amount);
    }
}
