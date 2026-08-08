# Coop Climb Probability and Payout Audit

Coop Climb is Scroll2Roll's original turn-based Chicken presentation. A round
contains 10 finite rungs. The engine commits a hidden deterministic safe/fail
path when the wager is prepaid; the view reveals only the rung the player has
chosen to advance onto. Completed, current, and future rungs are visually
distinct, and future safety is never shown.

The risk profiles use these independent per-rung survival ratios:

| Risk | Per-rung survival |
| --- | ---: |
| Low | 4/5 (80%) |
| Medium | 2/3 (66.67%) |
| High | 1/2 (50%) |

At cash-out depth `d`, cumulative survival is `(numerator / denominator)^d`.
The fixed multiplier in basis points is:

`floor(9600 / cumulative_survival)`

Here `10000` basis points is 1.00x and 9600 represents the 96% target return.
Settlement is `floor(stake * multiplier_basis_points / 10000)`. Because every
fixed multiplier is floored, the exact theoretical return at a chosen depth is
95.99% or 96.00%; it never exceeds the published target.

| Depth | Low multiplier BP | Low return BP | Medium multiplier BP | Medium return BP | High multiplier BP | High return BP |
| ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| 1 | 12000 | 9600 | 14400 | 9600 | 19200 | 9600 |
| 2 | 15000 | 9600 | 21600 | 9600 | 38400 | 9600 |
| 3 | 18750 | 9600 | 32400 | 9600 | 76800 | 9600 |
| 4 | 23437 | 9599 | 48600 | 9600 | 153600 | 9600 |
| 5 | 29296 | 9599 | 72900 | 9600 | 307200 | 9600 |
| 6 | 36621 | 9599 | 109350 | 9600 | 614400 | 9600 |
| 7 | 45776 | 9599 | 164025 | 9600 | 1228800 | 9600 |
| 8 | 57220 | 9599 | 246037 | 9599 | 2457600 | 9600 |
| 9 | 71525 | 9599 | 369056 | 9599 | 4915200 | 9600 |
| 10 | 89406 | 9599 | 553584 | 9599 | 9830400 | 9600 |

A failed advance returns zero. A successful advance does not settle until the
player chooses Cash Out. At the tenth safe rung, further advance is illegal and
Cash Out remains available. Credits are local play money with no monetary
value, and short-session results are not guaranteed by theoretical return.
