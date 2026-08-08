# Visual Design

Scroll2Roll uses a premium, modern, dark, original casino treatment with accessible contrast, clear hierarchy, and restrained motion.

## Color tokens

| Token | Value | Use |
| --- | --- | --- |
| `COLOR_BACKGROUND` | `#080B14` | Application backdrop |
| `COLOR_PANEL` | `#111827` | Cards, panels, modal surfaces |
| `COLOR_GOLD` | `#F5C542` | Primary action and brand accent |
| `COLOR_EMERALD` | `#10B981` | Positive state and secondary action |
| `COLOR_DANGER` | `#EF4444` | Destructive action and loss state |
| `COLOR_TEXT` | `#F3F4F6` | Primary text |
| `COLOR_MUTED` | `#9CA3AF` | Supporting text |
| `COLOR_BORDER` | `#293241` | Dividers and outlines |

Spacing, font sizes, radii, borders, button states, timing, and responsive breakpoints are centralized in `src/app/theme.rocket`. Reusable panels, buttons, cards, labels, and modals live in `src/app/components.rocket`. Procedural raylib shapes and text are replaceable presentation assets; they do not leak into engine APIs.

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
