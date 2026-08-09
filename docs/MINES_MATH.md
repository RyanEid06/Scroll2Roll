# Mines Probability and Payout Contract

Scroll2Roll Mines uses a 5-by-5 board with 25 tiles and a player-selected 1-24
mines. The engine prepays one integer-credit wager and deterministically commits
the complete unique mine layout before the first reveal. The presentation API
reports every unrevealed tile as hidden and never exposes its mine value.

For `m` mines and `r` safe reveals, the exact probability of surviving is:

`C(25 - m, r) / C(25, r)`

The play-money return factor is 9,600 basis points, or 96%. The cash-out
multiplier is recomputed from the implemented combination function:

`floor(9600 * C(25, r) / C(25 - m, r))`

Here 10,000 basis points is 1.00x. Settlement is:

`floor(wager * multiplier_basis_points / 10000)`

Both divisions use integer floor rounding. For one mine and one safe reveal,
survival is 24/25 and the multiplier is exactly 10,000 basis points (1.00x).
For 24 mines and one safe reveal, survival is 1/25 and the multiplier is
240,000 basis points (24.00x). Tests recompute every valid multiplier for all
mine counts and safe-reveal depths from the exact source combination values.

The layout uses a seeded Fisher-Yates permutation of tile indices and marks the
first `m` positions as mines. Reveal animations consume only the already
committed engine result and are bounded to 0.18 seconds for a safe gem and 0.24
seconds for settlement. A mine loses the prepaid wager. Cash-out is legal only
after at least one safe reveal, history is bounded to 20 results, and balances
cannot become negative.
