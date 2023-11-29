# Lottery Smart Contract

## Overview

This is a simple decentralized lottery smart contract implemented in Solidity. The contract allows participants to enter the lottery by sending a minimum entry fee. The winner is randomly picked from the pool of participants, and the contract balance is transferred to the winner.

## Smart Contract Details

- **Contract Name:** Lottery
- **Compiler Version:** Solidity ^0.8.3

## Functions

1. **`enter`**
   - Allows players to enter the lottery by sending a minimum entry fee.
   - Parameters: None
   - Requirements: The lottery must not be closed (lotteryId is 1).
   - Emits the `PlayerEntered` event.

2. **`pickWinner`**
   - Picks a winner by transferring the contract balance to a randomly selected player.
   - Requirements: Must be called by the owner.
   - Emits the `WinnerPicked` event.

3. **`getWinnerByLottery(uint lottery)`**
   - View function to get the winner of a specific lottery.
   - Parameters: `lottery` - The ID of the lottery.
   - Returns: The address of the winner.

4. **`getLotteryId`**
   - View function to get the current lottery ID.
   - Returns: The current lottery ID.

5. **`getBalance`**
   - View function to get the current contract balance.
   - Returns: The current contract balance.

6. **`getPlayers`**
   - View function to get the list of players.
   - Returns: An array of player addresses.

7. **`getRandomNumber`**
   - View function to generate a pseudo-random number based on owner and block information.
   - Returns: A pseudo-random number.

## Events

1. **`PlayerEntered`**
   - Event emitted when a player enters the lottery.
   - Parameters:
     - `player` - The address of the player who entered.
     - `amount` - The amount (in wei) sent by the player as the entry fee.

2. **`WinnerPicked`**
   - Event emitted when a winner is picked.
   - Parameters:
     - `winner` - The address of the player who won.
     - `amount` - The amount (in wei) transferred to the winner.

## Usage

Use [REMIX IDE](https://remix.ethereum.org/)

1. Deploy the contract to a supported blockchain network.

2. Interact with the contract using a web3-enabled application or script.


