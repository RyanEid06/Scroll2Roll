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

## Native UI overhaul milestone 4 - first four game interiors

- On 2026-08-11, the actual native executable was captured for Blackjack,
  European Roulette, No-Limit Hold'em, and HiLo in dark and light themes at
  800x600, 1024x768, 1280x720, and 1600x900. On the current 1920x1080 display,
  the largest decorated native-window client is 1920x1055; both themes were
  captured there, while deterministic rendering tests exercise the exact
  1920x1080 client contract. Evidence remains ignored under
  `out/visual-audit/milestone4/` with filenames containing game, theme, state,
  and requested client size.
- Minimum-size ready/active review confirms a dominant stage, separate compact
  action dock, persistent shell, readable custom typography, 44-pixel controls,
  reachable mouse/keyboard actions, visible disabled states, and no clipping or
  overlap. Standard/wide/cinema review confirms a distinct action rail,
  proportionate stage use, readable history/metrics, and theme-specific
  surfaces rather than inversion. Representative active captures were reviewed
  individually at 800x600, 1024x768, 1280x720, and 1600x900.
- `game_layout.rocket` supplies the common stage/dock/rail contract.
  `game_components.rocket` supplies cover-cropped original ambience with a
  procedural fallback, premium felt, real procedural suit marks, card faces,
  branded backs, chip stacks, metrics, status/help surfaces, and reduced-
  motion-aware committed offsets. These modules receive presentation state and
  own no casino decision.
- Blackjack now shows its curved emerald/brass table, dealer and active-hand
  hierarchy, AI seats, chip/wager state, real suits, settlement, legal-action
  disabling, and explicit Next/New Table controls. Its global source-aware help
  guide states 3:2, soft-17, split-ace, action, and safe-return rules without
  changing engine contracts.
- Roulette now shows a dimensional proportional wheel, locked-ball motion, the
  complete single-zero 0-36 cloth, outside/dozen/column/basket regions, placed
  chips, chip selector, focus, history, and settlement controls. Existing exact
  center/edge/intersection/street/six-line mapping remains engine-validated.
- Hold'em now shows an oval table with up to five opponent seats, branded hidden
  cards, only eligible public showdown cards, human private cards, dealer/SB/BB/
  fold/all-in state, board positions, pot, action history, raise-to sizing, and
  legal-action disabling. The view still receives only `PublicTable`; it never
  receives the deck or private opponent cards.
- HiLo now shows a private deck, oversized current card, exact cards-left and
  lower/equal/higher counts, a proportion bar, visible sequence, multiplier,
  potential return, and a prominent `EQUAL RANK = LOSS` warning. Initial input
  remains immediate; committed subsequent cards use the existing animation
  clock, and reduced motion removes the offset.
- The visual matrix found a 1024x768 Roulette defect: a fixed decorative ring
  inset made the smallest standard-mode inner radius negative. The wheel bands
  now scale proportionally, replacement dark/light captures pass, and
  `ui_core_games_view_test.rocket` draws all four games in ready/active/settled
  states, both themes, at all five exact target dimensions so that failure is
  covered permanently.
- All affected GUI flows use exported responsive hitboxes. The Roulette flow
  still proves split/corner/street/six-line/basket mapping; Hold'em still proves
  privacy and complete hand/reset/lobby flow; HiLo still proves private deck,
  equal-loss, correct/cash-out, persistence, and animation behavior. Sequential
  Debug and Release `scripts/validate.ps1` passes each completed the native
  build, `rocketc check`, all 46 tests, and both formatting checks. No game rule,
  deterministic result, persistence format, frozen Rocket contract, native ABI,
  package, or website was changed. Nothing was pushed, deployed, published,
  released, signed, or purchased.

## Native UI overhaul milestone 5 - three arcade interiors

- On 2026-08-11, the actual native executable was captured for Plinko, Coop
  Climb, and Midnight Crossing in dark and light themes at 800x600, 1024x768,
  1280x720, and 1600x900. Both themes were also captured at the current
  display's 1920x1055 maximum decorated-window client; deterministic rendering
  tests exercise exact 1920x1080. Ignored evidence is under
  `out/visual-audit/milestone5/` using game, theme, state, and requested-size
  filenames. Representative active captures cover every game at compact and
  standard dimensions.
- Plinko now has a deep cyan audited chamber, responsive triangular peg field,
  dimensional pegs, exact multiplier bins, batch configuration, committed-path
  balls, compact live status, and sub-step interpolation. Interpolation reads
  only precommitted engine paths; reduced motion retains the discrete committed
  stages and rendering never selects a bucket.
- Coop Climb now has an original observatory ascent, telescope goal, ten fixed
  multiplier rungs, hidden/next/secured/failed state, risk and pass controls,
  cash-out state, and a phase-aware compact dock. The renderer derives the
  displayed secured multiplier from the public fixed ladder and depth; it does
  not receive or expose future safe/fail values.
- Midnight Crossing now has a dominant top-down city board with safe medians,
  roads, tram lane, canals, checkpoint, procedural courier, vehicles, tram, and
  logs. All hazard positions and kinds come from public engine state and are
  scissored to the board; the view neither advances fixed ticks nor performs
  collision decisions. Compact and wide direction pads expose the same legal
  movement/pause/cash-out paths as the keyboard.
- Native review found one 800x600 Coop Climb overlap between ready controls and
  compact status metrics. The information band is now phase-aware—below the
  ready row and above active/settled actions—and replacement dark/light and
  active captures pass without clipping or overlap. Plinko's otherwise-empty
  compact live state also gained a status band during review.
- `ui_arcade_games_view_test.rocket` permanently checks target bounds,
  44-pixel controls, phase-specific non-overlap, balanced scissor state, and
  both-theme ready/active/settled rendering at all five exact dimensions. The
  Plinko, Coop Climb, and Midnight Crossing GUI tests now derive every changed
  pointer action from exported responsive hitboxes while preserving their
  complete rules, persistence, pause, settlement, and safe-lobby flows.
- Sequential Debug and Release `scripts/validate.ps1` passes each completed the
  native build, `rocketc check`, all 47 tests, and both formatting checks. The
  frozen Rocket checkout remained clean and the bundled font hash remained
  unchanged. Nothing was pushed, deployed, published, released, signed, or
  purchased.

## Native UI overhaul milestone 6 - final four interiors

- On 2026-08-11, the actual native executable was captured for Mines, Dice,
  Crash, and Slots in dark and light themes at 800x600, 1024x768, 1280x720,
  and 1600x900. The requested 1920x1080 review used the current display's
  1920x1055 maximum forced client while exact 1920x1080 is exercised by the
  deterministic renderer test. A separate true Windows maximize pass measured
  and reviewed a 1920x991 client for all four games. Ignored evidence is under
  `out/visual-audit/milestone6/`; capture profiles isolate both `APPDATA` and
  `LOCALAPPDATA`, assert client dimensions, and never consume real user saves.
- Representative live-state captures cover every game at light 800x600 and
  dark 1280x720. Mines shows its privacy-uniform unopened cavern and focused
  live grid; Dice shows one exact four-digit result split across two designed
  dice and a visible finite-auto Stop; Crash shows only the public live curve,
  rocket/exhaust, oversized multiplier, and Cash Out; Slots shows staged
  precommitted reels, procedural symbols, free-spin state, and disabled/Stop
  auto presentation without revealing unreached reels.
- Native inspection found and corrected two product defects. Dice originally
  drew the combined result over both already-labeled dice, duplicating and
  colliding glyphs; it now uses one result heading above the two two-digit
  faces. Slots' animated reel streaks originally escaped cell bounds into the
  marquee; every hidden reel is now scissored to its cell and the focused test
  proves balanced scissor cleanup. Replacement captures pass in both themes.
- Mines uses only `mines_api.tile_state` for tile rendering, so unrevealed mine
  placement never leaks. Crash consumes only `crash_api.PublicTable`, whose
  running crash point remains hidden. Dice and Slots render committed API state
  without selecting results or recomputing payouts. Reduced-motion paths retain
  clear committed state without motion offsets.
- `ui_final_games_view_test.rocket` checks the five exact target dimensions,
  every exported phase-specific control, 44-pixel actions, practical compact
  Mines board cells, non-overlap, bounds, both-theme ready/active/settled
  drawing, substantial draw activity, and balanced scissor state. Updated GUI
  flows derive all changed mouse actions from responsive view geometry while
  preserving complete rules, privacy, persistence, finite-auto, and safe-lobby
  behavior.
- Sequential Debug and Release `scripts/validate.ps1` passes each completed the
  native build, `rocketc check`, all 48 tests, and both formatting checks. The
  frozen Rocket checkout remained clean and the bundled font hash remained
  unchanged. Nothing was pushed, deployed, published, released, signed, or
  purchased.

## Post-art implementation Group 1 - Midnight Crossing, Crash, and Coop Climb

- On 2026-08-14, the actual native Release executable was inspected for all
  three Group 1 games in dark and light themes at 800x600, 1024x768, 1280x720,
  and 1600x900. Both themes were also reviewed at the current display's true
  maximized 1920x991 client; Windows Graphics Capture reports the 125%-scaled
  outer window as 1536x816. A requested 1920x1080 decorated window extends
  beyond this display's capturable work area, so the maximized native pass is
  the honest display-bound evidence while deterministic view tests continue to
  exercise the exact 1920x1080 client contract. The 46 ignored PNGs and
  isolated save profiles are under `out/visual-audit/group1/`.
- Ready art-backed composition was reviewed for every game, theme, and native
  size. Compact active and settled states verify the bottom action dock,
  visible disabled cash-out, reachable direction/advance/launch controls, all
  eight Midnight lanes, all ten Coop multipliers, and unclipped Crash curve and
  burst. Standard and wide states verify the action rail, scalable stage crop,
  readable hierarchy, bounded scissoring, and no overlap or dead-space defect.
  Representative active Crash states were also captured at 1024x768 light and
  1280x720 dark.
- The 800x600 dark reduced-motion profile was visibly verified in Settings and
  captured in active states for Midnight Crossing, Crash, and Coop Climb, plus
  representative Midnight collision and Coop failure settlement. A separate
  1024x768 light reduced-motion active Crash pass cross-checks the standard
  action-rail layout. Reduced motion keeps every committed/public state and
  removes the tick streak, bob, flare, and transition offsets instead of
  changing engine time, outcomes, controls, or geometry.
- Only reviewed material from `owner-art-20260812/accepted` was promoted to the
  versioned `assets/games/group1-v1/` runtime set: Midnight city, two top-down
  cars, tram, raft, and shared chicken; Crash flight environment, rocket, and
  burst; and Coop observatory and platform. The accepted oblique vehicle atlas
  was deliberately excluded because its camera angle and embedded markings do
  not fit the exact top-down lane composition. `assets/MANIFEST.md` records
  accepted/runtime/source counterpart SHA-256 values and the known provenance
  boundary without claiming unavailable generator identifiers or owner visual
  approval.
- `ui_resources.rocket` is the sole owner of the eleven new textures. It loads
  them once, exposes explicit ready flags and procedural fallbacks, and unloads
  each live handle exactly once. `ui_resources_test.rocket` verifies the full
  production set at 13 textures including the two existing atlases and returns
  texture/font counts to zero. The resource-backed arcade/final view fixtures
  also verify ready/active/settled drawing, balanced scissor cleanup, and zero
  live resources after close.
- Midnight retains the public 900-unit fixed-tick hazard projection and exact
  lane/collision/support geometry while its city, vehicles, tram, rafts,
  wakes, streaks, carried feedback, collision response, and checkpoint flare
  remain presentation-only. Crash still consumes only
  `crash_api.PublicTable`; the hidden crash point is never passed to rendering,
  and launch/trail/flame/cash-out/burst effects derive only from public phase
  and multiplier state. Coop keeps the hidden path private, renders all future
  rungs identically, and uses a 0.32-second presentation deadline only for the
  committed current/safe/failed/secured marker and summit response; input and
  rule transitions are never delayed.
- Focused tests passed one game at a time: Crossing rules, fixed-tick
  simulation/replay, GUI flow, resources, and arcade views; Crash rules,
  session, GUI flow, resources, and final-game views; and Chicken rules,
  session, GUI flow, resources, and arcade views. Final sequential
  `scripts/validate.ps1 -Configuration Release -RocketRoot "<frozen-rocket>"`
  and Debug passes each completed native generation/build, `rocketc check`, all
  48 tests, and both source/test formatting checks.
- This group changes no casino rule, private-state boundary, persistence
  format, fixed-tick geometry, frozen Rocket contract, raylib ABI, website, or
  package. Groups 2-4 were not started. Nothing was pushed, published,
  deployed, packaged, signed, or described as owner-approved.

## Post-art implementation Group 2 - Blackjack, Hold'em, and Roulette

- On 2026-08-14, Group 1 was verified before Group 2 changes: its committed
  scope and eleven runtime assets matched the accepted hashes, and fresh Debug
  and Release baseline passes each completed the native build, `rocketc check`,
  all 48 tests, and both formatting checks. No Group 1 game view or runtime
  asset is changed by the Group 2 diff; the shared resource owner is extended
  with its lifecycle tests still passing.
- Only seven reviewed files were promoted byte-identically from
  `owner-art-20260812/accepted` to `assets/games/group2-v1/`: the Blackjack
  room and dealing shoe, shared chip stack, Hold'em lounge and props atlas, and
  Roulette room and wheel. `assets/MANIFEST.md` records exact accepted/runtime
  hashes, the available source counterpart hashes, dimensions, provenance
  limits, and the 4x2 Hold'em atlas cell map. The baked rectangular premium
  table was excluded because it conflicts with responsive code-owned table
  geometry. The decorative roulette cradle was excluded because it is not an
  isolated ball aligned to the engine's 37 pockets.
- Blackjack retains its exact table and existing rule/action rectangles. Its
  reviewed room, shoe, chips, rail seats, wager markers, active-hand ring,
  committed card offset, and public settlement response are presentation-only.
  Hold'em retains the privacy-safe `PublicTable`: rival cards remain back-only
  unless that projection supplies two public cards, while atlas chips, pot,
  dealer/blind markers, active-player ring, and committed deal/chip offsets add
  visual weight. Roulette retains every board, number, rail, and mouse-bet
  rectangle; the physical wheel maps the engine's canonical 37-pocket order
  to the locked result, and the wheel marker and table highlight use the same
  committed winner.
- Reduced motion removes Blackjack and Hold'em interpolation offsets and locks
  the Roulette ball to its committed pocket without changing phase timing,
  state, outcomes, focus, controls, or geometry. Deterministic core-game view
  fallback fixtures exercise normal and reduced active states in both themes at
  exact 800x600, 1024x768, 1280x720, 1600x900, and 1920x1080 client dimensions.
  The production-resource fixture exercises both themes at 1280x720 with the
  same active-state profiles. Both paths verify balanced scissoring and zero
  live handles after close.
- `ui_resources.rocket` remains the sole texture owner. It loads the seven new
  textures once, exposes explicit ready flags and fallbacks, and unloads each
  live handle exactly once. `ui_resources_test.rocket` verifies one font and
  all 20 production textures, then verifies both live counts return to zero.
  Focused rules, session, GUI-flow, privacy, resource, and core-view tests pass
  for the three games; rendering does not load or allocate assets per frame.
- Actual Release-window inspection used isolated ignored settings profiles and
  Windows Graphics Capture. Dark and light ready composition passed at
  800x600, 1024x768, 1280x720, and 1600x900, followed by both themes at the
  current maximized 1920x991 client (1536x816 outer capture at 125% scaling).
  A requested decorated 1920x1080 window extends outside the capturable work
  area; the exact 1920x1080 contract is therefore deterministic-test evidence,
  not a claimed native capture. Compact active/settled review confirmed the
  bottom dock, focus rings, disabled actions, Blackjack dealer-hole concealment,
  Hold'em rival back-only cards until settlement, and Roulette wheel/table
  result agreement. Standard and wide review confirmed the action rail and
  unclipped table composition. The visibly enabled reduced-motion profile was
  also inspected maximized for all three games, including a live Hold'em hand
  and committed Blackjack/Roulette settlements.
- Final sequential Debug and Release `scripts/validate.ps1` passes each
  completed native generation/build, `rocketc check`, all 48 tests, and both
  source/test formatting checks. This group changes no game rule, private-state
  boundary, persistence format, Roulette hit region, legal-action contract,
  frozen Rocket contract, raylib ABI, website, or package. Groups 3-4 were not
  started. Nothing was pushed, published, deployed, packaged, signed, or
  described as owner-approved.

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

## Pre-overhaul 0.3.0 local acceptance

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

## Native UI overhaul milestone 7 - website, package, and final acceptance

The final local commands on 2026-08-11 are:

```powershell
.\scripts\validate.ps1 -Configuration Debug -RocketRoot "<frozen-rocket>"
.\scripts\validate.ps1 -Configuration Release -RocketRoot "<frozen-rocket>"
.\scripts\package-windows.ps1 -RocketRoot "<frozen-rocket>"
.\scripts\test-package.ps1
.\scripts\test-website.ps1
.\scripts\prepare-cloudflare-site.ps1 -Output .\out\cloudflare-site-final-acceptance
.\scripts\test-website.ps1 -Site .\out\cloudflare-site-final-acceptance
```

- Debug and Release each pass native generation/build, `rocketc check`, all 48
  tests, source formatting, and test formatting. This includes deterministic
  complete sessions and scripted keyboard/mouse flows for all eleven games;
  save-v1/v2/v3 migration and save-v4 recovery/round-trip; dark/light and
  reduced-motion drawing; safe Back; exact responsive geometry; private-state
  boundaries; native adapter/resources; audio stress; and clean shutdown.
- `out/package/Scroll2Roll-0.3.0-windows-x64.zip` is exactly 6,963,264 bytes
  (6.64 MiB) with SHA-256
  `83B4E94C24C196782CB04F209193303A6BD602A8A3E7B2B3A8E99548EC02D597`.
  Its exact 17-file allowlist includes the executable/user docs, complete
  pinned raylib license, both reviewed ImageGen atlases and provenance files,
  Manrope variable/static fonts plus OFL/metadata, and recursive checksums.
  Sidecar, allowlist, reviewed hashes, safe checksum paths, forbidden-content
  scan, and relocated-working-directory `--headless-smoke` all pass.
- The 19-file source site and fresh 20-file staged tree pass exact validation
  against that archive. The validator pins all 13 native-capture hashes, eleven
  game cards, profile safety, CSP, accessibility/reduced motion, semantic
  palette, honest native-only language, file ceilings, and archive metadata.
- In-app browser QA covers profile creation/editing/invalid-name focus, Play,
  and Download at 1280x720 and 390x844. Desktop cards measure 581x544 in two
  columns; phone cards measure 347x426 in one. Every visible capture loads at
  its 1280-pixel source width, exact package metadata renders, horizontal
  overflow is zero, and console warnings/errors are empty. QA found one mobile
  lobby-preview height defect; explicit automatic image height fixed it, and the
  replacement stage passed both static and browser checks.
- Native screenshot evidence spans startup, shell, settings, help/modals, both
  themes, all eleven ready/active/settled interiors, the exact five renderer
  sizes, requested-1080p/current-display maximum, and true maximize. Ignored
  audit evidence remains under `out/visual-audit/`; 13 representative actual
  captures are tracked under `website/assets/` and are presented to the owner
  for visual approval. The current display limitation is recorded honestly:
  forced client 1920x1055 and true maximize 1920x991, with deterministic exact
  1920x1080 renderer coverage.
- Logical local implementation commits are `26c397b`, `6aec64b`, `0c022e8`,
  `dcada3d`, `cb8c83e`, `8fbdce4`, and `851308f`. Generated builds, packages,
  relocation trees, staged sites, and full audit evidence remain ignored. The
  owner-provided untracked `SCROLL2ROLL_MASTER_PLAN.md` remains untouched.
- The frozen Rocket 2.0 checkout remains unchanged. Nothing was pushed,
  deployed, published, released, purchased, or signed, and visual approval is
  not claimed on the owner's behalf.
