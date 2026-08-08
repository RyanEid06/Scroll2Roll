# Architecture

## Dependency rules

The application follows one-way dependencies: reusable shell and Blackjack presentation call the public Blackjack API; that API coordinates engine modules; engine modules depend on shared model values and standard modules only. Persistence is an explicit boundary. The raylib wrapper and native adapter are infrastructure and never own casino rules.

Circular imports, duplicated visual rules, machine-specific paths, and C++ application state are prohibited.

## Implemented modules

- `src/blackjack/model.rocket`: public state and result values.
- `src/blackjack/cards.rocket`: validated cards, names, and hand evaluation.
- `src/blackjack/shoe.rocket`: deck construction, deterministic shuffling, draw, and cut-card policy.
- `src/blackjack/rules.rocket`: table limits and rule configuration.
- `src/blackjack/settlement.rocket`: outcome resolution and exact integer-credit payouts.
- `src/blackjack/engine.rocket`: betting, legal actions, state transitions, dealer progression, AI turns, and round cleanup.
- `src/blackjack/strategy.rocket`: deterministic basic strategy.
- `src/blackjack/api.rocket`: intentionally small presentation-facing facade.
- `src/app/*`: router, screens, reusable components, design tokens, and input flow.
- `src/persistence.rocket`: versioned local settings/save parsing and safe recovery.
- `src/rocket_raylib.rocket`: safe Rocket graphics/input/audio boundary.
- `native/rocket_raylib_adapter.*`: primitive ABI and resource-token policy only.

`src/app/registry.rocket` is the shell's routing boundary. Blackjack, European Roulette, and Plinko are registered as available; Poker remains an honest future placeholder until its mandated milestone. Adding a game does not require rewriting startup, lobby, settings, persistence, or common controls.

`src/app/blackjack_view.rocket` reads engine state and emits intents through `src/blackjack/api.rocket`. It does not calculate legal moves, hand values, payouts, or dealer behavior.

`src/roulette/model.rocket`, `rules.rocket`, and `engine.rocket` own the complete
single-zero table, validated bet geometry, limits, seeded wheel result,
settlement, and history. `src/roulette/api.rocket` wraps the engine in a
presentation session so the application can hold multiple game states without
module-alias collisions. `src/app/roulette_view.rocket` owns only table hit
regions, keyboard focus, procedural rendering, and animation timing; it never
chooses or changes the winning pocket.

`src/plinko/model.rocket`, `rules.rocket`, and `engine.rocket` own 8-16-row
configuration, three audited risk tables, deterministic 50/50 paths, bounded
1-10-ball batches, prepaid wagers, integer-credit settlement, and history.
`src/plinko/plinko_api.rocket` is the presentation session boundary.
`src/app/plinko_view.rocket` scales the peg board to the window and animates
only the paths already committed by the engine. Exact tables and binomial
expected-return calculations are published in `PLINKO_MATH.md`.

## Money representation

All play-money values are integer credits. Bets use a table unit compatible with exact 3:2 payouts. Balances must never become negative. Credits have no cash value and are not transferable.

## Determinism and testing

Shoe, Roulette wheel, and Plinko path generation accept explicit seeds. Tests use deterministic state construction through checked helpers and scripted GUI input. Production rendering and audio are excluded from engine decisions. Every safety loop has a finite error-producing bound.

## Native boundary

The C++ adapter owns only raylib calls, primitive C ABI translation, and validated resource tokens. Window, audio, sound, texture, and callback lifetimes are exercised by focused tests. Application state, Blackjack rules, persistence, routing, and rendering composition remain in Rocket.
