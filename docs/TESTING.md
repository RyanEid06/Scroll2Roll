# Testing Scroll2Roll

No feature claim is complete until its focused test passes.

The implemented matrix covers Rocket check/build/test, Blackjack card/shoe/rule invariants, complete European Roulette bet geometry and payouts, exact Plinko and Coop Climb probability/return tables, fixed-tick Midnight Crossing replays and hazards, exhaustive Hold'em evaluation and complete no-limit table flows, deterministic complete and consecutive sessions, nonnegative balances, safety limits, save-v1 migration/save-v2 recovery, scripted GUI input, native resource lifetimes, package contents, sanitized relocation, and static website checks.

Test setup helpers must return explicit failure or a nonzero test status when construction is invalid. They must never substitute a plausible fallback card, state, or resource.

## Rocket test suites

- `cards_shoe_test.rocket`: card validation, hand values, six-deck composition, deterministic shuffle, draw, and cut-card reshuffle.
- `hand_settlement_test.rocket`: hard/soft/natural/bust values and win/loss/push/Blackjack/surrender payouts.
- `betting_actions_test.rocket`: table limits, balances, Hit, Stand, Double, Split, split Aces, four-hand limit, and Late Surrender.
- `rounds_strategy_test.rocket`: AI decisions, dealer soft-17 behavior, complete rounds, consecutive rounds, and bounded progression.
- `persistence_test.rocket`: versioned round trips, missing/invalid/older save recovery, and approved play-money progress.
- `gui_flow_test.rocket`: scripted keyboard/mouse startup, lobby, settings, betting, complete round, next round, persistence, lobby return, and exit confirmation.
- `roulette_rules_test.rocket`: wheel uniqueness, colors, every inside/outside bet constructor, invalid geometry, zero behavior, and exact payouts.
- `roulette_session_test.rocket`: simultaneous wagers, limits, undo/clear/repeat/rebet, deterministic spins, settlement, history bounds, and multi-round balances.
- `roulette_gui_flow_test.rocket`: complete keyboard/mouse table flow, help, chip selection, engine-locked animation, persistence, rebet, clear, and lobby return.
- `plinko_math_test.rocket`: combinations, outcome counts, table symmetry, risk ordering, payout rounding, and exact 8-16-row expected returns documented in `PLINKO_MATH.md`.
- `plinko_session_test.rocket`: deterministic paths, batch validation, prepaid wagers, locked configuration, settlement, history bounds, failure paths, and consecutive-round balances.
- `plinko_gui_flow_test.rocket`: responsive lobby routing, keyboard/mouse configuration, help, bounded multi-ball animation, settlement, persistence, next round, and lobby return.
- `chicken_rules_test.rocket`: all fixed survival/multiplier tables, every depth's 95.99%-96.00% expected return, risk ordering, wager validation, and floor settlement documented in `COOP_CLIMB_MATH.md`.
- `chicken_session_test.rocket`: deterministic hidden paths, legal/illegal transitions, first/final-rung cash-out, failure, insufficient balance, 25-round balance bounds, and bounded history.
- `chicken_gui_flow_test.rocket`: minimum-size lobby routing, help, keyboard/mouse risk and wager controls, advance, cash-out/failure, persistence, next round, lobby return, and resource cleanup.
- `crossing_rules_test.rocket`: lane/hazard classification, world/tick/checkpoint bounds, collision overlap, pass validation, and exact cash-out payouts documented in `MIDNIGHT_CROSSING_DESIGN.md`.
- `crossing_simulation_test.rocket`: deterministic world generation and replays, traffic/tram/canal failure, log drift, checkpoints, difficulty, movement legality, pause, tick cap, cash-out, five-checkpoint completion, and 15-round balances.
- `crossing_gui_flow_test.rocket`: minimum-size keyboard/mouse direction flows, real-time safe timing, pause/help, two complete checkpoint cash-outs, persistence, next run, lobby return, rendering, and cleanup.
- `holdem_cards_evaluator_test.rocket`: deck uniqueness, deterministic shuffle,
  every focused category/tiebreak/wheel case, seven-card selection, ties, and
  exhaustive canonical counts across all 2,598,960 five-card hands.
- `holdem_betting_test.rocket`: one-to-five AI table bounds, heads-up and
  multiway blinds/order, check/call/fold/full raise, minimum targets, short
  all-ins and non-reopening, street advancement, uncontested pots, and chip
  conservation.
- `holdem_pots_ai_privacy_test.rocket`: contribution-tier main/side pots,
  folded money, split ties, clockwise odd chips, deterministic bounded AI,
  opponent privacy, explicit reset/rebuy, complete hands, consecutive hands,
  and conservation.
- `holdem_gui_flow_test.rocket`: minimum-size sixth-tile routing, help,
  privacy-safe rendering, keyboard sizing/raise/all-in, mouse Deal/Check/Call,
  complete consecutive hands, settlement persistence, explicit new table,
  lobby return, and resource cleanup.
- Four reviewed raylib tests cover API behavior, audio stress, resource lifetime, and missing assets.

The current suite passes 26/26 tests. Before those gates run,
`scripts/validate.ps1` also rejects duplicate `.rocket` basenames under `src` so
the frozen CodeView debugger can map every source unambiguously. Package
relocation and source/staged website checks are separate scripts. Exact evidence
is recorded in `VALIDATION.md`; generated evidence stays under ignored `out/`.
