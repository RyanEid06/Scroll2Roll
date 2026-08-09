# Architecture

## Dependency rules

The application follows one-way dependencies: reusable shell and Blackjack presentation call the public Blackjack API; that API coordinates engine modules; engine modules depend on shared model values and standard modules only. Persistence is an explicit boundary. The raylib wrapper and native adapter are infrastructure and never own casino rules.

Circular imports, duplicated visual rules, machine-specific paths, and C++ application state are prohibited.

## Implemented modules

- `src/blackjack/blackjack_model.rocket`: public state and result values.
- `src/blackjack/blackjack_cards.rocket`: validated cards, names, and hand evaluation.
- `src/blackjack/shoe.rocket`: deck construction, deterministic shuffling, draw, and cut-card policy.
- `src/blackjack/blackjack_rules.rocket`: table limits and rule configuration.
- `src/blackjack/settlement.rocket`: outcome resolution and exact integer-credit payouts.
- `src/blackjack/blackjack_engine.rocket`: betting, legal actions, state transitions, dealer progression, AI turns, and round cleanup.
- `src/blackjack/strategy.rocket`: deterministic basic strategy.
- `src/blackjack/blackjack_api.rocket`: intentionally small presentation-facing facade.
- `src/app/*`: router, screens, reusable components, design tokens, and input flow.
- `src/persistence.rocket`: versioned local settings/save parsing and safe recovery.
- `src/rocket_raylib.rocket`: safe Rocket graphics/input/audio boundary.
- `native/rocket_raylib_adapter.*`: primitive ABI and resource-token policy only.

`src/app/registry.rocket` is the shell's routing boundary. Blackjack, European Roulette, Plinko, Coop Climb, Midnight Crossing, No-Limit Hold'em, and Mines are registered as available. Adding a game does not require rewriting startup, lobby, settings, persistence, or common controls.

`src/app/blackjack_view.rocket` reads engine state and emits intents through `src/blackjack/blackjack_api.rocket`. It does not calculate legal moves, hand values, payouts, or dealer behavior.

`src/roulette/roulette_model.rocket`, `roulette_rules.rocket`, and
`roulette_engine.rocket` own the complete
single-zero table, validated bet geometry, limits, seeded wheel result,
settlement, and history. `src/roulette/roulette_api.rocket` wraps the engine in a
presentation session so the application can hold multiple game states without
module-alias collisions. `src/app/roulette_view.rocket` owns only table hit
regions, keyboard focus, procedural rendering, and animation timing; it never
chooses or changes the winning pocket.

`src/plinko/plinko_model.rocket`, `plinko_rules.rocket`, and
`plinko_engine.rocket` own 8-16-row
configuration, three audited risk tables, deterministic 50/50 paths, bounded
1-10-ball batches, prepaid wagers, integer-credit settlement, and history.
`src/plinko/plinko_api.rocket` is the presentation session boundary.
`src/app/plinko_view.rocket` scales the peg board to the window and animates
only the paths already committed by the engine. Exact tables and binomial
expected-return calculations are published in `PLINKO_MATH.md`.

`src/chicken/chicken_model.rocket`, `chicken_rules.rocket`, and
`chicken_engine.rocket` own the finite
10-rung Coop Climb round, fixed survival/multiplier profiles, prepaid wager,
hidden seeded path, legal advance/cash-out transitions, settlement, and bounded
history. `src/chicken/chicken_api.rocket` exposes only presentation intents.
`src/app/chicken_view.rocket` reads completed/current state but never inspects
future path values. Exact tables are published in `COOP_CLIMB_MATH.md`.

`src/crossing/crossing_model.rocket`, `crossing_rules.rocket`, and
`crossing_engine.rocket` own the integer
lane world, seeded hazards, fixed ticks, player movement, collisions, canal
support, checkpoints, difficulty, pause, cash-out, and settlement.
`src/crossing/crossing_api.rocket` exposes intents and tick requests.
`src/app/crossing_view.rocket` only scales engine positions and emits controls;
it never advances hazards. The full contract is in
`MIDNIGHT_CROSSING_DESIGN.md`.

`src/holdem/holdem_cards.rocket` owns the checked 52-card deck and deterministic
Fisher-Yates shuffle. `evaluator.rocket` selects and compares the best five of
seven; `holdem_rules.rocket` validates legal actions and sizing;
`holdem_engine.rocket` owns
blinds, order, streets, contributions, all-ins, reopening, and bounded
progression; `pots.rocket` settles contribution tiers, ties, and clockwise odd
chips; and `ai.rocket` uses only its own cards and public state.
`src/holdem/holdem_api.rocket` exposes privacy-safe opponents and legal human
intents. `src/app/holdem_view.rocket` renders only that public table. The full
contract is in `HOLDEM_DESIGN.md`.

`src/mines/mines_model.rocket`, `mines_rules.rocket`, and
`mines_engine.rocket` own the 5-by-5 board, exact combinatorial survival math,
seeded unique layout, prepaid wager, reveal legality, cash-out settlement, and
bounded history. `src/mines/mines_api.rocket` exposes hidden/safe/mine tile
states only after reveal. `src/app/mines_view.rocket` renders the original gem
grid and consumes committed outcomes during bounded animations. Exact formulas
and rounding are published in `MINES_MATH.md`.

## Money representation

All play-money values are integer credits. Bets use a table unit compatible with exact 3:2 payouts. Balances must never become negative. Credits have no cash value and are not transferable.

## Determinism and testing

Shoe, Roulette wheel, Plinko path, Coop Climb ladder, Midnight Crossing world generation, Hold'em deck/AI variation, and Mines layout accept explicit seeds. Tests use deterministic state construction through checked helpers and scripted GUI input. Production rendering and audio are excluded from engine decisions. Every safety loop has a finite error-producing bound.

## Native boundary

The C++ adapter owns only raylib calls, primitive C ABI translation, and validated resource tokens. Window, audio, sound, texture, and callback lifetimes are exercised by focused tests. Application state, Blackjack rules, persistence, routing, and rendering composition remain in Rocket.
