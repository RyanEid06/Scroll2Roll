# Visual Design

The native 0.3.0 rectangle-and-default-text presentation is an explicitly
rejected baseline. `UI_OVERHAUL.md` is the active owner mandate and
`UI_OVERHAUL_FOUNDATION.md` records the implementation/acceptance ledger. This
document describes the target system while views are replaced in logical
groups; it does not claim visual acceptance before that work is complete.

## Semantic color tokens

| Token | Value | Use |
| --- | --- | --- |
| Role | Dark | Light |
| --- | --- | --- |
| canvas | `#090B14` | `#EEF2FA` |
| shell | `#0F1324` | `#FFFFFF` |
| surface | `#151A2D` | `#FFFFFF` |
| elevated | `#1D2440` | `#E9EEFF` |
| primary text | `#F7F8FF` | `#172033` |
| secondary text | `#A2AAC4` | `#667085` |
| subtle border | `#2A3354` | `#D7DDEA` |
| primary | `#5B7CFF` | `#4F46E5` |
| violet | `#8B5CF6` | `#7C3AED` |
| cyan | `#22D3EE` | `#0891B2` |
| success / credit | `#34D399` | `#059669` |
| highlight | `#FBBF24` | `#D97706` |
| destructive | `#FB7185` | `#E11D48` |

Spacing, type roles, radii, borders, focus, component heights, 120/180/250 ms
timings, and breakpoints are centralized in `src/app/theme.rocket`. Responsive
safe regions live in `src/app/layout.rocket`. Reusable presentation components
live in `src/app/components.rocket`. Procedural raylib shapes, loaded fonts,
textures, and sounds do not leak into engine APIs.

## Typography and original art

Manrope replaces the prototype bitmap face for the new display, heading, body,
label, numeric, and caption roles. The exact unmodified font and SIL OFL 1.1
notice are bundled under `assets/fonts/manrope/`; custom measurement uses the
same loaded font as drawing. Default raylib text is an explicit tested degraded
mode, not the intended presentation.

Two reviewed 1536x1024 ImageGen atlases provide a coherent original hero and
eleven distinct game covers. They are sampled as 512x512 source cells and paired
with original procedural tables, boards, controls, objects, and effects rather
than stretched over entire game screens. Exact provenance, prompts, dimensions,
hashes, and visual-review notes live in `assets/MANIFEST.md` and
`assets/ui/IMAGEGEN_PROMPTS.md`.

The replacement component system supports elevated rounded surfaces; primary,
secondary, quiet, danger, focused, hovered, and disabled buttons; procedural
icon buttons; pills and badges; toggles; section headers; toasts; theme-aware
modals; and illustrated game cards. Every game card has a distinct procedural
degraded-mode glyph if its atlas cannot load.

Keyboard focus, disabled states, hover/pressed states, readable hand totals, suit differentiation, and resolution-aware layout are required. Motion must never obscure legal actions or round state.

The implemented startup, lobby, settings, exit confirmation, Blackjack table,
and European Roulette table use the same token system. Roulette adds a readable
red/black/emerald number grid, outside-bet regions, gold keyboard focus and
chips, an original procedural wheel, engine-locked ball position, help overlay,
and result history without copying a casino-provider layout. The website
preview intentionally echoes the system without claiming browser play.

Plinko reuses the same shell and tokens with a responsive triangular peg field,
symmetrical multiplier buckets, gold balls, a compact configuration rail, and
a rules overlay. At the 800x600 minimum, the board contracts horizontally and
vertically so it remains separate from controls and settlement actions. Motion
is staged from tested engine paths and cannot alter a landing bucket.

Coop Climb uses an original observatory ladder: procedural coops climb toward a
gold telescope, with accessible completed, current, failed, and future states.
The fixed multipliers remain visible while future safe/fail values remain
hidden. At 800x600 all 10 rungs and the control rail fit without overlap.

Midnight Crossing uses an original top-down night-city board with safe medians,
charcoal roads, a rail lane, blue canals, procedural vehicles/logs, and a
checkpoint band. Integer engine positions scale into the available board area;
the minimum-size control rail remains separate. Rendering never moves hazards.

Hold'em adds an original emerald oval table, purple S2R card backs, compact
opponent seat panels, dealer/blind/all-in markers, private human cards, five
community positions, pot/split labels, recent actions, and a dedicated action
rail. At 800x600 up to five opponents, sizing, legal action buttons, help,
settlement, reset, and lobby controls remain distinct. The view receives only
the privacy-safe public table and never the shuffled deck.

Mines adds an original midnight-blue 5-by-5 grid with gold procedural gems,
charcoal hidden tiles, a restrained red mine treatment, gold keyboard focus,
and a compact probability/control rail. At 800x600 the complete grid, balance,
wager, mine count, safe count, multiplier, potential payout, history, and
settlement actions remain distinct. Unrevealed tiles share one presentation
state regardless of their committed engine value.

Dice uses an original navy signal chamber with a large gold integer readout,
exact chance/multiplier rail, green/red result history, and compact finite-auto
controls. At 800x600 the visible Stop action, help, outcomes, restart, and lobby
remain separate; the readout consumes only the engine's locked integer.

HiLo uses an original midnight prediction table with one oversized drawn card,
two clearly disabled/enabled direction actions, exact remaining outcome counts,
a prominent danger-red `EQUAL RANK = LOSS` warning, cumulative multiplier and
potential-return rail, and a newest-first visible sequence. At 800x600 future
cards never appear, help remains readable, and result animations only reveal
the card already committed by the engine.

Crash uses an original local flight-recorder layout: a midnight plotting area,
procedural point trail, oversized exact multiplier, and an emerald-to-gold-to-
danger progression driven only by public engine state. A compact control rail
keeps wager, one-round auto target, Cash Out, revealed settlement, and bounded
history distinct at 800x600. Running screens say the point is hidden and never
show users, live bets, simulated activity, or multiplayer language.

Slots uses an original brass-and-midnight mechanical cabinet with five distinct
reel columns, three symbol rows, fixed-payline traces, and engine-proven win
highlights. A compact rail keeps line bet, five-line total, Turbo, finite
autoplay, Stop, free-spin status, Bonus, round result, and bounded history
distinct at 800x600. Sequential reveal consumes only precommitted stops; Turbo
changes timing but not layout, outcome, or settlement.

The static website now applies the same tokens in a three-page experience. The
profile page pairs an editorial welcome panel with a raised local-profile card.
The Play page follows a dense premium dashboard direction with a compact sticky
header, a high-contrast catalog hero, and eleven wide rectangular game cards. Each
card contains an original inline SVG illustration assembled from simple shapes;
no casino-provider artwork, layout, or external asset is copied. The Download
page gives the verified package its own gold-accented panel and separates
integrity, installation, requirements, unsigned-build, troubleshooting, and
privacy content into readable sections. Desktop cards use a two-column grid;
phone layouts collapse to one column without horizontal overflow. Visible
focus, skip links, semantic landmarks, sufficient contrast, and reduced-motion
rules apply across all three pages.
