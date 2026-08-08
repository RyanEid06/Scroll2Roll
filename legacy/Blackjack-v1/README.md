# Rocket Blackjack Logic Engine

This project contains the complete headless logic for a future 2D Blackjack game written in Rocket.

## Features

- One human player
- Up to five AI players
- Six-deck shuffled shoe
- Automatic reshuffling
- Chip balances and betting
- Hit
- Stand
- Double Down
- Split
- Late Surrender
- Dealer stands on soft 17
- Blackjack pays 3:2
- Double after split
- Maximum four split hands
- Split aces receive one card each
- Dealer blackjack handling
- Push, bust, win, loss, and surrender payouts
- Basic-strategy AI
- Step-by-step game state for future visuals

## Project Structure

```text
rocket_blackjack_logic/
├── rocket.toml
├── README.md
├── src/
│   ├── blackjack.rocket
│   └── main.rocket
└── tests/
    └── engine_test.rocket