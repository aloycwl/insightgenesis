// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {IInsightData} from "./IInsightData.sol";

contract Rewards is Ownable {
    IERC20 public igair;
    IInsightData public insightData;
    uint256 public rewardAmount = 1 ether;
    mapping(address => uint256) public rewardsValueClaimed;
    mapping(address => uint256) public rewardsCountClaimed;

    constructor() payable Ownable(msg.sender) {}

    function setIGAIr(address _address) external onlyOwner {
        igair = IERC20(_address);
    }

    function setInsightData(address _address) external onlyOwner {
        insightData = IInsightData(_address);
    }

    function setAmount(uint256 _rewardAmount) external onlyOwner {
        rewardAmount = _rewardAmount;
    }

    function claimRewards() external {
        unchecked {
            uint256 unclaimed = insightData.userCount(msg.sender) -
                rewardsCountClaimed[msg.sender];
            require(unclaimed > 0, "No rewards to claim");

            uint256 claimingAmount = unclaimed * rewardAmount;
            rewardsValueClaimed[msg.sender] += claimingAmount;
            ++rewardsCountClaimed[msg.sender];

            igair.transfer(msg.sender, claimingAmount);
        }
    }
}
