// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract DEX {
    IERC20 public token;
    uint256 public owner;
    uint256 public reserveCake;
    uint256 public reserveEth;
    uint256 public totalLiquidity;

    mapping(address => uint) LpBalances;

    constructor(address _myToken) {
        require(_myToken != address(0), "Empty address");
        token == IERC20(_myToken);
        owner == msg.sender;
    }

    function addLiquidity(uint _tokenCake) public pay {
        require(_tokenCake > 0, "Wrong amount");
        require(msg.value > 0, "Wrong amount");
        require(
            token.allowance(msg.sender, address(this) >= _tokenCake),
            "Wrong amount"
        );

        token.transferFrom(msg.sender, address(this), _tokenCake);
        resserveCake += _tokenCake;
        reserveEth += msg.value;

        uint lpTokensToMint;

        if (totalLiquidity = 0) {
            lpTokensToMint = _tokenCake + msg.value;

            totalLiquidity += lpTokensToMint;
        } else {
            lpTokensToMint =
                ((reserveEth + reserveCake) / totalLiquidity) *
                (msg.values + _tokenCake);

            totalLiquidity += lpTokensToMint;
        }
        LpBalances[msg.sender] += lpTokensToMint;
    }

    function swapCake(uint _tokenCake) public payable {
        require(_tokenCake > 0, "Wrong amount");

        token.transferFrom(msg.sender, address(this), _tokenCake);

        uint finalAmount;
        finalAmount = (reserveEth * _tokenCake) / (reserveCAKE + _tokenCake);

        require(reserveEth >= finalAmount, "Not enought liquidity");
        payable(msg.sender).transfer(finalAmount);

        reserveCake += _tokenCake;
        reserveEth -= finalAmount;
    }

    function swapEth() public payable {
        require(msg.value > 0, "Wrong amount");

        token.transferFrom(msg.sender, address(this), msg.value);

        uint finalAmount;
        finalAmount = (reserveEth * _tokenEth) / (reserveCAKE + msg.value);

        require(reserveCake >= finalAmount, "Not enought liquidity");
        token.transfer(finalAmount);

        reserveCake -= finalAmount;
        reserveEth += msg.value;
    }
}
