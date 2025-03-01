# Insight Genesis Smart Contracts

## ERC-20 Token Contract (IGAI.sol)

This contract implements standard token functions with additional features:

- **Default**: Full OpenZepplin import with basic ERC-20 standards.
- **Ownable**: Allows only the owner of the contract to perform certain administrative actions.
- **Mintable**: Allows the owner to mint new tokens.

---

## Insight Genesis Data Input Contract (InsightData.sol)

This contract allows users to store and track data. Each data entry is associated with an address, and the contract emits an event whenever new data is stored.

### Key Features
- **Mapping for Data**: Stores data in the `data` mapping.
- **User Tracking**: Associates each piece of data with the user (address) who submitted it.
- **Count Tracking**: Tracks the total number of data entries stored.
- **Event Emission**: Emits a `NewData` event every time new data is stored.

---

### State Variables

- `mapping(uint256 => bytes) public data`: Stores the data with an ID (incrementing count).
- `mapping(uint256 => address) public user`: Maps each data entry ID to the address of the user who submitted it.
- `mapping(address => uint256) public userCount`: Tracks how many data entries each user has submitted.
- `uint256 public count`: Keeps track of the total number of data entries.

---

### Events

#### `NewData(uint256 indexed, bytes, address)`
- **Description**: Emitted whenever new data is stored.
- **Parameters**:
  - `[0]`: The ID of the data entry.
  - `[1]`: The actual data that was stored.
  - `[2]`: The address of the user who submitted the data.

---

### Functions

#### `store(bytes memory _data)`
- **Description**: Allows a user to store data in the contract. The data is indexed and associated with the user's address.
- **Parameters**:
  - `_data`: The data to be stored, passed as bytes.
- **Modifiers**: Public, anyone can call this function.
- **Behavior**:
  - The data is stored in the `data` mapping under a unique `count` index.
  - The `user` mapping associates the data entry with the sender's address.
  - The `userCount` mapping increments for the sender to track their submissions.
  - The total `count` is incremented to track the number of data entries.
  - A `NewData` event is emitted to notify external listeners.

---

### Usage Example

```solidity
// Store some data
contractInstance.store("Example data");
```

## Gas Price Estimate for 16KB Data (Sample_16kb_bytecode.txt)

> 📌 **Important Highlight**  
> Storing a **16KB file** on Ethereum is expensive! Below are the estimated gas costs at different Gwei rates.

---

### 🚀 Gas Price Estimates  

📊 **Gas Cost in Ether (ETH)**  
- **At 50 Gwei**: `0.5939 ETH`  
- **At 100 Gwei**: `1.1878 ETH`  

💰 **Estimated USD Cost**  
- **At 50 Gwei**: `$1,781.74`  
- **At 100 Gwei**: `$3,563.48`  

---

### 🔍 Arbitrum Comparison  

Even on **Arbitrum**, which is approximately **66x cheaper** than Ethereum, the cost to store **16KB of data** is still significant.  
⚠️ **Minimum cost: 50 Gwei.**

---

### 📢 Summary  

✅ **Ethereum Storage Costs:**  
- Storing **16KB** costs between **0.5939 ETH – 1.1878 ETH** depending on gas price.  
- In **USD terms**, this ranges from **$1,781.74 – $3,563.48** at 50–100 Gwei.  

✅ **Arbitrum Advantage:**  
- Even at **66x lower costs**, storage still requires a **minimum of $50**.  

## Rewards Smart Contract (Rewards.sol)

### Overview

This contract allows users to claim rewards based on their activity recorded in an external `IInsightData` contract. The rewards are distributed in `IGAI` tokens, an `IERC20` token.

The contract is open-source and licensed under MIT.

### Imports
The contract imports:
- `Ownable` from OpenZeppelin for access control.
- `IERC20` for interacting with the ERC-20 token standard.
- `IInsightData`, a custom interface for fetching user data.

### State Variables
- `igai`: The ERC-20 token used for rewards.
- `insightData`: The contract storing user activity data.
- `rewardAmount`: The fixed reward per claimable event.
- `rewardsValueClaimed`: Tracks the total rewards claimed by each user.
- `rewardsCountClaimed`: Tracks the number of claims made by each user.

### Constructor
```solidity
constructor() Ownable(msg.sender) {}
```
Initializes the contract with the deployer as the owner.

### Functions
#### `setIGAI(address _address)`
```solidity
function setIGAI(address _address) external onlyOwner;
```
Sets the ERC-20 token used for rewards. Only callable by the owner.

#### `setInsightData(address _address)`
```solidity
function setInsightData(address _address) external onlyOwner;
```
Links the contract to an `IInsightData` contract to fetch user data. Only callable by the owner.

#### `setAmount(uint256 _rewardAmount)`
```solidity
function setAmount(uint256 _rewardAmount) external onlyOwner;
```
Sets the reward amount per claim. Only callable by the owner.

#### `claimRewards()`
```solidity
function claimRewards() external;
```
Allows users to claim rewards based on the number of claimable events recorded in `IInsightData`. Ensures users can only claim unclaimed rewards.

### Usage
1. The owner sets the `IGAI` token address and `IInsightData` contract.
2. The owner sets the reward amount.
3. Users can call `claimRewards()` if they have unclaimed rewards.

---

## Deploy and set all variable conveniently (Deployer.sol)
This contract initializes and links the core contracts:

- Deploys `IGAI`, `InsightData`, and `Rewards`.
- Mints `10 billion IGAI` tokens for the `Rewards` contract.
- Establishes the contract relationships.
- Transfers ownership to the deployer.

To deploy the smart contracts, simply deploy the `Deployer` contract, which will automatically initialize the other contracts and configure them accordingly.

---

