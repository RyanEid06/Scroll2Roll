# Crash Probability, Tick, and Settlement Contract

Scroll2Roll Crash is a local single-player game. It has no users, live bets,
multiplayer activity, network outcome source, or cash value. The engine commits
one threshold when it atomically validates and prepays a wager. The public
table hides that threshold while the round is running and reveals it only
after settlement.

## Deterministic distribution

Each round maps its seed and round number to exactly one uniform integer ticket
from 1 through 1,000,000. Tickets 1 through 40,000 produce an immediate 1.00x
crash, an exact probability of 4%. For every other ticket, define
`d = ticket - 40000`, so `d` is 1 through 960,000, and compute:

`threshold = clamp(floor(10000 * 960000 / d), 10001, 10000000)`

All values are integer basis points: 10,000 is 1.00x and 10,000,000 is the
1,000.00x cap. The complete million-ticket test proves 40,000 instant points,
640,000 thresholds at least 1.50x, 480,000 at least 2.00x, 96,000 at least
10.00x, and 960 capped outcomes.

This is a 96% reciprocal-survival play-money model. Because cash-out must be
strictly before the threshold and thresholds use integer floor rounding, the
exact return at a particular target is slightly below or equal to 96%. At
1.50x, 639,957 of 1,000,000 tickets satisfy `threshold > 1.50x`, producing an
exact gross return of 9,599 basis points after integer floor. Tests enumerate
that result directly; the UI does not state a rounded return as an exact RTP.

## Fixed simulation and ordering

The round begins at exactly 10,000 basis points. At 20 fixed engine ticks per
second, tick `t` uses:

`min(10000000, 10000 + 50*t + floor(t*t/20))`

The application requests at most eight ticks per rendered frame and drops
excess accumulated frame time. The engine independently caps a round at 20,000
ticks. Rendering, graph points, color, and audio consume engine state and never
advance or modify the threshold or multiplier.

For each tick, a configured single-round auto target settles first only when it
is above the current multiplier, strictly below the committed threshold, and
reached by the next tick. Otherwise a threshold reached by that tick crashes
the round. Manual Cash Out is processed before frame tick advancement and is
accepted only while the exact current multiplier is strictly below the hidden
threshold. An immediate 1.00x threshold settles during Start and cannot be
cashed out.

## Credits, bounds, and persistence

Wagers are 5 through 1,000 credits in units of 5. The optional auto target is
Off or 1.01x through 100.00x in 0.01x units and applies to one round only; it
never starts another wager. Settlement is
`floor(wager * multiplier_basis_points / 10000)` and balances cap at
10,000,000,000 credits. History is newest-first and capped at 20 settled
rounds. Only a settled balance is written to the shared save; no live wager,
hidden threshold, or auto action is persisted.
