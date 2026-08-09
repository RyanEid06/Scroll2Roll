# HiLo Probability and Payout Contract

Scroll2Roll HiLo uses the checked standard 52-card deck shared with Hold'em.
Ranks are ordered `2 < 3 < ... < K < A`; suits never break a rank tie. The deck
is shuffled with deterministic Fisher-Yates exactly once when a new round's
wager is prepaid. One card is exposed, every future card remains private, and
the deck is not reshuffled during the round.

Before each prediction, the engine counts the actual remaining cards as lower,
higher, or equal to the visible rank. If `n` cards remain and `w` satisfy the
chosen Higher or Lower relation, the action is legal only when `w > 0`. Equal
rank is excluded from both winning counts and is always a loss.

The cumulative multiplier starts at 10,000 basis points. After a correct step:

`next = floor(previous * 9600 * n / (w * 10000))` basis points.

The potential return is `floor(wager * next / 10000)` credits. Every division
uses integer floor rounding, so engine, tests, help, and table labels agree.
The 9,600-basis-point factor applies a 96% play-money return factor at each
accepted prediction. To keep integer state and local saves bounded, cumulative
multiplier display is capped at 100,000,000,000 basis points and any single
payout or persisted balance is capped at 10,000,000,000 play credits.

The wager is prepaid atomically. A wrong prediction or equal rank pays zero. A
correct prediction advances the visible sequence and permits Cash Out. If all
51 future cards are predicted correctly, deck exhaustion settles the current
potential payout automatically. Next creates a ready boundary; the following
Deal performs the next shuffle. Round and visible-sequence histories are
bounded in presentation, and public table state contains only cards already
drawn.
