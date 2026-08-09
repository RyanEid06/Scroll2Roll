# Slots Reel, Feature, and Return Contract

Scroll2Roll Slots is a local, single-player, five-reel, three-row game. It uses
five fixed paylines, integer-credit settlement, deterministic precommitment,
and no browser, account, real-money, or multiplayer behavior.

## Symbols and reel strips

Symbol identifiers are Pebble `0`, Quill `1`, Lantern `2`, Compass `3`, Scroll
`4`, Wild Sigil `5`, Scatter Moon `6`, and Bonus Gear `7`. Every reel has 20
stops with frequencies `5, 5, 3, 2, 2, 1, 1, 1` in that order. The exact strips
are:

```text
R1  0 1 2 0 3 1 4 0 2 1 5 0 3 1 6 2 0 4 1 7
R2  1 0 3 1 2 0 4 1 0 2 6 1 3 0 5 1 4 0 2 7
R3  2 1 0 4 1 0 2 3 1 0 7 1 4 0 2 1 5 0 3 6
R4  0 2 1 3 0 1 4 2 0 1 6 3 1 0 5 2 1 4 0 7
R5  1 3 0 2 1 4 0 1 2 0 5 1 3 0 6 2 1 4 0 7
```

A stop supplies its symbol to the top row, followed by the next two wrapping
strip positions in the middle and bottom rows. The five fixed row paths are
top `0-0-0-0-0`, middle `1-1-1-1-1`, bottom `2-2-2-2-2`, V
`0-1-2-1-0`, and inverse V `2-1-0-1-2`.

## Line awards

The table contains line-bet multipliers for three, four, and five consecutive
matching symbols from the leftmost reel:

| Symbol | 3 | 4 | 5 |
| --- | ---: | ---: | ---: |
| Pebble | 3x | 9x | 24x |
| Quill | 6x | 15x | 36x |
| Lantern | 9x | 24x | 60x |
| Compass | 12x | 36x | 105x |
| Scroll | 18x | 60x | 180x |
| Wild Sigil | 24x | 90x | 300x |

Wild Sigil substitutes for Pebble through Scroll. A line is evaluated against
every legal substituted symbol and receives only the highest one-line award;
an all-Wild line uses the Wild table. Scatter Moon and Bonus Gear do not form
line wins. Every winning fixed line is added, including simultaneous lines.

## Scatters, free spins, and bonus

Scatter Moon pays anywhere using the total five-line bet: three, four, and five
Scatters pay `2x`, `10x`, and `40x` and award two, three, and five free spins.
Free spins do not retrigger. Every line, Scatter, and Bonus award during a free
spin is multiplied by the fixed `2x` free-spin multiplier.

Three or more Bonus Gears trigger one precommitted, uniformly selected ticket.
Tickets `0-3` pay `1x`, `2x`, `4x`, or `6x` the total bet. The ticket and all
five reel stops are committed before presentation begins; Turbo changes only
reel-reveal timing.

## Exact theoretical return

The wager is 1-20 credits per line across all five lines, so one paid spin costs
5-100 credits. The source recomputation uses all `20^5` stop combinations and
all four equally likely bonus tickets:

```text
D = 20^5 * 4 = 12,800,000
B = 55,281,870          base-spin payout numerator at line bet 1
F = 711,720             awarded-free-spin numerator
```

`B / D` is the expected base-spin payout in credits at a five-credit total bet.
`F / D` is the expected number of awarded, non-retriggering free spins. Each
free spin has the same outcome distribution and a fixed 2x award multiplier.
Therefore:

```text
RTP = (B / D) * (1 + 2F / D) / 5
    = 0.959836866495...
    = 95.9836866495...%
```

The displayed two-decimal return is the integer floor `9598` basis points, or
`95.98%`; it is not rounded upward. `slots_rules_test.rocket` recomputes the
reel frequencies, weighted line awards, feature masks, exact numerators,
denominator, and basis-point floor from the production source.

## Lifecycle and bounds

A paid spin is prepaid atomically. Configuration is locked while committed
reels or free spins are being presented. Free spins complete before the paid
round is persisted. Finite autoplay explicitly requests 1-10 paid rounds,
commits only one outcome at a time, exposes Stop between outcomes, and ends at
the count, an explicit stop, or insufficient credits. History is capped at 20
paid rounds, balance at 10,000,000,000 credits, and all invalid or unaffordable
requests leave state unchanged.
