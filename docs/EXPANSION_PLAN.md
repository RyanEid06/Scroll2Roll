# Scroll2Roll 0.2.0 Expansion Plan

## Authority and scope

This plan records the owner-approved expansion of the completed Scroll2Roll
0.1.0 baseline. It extends, but does not weaken, `MASTER_PLAN.md`. The work adds
five complete local, single-player, account-free, play-money games in this
order:

1. European Roulette.
2. Plinko.
3. Chicken.
4. Cross the Road.
5. Single-player No-Limit Texas Hold'em.

Blackjack remains a supported sixth game and every existing Blackjack behavior
and regression test remains an acceptance requirement. Rocket 2.0 and the
Rocket repository remain frozen. Casino source, tests, documentation, assets,
packages, and website work stay in this repository.

The application and save version for this expansion is **0.2.0**. The save
header becomes `scroll2roll-save-2`; the loader will migrate valid
`scroll2roll-save-1` data without losing audio, display, AI-count, first-run, or
play-credit values. Unknown, truncated, or invalid data continues to recover to
safe defaults with an explicit recovery message.

## Product and safety boundaries

- Credits are local play-money counters with no monetary value.
- There are no accounts, payments, purchases, deposits, withdrawals,
  cryptocurrency, online services, cloud saves, or multiplayer networking.
- The Windows x64 native application is not browser-playable. The Cloudflare
  site remains a static product and download site.
- Game names, procedural visuals, animation, sounds, rules presentation, and
  copy are original Scroll2Roll work. No protected casino-provider or arcade
  branding, source, art, layout, character, sound, or exact presentation will
  be copied.
- Random outcomes are deterministic under an explicit test seed. Production
  sessions derive documented per-round seeds. No presentation animation may
  change or reroll an engine result.
- Every wager is validated before balance mutation. Failed operations are
  atomic, balances cannot become negative, and all simulation/state loops have
  finite guards.

## Architecture

### Dependency direction

Dependencies remain one way:

1. Shared value modules: cards where rules truly overlap, deterministic random
   helpers, credit/bet validation, result history, and small immutable utility
   values.
2. A rendering-independent model, rules module, engine, and settlement module
   for each game.
3. A deliberately small presentation-facing API for each game.
4. Versioned persistence, independent of every game engine.
5. Reusable application router, theme, components, help/results overlays, and
   per-game views/controllers.
6. The safe Rocket raylib wrapper over the primitive C++ adapter.

Rules, legal actions, RNG, collision outcomes, card privacy, AI decisions,
settlement, and payouts never live in a view, application router, or C++
adapter. Views render engine state and emit intents through a game's API.

### Application router and sessions

`src/app/registry.rocket` will describe all six available games with stable
integer identifiers, names, descriptions, controls/help metadata, and routing
availability. The lobby will use a responsive grid rather than fixed
Blackjack/Roulette/Poker slots.

The application state will own one inactive/default state per game because
Rocket values are explicit and serializable. Only the selected game's
controller updates each frame. Shared transitions handle startup, lobby,
settings, help, result/restart, persistence, and exit confirmation. Returning
to the lobby settles or explicitly abandons only according to the selected
engine's documented legal transition; no renderer silently refunds or settles
a wager.

### Shared credit policy

Version 0.2.0 keeps one local play-credit balance. A game receives the current
balance when a session starts and returns an engine-computed balance at a
settled/cash-out/hand boundary. Leaving a live wager requires a game-specific
confirmation or is disabled. Persistence occurs only at safe boundaries.

The existing 10-credit minimum remains the default entry stake. Engines may
document narrower units where payout arithmetic requires them. All payout math
uses integers. Fractional theoretical values are represented as integer ratios
and rounded only by an explicitly documented rule.

### Shared systems

Extraction is allowed only when it removes real duplication:

- `src/shared/cards.rocket`: card identity, rank/suit names, standard deck, and
  deterministic shuffle shared by Blackjack and Hold'em. Blackjack hand value
  and rules stay in Blackjack.
- `src/shared/random.rocket`: bounded deterministic integer generation and
  derived seeds without rendering dependencies.
- `src/shared/credits.rocket`: common nonnegative amount and table-limit checks.
- `src/shared/history.rocket`: compact integer result-history helpers where
  representation is genuinely common.
- `src/app/components.rocket`: reusable buttons, panels, chips, cards, tabs,
  meters, help/results overlays, and focus/disabled presentation.

No common "casino engine" will couple unrelated rules. Roulette bet geometry,
Plinko paths, Chicken ladders, Cross the Road simulation, and poker betting
remain owned by their respective engines.

### Raylib adapter audit

The current adapter already supplies window dimensions, timing, rectangles,
circles, text measurement, keyboard/mouse input, textures, fonts, audio,
scripted input, and lifetime counters. Before each UI milestone, use the
existing operations first. Add only demonstrated primitives such as line or
triangle drawing, mouse-wheel input, or clipping when the game cannot meet its
readability/control requirement without them. Each adapter addition requires
test-mode behavior, stale-handle/error validation where applicable, and
resource-lifetime regression coverage.

## European Roulette

### Rules and data model

The wheel is single-zero European Roulette with pockets 0 through 36. The
canonical wheel order is:

`0, 32, 15, 19, 4, 21, 2, 25, 17, 34, 6, 27, 13, 36, 11, 30, 8, 23, 10, 5,
24, 16, 33, 1, 20, 14, 31, 9, 22, 18, 29, 7, 28, 12, 35, 3, 26`.

Bet records contain a bet-kind code, up to six canonical pocket values, and an
integer stake. Constructors validate exact adjacency/geometry rather than
trusting the view. Supported bets and profit odds are:

| Bet | Covered pockets | Profit odds |
| --- | ---: | ---: |
| Straight | 1 | 35:1 |
| Split | 2 | 17:1 |
| Street | 3 | 11:1 |
| Corner | 4 | 8:1 |
| Basket (0, 1, 2, 3) | 4 | 8:1 |
| Six-line | 6 | 5:1 |
| Dozen | 12 | 2:1 |
| Column | 12 | 2:1 |
| Red/black | 18 | 1:1 |
| Odd/even | 18 | 1:1 |
| Low/high | 18 | 1:1 |

The settlement return for a winner is `stake * (profit_odds + 1)`. Zero loses
all even-money, dozen, and column bets. Every bet is evaluated independently,
so multiple simultaneous bets settle atomically.

### Engine and API

Phases are betting, spinning, and settled. The API exposes creation, chip
selection, validated placement, undo, clear, repeat/rebet, spin/result commit,
history, total wager, balance, and next round. The engine chooses the winning
pocket from the canonical wheel using the explicit seed and round number before
animation begins. Repeat copies the previous wager set before a spin; rebet
starts the next betting phase with the last settled wager set when affordable.
Table minimum, maximum per position, and maximum total wager are explicit.

### UI

The view includes a readable 0-36 table, red/black coloring, outside-bet areas,
chip denomination controls, placed-chip totals, total wager/balance, undo,
clear, repeat/rebet, spin, help, winning pocket, payout, and recent history.
Mouse hit regions include number centers, shared edges, row intersections,
street/six-line edges, the basket region, and outside bet boxes. Keyboard focus
can traverse the same targets and place/remove a chip. The wheel and ball
animation consume the already-chosen pocket and finish within a fixed duration.

### Deterministic tests

Tests cover every bet constructor and invalid geometry; colors and outside
groups; zero behavior; all odds; simultaneous wins/losses; table limits;
insufficient funds; undo/clear/repeat/rebet; deterministic seeds and history;
multi-round balance invariants; persistence boundaries; scripted keyboard and
mouse placement/spin/results/lobby flows; and bounded animation completion.

## Plinko

### Rules and payout math

Boards support 8 through 16 rows. A result contains exactly `rows` left/right
steps and a bucket index from 0 through `rows`. Low, medium, and high risk each
have an explicit integer multiplier table in basis points, where `10000` is
1.00x. Settlement is `stake * multiplier_basis_points / 10000` using floor
rounding, documented in the help screen.

For a fair 50/50 path, bucket probability is
`C(rows, bucket) / 2^rows`. The documented theoretical expected return is the
sum of probability times multiplier. Every shipped table must be auditable in
source and documentation, remain below or equal to 100%, and target a narrow
published play-money return band. A validation test recomputes every row/risk
expected return from the actual table rather than a duplicated claim.

### Engine and API

The engine owns row/risk selection, bet validation, deterministic path
generation, single or queued multi-ball drops, settlement, balance, and recent
results. A batch is bounded to a documented small maximum. If autoplay is
implemented, its requested drop count is finite and stops on insufficient
credits or the count limit.

### UI and tests

The view renders pegs, a ball following the engine path, buckets, multipliers,
row/risk/bet/batch controls, history, help, results, restart, and lobby flow.
Tests cover every supported row/risk table, expected-return calculation, path
length/bucket invariants, deterministic seeds, bet failures, batch bounds,
multi-round balances, animation/path agreement, persistence, and scripted
keyboard/mouse flows.

## Chicken

### Original rules and payout math

Chicken is an original turn-based ladder named **Coop Climb** in presentation.
It does not reproduce another provider's road, character, artwork,
multipliers, or layout. A round locks one wager and generates a deterministic
safe/fail path for a finite ladder. After every safe rung, the player chooses
advance or cash out. A failed advance loses the wager.

Low, medium, and high risk profiles define per-step survival probabilities as
integer ratios and a house-return target. The cash-out multiplier at depth `d`
is derived and then fixed in an auditable basis-point table:

`multiplier(d) = floor(target_return * 10000 / cumulative_survival(d))`.

Tables, maximum depth, rounding, theoretical return, and the fact that future
path values are hidden are documented. Cash-out settlement is
`stake * multiplier_basis_points / 10000` with floor rounding.

### Engine, UI, and tests

The engine owns risk, wager, hidden deterministic path, legal advance/cash-out,
settlement, and balance. The UI presents an original observatory/coops motif,
clearly separated completed/current/future rungs, multiplier progression,
advance/cash-out controls, help, results, restart, and lobby flow. Tests cover
probability and multiplier tables, deterministic paths, each legal/illegal
transition, first/last-rung cash-out, failure, wager validation, nonnegative
balances, multi-round sessions, bounded completion, and scripted keyboard and
mouse flows.

## Cross the Road

### Original real-time design

Cross the Road is presented as **Midnight Crossing**, a player-controlled
real-time arcade survival game distinct from Coop Climb. The player moves on a
bounded lane grid through original city traffic, tram tracks, and canal/log
hazards. Forward movement reaches checkpoints, increases score and a visible
cash-out multiplier, and raises deterministic simulation difficulty. Sideways
and backward movement support avoidance but do not farm score.

Player input determines movement and timing. A seeded simulation determines
hazard spawn patterns, directions, speeds, and phase offsets. The engine—not
the view—advances fixed simulation ticks, applies inputs, detects collisions,
determines safe support on water lanes, awards checkpoints, exposes legal
cash-out, and settles the wager. Variable render time is accumulated into a
bounded number of fixed ticks per frame; excess time is capped.

### Engine, UI, and tests

The simulation uses integer/fixed-point positions so identical seed and input
scripts produce identical results. The UI renders lanes, original player and
hazard shapes, checkpoint/score/multiplier/balance, pause/help, failure,
cash-out, restart, and lobby flow. Keyboard uses arrows/WASD-equivalent keys
available through the adapter; mouse/touch-style directional controls provide
equivalent movement and cash-out.

Tests cover deterministic world generation, identical scripted replays,
traffic/tram/water collisions, safe-platform movement, checkpoint scoring,
difficulty bounds, illegal movement, pause, cash-out, failure, tick guards,
multi-round balances, persistence, and complete keyboard/mouse GUI scripts.

## No-Limit Texas Hold'em

### Table and card rules

The game is a local cash table with one human and 1-5 bounded AI opponents.
The engine owns a standard 52-card deck, deterministic Fisher-Yates shuffle,
dealer button, blinds, heads-up exceptions, action order, four betting streets,
legal actions, contributions, all-ins, folds, showdown, and next-hand/table
reset behavior.

The minimum opening bet is the big blind. A full raise is at least the current
minimum raise increment; a short all-in is legal but does not reopen raising
for players who already acted. Check, call, bet, raise, fold, and all-in are
validated against turn, stack, call amount, minimum/maximum target, and reopen
state. Every betting loop is bounded and also terminates when only one live
player remains or all remaining players are all-in.

### Hand evaluation and pots

Seven-card evaluation selects the best five-card hand and compares, in order:
high card, pair, two pair, three of a kind, straight, flush, full house, four of
a kind, straight flush. Tiebreak vectors are lexicographic and support the
wheel straight. Tests include exhaustive five-card category counts and focused
seven-card/tie cases.

Main and side pots are built from contribution levels. Folded contributions
remain in pots but folded players are ineligible. Each pot is divided equally
among its best eligible hands. Odd chips are awarded one at a time clockwise
from the first live seat left of the dealer button. Uncontested pots settle
without exposing folded hole cards.

Players at zero credits sit out the next hand. If the human cannot cover the
big blind, the table offers an explicit play-money reset/rebuy to the documented
default rather than silently creating credits. AI seats reset only through the
same documented new-table action.

### Deterministic AI

AI decisions use only engine-visible information: legal actions, hole cards,
community cards, pot odds, stack pressure, position, and a deterministic
seeded variation value. Preflop uses a bounded starting-hand score; postflop
uses the evaluator plus a bounded deterministic rollout or documented made-hand
and draw heuristic. AI never reads the human's hole cards or future deck.
It is described as credible recreational AI, not professional or unbeatable.

### API, UI, and tests

The API exposes public table state with privacy-safe opponent views, legal
actions and bet bounds for the human, apply action, deterministic AI step,
bounded run-until-human/showdown, next hand, and table reset. The UI includes
dealer/blind markers, private human cards, hidden opponent cards, community
cards, pots, stacks, street contributions, action history, active-seat
highlight, sizing presets/slider-equivalent controls, disabled illegal actions,
showdown reveals, split-pot presentation, next hand, help, restart, and lobby.

Tests cover deck uniqueness/shuffle determinism; all hand categories and ties;
heads-up and multiway blinds/order; every action and minimum-raise rule; short
all-ins and reopening; folds/checks/calls/bets/raises; street advancement;
uncontested pots; main/side/split/odd-chip pots; privacy; deterministic AI;
eliminations/reset; complete deterministic hands and sessions; negative-balance
and chip-conservation invariants; safety guards; persistence boundaries; and
scripted keyboard/mouse GUI flows.

## Milestones and gates

### E0 - Baseline and expansion foundation

- Record clean Git baseline and rerun Debug/Release validation.
- Add this expansion plan before implementation.
- Add shared primitives only with focused tests.
- Introduce version 0.2.0 and save-v2 migration with backward-compatibility
  tests before relying on new fields.
- Update architecture, roadmap, testing, controls, and project context.

### E1 - European Roulette

Complete engine, API, UI, deterministic tests, GUI flows, router entry,
persistence boundary, help, documentation, and Blackjack regression validation.
Only then replace the Roulette placeholder.

### E2 - Plinko

Complete engine, API, UI, auditable multiplier/return tables, deterministic
tests, GUI flows, router entry, documentation, and all prior regression tests.

### E3 - Chicken / Coop Climb

Complete engine, API, original UI, probability/payout documentation,
deterministic tests, GUI flows, router entry, and all prior regression tests.

### E4 - Cross the Road / Midnight Crossing

Complete fixed-tick engine, deterministic hazards and replay tests, complete
real-time UI and controls, GUI flows, router entry, documentation, and all
prior regression tests.

### E5 - No-Limit Texas Hold'em

Complete cards/evaluator, betting state machine, pots, deterministic AI, privacy
API, complete UI, GUI flows, router replacement for the Poker placeholder,
documentation, and all prior regression tests.

### E6 - Release acceptance

- Run Debug and Release native builds.
- Run `rocketc check`, the complete Rocket suite, and formatting checks.
- Run deterministic complete-round/session tests for all six games.
- Run save-v1 migration, save-v2 round-trip, missing/corrupt recovery tests.
- Run scripted keyboard and mouse GUI flows for every game.
- Run native adapter, resource lifetime, audio, missing-asset, and clean-shutdown
  tests.
- Revalidate Visual Studio Community 2026 Build, Run, Test, Stop, Output/Error
  List, LSP diagnostics/navigation/refactoring/formatting, and Rocket-source
  debugging from this repository.
- Produce the portable 0.2.0 Windows x64 package with notices, version,
  controls, troubleshooting, checksums, and no forbidden content.
- Test the package from a sanitized relocated directory without the checkout.
- Update and validate the source and staged Cloudflare site against current
  official free-tier limits, with only verified feature claims.
- Record exact commands, results, limitations, archive size, and SHA-256 in
  durable documentation.
- Inspect the final diff and ignored/untracked files; make logical local commits
  and finish with a clean working tree.
- Do not push, deploy, publish, create a release, or claim signing.

## Definition of done for each game

A game milestone is complete only when its engine is rendering-independent;
its public API is small; every required rule and payout is implemented; seeded
outcomes are reproducible; balances and loops satisfy invariants; keyboard and
mouse interaction cover a full playable flow; help, disabled actions, results,
restart, and lobby return are present; persistence boundaries are safe; focused
and failure-path tests pass; all prior game and infrastructure tests still
pass; documentation and `PROJECT_CONTEXT.md` describe only verified behavior;
and the milestone is captured in a logical local Git commit.
