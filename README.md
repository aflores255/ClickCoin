# ClickCoin Smart Contract

## 📝 Overview
ClickCoin is an ERC20 token designed to be deployed on any EVM compatible blockchain. This contract includes a token burn mechanism that applies a percentage of token burn on each transfer. Additionally, only the owner of the contract can mint new tokens and modify the burn rate.

The contract is written in **Solidity (0.8.24)** and utilizes OpenZeppelin libraries for secure and standardized ERC20 functionality and ownership management.

## 🚀 Features

| Feature | Description |
|---------|-------------|
| **ERC20 Standard** | Implements the standard ERC20 interface (transfer, approve, balanceOf, etc.). |
| **Ownable (Access Control)** | Restricts certain functions (like minting and burn rate modification) to the contract owner. |
| **Controlled Minting** | Only the owner can create new tokens via the `mint` function. |
| **Burn Rate** | Allows setting a burn rate percentage on each transfer (configured by the owner). |
| **Initial Supply** | Mints 1,000,000 tokens (with 18 decimals) to the deployer's address when the contract is deployed. |

## 📜 Contract Details

### ⚙️ Inheritance

- **ERC20**: Provides core token logic (balances, transfers, approvals, total supply).
- **Ownable**: Provides ownership functionality, allowing only the owner to perform restricted actions.

### 📡 Key Inherited Functions

| Function | Description |
|----------|-------------|
| `approve` | Allows a spender to spend a specified amount of tokens on behalf of the owner. |
| `transfer` | Transfers tokens from the caller’s address to another address. |
| `transferFrom` | Transfers tokens from one address to another if the caller has been approved as a spender This function does not burn any tokens|
| `allowance` | Returns how many tokens a spender is still allowed to spend on behalf of an owner. |
| `balanceOf` | Returns the token balance of a specific address. |
| `totalSupply` | Shows the total amount of tokens in circulation. |
| `decimals` | Specifies the number of decimals the token uses (default is 18). |
| `name` | The name of the token (e.g., "ClickCoin"). |
| `symbol` | The symbol of the token (e.g., "CLK"). |
| `owner` | Returns the current owner of the contract. |
| `transferOwnership` | Allows transferring ownership of the contract to a new address. |
| `renounceOwnership` | Allows renouncing the ownership of the contract. |

### 💻 Custom Functions

| Function | Description |
|----------|-------------|
| `constructor` | Initializes the token with a name (`name_`), symbol (`symbol_`), and mints 1,000,000 tokens to the deployer's address. Also, sets the contract owner to the deployer's address. |
| `mint(uint256 amount)` | Allows the owner to mint new tokens and assign them to their address. Only the owner can call this function. |
| `burn(uint256 amount)` | Allows the owner to burn tokens directly from their address. |
| `setBurnRate(uint16 _burnRate)` | Allows the owner to modify the burn rate (based on a 10,000 base). |
| `transfer(address to, uint256 value)` | Overrides the standard ERC20 transfer function to apply the burn amount before transferring tokens. |

## 🛠️ How to Use

### 🔧 Prerequisites
- Remix IDE or any compatible Solidity development environment.
- Solidity version: 0.8.24 (or compatible).

### 🚀 Deployment Steps
1. Open **Remix IDE**.
2. Create a new file (e.g., `ClickCoin.sol`).
3. Copy and paste the ClickCoin contract code into the file.
4. Ensure that the Solidity version is set to **0.8.24**.
5. Click **Compile**.
6. Deploy the contract on Remix VM or any EVM-compatible network (e.g., Ethereum, Arbitrum, Optimism).

### 🖱️ Interacting with the Contract

- **Mint Tokens**: Only the owner can call `mint(uint256 amount)` to create new tokens.
- **Transfer Tokens**: Use `transfer(address to, uint256 amount)` to send tokens to another address.
- **Approve & TransferFrom**: 
    - Use `approve(address spender, uint256 amount)` to allow a third party to manage your tokens.
    - Use `transferFrom(address from, address to, uint256 amount)` to transfer tokens on someone else's behalf.
- **Check Balance**: `balanceOf(address account)` returns the token balance of a specific address.
- **Transfer Ownership**: Use `transferOwnership(address newOwner)` to transfer ownership of the contract to a new address or `renounceOwnership()` to relinquish ownership of the contract.

## 📄 License
This project is licensed under **LGPL-3.0-only**. Refer to the header in the Solidity file or the GNU Lesser General Public License documentation for more details.
