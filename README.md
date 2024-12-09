# FundMe Contract

## Overview

The `FundMe` contract is a decentralized crowdfunding solution that allows users to contribute funds securely in Ethereum. It includes features for managing contributions, enforcing minimum funding requirements, and allowing only the owner to withdraw funds.

## Key Features

- **Minimum Funding Requirement**:  
  Contributors must send at least the equivalent of **5 USD** (in ETH) to the contract. This is ensured using a `PriceConverter` library for real-time ETH to USD conversion.

- **Owner-Only Withdrawal**:  
  Only the contract owner can withdraw the accumulated funds, protected by an `onlyOwner` modifier.

- **Secure Payment Handling**:  
  Supports multiple payment transfer methods (`transfer`, `send`, and `call`) with fallback mechanisms to ensure reliable fund withdrawal.

- **Transparent Contribution Tracking**:  
  Records the amount funded by each contributor using a `mapping`.

- **Fallback Functions**:  
  Supports Ether transfers directly to the contract using `receive` and `fallback` functions, which call the `fund` function automatically.

## Key Variables

- **`MINIMUM_USD`**: Constant defining the minimum contribution in USD (5 USD).
- **`i_owner`**: Immutable address of the contract owner, set during deployment.
- **`funders`**: Array storing addresses of contributors.
- **`amountFunded`**: Mapping that tracks the total contribution for each address.

## How It Works

1. **Funding**:  
   - Users send ETH to the contract via the `fund` function or by sending Ether directly to the contract.  
   - The contract ensures the contributed amount meets the minimum USD requirement before processing.

2. **Withdrawing**:  
   - The owner can withdraw the entire balance using the `withdraw` function. Multiple transfer mechanisms are included to handle edge cases in payment processing.

3. **Fallback Support**:  
   - Contributions sent directly to the contract are automatically added via the `receive` or `fallback` functions.

