# Testing Scroll2Roll

No feature claim is complete until its focused test passes.

The implemented matrix covers Rocket check/build/test, Blackjack card/shoe/rule invariants, complete European Roulette bet geometry and payouts, deterministic complete and consecutive sessions, nonnegative balances, safety limits, save-v1 migration/save-v2 recovery, scripted GUI input, native resource lifetimes, package contents, sanitized relocation, and static website checks.

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
- Four reviewed raylib tests cover API behavior, audio stress, resource lifetime, and missing assets.

The current suite passes 13/13 tests. Package relocation and source/staged website checks are separate scripts. Exact evidence is recorded in `VALIDATION.md`; generated evidence stays under ignored `out/`.
