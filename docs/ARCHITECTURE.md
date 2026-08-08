# Architecture

## Dependency rules

The application follows one-way dependencies: reusable shell and Blackjack presentation call the public Blackjack API; that API coordinates engine modules; engine modules depend on shared model values and standard modules only. Persistence is an explicit boundary. The raylib wrapper and native adapter are infrastructure and never own casino rules.

Circular imports, duplicated visual rules, machine-specific paths, and C++ application state are prohibited.

## Planned modules

- `src/blackjack/model.rocket`: public state and result values.
- `src/blackjack/cards.rocket`: validated cards, names, and hand evaluation.
- `src/blackjack/shoe.rocket`: deck construction, deterministic shuffling, draw, and cut-card policy.
- `src/blackjack/rules.rocket`: table limits and rule configuration.
- `src/blackjack/engine.rocket`: betting, legal actions, state transitions, dealer, settlement, and round cleanup.
- `src/blackjack/strategy.rocket`: deterministic basic strategy.
- `src/blackjack/api.rocket`: intentionally small presentation-facing facade.
- `src/app/*`: router, screens, reusable components, design tokens, and input flow.
- `src/persistence.rocket`: versioned local settings/save parsing and safe recovery.
- `src/rocket_raylib.rocket`: safe Rocket graphics/input/audio boundary.
- `native/rocket_raylib_adapter.*`: primitive ABI and resource-token policy only.

## Money representation

All play-money values are integer credits. Bets use a table unit compatible with exact 3:2 payouts. Balances must never become negative. Credits have no cash value and are not transferable.

## Determinism and testing

Shoe generation accepts an explicit seed. Tests use deterministic state construction through checked helpers and scripted GUI input. Production rendering and audio are excluded from engine decisions. Every safety loop has a finite error-producing bound.

