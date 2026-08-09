# Dice Probability and Payout Contract

Scroll2Roll Dice draws one deterministic integer in the exact domain 0 through
9,999. A target is valid from 1 through 9,999. Roll Under wins when
`roll < target`, so it has `target` winning outcomes. Roll Over wins when
`roll >= target`, so it has `10000 - target` winning outcomes. No floating-
point comparison participates in probability, result, or settlement.

For `w` winning outcomes, the 96% play-money return multiplier is:

`floor(9600 * 10000 / w)` basis points.

Settlement is `floor(wager * multiplier_basis_points / 10000)`. Both divisions
use integer floor rounding. Tests exhaust all 9,999 targets in both directions,
including the exact boundary result for each comparison.

Manual rolls settle immediately and remain available after Next. Optional
auto-roll is explicitly enabled for 1-20 results. The engine commits and
settles one result per bounded step; the presentation never rerolls it. A
visible Stop action is available between steps. The batch also stops on its
requested count, insufficient credits, or configured 0-20 win/loss limits,
where zero disables that condition. History is bounded to 20 results and every
wager is prepaid atomically.
