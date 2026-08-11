# Native UI Overhaul Foundation

This document is the implementation ledger for `UI_OVERHAUL.md`. The owner has
rejected the native 0.3.0 presentation; passing game-flow tests do not make that
presentation visually acceptable. Rules, deterministic outcomes, privacy,
balances, persistence boundaries, and input parity remain the accepted behavior
baseline. The owner-visible rendering is being replaced.

## Rejected baseline audit

The packaged 0.3.0 executable was launched and inspected before source changes.
Ignored evidence is under `out/visual-audit/`; it is not a screenshot-baseline
test suite and must not enter Git.

| Size | Observed failure |
| --- | --- |
| 800x600 | Fixed coordinates clip the right control rail and make controls unreachable. Labels crowd the play area and the lobby does not reflow. |
| 1280x720 | The shell does not use the added width. Large empty regions surround narrow fixed panels. |
| 1600x900 | The original six large lobby cards remain disconnected from five cramped text strips. The interface scales as empty space rather than composition. |

Every ready-state game screen was also inspected at 800x600:
`baseline-fresh-blackjack-800x600.png`,
`baseline-fresh-roulette-800x600.png`,
`baseline-fresh-plinko-800x600.png`,
`baseline-audited-coop-climb-800x600.png`,
`baseline-audited-midnight-crossing-800x600.png`,
`baseline-audited-holdem-800x600.png`,
`baseline-audited-mines-800x600.png`,
`baseline-audited-dice-800x600.png`,
`baseline-audited-hilo-800x600.png`,
`baseline-audited-crash-800x600.png`, and
`baseline-audited-slots-800x600.png`. Across all eleven, the default bitmap
font, flat rectangles, weak state hierarchy, limited material depth, and
inconsistent or clipped lobby/help controls confirm that this is a full-screen
replacement, not a shell reskin.

The temporary owner images and current Subframe, Behance, and ThemeForest index
examples were used only as composition research. No reference screenshot,
gallery preview, watermark, provider logo, branded game object, or commercial
template may be copied, traced, downloaded, or bundled. The durable synthesis
is: quiet layered shell, bold original focal illustration, recognizable game
silhouette, dominant stage, compact action dock, secondary status/history,
purpose-designed light mode, and result-synchronized motion.

## Breakpoints and safe geometry

`src/app/layout.rocket` is the only source of top-level responsive geometry.
Views may derive smaller local geometry from its positive regions but must not
reintroduce a second fixed desktop layout.

| Width | Mode | Navigation | Lobby columns | Game composition |
| --- | --- | --- | --- | --- |
| 800-959 | compact | top bar; no side rail | 2 | stage above a 132-168 px action dock |
| 960-1439 | standard | 72 px rail | 3 | stage plus 264-376 px action rail |
| 1440-1799 | wide | 88 px rail | 4 from 1520 px | larger stage plus clamped action rail |
| 1800+ | cinema | 88 px rail | 5 | larger stage plus clamped action rail |

The five acceptance viewports are 800x600, 1024x768, 1280x720, 1600x900,
and 1920x1080, followed by maximized inspection on the current display. Safe
margins are 16/24/32 px by mode. The top bar is 64 px compact and 72 px
otherwise. Pointer targets are at least 44 px where practical. Geometry is
clamped before drawing. Help and history use clipped/scrollable regions once
the narrow adapter operations are present.

## Semantic visual system

Dark and light colors, spacing, typography roles, focus, elevation, radii,
component heights, motion duration, and breakpoints live in
`src/app/theme.rocket`. Game-specific colors may supplement these tokens for a
surface or object; shell text, status, focus, and action states must remain
semantic. Compatibility aliases exist only while old views are replaced in
reviewable groups.

Motion uses 120 ms for direct feedback, 180 ms for ordinary state changes, and
250 ms for slower panel/modal transitions. Committed game outcomes may be more
expressive, but settlement occurs in the engine first. Reduced motion removes
decorative interpolation and shortens outcome staging without changing the
committed result.

## Asset ownership and manifest policy

All shipped resources live below `assets/` and must be addressed through a
central manifest in Rocket. Each manifest entry records a stable key, relative
path, intended dimensions, source, author/tool, creation or retrieval date,
license, required notice, theme compatibility, and fallback policy. Generated
source images and experimental outputs remain ignored; only reviewed runtime
assets and their human-readable provenance enter Git.

Core art cannot fall back to a blank rectangle. If a core texture is missing or
corrupt, the app uses a deliberately styled procedural equivalent and reports a
non-blocking resource status. Fonts fall back to raylib's default font only as
an explicit degraded mode that tests can detect. Every loaded font, texture,
sound, render target, and temporary buffer has one owner and one cleanup path.

### Screen and game inventory

| Screen | Background / cover | Main surface | Required objects and effects | Controls / sound |
| --- | --- | --- | --- | --- |
| Startup | original ribbon-orbit launch illustration | layered brand plate | orbit ribbons, card/chip sparks, restrained reveal | Continue, Settings; soft launch cue |
| Lobby | original panoramic hero plus eleven unique covers | elevated responsive cards | distinct focal silhouette, category badge, hover/focus rim | Back/Settings/theme, paging/scroll cues, card activation |
| Settings/help/modals | theme-aware abstract ribbon field | elevated sheet/modal | icons, section markers, dim/backdrop depth | toggles, steppers, reset/confirm; quiet state cues |
| Blackjack | indigo casino-room ambience; crown/card cover | curved emerald felt table and padded rail | shoe, dealer/player cards, chips, betting circles, deal/settle particles | wager/deal/hit/stand/double/split/surrender; card/chip cues |
| European Roulette | burgundy-violet room; wheel cover | wheel plus full single-zero felt grid | ball, pockets, chip stack, selected bets, spin trail | chip selector, undo/clear/spin/rebet; wheel/ball cues |
| Plinko | cyan-indigo chamber; peg-token cover | deep triangular peg board | dimensional pegs, glowing token, multiplier bins, bounce trail | wager/rows/risk/balls/drop; peg/landing cues |
| Coop Climb | dawn observatory; telescope-coop cover | vertical brass ladder/tower | climber token, ten rungs, telescope goal, safe/fail reveal | wager/risk/climb/cash out; step/outcome cues |
| Midnight Crossing | neon night city; courier-lantern cover | dominant road/rail/water board | original courier, vehicles, tram, logs, lanes, checkpoint flare | wager/difficulty/start/movement/cash out; traffic/water cues |
| Texas Hold'em | violet lounge; card-table cover | oval emerald felt table and padded rail | six seats, community cards, hole cards, dealer/blind markers, chip pots | deal/check/call/raise/fold/all-in; deal/chip cues |
| Mines | jewel cavern; gem/mine cover | large inset 5x5 tile board | dimensional hidden tiles, original gems/mines, reveal dust/glow | wager/mines/reveal/cash out; reveal/outcome cues |
| Dice | synthwave signal vault; dice cover | central numeric roll chamber | two original dice, threshold band, exact readout, result pulse | wager/target/direction/auto/roll/stop; roll/result cues |
| HiLo | astral card room; rising/falling cards cover | centered prediction altar/table | oversized current card, deck, lower/higher arcs, sequence | wager/deal/lower/higher/cash out; turn/result cues |
| Crash | deep-space flight deck; rocket cover | dominant curve/rocket plot | original rocket, exhaust, path, multiplier, crash burst | wager/auto target/launch/cash out; thrust/crash cues |
| Slots | art-deco midnight arcade; cabinet cover | dimensional five-reel cabinet | reviewed symbols, paylines, lamps, win frames, bonus flare | line bet/turbo/autoplay/spin/stop; reel/stop/win cues |

The initial production plan is original ImageGen raster art for the lobby hero
and eleven covers, plus polished procedural raylib tables, boards, cabinet,
cards, chips, tokens, symbols, and synchronized effects. Artwork is accepted
only after visual inspection for silhouette, lighting, crop, text artifacts,
watermarks, unwanted branding, theme compatibility, and resolution. External
assets require an independently verified redistribution license and notice;
none is accepted merely because it appears in a search gallery.

## Native adapter inventory

The current Scroll2Roll-owned adapter safely exposes window/frame lifetime,
solid rectangles and circles, default text measurement/drawing, input,
texture load/draw/unload, font load/draw/unload, audio, and deterministic test
counters. It deliberately owns no casino or layout policy.

Demonstrated presentation gaps to add narrowly and test:

- custom-font measurement so alignment uses the same font that is drawn;
- non-uniform destination texture drawing with an optional source region;
- line, thick line, triangle, ring/arc, and rounded-rectangle primitives for
  original tables, boards, paths, focus rings, and iconography;
- scissor begin/end for help, history, and compact lobby regions;
- mouse-wheel input for those Rocket-owned scroll models;
- test-mode last-operation/counter hooks sufficient to prove clipping,
  custom-font fallback, and balanced begin/end and load/unload lifetimes.

Gradient meshes, particles, easing, responsive layout, focus order, scrolling
policy, theme selection, and all game composition stay in Rocket. The adapter
will grow only for a reviewed use that the safe existing boundary cannot
express.

## Acceptance ledger

Implementation status on 2026-08-11:

| Milestone | Status | Evidence |
| --- | --- | --- |
| Foundation and rejected-baseline audit | Accepted | Five responsive geometry targets; 42/42 Debug and Release |
| Assets, resources, persistence, components | Accepted | Reviewed ImageGen atlases, licensed Manrope, degraded modes; 44/44 |
| Startup, shell, lobby, settings, help, modals | Accepted | Actual dark/light native captures at every target and maximized; 45/45 |
| Blackjack, Roulette, Hold'em, HiLo interiors | Pending | Must pass focused implementation, visual, and regression gates |
| Remaining seven interiors | Pending | Must pass focused implementation, visual, and regression gates |
| Website, package, final acceptance | Pending | Must use the completed asset-bearing application |

Every milestone must pass the relevant focused tests and the complete Debug and
Release validation scripts before its commit. Visual milestones also require
actual native screenshots in both themes at every target resolution; screenshots
stay ignored but their filenames and observations are recorded in
`docs/VALIDATION.md`. No screenshot is accepted solely because the app launched.

Per screen, acceptance means: no old debug composition remains; the defining
spatial metaphor is recognizable before reading the title; the stage is the
dominant region; controls follow action order; Back is persistent and state
safe; both themes have readable contrast; keyboard and mouse reach the same
legal actions; labels do not clip; and the minimum viewport has no overlap,
negative geometry, or unreachable control.

This ledger does not claim that the visual overhaul is complete. It defines the
evidence required to make that claim after all eleven interiors, the package,
and the aligned website have passed.
