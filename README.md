# BitPredict

## Decentralized Bitcoin Price Prediction Markets on Stacks

BitPredict is a decentralized prediction market protocol built on the Stacks blockchain. It enables users to stake STX tokens to predict the future price movement of Bitcoin (BTC) in a secure, trustless, and censorship-resistant environment. The contract uses Clarity and integrates with a trusted oracle for settlement, leveraging Stacks’ Bitcoin anchoring for integrity and transparency.

## Features

- **Decentralized & Trustless**: No central control over user funds.
- **Market Creation**: Anyone can create time-bound BTC prediction markets.
- **User Predictions**: Users place STX stakes on "up" or "down" outcomes.
- **Oracle-Based Settlement**: Final BTC price provided by a verified oracle.
- **Winnings Distribution**: Automatic proportional payouts to winners.
- **Platform Fee**: A small % fee supports platform sustainability.
- **Admin Controls**: Update oracle address, stake minimum, fees, and withdraw earnings.

## Smart Contract Overview

### Constants

- `contract-owner`: Initial deployer of the contract.
- Error codes: Custom `err-*` codes for consistent error handling.
- Configurable constants for minimum stake and platform fee.

### State Variables

- `oracle-address`: Authorized oracle to resolve market outcomes.
- `minimum-stake`: Required minimum STX amount to participate.
- `fee-percentage`: Fee deducted from winnings (in %).
- `market-counter`: Incremental ID tracker for created markets.

### Data Maps

- `markets`: Stores metadata about each prediction market.
- `user-predictions`: Stores user-specific stakes and outcomes for each market.

## Core Functions

### Public Functions

#### `create-market(start-price, start-block, end-block)`

Creates a new market.

- Must be called by contract owner.
- `start-price`: Initial BTC price.
- `start-block`, `end-block`: Define the window for placing predictions.

#### `make-prediction(market-id, prediction, stake)`

Places a prediction.

- `prediction`: `"up"` or `"down"`.
- STX tokens are transferred into the contract.

#### `resolve-market(market-id, end-price)`

Closes a market with the final price.

- Only callable by `oracle-address`.
- Triggers state update to "resolved".

#### `claim-winnings(market-id)`

Claims user's winnings after market resolution.

- Checks if user prediction matches result.
- Calculates share, deducts fee, and sends payout.

### Read-Only Functions

- `get-market(market-id)`: Returns market details.
- `get-user-prediction(market-id, user)`: Returns a user's prediction details.
- `get-contract-balance()`: Returns the STX balance of the contract.

### Admin Functions

- `set-oracle-address(new-address)`
- `set-minimum-stake(new-minimum)`
- `set-fee-percentage(new-fee)`
- `withdraw-fees(amount)`

## Deployment & Usage

### Deploying the Contract

Deploy using [Clarinet](https://docs.stacks.co/docs/clarity/clarinet/overview/) or the Stacks CLI.

```bash
clarinet check
clarinet deployment
```

### Interacting

Use a Clarity-compatible wallet (e.g., Hiro Wallet) or custom frontend DApp to interact with:

- `make-prediction`
- `claim-winnings`
- `get-market`

## Payout Formula

Payouts are proportional to a user's stake among total winning-side stakes:

```
winnings = (user stake × total stake) / total winning-side stake
payout = winnings - platform fee
```

---

## Security Considerations

- **Oracle Trust**: Ensure `oracle-address` is securely managed.
- **Reentrancy-safe**: Clarity does not support reentrancy, reducing attack surface.
- **Immutable Logic**: Contract behavior is transparent and auditable.
