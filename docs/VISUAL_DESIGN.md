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
