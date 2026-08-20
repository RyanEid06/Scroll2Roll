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
- `mines_rules_test.rocket`: all 1-24 mine counts, exact combinations,
  survival fractions, every safe-depth multiplier, and payout floor rounding.
- `mines_session_test.rocket`: unique deterministic layouts, privacy, safe and
  mine reveals, cash-out legality, duplicate/invalid atomic failures,
  insufficient credits, history bounds, and consecutive-round balances.
- `mines_gui_flow_test.rocket`: minimum-size seventh-card routing, complete
  keyboard and mouse configuration/reveal/cash-out flows, bounded animation,
  help, persistence, next round, lobby return, rendering, and cleanup.
- `dice_rules_test.rocket`: every target in both directions, exact win counts,
  boundary comparisons, multipliers, payout rounding, and auto bounds.
- `dice_session_test.rocket`: seeded results, atomic errors, manual and finite
  auto rounds, every stop condition including user stop, long sessions,
  history, and balance invariants.
- `dice_gui_flow_test.rocket`: minimum-size routing, help, keyboard/mouse manual
  rounds, incremental auto animation, visible Stop, persistence, and lobby.
- `hilo_rules_test.rocket`: checked deck uniqueness, deterministic shuffle,
  exact lower/higher/equal counts for every rank and remaining-deck prefix,
  impossible actions, tie behavior, cumulative multiplier, payout, and caps.
- `hilo_session_test.rocket`: deterministic private decks and draws, correct,
  wrong, and equal results, cash-out legality, exact settlement, full 52-card
  exhaustion, consecutive rounds, restart boundaries, history, and balances.
- `hilo_gui_flow_test.rocket`: minimum-size ninth-entry routing, help,
  keyboard/mouse deal/prediction/cash-out/next/lobby flows, privacy projection,
  animation agreement, persistence, rendering, and native cleanup.
- `crash_rules_test.rocket`: all one million distribution tickets, exact
  instant/survival/cap counts, reciprocal return example, tick curve and caps,
  wager/auto validation, and payout floor rounding.
- `crash_session_test.rocket`: deterministic precommitments, live privacy,
  before/at/after boundary behavior, auto cash-out, atomic failures, long-frame
  caps, instant crashes, consecutive rounds, restart, history, and balances.
- `crash_gui_flow_test.rocket`: minimum-size tenth-entry routing, help pause,
  keyboard/mouse manual and automatic complete rounds, live privacy, graph
  drawing, engine agreement, persistence, restart, lobby, and native cleanup.
- `slots_rules_test.rocket`: exact strips/frequencies/paylines, every line
  award and Wild substitution, overlapping wins, Scatter/free-spin/Bonus
  behavior, stop validation, and source-recomputed exact theoretical return.
- `slots_session_test.rocket`: deterministic committed stops and tickets,
  atomic failures, configuration lock, free-spin completion, Bonus and zero-win
  paths, finite/user/credit autoplay stops, 100 rounds, history, and balances.
- `slots_gui_flow_test.rocket`: minimum-size eleventh-entry routing, help,
  keyboard/mouse manual, Turbo, stopped and complete finite autoplay, committed
  sequential reveal, persistence, restart, lobby, drawing, and native cleanup.
- Four reviewed raylib tests cover API behavior, audio stress, resource lifetime, and missing assets.

The accepted pre-overhaul post-Slots suite passed 41/41 tests. Before those gates run,
`scripts/validate.ps1` also rejects duplicate `.rocket` basenames under `src` so
the frozen CodeView debugger can map every source unambiguously. Package
relocation and source/staged website checks are separate scripts. The website
validator checks all three pages, exactly eleven catalog cards, the complete
verified package identity, local-only profile storage, nickname/avatar safety
controls, the absence of password and network APIs, same-origin security policy,
accessible focus/reduced-motion hooks, prohibited product claims, and Cloudflare
file/asset ceilings. Browser interaction checks cover local profile creation,
reset, and navigation, desktop two-column card geometry, all eleven titles,
exact package presentation, console errors, and 390px Play/Download layouts
without horizontal overflow.
Exact evidence is recorded in `VALIDATION.md`; generated evidence stays under
ignored `out/`.

## Native UI overhaul gates

The pre-overhaul functional baseline is 41/41. `ui_foundation_test.rocket` adds
deterministic coverage for semantic timing/target constants, responsive mode
selection, lobby columns, positive usable geometry, compact stacking, and the
exact five required viewports. Later overhaul milestones must add focused
tests for theme migration/round-trip, persistent safe Back behavior, both-theme
drawing for every screen, custom-font success/fallback/cleanup, texture and
scissor lifetimes, mouse-wheel scroll bounds, reduced motion, and non-overlap
layout invariants.

`ui_resources_test.rocket` covers independent font/atlas success, missing and
corrupt degradation, exact atlas mapping, and balanced unload/close lifetimes.
`ui_components_test.rocket` draws both-theme surfaces and every shared state,
uses real-font and atlas handles through the deterministic adapter, exercises an
illustrated card and a distinct procedural fallback, and proves scissor/resource
cleanup. The adapter smoke test now covers custom-font measurement, source-
region texture drawing, rounded fill/outline, line, triangle, ring, balanced
scissor, and consumable mouse wheel. Persistence tests cover save-v1, save-v2,
and save-v3 migration to save-v4, save-v4 round-trip, theme/reduced-motion
integrity, and invalid recovery. The current suite passes 44/44 in Debug and
Release before the shell milestone.

`ui_shell_test.rocket` covers exact layout and drawing at 800x600, 1024x768,
1280x720, 1600x900, and 1920x1080; compact/wide lobby paging; minimum target and
card sizes; non-overlap; resource-backed dark/light startup, lobby, settings,
and help drawing; theme persistence; reduced motion; exact help return; safe
Back; live-wager preservation; and explicit modal hitboxes. All eleven GUI flow
tests now discover and activate games through the responsive lobby contract.
`ui_core_games_view_test.rocket` covers the accepted Blackjack, Roulette,
Hold'em, and HiLo replacement group. It checks compact/standard/wide/cinema
stage and rail bounds, 44-pixel controls, phase-specific non-overlap, and both-
theme ready/active/settled drawing at 800x600, 1024x768, 1280x720, 1600x900,
and 1920x1080. The Roulette GUI flow derives center, edge, corner, street,
six-line, basket, chip, and action clicks from responsive view geometry;
Hold'em and HiLo GUI flows likewise use exported responsive controls. The
current suite passes 46/46 in Debug and Release.

`ui_arcade_games_view_test.rocket` covers the accepted Plinko, Coop Climb, and
Midnight Crossing replacement group. It checks phase-specific exported
controls for 44-pixel minimum size, bounds, and non-overlap, then draws each
game in ready/active/settled states in both themes at all five exact target
dimensions. The three scripted GUI flows now click those exported responsive
rectangles instead of compatibility-era pixels. The current suite passes
47/47 in Debug and Release.

`ui_final_games_view_test.rocket` covers the accepted Mines, Dice, Crash, and
Slots replacement group. It validates every exported phase-specific control at
800x600, 1024x768, 1280x720, 1600x900, and exact 1920x1080 for bounds,
non-overlap, and 44-pixel targets. Mines' 25 compact board cells have a separate
32-pixel practical minimum while every action remains at least 44 pixels. The
test draws ready/active/settled states in both themes, verifies balanced scissor
state after clipped reel motion, and requires substantial draw activity. The
four scripted GUI flows now use exported responsive rectangles for every
changed pointer path. The current suite passes 48/48 in Debug and Release.

That 48/48 statement is the accepted pre-post-art/full-overhaul baseline.
Post-art Groups 1-3 each completed fresh Debug/Release passes. Group 4 completed
repository check plus focused resource/final-view/core-view fixtures and native
Dice/HiLo review. On 2026-08-20 the owner explicitly requested no further game
builds and no repeated all-eleven suite, so no fresh post-Group-4 full pass is
claimed.

Functional drawing tests are necessary but not visual acceptance. Each visual
milestone launches the actual native executable and records dark/light captures
at 800x600, 1024x768, 1280x720, 1600x900, 1920x1080, and maximized. Review must
check recognizable game grammar, stage dominance, action order, typography,
contrast, focus/disabled states, help/history usability, clipping, overlap,
negative geometry, reachability, and any lingering flat debug composition.

Final package validation checks an exact 48-file allowlist, recursive internal
checksums, reviewed font/art/manifest hashes, the complete pinned raylib
license, forbidden source/build/development content, safe checksum paths,
archive sidecar integrity, and a relocated `--headless-smoke` run with the
relocation directory as the process working directory. The post-art local
review archive is 51,516,900 bytes with SHA-256
`e27cc112aa7a50dde1acea8d369aeb594ab88552f7668625df7c37008f1d0115`.
It was intentionally created from the existing executable without a new build,
so it is not fresh Release evidence.

Final source-website validation checks all 13 verified native-capture hashes, their
references, the eleven equal cards, local profile safety, CSP, reduced motion,
semantic palette hooks, prohibited claims, and exact package metadata. When a
staged archive exists, its bytes and hash are also checked. The current 49.13
MiB archive exceeds the static host's 25 MiB per-file ceiling, so no new staged
tree or browser re-acceptance is claimed. The prior 19/20-file and desktop/mobile
browser QA remains historical baseline evidence.
