// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract IGAI is ERC20, Ownable {
    constructor() ERC20("Insight Rewards", "IGAIr") Ownable(msg.sender) {}

    function mint(address to, uint256 amount) public onlyOwner {
        unchecked {
            _mint(to, amount);
        }
    }
}
