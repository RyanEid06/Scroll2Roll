# Scroll2Roll Project Context and Chat Handoff

Read this file and `MASTER_PLAN.md` completely at the start of every Scroll2Roll chat. Update this file after every meaningful milestone; never describe unverified functionality as complete.

## Project identity

- Product: Scroll2Roll
- Repository: `https://github.com/RyanEid06/Scroll2Roll.git`
- Local workspace: `C:\Users\Administrator\Desktop\Projects\Scroll2Roll`
- Application: downloadable Windows desktop casino
- Language: frozen Rocket 2.0
- Graphics/input/audio: Rocket's reviewed raylib 6.0 integration
- Target: Windows x64
- IDE: Visual Studio Community 2026 with Rocket Language 2.0.3
- Current released baseline: 0.1.0
- Expansion target: 0.2.0

## Product vision and completed scope

Scroll2Roll is a polished, local, single-player, play-money casino shell that can add owner-approved games one at a time. Version 0.1.0 completes Blackjack first with a branded startup experience, reusable lobby and settings, deterministic headless engine tests, a native raylib table, versioned local persistence, portable Windows packaging, and a prepared Cloudflare product/download website.

All 13 implementation and validation milestones in `MASTER_PLAN.md` are complete locally. No push, release publication, Cloudflare deployment, or signing was performed.

The owner has approved the 0.2.0 expansion defined in
`EXPANSION_PLAN.md`: European Roulette, Plinko, Chicken (presented as the
original Coop Climb), Cross the Road (presented as the original real-time
Midnight Crossing), and single-player No-Limit Texas Hold'em, implemented in
that order. European Roulette, Plinko, Chicken, Cross the Road, Hold'em, and the
save-v2 foundation are complete. All five expansion games must pass their final
milestone and release-acceptance gates before 0.2.0 is accepted.

## Explicit non-goals

- No real-money gambling or monetary value.
- No accounts, payments, purchases, deposits, withdrawals, or cryptocurrency.
- No online multiplayer or gambling service.
- No browser implementation of the Rocket casino.
- No Rocket syntax, compiler, runtime ABI, LSP, diagnostic, package, CodeView/PDB, source-map, or Phase 19 changes.
- No additional games beyond the five explicitly approved for 0.2.0.
- No push, publication, deployment, or unsupported signing claim without owner approval.

## Rocket and raylib constraints

Rocket 2.0 remains frozen and the original Rocket repository remains untouched by casino implementation. Scroll2Roll adapts to four-space indentation, single-line call/signature/expression syntax, explicit `Result` failures, deterministic package layout, the Windows x64 C ABI, and the reviewed primitive-only raylib adapter. Casino behavior stays in Rocket. Native C++ is restricted to primitive raylib adaptation and validated resource tokens. The configurable Rocket checkout supplies pinned MSVC, Ninja, LLVM/Clang 22.1.6, and raylib 6.0; Scroll2Roll does not download a second raylib copy.

## Implemented functionality

- The authoritative master plan is preserved byte-for-byte as `docs/MASTER_PLAN.md`.
- The untouched original failing draft is preserved under `legacy/Blackjack-v1`.
- A modular rendering-independent Blackjack engine implements checked cards, exact hand values, a deterministic six-deck shoe, cut-card reshuffling, table limits, player/AI betting, legal actions, Hit, Stand, Double Down, Split, Double After Split, a four-hand maximum, split-Ace one-card behavior, no standard resplit, Late Surrender, dealer stand on soft 17, naturals, exact 3:2 settlement, and deterministic AI/basic-strategy progression.
- Complete and consecutive rounds have bounded transitions and nonnegative play-money balances.
- A small `src/blackjack/api.rocket` facade is the only rules boundary used by the visual table.
- The raylib application implements startup, reusable lobby routing, settings, exit confirmation, keyboard/mouse controls, playable Blackjack, Roulette, Plinko, Coop Climb, Midnight Crossing, and No-Limit Hold'em tables, zero-to-five AI settings, disabled illegal actions, outcomes, next round/hand, restart/reset, and lobby return.
- Versioned local persistence stores display/audio preferences, AI count, first-run state, and approved play-money progress at `%LOCALAPPDATA%\Scroll2Roll\settings.s2r`, with safe missing/invalid/older-data recovery.
- The static website and Cloudflare Pages staging flow are implemented without claiming browser play.
- Release packaging includes the native executable, version, notices, controls, troubleshooting, and checksums, and passes relocated headless smoke validation.
- Version 2 persistence writes `scroll2roll-save-2`, migrates valid
  `scroll2roll-save-1` settings and credits, and safely recovers from missing,
  invalid, or unsupported data.
- European Roulette is fully playable through its rendering-independent engine
  and presentation API. It implements the single-zero 0-36 wheel; correct
  colors; straight, split, street, corner, six-line, basket, dozen, column,
  red/black, odd/even, and low/high wagers; per-position/total limits; multiple
  wagers; undo, clear, repeat, rebet; deterministic result-locked animation;
  exact settlement; bounded history; help; keyboard/mouse controls; restart;
  and safe lobby return.
- Plinko is fully playable for 8-16 rows at Low, Medium, and High risk. Exact
  symmetric multiplier tables are normalized and audited against binomial
  landing probabilities for a 95.99%-96.00% theoretical return. Its engine
  commits explicit seeded 50/50 paths before a bounded 1-10-ball animation,
  prepays the batch, floors fractional-credit payouts, locks live
  configuration, preserves bounded history, and supports complete keyboard and
  mouse play. `PLINKO_MATH.md` publishes every table and return calculation.
- Chicken is presented as the original Coop Climb observatory ladder. Its
  rendering-independent engine prepays one wager, commits a hidden deterministic
  10-rung path, enforces advance/cash-out legality, reveals no future safety in
  the view, and settles failure or first-through-final-rung cash-outs. Low,
  Medium, and High use fixed 4/5, 2/3, and 1/2 per-step survival with audited
  95.99%-96.00% tables published in `COOP_CLIMB_MATH.md`.
- Cross the Road is presented as the original Midnight Crossing real-time city
  board. Its rendering-independent engine owns a seeded 900-unit, eight-lane
  integer world; cars, tram, and moving-log hazards; 20 Hz fixed ticks; bounded
  movement; collision/support; pause; checkpoints; difficulty; cash-out; and
  five-checkpoint completion. Keyboard and mouse timing determine the result.
  `MIDNIGHT_CROSSING_DESIGN.md` publishes the simulation and payout contract.
- Single-player No-Limit Texas Hold'em is fully playable with one human and
  1-5 deterministic recreational AI rivals. Its rendering-independent engine
  owns a checked 52-card deck, deterministic Fisher-Yates shuffle, heads-up and
  multiway blinds/order, four betting streets, complete no-limit actions,
  minimum/full/short-all-in reopening rules, best-five-of-seven evaluation,
  contribution-tier main/side/split pots, clockwise odd chips, eliminations,
  explicit table reset, bounded AI, and chip conservation. Its API hides
  opponent cards until a non-folded showdown and never exposes folded cards to
  the view. `HOLDEM_DESIGN.md` publishes the full contract.

## Architecture

Dependency direction is one way:

1. Per-game model values and validated rule constructors.
2. Rendering-independent Blackjack, Roulette, Plinko, Coop Climb, Midnight Crossing, and Hold'em engines and settlement.
3. Small presentation-facing APIs and sessions.
4. Versioned local persistence isolated from rules.
5. Reusable router, design tokens, components, lobby, settings, and per-game views.
6. The safe Rocket raylib wrapper over a primitive C++ adapter.

Rendering never owns game rules or random outcomes. The C++ adapter never owns application or casino state. Deterministic headless tests do not require a real window or audio device.

## Verified evidence

- The Rocket repository was clean on `master` at `cbf7b1a` before Scroll2Roll changes, and no casino file was placed there.
- The source master plan and `docs/MASTER_PLAN.md` both have SHA-256 `48D1E92041299ED413FA6947E4342783B29B142041D1A445C049EA259D50C4C9`.
- The preserved original `legacy/Blackjack-v1/src/blackjack.rocket` has SHA-256 `11D7291C9F222C77BCCC5A7AF8C457F0083FC6BE42DB3CA6458B80B5C3FAB5CC` and still reproduces its original Rocket parser failure.
- Debug and Release validation each pass build/check, 10/10 Rocket tests, and formatting checks.
- Visual Studio GUI Build/Run/Test/Stop/Debug, Error List navigation, Go To Definition, source breakpoints, stepping, six-frame call stack, one represented scalar local, clean stop, and terminal-free processes were verified from this repository.
- A framed Scroll2Roll LSP session verified project discovery, completion, hover, definition, references, rename, symbols, semantic tokens, and live diagnostics without protocol errors.
- The portable package passes forbidden-content scanning and a relocated `--headless-smoke` launch outside the source checkout.
- The final `Scroll2Roll-0.1.0-windows-x64.zip` is 1,507,358 bytes with SHA-256 `6408d68501e02005164ff2bb016026d71b90ae6e49dfe43e2f324c0dc96d4ac7`.
- Source and staged website validation pass current Cloudflare Pages Free file-count and per-asset limits.
- Detailed evidence and exact commands are in `docs/VALIDATION.md`.
- The 0.2.0 expansion baseline was rerun on 2026-08-08: Debug and Release each
  passed native build, `rocketc check`, all 10 existing tests, and both
  formatting checks before new game implementation began.
- The complete post-Plinko Rocket suite passes 16/16, including the original 10
  tests plus focused Roulette and Plinko rules/math, session, and scripted
  keyboard/mouse GUI flows.
- Debug and Release milestone-E2 validation each pass the native build,
  `rocketc check`, all 16 tests, and both formatting checks. Source website
  validation also passes with only implemented games claimed.
- The complete post-Coop-Climb Rocket suite passes 19/19, preserving all 16
  prior regressions and adding probability/rules, deterministic session, and
  minimum-size scripted keyboard/mouse GUI coverage.
- Debug and Release milestone-E3 validation each pass the native build,
  `rocketc check`, all 19 tests, and both formatting checks. Source website
  validation also passes with only implemented games claimed.
- The complete post-Midnight-Crossing Rocket suite passes 22/22, preserving all
  19 prior regressions and adding rule/geometry, deterministic fixed-tick
  simulation/replay, and minimum-size keyboard/mouse GUI coverage.
- Debug and Release milestone-E4 validation each pass the native build,
  `rocketc check`, all 22 tests, and both formatting checks. Source website
  validation also passes with only implemented games claimed.
- The complete post-Hold'em Rocket suite passes 26/26, preserving all 22 prior
  regressions and adding exhaustive five-card category counts, focused
  seven-card/tie evaluation, blinds/action/reopening rules, main/side/split/odd
  pots, deterministic one-to-five-rival AI, privacy, chip conservation,
  consecutive hands, and minimum-size keyboard/mouse GUI coverage.
- Debug and Release milestone-E5 validation each pass the native build,
  `rocketc check`, all 26 tests, and both formatting checks. Source website
  validation also passes with all six implemented games claimed.

## Deliberate limitations

- Version 0.1.0 is unsigned. Windows may show an unknown-publisher warning; trusted code signing is not claimed.
- The game is local-only and play-money-only. Credits are not transferable and have no cash value.
- Hold'em AI is intentionally described as deterministic recreational play,
  not professional, adaptive, online, or unbeatable poker.
- The packaged application uses procedural UI art and a short generated tone; it does not ship a screenshot-baseline suite or external art/audio catalog.
- The frozen Rocket debugger represented the scalar `status` local during acceptance; managed locals such as the argument array may display as unavailable in the native debugger.
- The frozen LSP's formatter is exposed through its `source.format.rocket` code-action contract and the reproducible `rocketc fmt` workflow; Visual Studio's generic `Edit.FormatDocument` command is not advertised for Rocket documents.
- No public release, Cloudflare site, remote download, external production user, or certificate signature is claimed.

## Visual design tokens

- Background: `#080B14`
- Panel: `#111827`
- Primary/gold: `#F5C542`
- Secondary/emerald: `#10B981`
- Danger/red: `#EF4444`
- Primary text: `#F3F4F6`
- Muted text: `#9CA3AF`
- Border: `#293241`

Spacing, typography, component states, borders, timing, and responsive layout values are centralized in `src/app/theme.rocket`.

## Milestones

- Completed: repository foundation and original-draft preservation.
- Completed: Rocket 2.0 repair, modular Blackjack engine, focused tests, and deterministic round flows.
- Completed: reviewed raylib integration, reusable shell, full visual Blackjack, settings, and local persistence.
- Completed: Visual Studio Community 2026 repository acceptance.
- Completed: Windows packaging, relocated smoke validation, static website, and Cloudflare Pages preparation.
- Completed: owner-approved 0.2.0 architecture, rules, payout math,
  deterministic strategy, UI contracts, migration design, milestone gates, and
  acceptance criteria in `EXPANSION_PLAN.md`.
- Completed: expansion milestone E0, including version 0.2.0 identity,
  save-v1-to-save-v2 migration, and the multi-game session boundary.
- Completed: expansion milestone E1, complete European Roulette engine, API,
  UI, persistence flow, deterministic tests, and Blackjack regression gate.
- Completed: expansion milestone E2, audited 8-16-row Plinko engine and tables,
  bounded multi-ball UI/animation, deterministic tests, and regression gate.
- Completed: expansion milestone E3, Chicken presented as the original Coop
  Climb, including fixed probability/payout tables, hidden deterministic paths,
  complete UI, focused tests, and regression gates.
- Completed: expansion milestone E4, Cross the Road presented as the original
  Midnight Crossing, including deterministic fixed-tick simulation, real-time
  hazards and log support, checkpoints, complete UI, focused tests, and Debug
  and Release regression gates.
- Completed: expansion milestone E5, single-player No-Limit Texas Hold'em,
  including cards/evaluator, complete no-limit betting, contribution-tier pots,
  deterministic AI, privacy API, full UI, focused tests, and Debug/Release
  regression gates.
- Current: expansion milestone E6, final 0.2.0 release acceptance.
- Next: checkpoint E5, then revalidate all six games, Visual Studio workflows,
  packaging and sanitized relocation, the source/staged static website, final
  documentation, ignored artifacts, and the clean local handoff without any
  push, publication, deployment, signing, or external tester claim.

## Major decisions

- Preserve the draft under `legacy/Blackjack-v1` so the repaired implementation never destroys historical evidence.
- Use integer credits and even bet units so Blackjack 3:2 payouts remain exact.
- Keep the casino economy local and deliberately small; persistence contains only versioned preferences, first-run state, AI count, and play-money progress.
- Keep rendering dependent on the tested Blackjack API instead of duplicating game rules.
- Keep the native adapter narrow and reusable; new UI operations were added only when demonstrated necessary.
- Keep the Cloudflare site static and separate from native application behavior. The current archive fits Pages Free's verified 25 MiB per-asset limit.
- Use version 0.2.0 and `scroll2roll-save-2` for the expansion, with explicit
  migration of valid `scroll2roll-save-1` data and safe recovery for corrupt or
  unsupported data.
- Maintain one local play-credit balance across games, transferring it only at
  engine-defined safe settlement/cash-out/hand boundaries.

## Files that must remain out of Git

Generated bindings, `.rocketc`, `out`, `build`, `.vs`, Visual Studio experimental state, downloaded dependencies, compiler/toolchain trees, native objects, executables, DLLs, libraries, PDBs, packages, caches, local configuration, and real user save data.

## New-chat handoff

Read `AGENTS.md`, `docs/MASTER_PLAN.md`, `docs/EXPANSION_PLAN.md`, and this file
completely. Inspect Git status and preserve user changes. The 0.1.0 Blackjack
baseline remains preserved and the post-Hold'em suite passes 26/26. Continue from **Milestones**
in the exact approved game order. Use frozen Rocket 2.0 and the pinned raylib
integration, rerun all prior tests at every game gate, update this handoff, make
logical local commits, and do not push, publish, deploy, sign, or add an
unapproved game.
