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

`src/app/registry.rocket` is the shell's routing boundary. Blackjack, European Roulette, Plinko, Coop Climb, Midnight Crossing, No-Limit Hold'em, Mines, Dice, HiLo, Crash, and Slots are registered as available. Adding a game does not require rewriting startup, lobby, settings, persistence, or common controls.

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

`src/dice/dice_model.rocket`, `dice_rules.rocket`, and `dice_engine.rocket`
own the integer 0-9999 domain, exact under/over boundaries, basis-point payout,
seeded results, manual rounds, and bounded incremental auto-roll with explicit
user/win/loss/count/credit stops. `dice_api.rocket` is the small presentation
facade; `dice_view.rocket` only animates committed results. `DICE_MATH.md`
publishes the exact contract.

`src/hilo/hilo_cards.rocket` validates and reuses the shared standard deck and
Fisher-Yates shuffle. `hilo_model.rocket`, `hilo_rules.rocket`, and
`hilo_engine.rocket` own remaining-deck counts, possible-action checks, prepaid
wagers, tie losses, cumulative basis-point multipliers, sequence advancement,
cash-out, exhaustion settlement, and bounded history. `hilo_api.rocket` exposes
a privacy-safe public table containing only drawn cards; `hilo_view.rocket`
renders that projection and committed animations. `HILO_MATH.md` publishes the
exact probability, return, rounding, and cap contract.

`src/crash/crash_model.rocket`, `crash_rules.rocket`, and
`crash_engine.rocket` own the million-ticket reciprocal distribution, prepaid
wager, hidden precommitment, exact fixed-tick multiplier, strict cash-out
boundary, optional one-round auto target, settlement, and bounded history.
`crash_api.rocket` reveals the threshold only after settlement, while
`crash_view.rocket` renders an engine-derived procedural graph and emits
intents. `CRASH_MATH.md` publishes the exact distribution, return examples,
tick curve, ordering, rounding, and caps.

`src/slots/slots_model.rocket`, `slots_rules.rocket`, and
`slots_engine.rocket` own five fixed 20-stop reels, the 5-by-3 grid, five
paylines, Wild substitution, anywhere Scatters, non-retriggering free spins,
precommitted Bonus tickets, paid-round settlement, finite autoplay, and bounded
history. `slots_api.rocket` is the presentation boundary;
`src/app/slots_view.rocket` reveals only committed reels and engine-proven
paylines. `SLOTS_MATH.md` publishes every strip, award, feature, exact return
derivation, rounding rule, and lifecycle bound.

## Money representation

All play-money values are integer credits. Bets use a table unit compatible with exact 3:2 payouts. Balances must never become negative. Credits have no cash value and are not transferable.

## Determinism and testing

Shoe, Roulette wheel, Plinko path, Coop Climb ladder, Midnight Crossing world generation, Hold'em deck/AI variation, Mines layout, Dice results, HiLo decks, Crash thresholds, and Slots stops/bonus tickets accept explicit seeds. Tests use deterministic state construction through checked helpers and scripted GUI input. Production rendering and audio are excluded from engine decisions. Every safety loop has a finite error-producing bound.

## Native boundary

The C++ adapter owns only raylib calls, primitive C ABI translation, and validated resource tokens. Window, audio, sound, texture, and callback lifetimes are exercised by focused tests. Application state, Blackjack rules, persistence, routing, and rendering composition remain in Rocket.

## UI overhaul boundary

The rejected 0.3.0 presentation is replaced without changing a game engine or
duplicating a rule. `src/app/theme.rocket` owns semantic dark/light values and
`src/app/layout.rocket` owns clamped top-level regions and breakpoints. The
application owns presentation state, navigation, theme, reduced motion,
scrolling, focus, animation clocks, and resource manifest handles. Each view
continues to consume only its public game/session projection.

`src/app/shell_view.rocket` owns the responsive startup, persistent global
shell, lobby, settings, and global-help composition. Compact lobby screen IDs
encode keyboard card focus without leaking it into a game engine; help screen
IDs preserve the exact source screen. `application.rocket` remains the router
and delegates Back eligibility to each existing engine/session boundary. The
adapter calls raylib `SetExitKey(KEY_NULL)` after window creation so Escape is
ordinary input and cannot bypass Rocket-owned active-wager protection.

Narrow additions to `native/rocket_raylib_adapter.*` may expose only primitive
rendering, custom-font measurement, scissoring, mouse-wheel input, and resource
lifetime facts required by the reviewed UI. The adapter cannot own themes,
layout, animation policy, game meaning, or settlement. The detailed gap and
asset ownership audit is in `UI_OVERHAUL_FOUNDATION.md`.

The demonstrated additions are custom-font measurement, destination/source-
region texture drawing, thick lines, triangles, rings, rounded rectangles and
outlines, balanced scissoring, and consumable mouse-wheel input. All validate
arguments and resource/frame handles, expose deterministic test behavior, and
remain policy-free. `src/app/ui_resources.rocket` is the single owner for the
bundled static Manrope Medium face and two reviewed cover atlases; it loads each
independently,
reports degraded mode, and releases every live handle before the window closes.
