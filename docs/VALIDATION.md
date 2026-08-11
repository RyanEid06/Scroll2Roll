# Validation Evidence

This file records the complete local acceptance pass performed on Windows x64 on 2026-08-08. Generated artifacts remain ignored and are reproducible from the documented scripts.

## Native UI overhaul milestone 1 - visual audit and foundation

- On 2026-08-09, the accepted packaged 0.3.0 executable was inspected before
  source changes at 800x600, 1280x720, and 1600x900. Ready states for all eleven
  games were also inspected at 800x600. The audit confirmed clipped/unreachable
  controls at minimum size, non-responsive fixed layouts, excessive dead space
  at larger sizes, default bitmap typography, five unequal lobby strips, and
  the same flat panel grammar across distinct games. Evidence remains ignored
  under `out/visual-audit/`; exact names and findings are recorded in
  `UI_OVERHAUL_FOUNDATION.md`.
- Current Subframe examples and representative current Behance casino-template
  projects were inspected along with all owner-supplied references. The
  ThemeForest index was reviewed through its public result listing because its
  interactive page presented a challenge screen. No gallery or reference asset
  was downloaded, purchased, copied, or added to the product.
- `src/app/theme.rocket` now defines the mandated purpose-designed dark/light
  semantic palettes, spacing, radii, elevation, focus, 44-pixel target, type
  roles, 120/180/250 ms motion, and breakpoint tokens. Compatibility aliases
  keep accepted views building only while their reviewable replacement proceeds.
- `src/app/layout.rocket` defines compact, standard, wide, and cinema modes,
  safe margins, navigation widths, top bars, lobby grids, stage/action splits,
  compact docks, and positive clamped geometry. `ui_foundation_test.rocket`
  verifies 800x600, 1024x768, 1280x720, 1600x900, and 1920x1080.
- `UI_OVERHAUL_FOUNDATION.md` records the rejected baseline, per-screen/game
  asset inventory, ownership/license/fallback policy, native adapter gaps,
  responsive contract, and visual acceptance criteria before implementation.
- Debug and Release `scripts/validate.ps1` each passed the native build,
  `rocketc check`, all 42 tests, and both formatting checks. All 41 accepted
  behavior/regression tests remain green and the new foundation test passes.
- This milestone changes no casino rule, deterministic outcome, persistence
  format, native ABI, package, or website. The frozen Rocket repository was not
  modified. Nothing was pushed, deployed, published, released, purchased, or
  signed.

## Native UI overhaul milestone 2 - assets, typography, resources, and components

- The built-in ImageGen workflow created two 1536x1024 3x2 atlases specifically
  for Scroll2Roll with no external image input. Generation
  `exec-1bb025af-9d20-458c-907f-63941af5f9f2` contains Blackjack, Roulette,
  Plinko, Coop Climb, Midnight Crossing, and Hold'em. Generation
  `exec-0e2406d9-680b-49ed-8fb2-b0811f830ecc` contains the brand hero, Mines,
  Dice, HiLo, Crash, and Slots. Both were inspected at original resolution for
  crop, silhouette, lighting, artifacts, unintended text, watermark, copied UI,
  branding, and light/dark compatibility before acceptance. Exact prompts and
  SHA-256 values are in `assets/ui/IMAGEGEN_PROMPTS.md` and `assets/MANIFEST.md`.
- The exact unmodified Manrope variable font was retrieved from Google Fonts'
  `ofl/manrope` directory with its OFL 1.1 license and metadata. Its SHA-256 is
  `D0639BE45D0AF36E798172419D7BD173C4BD4F29E2B76CBB69DB1D11BF8B0A40`.
  The license and metadata hashes are recorded in the manifest and the required
  notice is in `THIRD_PARTY_NOTICES.md`. No asset was purchased.
- The native adapter now validates and tests custom-font measurement,
  destination/source-region textures, thick lines, triangles, rings, rounded
  rectangles/outlines, balanced scissoring, and mouse-wheel input. It remains
  primitive and policy-free. Production font loading rejects missing/corrupt
  files and silent default-font substitution.
- `ui_resources.rocket` independently loads the font and atlases, reports a
  procedural degraded mode, and releases all live handles before window close.
  The real Release executable log confirmed Manrope at a 512x256 glyph texture
  and both RGB atlases at 1536x1024. The ignored
  `out/visual-audit/milestone2-resource-startup.png` intentionally still shows
  the rejected lobby because shell replacement belongs to milestone 3; it is
  not claimed as visual acceptance.
- Persistence now writes `scroll2roll-save-4`, adding only `light_mode` and
  `reduced_motion`. Valid save-v1/v2/v3 data migrates with safe dark/full-motion
  defaults; credits and all prior settings are preserved. Invalid UI values
  recover to defaults. Settings keyboard paths toggle and save both preferences.
- The replacement shared component layer covers custom type roles, rounded
  elevated surfaces, complete button states, procedural icon buttons, pills,
  badges, toggles, section headers, toasts, modals, illustrated cards, focus
  rings, both themes, and a distinct per-game procedural art fallback.
- Debug and Release `scripts/validate.ps1` each passed the native build,
  `rocketc check`, all 44 tests, and both formatting checks. All 41 accepted game
  and infrastructure regressions remain green. The frozen Rocket repository
  remained clean. Nothing was pushed, deployed, published, released, signed,
  or purchased.

## Native UI overhaul milestone 3 - responsive shell and lobby

- On 2026-08-11, the actual native Release executable was inspected in both
  dark and light themes. Exact client captures cover startup at 1280x720;
  lobby at 800x600, 1024x768, 1280x720, 1600x900, 1920x1080, and maximized
  1920x991; and settings, global help, exit confirmation, and all three compact
  lobby pages at 800x600. Evidence remains ignored under
  `out/visual-audit/milestone3/`.
- The branded launch scene, persistent top shell, wide navigation rail,
  purpose-designed theme switch, visible balance, responsive hero, and all
  eleven equal illustrated game cards were reviewed for hierarchy, crop,
  typography, contrast, focus, clipping, and dead space. The compact lobby
  correctly pages as 4/4/3 cards and supports mouse, wheel, arrows, Tab, Enter,
  and explicit page controls. Light mode uses its own canvas, surfaces,
  shadows, borders, and text values rather than a color inversion.
- Settings and global help fit the minimum viewport. Settings exposes theme,
  reduced motion, audio, volume, Hold'em AI count, and reset guidance through
  clear toggles, steppers, and slider. Exit confirmation presents explicit
  Cancel and destructive Exit actions. Help returns to its exact source.
- Every non-lobby screen has a persistent Back control. Back, `B`, and Escape
  all consult the active engine's existing safe-return boundary. A live wager
  remains intact and receives a state-aware explanation; ready or settled
  games return immediately. Raylib's default Escape close key is disabled with
  `SetExitKey(KEY_NULL)` so the Rocket application, not the native window loop,
  owns this policy.
- The retrieved Manrope variable source remains unmodified. Because raylib
  selected its first ExtraLight instance, the shipped face is a deterministic
  `wght=500` static instance named `Manrope-Medium.ttf`, derived with FontTools
  4.59.0 under the same SIL OFL 1.1 license. Its SHA-256 is
  `98EE850D1D257F4BB2328C24DFFF392F85A351A61ED7F600DBA140BCBB5313F9`.
  The actual Release log confirms the Medium face and both 1536x1024 atlases
  loaded successfully.
- `ui_shell_test.rocket` verifies the five required dimensions, compact and
  wide page counts, positive non-overlapping geometry, minimum card/control
  sizes, both-theme resource-backed drawing, theme persistence, reduced
  motion, exact help return, safe Back, blocked live-wager integrity, and
  explicit modal hitboxes. All eleven GUI flow tests route through the new
  responsive lobby instead of legacy fixed strip coordinates.
- Sequential Debug and Release `scripts/validate.ps1` passes each completed the
  native build, `rocketc check`, all 45 tests, and both formatting checks. A
  discarded concurrent attempt produced one linker write collision because
  both configurations share `.rocketc` test executable paths; the isolated
  rerun passed that same exhaustive Hold'em evaluator and the full suite.
  Frozen Rocket remained clean. Nothing was pushed, deployed, published,
  released, signed, or purchased.

## 0.2.0 expansion baseline

Before expansion implementation, both Debug and Release
`scripts/validate.ps1` passes completed again on 2026-08-08. Each configuration
passed the native CMake/raylib build, `rocketc check`, all 10 existing Rocket
tests, and `rocketc fmt --check` for `src` and `tests`. This is the regression
baseline for every game milestone in `EXPANSION_PLAN.md`.

## 0.3.0 expansion baseline and milestone 1 - Mines

- Before 0.3.0 changes, Debug and Release `scripts/validate.ps1` each passed
  native generation/build, `rocketc check`, all 26 accepted tests, and both
  formatting checks on 2026-08-09.
- Version identity is 0.3.0. Persistence writes `scroll2roll-save-3`; focused
  tests migrate valid save-v1 and save-v2 values, verify save-v3 round-trip,
  and verify missing, corrupt, invalid, and unsupported recovery.
- `mines_rules_test.rocket` recomputes every multiplier for all 1-24 mine
  counts and every legal safe-reveal depth from exact combinations. It verifies
  the 9,600-basis-point return factor and both multiplier and payout floor
  rounding published in `MINES_MATH.md`.
- `mines_session_test.rocket` verifies unique seeded 25-tile layouts, exact mine
  counts, deterministic agreement, hidden-tile API privacy, safe/mine results,
  cash-out and duplicate-reveal legality, atomic failures, insufficient
  credits, bounded history, and 25 consecutive nonnegative-balance rounds.
- `mines_gui_flow_test.rocket` runs at 800x600 and covers the seventh lobby
  entry, help, keyboard and mouse configuration/reveals/cash-outs, engine-
  committed 0.18/0.24-second animations, persistence, next round, lobby return,
  drawing, and native cleanup.
- The complete suite passes 29/29, preserving every prior game and
  infrastructure regression. Debug and Release `scripts/validate.ps1` each
  pass native generation/build, `rocketc check`, all 29 tests, and both source
  and test formatting checks.
- Source website validation still passes all six files against the last real
  verified 0.2.0 package metadata. The website is intentionally not relabeled
  0.3.0 until all five expansion games and the real 0.3.0 package exist.
- No package, push, publication, deployment, release, or signing was performed.

## 0.3.0 milestone 2 - Dice

- `dice_rules_test.rocket` exhausts targets 1-9999 for Roll Under and Roll Over,
  verifies complementary exact outcome counts, both comparison boundaries,
  every multiplier, payout floors, and all wager/auto/stop bounds against
  `DICE_MATH.md`.
- `dice_session_test.rocket` verifies deterministic manual results, atomic
  configuration and credit failures, finite count completion, win/loss/user/
  insufficient-credit stops, incremental step bounds, 100 consecutive rounds,
  history limits, restart, and nonnegative balances.
- `dice_gui_flow_test.rocket` runs at 800x600 and verifies eighth-card routing,
  help, exact keyboard configuration, keyboard and mouse manual rounds,
  engine-locked animation, incremental auto progression, visible Stop,
  persistence, restart/next boundaries, lobby return, and resource cleanup.
- The complete suite passes 32/32 with every prior test preserved. Debug and
  Release `scripts/validate.ps1` each pass native generation/build, `rocketc
  check`, all 32 tests, and both formatting checks. Source website validation
  remains on the last real verified 0.2.0 archive as required during expansion.
- No package, push, publication, deployment, release, or signing was performed.

## 0.3.0 milestone 3 - HiLo

- `hilo_rules_test.rocket` validates standard-deck uniqueness and deterministic
  shuffle, recomputes lower/higher/equal counts for all 13 ranks at every
  remaining-deck prefix, verifies impossible actions and equal losses, and
  checks the cumulative 9,600-basis-point formula, floor payout, and documented
  caps against `HILO_MATH.md`.
- `hilo_session_test.rocket` verifies deterministic cards and draws, public
  future-card privacy, insufficient credits, correct/wrong/equal settlement,
  cash-out legality, exact multipliers, 100 consecutive bounded rounds, safe
  restart, 20-entry history, and correct automatic settlement after all 52
  cards are consumed.
- `hilo_gui_flow_test.rocket` runs at 800x600 and verifies ninth-entry routing,
  prominent tie-loss help/table text, keyboard and mouse flows, disabled active
  lobby return, public sequence agreement with committed draws, bounded result
  animation, cash-out, persistence, next/restart/lobby boundaries, drawing, and
  native resource cleanup.
- The complete suite passes 35/35 with every prior test preserved. Debug and
  Release `scripts/validate.ps1` each pass native generation/build, `rocketc
  check`, all 35 tests, and both formatting checks. Source website validation
  remains on the last real verified 0.2.0 archive as required during expansion.
- No package, push, publication, deployment, release, or signing was performed.

## 0.3.0 milestone 4 - Crash

- `crash_rules_test.rocket` enumerates all 1,000,000 tickets and verifies the
  exact 40,000 instant points, 1.50x/2.00x/10.00x survival counts, 1,000x cap
  mass, reciprocal monotonic block, exact 1.50x strict-boundary return example,
  fixed curve through 20,000 ticks, wager/auto bounds, and payout floors
  published in `CRASH_MATH.md`.
- `crash_session_test.rocket` verifies deterministic thresholds, running-table
  privacy, invalid and unaffordable atomic failures, strict before/at/after
  cash-out behavior, immediate crash, single-round auto success/failure,
  per-call tick caps, negative requests, 100 rounds, 20-entry history, restart,
  and nonnegative capped balances.
- `crash_gui_flow_test.rocket` runs at 800x600 and verifies tenth-entry routing,
  keyboard and mouse configuration, running privacy, a 30-frame help pause,
  disabled live lobby return, manual and automatic complete rounds, graph
  drawing from public engine state, persistence, restart, lobby, and cleanup.
- The complete suite passes 38/38 with every prior test preserved. Debug and
  Release `scripts/validate.ps1` each pass native generation/build, `rocketc
  check`, all 38 tests, and both formatting checks. Source website validation
  remains on the last real verified 0.2.0 archive as required during expansion.
- No package, push, publication, deployment, release, or signing was performed.

## 0.3.0 milestone 5 - Slots

- `slots_rules_test.rocket` verifies all fixed reel stops, per-reel symbol
  frequencies, five paylines, every three/four/five line award, highest-award
  Wild substitution, all-Wild and overlapping lines, Scatter/free-spin/Bonus
  rules, invalid stops, and exact return values published in `SLOTS_MATH.md`.
  It recomputes the 12,800,000 denominator, 55,281,870 base-payout numerator,
  711,720 awarded-free-spin numerator, and 9,598-basis-point display floor from
  production strips and rules.
- `slots_session_test.rocket` verifies deterministic agreement independent of
  Turbo, committed five-stop/Bonus outcomes, atomic invalid and unaffordable
  requests, locked configuration, complete non-retriggering 2x free spins,
  Bonus/zero-win seeds, explicit and finite autoplay stops, 100 paid rounds,
  20-entry history, restart, and nonnegative capped balances.
- `slots_gui_flow_test.rocket` runs at 800x600 and verifies eleventh-entry
  routing, help, line bet, Turbo, autoplay count, keyboard/mouse manual spins,
  locked committed reels, sequential reveal, visible Stop, stopped and complete
  autoplay, persistence only after complete paid rounds, restart, lobby, draw,
  and native cleanup.
- The complete suite passes 41/41 with every prior test preserved. Debug and
  Release `scripts/validate.ps1` each pass native generation/build, `rocketc
  check`, all 41 tests, and both formatting checks. Source website validation
  remains on the last real verified 0.2.0 archive pending the final local 0.3.0
  package and site acceptance gate.
- No package, push, publication, deployment, release, or signing was performed
  during the Slots milestone.

## Rocket and native application

- Debug `scripts/validate.ps1`: CMake/raylib build, Rocket check, 10/10 tests, and `src`/`tests` formatting checks passed.
- Release `scripts/validate.ps1`: the same matrix passed 10/10 tests.
- The test set covers the Blackjack rules, deterministic multi-round flows, balances and bounds, persistence recovery, scripted GUI flow, and native resource/audio/asset lifetimes described in `TESTING.md`.
- `Scroll2Roll.exe --headless-smoke` exits successfully from a relocated package without the source checkout.

## Expansion milestone E1 - European Roulette

- Focused Roulette engine tests verify every required bet geometry and failure
  path, exact payouts including zero behavior, simultaneous wagers,
  table/position limits, deterministic wheel results, undo/clear/repeat/rebet,
  bounded history, and 15-round balance invariants.
- The scripted GUI test verifies keyboard and mouse chip placement, help,
  selection, undo, engine-locked animation, settlement, save-v2 persistence,
  rebet, clear, and safe lobby return.
- The complete Rocket suite passes 13/13 with all 10 original Blackjack and
  infrastructure regressions preserved.
- Debug and Release `scripts/validate.ps1` each pass the native build,
  `rocketc check`, all 13 tests, and both formatting checks after the complete
  Roulette integration.
- Source website validation passes for the updated 0.2.0 Blackjack and European
  Roulette claims. No package publication or deployment was performed.

## Expansion milestone E2 - Plinko

- `plinko_math_test.rocket` verifies every row count from 8 through 16 for all
  three risk levels: exact binomial outcome counts, symmetric multiplier
  arrays, intended risk ordering, valid configuration, payout rounding, and
  theoretical return between 95.99% and 96.00%. Every audited table is
  published in `PLINKO_MATH.md`.
- `plinko_session_test.rocket` verifies explicit-seed 50/50 paths, bucket/path
  invariants, 1-10-ball batch bounds, prepaid wagers, configuration locking,
  insufficient-balance errors, exact settlement, bounded history, and 12
  consecutive rounds without a negative balance.
- `plinko_gui_flow_test.rocket` verifies responsive lobby routing, help,
  keyboard and mouse configuration, engine-committed multi-ball animation,
  bounded settlement, save-v2 persistence, next round, safe lobby return, and
  native resource cleanup.
- The complete Rocket suite passes 16/16 with all 10 original Blackjack and
  infrastructure regressions plus all Roulette tests preserved.
- Debug and Release `scripts/validate.ps1` each pass the native build,
  `rocketc check`, all 16 tests, and both formatting checks after complete
  Plinko integration.
- Source website validation passes for the updated Blackjack, European
  Roulette, and Plinko claims. No package publication or deployment was
  performed.

## Expansion milestone E3 - Chicken / Coop Climb

- `chicken_rules_test.rocket` verifies the fixed 10-rung tables for Low 4/5,
  Medium 2/3, and High 1/2 per-step survival; every chosen cash-out depth has
  an exact theoretical return of 95.99% or 96.00%. It also verifies risk
  ordering, wager bounds, depth bounds, and floor settlement against
  `COOP_CLIMB_MATH.md`.
- `chicken_session_test.rocket` verifies deterministic hidden paths, all legal
  and illegal transitions, configuration locking, first- and final-rung
  cash-outs, first-rung failure, insufficient balance behavior, 25 consecutive
  rounds, nonnegative balances, and 20-result history bounding.
- `chicken_gui_flow_test.rocket` runs at the 800x600 minimum and verifies lobby
  routing, help, keyboard and mouse risk/wager changes, start, advance,
  cash-out/failure, save-v2 persistence, next round, lobby return, rendering,
  and native resource cleanup.
- The complete Rocket suite passes 19/19 with all 16 prior Blackjack,
  infrastructure, Roulette, and Plinko regressions preserved.
- Debug and Release `scripts/validate.ps1` each pass the native build,
  `rocketc check`, all 19 tests, and both formatting checks after complete Coop
  Climb integration.
- Source website validation passes with Coop Climb added alongside the three
  prior complete games. No package publication or deployment was performed.

## Expansion milestone E4 - Cross the Road / Midnight Crossing

- `crossing_rules_test.rocket` verifies the 900-unit, eight-lane world; every
  required hazard kind and lane; fixed-tick bounds; checkpoint and difficulty
  limits; collision/support geometry; exact checkpoint multipliers; and floor
  settlement.
- `crossing_simulation_test.rocket` verifies deterministic seeded world
  generation and replay; wrapped car, tram, and log movement; traffic and tram
  collisions; water failure and moving-log support; checkpoint resets and
  difficulty progression; pause behavior; the eight-tick frame cap; cash-out;
  automatic five-checkpoint completion; and 15 consecutive rounds with a
  nonnegative balance.
- `crossing_gui_flow_test.rocket` runs at the 800x600 minimum and verifies safe
  keyboard- and mouse-timed crossings, pause/help, two checkpoint cash-outs,
  save-v2 persistence, rendering, lobby return, and native resource cleanup.
- The complete Rocket suite passes 22/22 with all 19 prior Blackjack,
  infrastructure, Roulette, Plinko, and Coop Climb regressions preserved.
- Debug and Release `scripts/validate.ps1` each pass the native build,
  `rocketc check`, all 22 tests, and both formatting checks after complete
  Midnight Crossing integration.
- Source website validation passes with Midnight Crossing added alongside the
  four prior complete games. No package publication or deployment was
  performed.

## Expansion milestone E5 - No-Limit Texas Hold'em

- `holdem_cards_evaluator_test.rocket` verifies a unique standard 52-card deck,
  deterministic Fisher-Yates shuffling, all nine categories, category-specific
  tiebreaks, wheel straights, seven-card best-hand selection, ties, and the
  canonical category counts across all 2,598,960 five-card combinations.
- `holdem_betting_test.rocket` verifies the 1-5-AI table bounds, heads-up and
  multiway blind/action order, checks, calls, folds, opening bets, full raises,
  minimum targets, short all-ins, non-reopening and later full reopening,
  street advancement, uncontested settlement, and chip conservation.
- `holdem_pots_ai_privacy_test.rocket` verifies contribution-tier main and side
  pots, folded contributions, split ties, clockwise odd chips, an explicit
  reset/rebuy, deterministic complete one- and five-rival hands, opponent-card
  privacy, folded-card privacy, consecutive hands, bounded AI, and table chip
  conservation.
- `holdem_gui_flow_test.rocket` runs at the 800x600 minimum and verifies sixth-
  tile routing, complete help, private/public card rendering, keyboard sizing,
  raise and all-in, mouse Deal and Check/Call, two complete hands, disabled
  actions, settlement persistence, explicit new table, lobby return, and native
  resource cleanup.
- The complete Rocket suite passes 26/26 with all 22 prior Blackjack,
  infrastructure, Roulette, Plinko, Coop Climb, and Midnight Crossing
  regressions preserved.
- Debug and Release `scripts/validate.ps1` each pass the native build,
  `rocketc check`, all 26 tests, and both formatting checks after complete
  Hold'em integration.
- Source website validation passes with all six implemented games claimed. No
  package publication or deployment was performed.

## Visual Studio Community 2026 cumulative acceptance

The installed Rocket Language 2.0.3 extension was first exercised interactively
from this repository with `src/main.rocket` active during the 0.1.0 acceptance:

- all seven Rocket commands were present; Build, Run, Test, Debug, environment validation, and options were available, while Stop became available only during an active process;
- GUI Build refreshed `.rocketc/Scroll2Roll.exe`, its PDB, and its Rocket source map;
- GUI Test refreshed all 10 test executables and returned to idle;
- GUI Run launched the native Scroll2Roll process, Stop terminated it, and no PowerShell, Windows Terminal, `cmd`, `conhost`, or external debug-console child was created;
- the Visual Studio-hosted `rocket-lsp.exe` remained attached to the repository;
- a framed LSP session analyzed 33 project files and verified qualified completion, hover, definition, two references, prepare-rename/rename edits, workspace symbols, 1,360 semantic-token integers, and a live diagnostic without protocol errors;
- an unsaved invalid edit navigated through Error List to `src/main.rocket` line 18; Undo restored clean state and the on-disk SHA-256 was unchanged;
- Go To Definition navigated a Blackjack call at `blackjack_cards.rocket` line 32 to `blackjack_value` at line 19;
- Debug stopped at a Rocket source breakpoint, F11 entered `src.app.application.run`, the call stack exposed six frames, the Locals collection represented `status = 0`, and Stop returned to design mode with no game process left;
- formatting is enforced by `rocketc fmt` in both validation configurations; the frozen LSP exposes its whole-document formatter through the `source.format.rocket` code-action contract rather than Visual Studio's generic `Edit.FormatDocument` command.

The final 0.2.0 pass then exercised the unchanged extension against the expanded
repository with the pinned compiler and language-server environment variables:

```powershell
$env:ROCKET_COMPILER = "<frozen-rocket>\out\build\windows-release\rocketc.exe"
$env:ROCKET_LANGUAGE_SERVER = "<frozen-rocket>\out\build\windows-release\rocket-lsp.exe"
devenv.exe "<checkout>\src\main.rocket" /Command Build.BuildRocketProject
devenv.exe "<checkout>\src\main.rocket" /Command Rocket.TestRocketProject
devenv.exe "<checkout>\src\main.rocket" /Command Rocket.RunRocketProject
node .\scripts\test-lsp.mjs
```

- Build recreated a deliberately removed `Scroll2Roll.exe`, PDB, and source map;
  the final map includes the new Hold'em view and API sources.
- Test recreated a deliberately removed Hold'em test executable and completed
  the same 26-test project suite proven by both release gates.
- Run launched `.rocketc/Scroll2Roll.exe` through the Visual Studio-owned
  `rocketc run` process, with the pinned `rocket-lsp.exe` attached to the same
  IDE instance. No PowerShell, Windows Terminal, `cmd`, or external debug
  console was launched; Windows did create hidden `conhost` processes for the
  redirected compiler and language-server streams.
- The portable framed LSP check against the new Hold'em view returned 21 matching
  workspace symbols, hover data, one definition into `components.rocket`, 529
  completion items, 6,350 semantic-token integers, and three live diagnostics
  across two notifications, with empty protocol stderr.
- Fresh PDB/source-map generation and the Rocket Debug command surface were
  rechecked. The complete source-breakpoint, F11, call-stack, Locals, Stop, Error
  List, and Go To Definition interaction remains the preceding full acceptance
  baseline.

### Visual Studio tool-discovery and debug-source repair

Two owner-reported dialogs were reproduced and repaired on 2026-08-09:

- `rocketc.exe was not found` was fixed by persisting the verified pinned
  compiler and language-server executables in the Windows user
  `ROCKET_COMPILER` and `ROCKET_LANGUAGE_SERVER` values. No machine path was
  added to Git.
- The frozen CodeView basename collision was fixed application-side by renaming
  all 22 colliding `api`, `cards`, `engine`, `model`, and `rules` modules to
  game-prefixed filenames and updating every import and qualifier. The source
  tree now has 48 unique Rocket basenames.
- `rocketc build . --debug` produced an unoptimized PDB/map covering 40 unique
  source files with zero duplicate basenames.
- A fresh Visual Studio instance loaded `RocketPackage` and the pinned LSP,
  accepted the map, attached the native debugger, and launched
  `Scroll2Roll.exe`; neither reported dialog appeared in the activity log.
  `Rocket.StopRocket`, invoked in that same IDE Command Window, ended the game
  and returned the IDE title from Running to design mode.
- Post-repair Debug and Release `scripts/validate.ps1` each passed the native
  build, `rocketc check`, all 26 tests, and both formatting checks. The portable
  LSP check also remained clean.

### Native frame-loop repair

The owner-visible white `Scroll2Roll (Not Responding)` window was reproduced on
2026-08-09. Startup markers proved window creation, WASAPI initialization, every
Rocket update, and every Rocket draw completed. A five-second direct C++/raylib
probe reproduced the same failure without any Rocket or casino state, isolating
the native frame contract.

Both generated CMake caches had `SUPPORT_CUSTOM_FRAME_CONTROL=ON`. In that mode
raylib's `EndDrawing()` deliberately omits buffer swapping, target-FPS timing,
and event polling, while Scroll2Roll's adapter relies on the standard
`EndDrawing()` contract. `CMakeLists.txt` now forces the option off. After a
native rebuild, six consecutive live-process samples reported
`Responding=True`; working memory stayed near 89-94 MiB instead of rising toward
900 MiB, and the rendered window closed normally. Fresh Debug and Release
validation each passed the native build, `rocketc check`, all 26 tests, and both
formatting checks.

## Version 0.2.0 Windows package

The final packaging commands were:

```powershell
.\scripts\package-windows.ps1 -RocketRoot "<frozen-rocket>"
.\scripts\test-package.ps1
```

`out/package/Scroll2Roll-0.2.0-windows-x64.zip` is 1,733,465 bytes
with SHA-256
`901AD7600017EB227A7DDB755B56D65490CB978797228A6C3EBA60E2089CDA4B`.
It contains `Scroll2Roll.exe`, README, controls, troubleshooting, version,
notices, and `SHA256SUMS.txt`. Every internal checksum was recomputed and
matched. The archive excludes sources, dependencies, compiler/build trees,
`.vs`, `.rocketc`, caches, objects, PDBs, maps, and machine paths.

`scripts/test-package.ps1` extracted the archive into ignored `out/relocation`,
passed its forbidden-content scan, and passed the relocated `--headless-smoke`
launch without relying on the source checkout.

No trusted code signature is claimed.

## Static website

- `.\scripts\test-website.ps1` passes the six source `website/` files.
- `.\scripts\prepare-cloudflare-site.ps1 -Output
  .\out\cloudflare-site-validation` and `.\scripts\test-website.ps1 -Site
  .\out\cloudflare-site-validation` pass the seven staged files with the
  1,733,465-byte release archive included. The alternate ignored output was
  used because another local process held the prior default staged archive;
  the workflow now supports this explicit safe override.
- The validator enforces the current Cloudflare Pages Free ceilings of 20,000
  files and 25 MiB per asset, rechecked against official Cloudflare
  documentation on 2026-08-09, and rejects browser-playable or real-money
  wording.
- The redesigned site has three destinations: local profile/onboarding, the
  complete six-game native catalog, and verified Windows download. The source
  validator additionally checks nickname/avatar safety controls, no password
  field or network API, same-origin CSP, accessible focus/reduced-motion hooks,
  exactly six original-art cards, and the archive's exact size and SHA-256.
- In-app browser checks completed the empty-name flow, invalid MIME rejection,
  corrupt PNG signature rejection, local profile creation and navigation,
  desktop card geometry (six 581-by-280-pixel rectangular cards at the tested
  viewport), Download navigation and metadata, zero console errors, and 390px
  profile/Play/Download layouts without horizontal overflow.
- No Cloudflare deployment, Git push, GitHub release, or other publication was performed.

## Expansion milestone E6 - final 0.2.0 acceptance

The exact release gates were:

```powershell
.\scripts\validate.ps1 -Configuration Debug -RocketRoot "<frozen-rocket>"
.\scripts\validate.ps1 -Configuration Release -RocketRoot "<frozen-rocket>"
.\scripts\package-windows.ps1 -RocketRoot "<frozen-rocket>"
.\scripts\test-package.ps1
.\scripts\test-website.ps1
.\scripts\prepare-cloudflare-site.ps1
.\scripts\test-website.ps1 -Site .\out\cloudflare-site
```

Both validation configurations passed native generation/build, `rocketc check`,
all 26 tests, source formatting, and test formatting. Those tests include
deterministic complete rounds/sessions and keyboard/mouse GUI paths for all six
games, save-v1 migration and corrupt/unsupported recovery, missing assets,
native resource lifetimes, and clean shutdown. Package relocation and both site
trees passed as described above. The frozen Rocket checkout remained clean.

## Final 0.3.0 local acceptance

The final commands run on 2026-08-09 were:

```powershell
.\scripts\validate.ps1 -Configuration Debug -RocketRoot "<frozen-rocket>"
.\scripts\validate.ps1 -Configuration Release -RocketRoot "<frozen-rocket>"
.\scripts\package-windows.ps1 -RocketRoot "<frozen-rocket>"
.\scripts\test-package.ps1
.\scripts\test-website.ps1
.\scripts\prepare-cloudflare-site.ps1
.\scripts\test-website.ps1 -Site .\out\cloudflare-site
```

- Debug and Release each passed native generation/build, `rocketc check`, all
  41 Rocket tests, source formatting, and test formatting. This includes
  deterministic complete sessions and scripted keyboard/mouse flows for all
  eleven games; save-v1/save-v2 migration, save-v3 round-trip, and invalid data
  recovery; and native adapter, lifetime, audio stress, missing asset, and clean
  shutdown coverage.
- `out/package/Scroll2Roll-0.3.0-windows-x64.zip` is exactly 1,919,372 bytes
  (1.83 MiB) with SHA-256
  `FD2B4EC31734DCB6E51707C862A439966E5771CBDA136DCD4F6B09726082688B`.
  It contains the executable, version, README, notices, controls,
  troubleshooting, and `SHA256SUMS.txt`. The forbidden-content scan and
  sanitized `out/relocation` headless smoke both passed.
- The six-file source site and fresh seven-file `out/cloudflare-site` tree pass
  the validator with exactly eleven original-art cards, the exact archive
  identity, local-profile controls, no network APIs, security headers,
  accessibility/reduced-motion hooks, prohibited-claim checks, and Cloudflare's
  20,000-file and 25-MiB-per-asset ceilings.
- In-app browser validation created and reset a local-only profile, confirmed
  all eleven titles and native launcher language, measured two 581-by-280-pixel
  cards per row at 1280 pixels, and verified 390-pixel one-column Play and
  Download layouts without horizontal overflow. The Download page showed the
  exact archive name/hash and produced no console warnings or errors.
- Generated build, package, relocation, and staged-site artifacts remained
  ignored. The separate frozen Rocket checkout remained clean on `master` at
  `cbf7b1a`. No Git push, Cloudflare deployment, publication, public release,
  or signing was performed or claimed.
