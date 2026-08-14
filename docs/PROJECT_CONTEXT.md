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
- Last fully accepted local package version: 0.3.0; no public release is claimed
- Current implementation version: 0.3.0

## Product vision and completed scope

Scroll2Roll is an illustration-led, local, single-player, play-money casino
shell. The
accepted 0.2.0 baseline includes complete Blackjack, European Roulette, Plinko,
Coop Climb, Midnight Crossing, and No-Limit Texas Hold'em. The owner-approved
0.3.0 expansion in `EXPANSION_0_3_IMPLEMENTATION.md` adds Mines, Dice, HiLo,
Crash, and Slots in that order. All five games and the save-v3 foundation are
complete. The real 0.3.0 package, relocation smoke, eleven-game source site,
fresh staged site, exact archive metadata, and responsive browser flows have
passed local acceptance.

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
- No additional games beyond the five explicitly approved for 0.3.0.
- No push, publication, deployment, or unsupported signing claim without owner approval.

## Rocket and raylib constraints

Rocket 2.0 remains frozen and the original Rocket repository remains untouched by casino implementation. Scroll2Roll adapts to four-space indentation, single-line call/signature/expression syntax, explicit `Result` failures, deterministic package layout, the Windows x64 C ABI, and the reviewed primitive-only raylib adapter. Casino behavior stays in Rocket. Native C++ is restricted to primitive raylib adaptation and validated resource tokens. The configurable Rocket checkout supplies pinned MSVC, Ninja, LLVM/Clang 22.1.6, and raylib 6.0; Scroll2Roll does not download a second raylib copy.

## Implemented functionality

- The authoritative master plan is preserved byte-for-byte as `docs/MASTER_PLAN.md`.
- The untouched original failing draft is preserved under `legacy/Blackjack-v1`.
- A modular rendering-independent Blackjack engine implements checked cards, exact hand values, a deterministic six-deck shoe, cut-card reshuffling, table limits, player/AI betting, legal actions, Hit, Stand, Double Down, Split, Double After Split, a four-hand maximum, split-Ace one-card behavior, no standard resplit, Late Surrender, dealer stand on soft 17, naturals, exact 3:2 settlement, and deterministic AI/basic-strategy progression.
- Complete and consecutive rounds have bounded transitions and nonnegative play-money balances.
- A small `src/blackjack/blackjack_api.rocket` facade is the only rules boundary used by the visual table.
- The raylib application implements startup, reusable lobby routing, settings,
  exit confirmation, keyboard/mouse controls, eleven playable Blackjack, Roulette,
  Plinko, Coop Climb, Midnight Crossing, No-Limit Hold'em, Mines, Dice, HiLo,
  Crash, and Slots tables, zero-to-five AI settings, disabled illegal actions,
  outcomes, next round/hand, restart/reset, and lobby return.
- Versioned local persistence stores display/audio preferences, AI count, first-run state, and approved play-money progress at `%LOCALAPPDATA%\Scroll2Roll\settings.s2r`, with safe missing/invalid/older-data recovery.
- The static website and Cloudflare Pages staging flow are implemented without claiming browser play.
- The static website is a responsive three-page experience: new visitors create
  a non-authenticated local browser profile with a validated nickname and
  optional PNG/JPEG/WebP avatar; the Play page presents all eleven complete native
  games with verified native captures; and the Download page presents the exact
  verified 0.3.0 package, integrity data, installation, requirements,
  unsigned-build disclosure, and troubleshooting. Profile data stays in
  `localStorage`, is never transmitted, and can be edited or reset.
- Release packaging includes the native executable, reviewed fonts and cover
  atlases, asset/provenance manifests, complete licenses, version, notices,
  controls, troubleshooting, and recursive checksums, and passes exact-content
  and relocated headless-smoke validation.
- Version 2 persistence writes `scroll2roll-save-2`, migrates valid
  `scroll2roll-save-1` settings and credits, and safely recovers from missing,
  invalid, or unsupported data.
- Version 3 persistence writes `scroll2roll-save-3`, migrates valid save-v1 and
  save-v2 settings and credits without adding game-rule state, and preserves
  explicit missing, corrupt, and unsupported recovery.
- Version 4 persistence adds only the persisted dark/light theme and
  reduced-motion preference, migrates valid save-v1/v2/v3 data with credit
  integrity, and never persists live wagers, private outcomes, or resource
  handles.
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
- Mines is fully playable on a 5-by-5 board with 1-24 mines. Its engine prepays
  the wager, commits a unique seeded layout with Fisher-Yates, exposes no
  unrevealed mine information through the API, enforces atomic one-tile
  reveals and cash-out after a safe gem, and bounds history and animation. All
  multipliers use exact combinations, a 96% play-money return factor, basis
  points, and floor settlement published in `MINES_MATH.md`.
- Dice is fully playable with exact 0-9999 Roll Under/Roll Over boundaries,
  exhaustive target math, 96% basis-point multipliers, fast manual rounds, and
  explicitly enabled 1-20-result auto-roll. Auto commits one result per step,
  exposes Stop between steps, and terminates on requested, win, loss, or credit
  limits. `DICE_MATH.md` publishes the integer and rounding contract.
- HiLo is fully playable from a checked shared 52-card deck with deterministic
  Fisher-Yates shuffle, future-card privacy, exact remaining lower/higher/equal
  counts, disabled impossible predictions, prominent equal-rank loss, prepaid
  wagers, cumulative 96% basis-point math, cash-out, exhaustion settlement,
  sequence/history bounds, and safe lifecycle transitions. `HILO_MATH.md`
  publishes the exact probability, rounding, and cap contract.
- Crash is fully playable as a local single-player precommitted curve. Its
  rendering-independent engine prepays a validated wager, maps a deterministic
  million-ticket sample to a hidden reciprocal threshold with an exact 4%
  1.00x mass, advances an exact 20 Hz bounded multiplier, enforces strict
  manual and one-round auto cash-out ordering, reveals only after settlement,
  and caps history, balance, ticks, and per-frame work. `CRASH_MATH.md` publishes
  the exact distribution, return example, curve, ordering, rounding, and caps.
- Slots is fully playable on five fixed 20-stop reels and a 5-by-3 grid with
  five paylines, highest-award Wild substitution, anywhere Scatters,
  non-retriggering 2x free spins, precommitted Bonus tickets, 1-20 line bets,
  presentation-only Turbo, and explicitly bounded 1-10-round autoplay. The
  exact 95.9836866495% theoretical return is recomputed from production strips
  and rules in tests and published in `SLOTS_MATH.md`.

## Architecture

Dependency direction is one way:

1. Per-game model values and validated rule constructors.
2. Rendering-independent Blackjack, Roulette, Plinko, Coop Climb, Midnight Crossing, Hold'em, Mines, Dice, HiLo, Crash, and Slots engines and settlement.
3. Small presentation-facing APIs and sessions.
4. Versioned local persistence isolated from rules.
5. Reusable router, design tokens, components, lobby, settings, and per-game views.
6. The safe Rocket raylib wrapper over a primitive C++ adapter.

Rendering never owns game rules or random outcomes. The C++ adapter never owns application or casino state. Deterministic headless tests do not require a real window or audio device.

## Verified evidence

- The Rocket repository was clean on `master` at `cbf7b1a` before Scroll2Roll changes, and no casino file was placed there.
- The source master plan and `docs/MASTER_PLAN.md` both have SHA-256 `48D1E92041299ED413FA6947E4342783B29B142041D1A445C049EA259D50C4C9`.
- The preserved original `legacy/Blackjack-v1/src/blackjack.rocket` has SHA-256 `11D7291C9F222C77BCCC5A7AF8C457F0083FC6BE42DB3CA6458B80B5C3FAB5CC` and still reproduces its original Rocket parser failure.
- The original 0.1.0 Debug and Release baseline passed build/check, 10/10
  Rocket tests, and formatting checks.
- Visual Studio GUI Build/Run/Test/Stop/Debug, Error List navigation, Go To Definition, source breakpoints, stepping, six-frame call stack, one represented scalar local, clean stop, and terminal-free processes were verified from this repository.
- A framed Scroll2Roll LSP session verified project discovery, completion, hover, definition, references, rename, symbols, semantic tokens, and live diagnostics without protocol errors.
- The portable package passes forbidden-content scanning and a relocated `--headless-smoke` launch outside the source checkout.
- The preserved 0.1.0 package baseline was 1,507,358 bytes with SHA-256
  `6408d68501e02005164ff2bb016026d71b90ae6e49dfe43e2f324c0dc96d4ac7`;
  current 0.2.0 package evidence is recorded below.
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
- Final milestone-E6 Debug and Release validation each pass native generation
  and build, `rocketc check`, all 26 tests, and both formatting checks. Visual
  Studio 18.8.2 with Rocket Language 2.0.3 recreated a cleanly removed app
  executable/PDB/source map, recreated a removed Hold'em test executable through
  its Test command, launched the native app through Run, and hosted the pinned
  LSP. The current framed Hold'em-view session verified symbols, completion,
  hover, definition, semantic tokens, and live diagnostics without protocol
  stderr; the earlier full interactive Stop/Error List/navigation/source-debug
  baseline remains the durable interaction proof.
- `Scroll2Roll-0.2.0-windows-x64.zip` is 1,733,465 bytes with SHA-256
  `901AD7600017EB227A7DDB755B56D65490CB978797228A6C3EBA60E2089CDA4B`.
  Its internal checksums, forbidden-content scan, and relocated headless smoke
  all pass.
- The six-file source site and seven-file staged site pass the expanded website
  validator with the exact release archive. Focused browser checks pass local
  profile validation/navigation, invalid and corrupt avatar handling, six
  rectangular desktop cards, Download metadata, zero console errors, and 390px
  responsive layouts without horizontal overflow. The staged tree remains below Cloudflare Pages Free's
  officially rechecked 20,000-file and 25-MiB-per-asset limits. Nothing was
  pushed, published, deployed, released, or signed.
- Visual Studio tool discovery is repaired persistently through the Windows user
  `ROCKET_COMPILER` and `ROCKET_LANGUAGE_SERVER` values; those local paths remain
  outside Git. Twenty-two colliding per-game modules were renamed with
  game-prefixed basenames, leaving 48 unique `src` basenames. An unoptimized
  build produced a 40-source map with zero basename collisions. Visual Studio
  Debug then loaded the pinned LSP, attached to and launched Scroll2Roll without
  either reported dialog, and Stop Rocket returned the IDE to design mode with
  no game process left. Debug and Release still pass all 26 tests and formatting
  checks. `scripts/validate.ps1` now prevents basename regressions.
- The 0.3.0 pre-change baseline was rerun on 2026-08-09: Debug and Release each
  passed native generation/build, `rocketc check`, all 26 accepted tests, and
  both formatting checks.
- The complete post-Mines suite passes 29/29, preserving all 26 prior tests and
  adding exact Mines rules/math, deterministic session/privacy/boundary, and
  minimum-size keyboard/mouse GUI coverage. Save-v1 and save-v2 migration to
  save-v3 and save-v3 round-trip/recovery pass in the persistence suite.
- The complete post-Dice suite passes 32/32, preserving all 29 prior tests and
  adding exhaustive Dice rules, deterministic manual/auto session boundaries,
  every finite stop condition, and minimum-size keyboard/mouse GUI coverage.
- The complete post-HiLo suite passes 35/35, preserving all 32 prior tests and
  adding checked-deck/exhaustion coverage, exact counts for every rank and
  remaining prefix, privacy, deterministic/tie/cash-out sessions, and bounded
  minimum-size keyboard/mouse GUI animation coverage.
- The complete post-Crash suite passes 38/38, preserving all 35 prior tests and
  adding exhaustive million-ticket distribution/return coverage, deterministic
  fixed-tick/boundary/auto/session tests, public-threshold privacy, long-frame
  caps, help pause, and complete minimum-size keyboard/mouse flows.
- The complete post-Slots suite passes 41/41, preserving all 38 prior tests and
  adding fixed-strip/payline/feature math with exact source-recomputed return,
  deterministic paid/free/Bonus sessions and finite autoplay, and complete
  minimum-size keyboard/mouse flows with committed sequential presentation.
- The superseded pre-overhaul `Scroll2Roll-0.3.0-windows-x64.zip` was
  1,919,372 bytes with SHA-256
  `FD2B4EC31734DCB6E51707C862A439966E5771CBDA136DCD4F6B09726082688B`.
  Internal checksums, forbidden-content scanning, and relocated headless smoke
  pass. The six-file source site and seven-file staged site pass with that exact
  archive; responsive browser checks confirm 11 cards, local profile/reset,
  desktop two-column and 390px one-column layouts, exact download metadata, and
  zero console errors.
- The separate frozen Rocket repository remains clean on `master` at `cbf7b1a`
  after final 0.3.0 acceptance.

## Deliberate limitations

- Version 0.3.0 is unsigned. Windows may show an unknown-publisher warning;
  trusted code signing is not claimed.
- The game is local-only and play-money-only. Credits are not transferable and have no cash value.
- Hold'em AI is intentionally described as deterministic recreational play,
  not professional, adaptive, online, or unbeatable poker.
- The packaged application combines reviewed original ImageGen covers with
  procedural native tables, boards, cabinets, and a short generated tone. It
  does not ship third-party casino-provider art or an automated screenshot-
  baseline comparison suite.
- The current 1920x1080 display permits a 1920x1055 forced client and a 1920x991
  true-maximized client after Windows chrome/taskbar; deterministic renderer
  tests exercise exact 1920x1080 geometry.
- The frozen Rocket debugger represented the scalar `status` local during acceptance; managed locals such as the argument array may display as unavailable in the native debugger.
- The frozen LSP's formatter is exposed through its `source.format.rocket` code-action contract and the reproducible `rocketc fmt` workflow; Visual Studio's generic `Edit.FormatDocument` command is not advertised for Rocket documents.
- No public release, Cloudflare site, remote download, external production user, or certificate signature is claimed.
- The website profile exists only in the current browser's storage. Clearing
  site data or choosing Reset removes it; it is not an authenticated or portable
  account and does not affect the native application's separate local settings.

## Native UI overhaul status

The owner has reviewed the accepted native captures and set a higher visual
quality bar: modern, smooth, fun game interiors with convincing physical
objects and surrounding places, including recognizable vehicles, roads,
tables, rockets, slot machines, characters, boards, and environmental props.
Engineering acceptance of the current 48/48 baseline remains valid, but it is
not owner visual approval. `docs/GAME_VISUAL_REFINEMENT_PLAN.md` is the durable
four-chat execution plan. It assigns sequential groups for living worlds and
motion; physical casino tables; arcade cabinets and tactile boards; and Dice,
HiLo, final cohesion, website captures, packaging, and acceptance. It also
defines how owner-generated art may be briefed, reviewed, licensed, manifested,
integrated, and tested without weakening engine/privacy boundaries.
`docs/OWNER_ASSET_GENERATION_PROMPTS.md` supplies the exact PNG formats,
filenames, per-game prompts, and provenance record for those owner assets.
`docs/ASSET_ANIMATION_IMPLEMENTATION_PLAN.md` is the durable next-step
handoff: promote only selected reviewed assets, integrate each game's visual
composition and committed/reduced-motion animation together, complete the four
groups sequentially, and defer website/package refresh until final native
acceptance.

The owner rejected the accepted 0.3.0 native presentation and mandated a full
dark/light, illustration-led replacement of the shell and all eleven game
interiors in `UI_OVERHAUL.md`. Milestone 1 is complete: the actual package was
audited at multiple sizes and every game at 800x600; current reference patterns
were researched without importing gallery content; a complete screen/game asset
inventory and adapter-gap audit were recorded; semantic dual-theme tokens and
responsive layout helpers were added; and a five-viewport test brought the
suite to 42/42. Debug and Release validation both pass.

Milestone 2 is also complete. Two original ImageGen atlases provide the hero and
eleven unique covers; the exact prompts, generation IDs, visual review, and
hashes are committed. The unmodified Manrope variable source and its SIL OFL
1.1 license/metadata are bundled with exact upstream URLs and hashes. The narrow
native adapter now provides only the demonstrated primitives needed for the new
presentation. `ui_resources.rocket` owns font/atlas success, degraded mode, and
cleanup. Save-v4 adds only `light_mode` and `reduced_motion`, safely migrates
valid save-v1/v2/v3, and preserves credits. The replacement component layer and
focused tests bring the suite to 44/44 in both Debug and Release.

Milestone 3 is complete. The actual native shell now has a branded launch
scene, persistent application header, wide navigation rail, visible balance,
global theme/help/settings controls, a responsive equal-card eleven-game
lobby, compact 4/4/3 paging, purpose-designed dark/light rendering, readable
minimum-size settings/help, and explicit confirmation buttons. Every non-lobby
screen uses the same Back policy and consults its engine-defined safe boundary;
live wagers are preserved with an explanation. The native adapter disables
raylib's implicit Escape-close key so Rocket owns that policy. A deterministic
SIL-OFL static Manrope Medium instance fixes raylib's variable-font ExtraLight
selection while preserving the exact variable source. Actual native captures
at every required viewport and maximized passed review. Focused shell tests and
all accepted regressions bring the suite to 45/45 in Debug and Release.

Milestone 4 is complete. A shared responsive interior contract now supplies a
dominant stage plus compact dock or wide action rail, original atlas ambience,
premium felt, procedural playing cards and suits, branded card backs, chips,
metrics, exact-rule overlays, and reduced-motion-aware committed animation.
Blackjack now presents a curved emerald table with dealer/player hierarchy,
legal actions, settlement, AI seats, and round-safe controls. Roulette presents
a proportional wheel and complete single-zero 0-36 betting cloth, mouse edge/
intersection/rail precision, selected chips, locked-ball motion, and history.
Hold'em presents an oval table, privacy-safe hidden rivals, exposed eligible
showdown cards, blind/dealer/fold/all-in markers, community cards, pot display,
raise-to sizing, and recent actions. HiLo presents a private deck, oversized
current card, exact lower/equal/higher counts, a prominent equal-rank-loss
warning, sequence, multiplier, and cash-out state. Actual dark/light native
captures cover every required size, with a 1920x1055 maximum client on the
current 1920x1080 display; deterministic view tests exercise exact 1920x1080.
All 46 tests pass in Debug and Release.

Milestone 5 is complete. Plinko now presents a deep audited peg chamber with
exact multiplier bins and reduced-motion-aware interpolation along committed
engine paths. Coop Climb presents an original observatory ladder with ten
fixed-value coops, a telescope goal, and privacy-safe hidden/next/secured/failed
states. Midnight Crossing presents a top-down city board with roads, tram,
canals, checkpoint, courier, vehicles, and logs driven only by public fixed-
tick state. All three use responsive compact/wide controls, exact-rule guides,
and dark/light original ambience. Actual native captures cover the full target
matrix plus compact/standard active states; review found and fixed one compact
Coop status overlap. All 47 tests pass in Debug and Release.

Milestone 6 is complete. Mines, Dice, Crash, and Slots now use the shared
responsive interior contract with privacy-safe cavern tiles, dimensional signal
dice, public-only rocket flight data, and cell-clipped committed reels. Their
full dark/light responsive matrix, active states, requested-1080p/maximized
captures, and 48/48 Debug/Release gates pass.

Milestone 7 is complete. The aligned website uses 13 verified native captures;
the 19-file source and 20-file staged trees pass exact validation and responsive
browser QA. The asset-bearing 17-file package is 6,963,264 bytes with SHA-256
`83B4E94C24C196782CB04F209193303A6BD602A8A3E7B2B3A8E99548EC02D597`;
recursive hashes, licenses, exact reviewed assets, forbidden-content scan, and
relocated launch pass. `docs/UI_OVERHAUL_FOUNDATION.md` is the completed audit
and acceptance ledger. Owner visual approval and any publication remain
separate decisions.

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
- Completed: expansion milestone E6, including final Debug/Release gates,
  cumulative Visual Studio acceptance, LSP checks, portable package and internal
  hashes, sanitized relocation, source/staged site validation, exact archive
  evidence, and the clean local handoff.
- Completed: post-acceptance native frame-loop repair. Scroll2Roll now forces
  raylib custom frame control off so the standard `EndDrawing()` lifecycle
  swaps buffers, limits FPS, and pumps Windows events. The previously white,
  nonresponsive window now renders responsively with stable memory, and both
  Debug and Release gates pass 26/26.
- Completed: static website profile/catalog redesign with three accessible
  destinations, original six-game card art, exact verified package evidence,
  local-only nickname/avatar persistence, expanded source/staged validation,
  and focused desktop/phone browser checks. Native application files were not
  changed.
- Completed: 0.3.0 milestone 1 Mines and save-v3 foundation, including exact
  combinatorial payout math, seeded hidden layout, complete native flow,
  focused tests, and all earlier regressions.
- Completed: 0.3.0 milestone 2 Dice, including exact integer probability,
  finite stoppable auto-roll, native UI, focused tests, and all regressions.
- Completed: 0.3.0 milestone 3 HiLo, including checked shared cards, exact
  remaining-deck probability, privacy-safe UI, focused tests, and all regressions.
- Completed: 0.3.0 milestone 4 Crash, including exact reciprocal distribution,
  private deterministic precommitment, bounded fixed ticks, strict cash-out,
  single-round auto target, full UI, focused tests, and all regressions.
- Completed: 0.3.0 milestone 5 Slots, including fixed source-owned reel strips,
  exact line/feature/return math, precommitted outcomes, free spins, finite
  stoppable autoplay, complete UI, focused tests, and all regressions.
- Completed: final local 0.3.0 package and website acceptance, including exact
  archive identity, internal hashes, forbidden-content scan, relocated smoke,
  source/staged validators, responsive browser checks, and clean local handoff.
  Nothing was pushed, published, deployed, released, or signed.
- Completed: native UI overhaul milestone 1, including honest rejected-baseline
  evidence, reference synthesis, the complete per-screen/game asset inventory,
  primitive-adapter/test-hook audit, purpose-designed dark/light semantic
  tokens, clamped responsive geometry for all five required viewports, one new
  focused test, and passing 42/42 Debug and Release gates.
- Completed: native UI overhaul milestone 2, including two reviewed original
  ImageGen atlases, SIL-OFL Manrope typography, exact asset/prompt
  provenance, safe production load/degraded/unload ownership, narrow tested
  raylib primitives, save-v4 theme/reduced-motion migration, the replacement
  component system, and passing 44/44 Debug and Release gates.
- Completed: native UI overhaul milestone 3, including branded startup,
  persistent responsive shell, state-safe Back, purpose-designed dark/light
  themes, settings/help/explicit modals, the illustrated responsive eleven-card
  lobby, static Manrope Medium rendering, actual native visual review at every
  required viewport, and passing 45/45 Debug and Release gates.
- Completed: native UI overhaul milestone 4, including the shared responsive
  game-interior composition, procedural premium table/card/chip vocabulary,
  complete Blackjack/European Roulette/No-Limit Hold'em/HiLo replacements,
  exact-rule guides, privacy-safe projections, committed/reduced motion,
  actual dark/light native review across the target matrix, and passing 46/46
  Debug and Release gates.
- Completed: native UI overhaul milestone 5, including complete Plinko, Coop
  Climb, and Midnight Crossing replacements; committed-path interpolation;
  privacy-safe ladder and public fixed-tick hazard rendering; actual dark/light
  and active-state native review; and passing 47/47 Debug and Release gates.
- Completed: native UI overhaul milestone 6, including complete Mines, Dice,
  Crash, and Slots replacements; privacy-safe tiles and committed flight data;
  exact signal and reel-result presentation; procedural gems, mines, dice,
  rocket/exhaust, cabinet, paylines, and eight symbols; actual dark/light,
  active-state, requested-1080p, and maximized native review; and passing 48/48
  Debug and Release gates. All eleven native game interiors are accepted.
- Completed: native UI overhaul milestone 7, including 13 tracked verified
  native website captures; aligned semantic styling; source/staged validation;
  1280x720 and 390x844 browser QA; the exact 17-file asset-bearing package;
  recursive hashes, licenses, forbidden-content and relocated-smoke gates; final
  documentation; and clean Scroll2Roll/frozen-Rocket audits. No publication,
  deployment, push, release, purchase, signing, or owner-approval claim was made.
- Completed locally: post-art implementation Group 1 for Midnight Crossing,
  Crash, and Coop Climb. Eleven reviewed assets were promoted to the versioned
  `assets/games/group1-v1/` runtime set with accepted/runtime/source hashes and
  explicit provenance limits. Each game now combines its final resource-backed
  composition with committed, reduced-motion-aware presentation while keeping
  fixed-tick geometry, hidden outcomes, controls, and rule ownership unchanged.
  Resource-backed and fallback view fixtures pass with balanced scissoring and
  zero live handles. Focused tests and sequential full Debug/Release validation
  pass 48/48. Forty-six ignored native evidence captures cover all three games
  in dark/light at 800x600, 1024x768, 1280x720, 1600x900, and the current
  maximized 1920x991 client, plus active, settled, disabled, and reduced-motion
  states. This is verified local evidence for owner review, not owner visual
  approval; Groups 2-4, website/package refresh, push, publication, deployment,
  release, and signing were not performed.

## Major decisions

- Created an unintegrated owner-art staging package at `owner-art-20260812`:
  37 visually reviewed high-resolution PNGs and 29 retained source originals.
  The package covers all eleven games with coordinated environments, physical
  props, character/vehicle pieces, VFX, and reusable atlases. It is art-only;
  no native or web implementation, game rules, package, deployment, or Git
  promotion occurred in this milestone.

- Preserve the draft under `legacy/Blackjack-v1` so the repaired implementation never destroys historical evidence.
- Use integer credits and even bet units so Blackjack 3:2 payouts remain exact.
- Keep the casino economy local and deliberately small; persistence contains only versioned preferences, first-run state, AI count, and play-money progress.
- Keep rendering dependent on the tested Blackjack API instead of duplicating game rules.
- Keep the native adapter narrow and reusable; new UI operations were added only when demonstrated necessary.
- Keep the Cloudflare site static and separate from native application behavior. The current archive fits Pages Free's verified 25 MiB per-asset limit.
- Use version 0.2.0 and `scroll2roll-save-2` for the expansion, with explicit
  migration of valid `scroll2roll-save-1` data and safe recovery for corrupt or
  unsupported data.
- Use version 0.3.0 and `scroll2roll-save-3` for the current expansion, with
  explicit migration of both valid prior formats and no persisted live wagers.
- Maintain one local play-credit balance across games, transferring it only at
  engine-defined safe settlement/cash-out/hand boundaries.
- Keep every compiled Rocket source basename unique so frozen CodeView records
  remain unambiguous without changing Rocket 2.0 or its Visual Studio extension.
- Force raylib `SUPPORT_CUSTOM_FRAME_CONTROL` off because the safe Rocket adapter
  intentionally delegates buffer swapping, frame pacing, and event polling to
  raylib's standard `EndDrawing()` behavior.
- Keep the website profile deliberately non-authenticated and browser-local.
  Accept only decoded PNG/JPEG/WebP avatars up to 1.5 MiB, store them as data
  URLs, and block network connections through both implementation and CSP.
- Treat the 0.3.0 native visuals as a rejected baseline while preserving its
  accepted engines and flows. Keep theme/layout/motion policy in Rocket, grow
  the Scroll2Roll-owned native adapter only with demonstrated primitive needs,
  and require visual inspection in both themes in addition to functional tests.
- Use `scroll2roll-save-4` only for the two approved UI preferences. Migrate
  valid save-v1/v2/v3 values with dark theme and full motion defaults; never
  persist live wagers, private outcomes, or generated resource handles.
- Derive every replacement game interior from `game_layout.rocket` and
  `game_components.rocket`: compact viewports use a bottom dock, larger
  viewports use an action rail, and all rule/state meaning continues to come
  from the existing engine or privacy-safe public projection.
- Promote reviewed post-art runtime files in versioned per-group directories,
  keep their exact accepted/runtime/source counterpart hashes in
  `assets/MANIFEST.md`, and preserve procedural fallbacks. The owner-art staging
  directory remains ignored source evidence; local integration direction is not
  owner visual approval or release approval.

## Files that must remain out of Git

Generated bindings, `.rocketc`, `out`, `build`, `.vs`, Visual Studio experimental state, downloaded dependencies, compiler/toolchain trees, native objects, executables, DLLs, libraries, PDBs, packages, caches, local configuration, and real user save data.

## New-chat handoff

Read `AGENTS.md`, `UI_OVERHAUL.md`, `docs/GAME_VISUAL_REFINEMENT_PLAN.md`,
`docs/OWNER_ASSET_GENERATION_PROMPTS.md`, `docs/MASTER_PLAN.md`,
`docs/ASSET_ANIMATION_IMPLEMENTATION_PLAN.md`,
`docs/UI_OVERHAUL_FOUNDATION.md`, `docs/EXPANSION_PLAN.md`,
`docs/EXPANSION_0_3_IMPLEMENTATION.md`, and this file completely. Inspect Git
status and preserve user changes. The accepted 0.2.0 baseline remains intact;
Mines, Dice, HiLo, Crash, Slots, and save-v4 migration are complete. The full UI
overhaul passes 48/48 in Debug and Release. The accepted asset-bearing 0.3.0
archive is 6,963,264 bytes with SHA-256
`83B4E94C24C196782CB04F209193303A6BD602A8A3E7B2B3A8E99548EC02D597`;
package/relocation and 19-file source/20-file staged-site checks pass. All eleven
interiors, both themes, every responsive target, and representative active
states passed local visual review; tracked website captures present that work
for owner approval. Post-art implementation Group 1 is now complete locally for
Midnight Crossing, Crash, and Coop Climb: its versioned asset provenance,
resource lifecycle, focused tests, 48/48 Debug/Release gates, and 46 ignored
native dark/light/reduced-motion evidence captures are verified. Group 2 is the
next sequential plan boundary, but this Group 1 goal does not authorize it;
do not start Groups 2-4 without a new owner direction. Keep
using frozen Rocket 2.0 and the pinned raylib integration with custom frame
control forced off. Preserve the untracked owner files and audit artifacts.
Do not refresh the website/package before the plan's final Group 4 acceptance,
or push, publish, deploy, release, sign, purchase, or claim owner visual
approval without explicit owner permission.
