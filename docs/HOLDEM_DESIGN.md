# No-Limit Texas Hold'em Contract

Scroll2Roll Hold'em is a local, play-money cash table with one human and one to
five deterministic recreational AI rivals. It has no rake, house opponent,
real-money value, network play, or hidden credit creation. The documented
table-reset action restores every seat to 1,000 local play credits.

## Cards, seats, and streets

- One standard 52-card deck is shuffled by deterministic Fisher-Yates from the
  hand seed. Cards are never duplicated and future deck order is private.
- Blinds are 5/10. In a multiway hand the seats left of the dealer post small
  and big blind and action begins left of the big blind. Heads-up, the dealer
  posts the small blind, acts first preflop, and acts last after the flop.
- The engine deals two private cards per funded seat, then preflop, flop,
  turn, and river betting. One card is burned before the 3/1/1 community-card
  deals. Zero-stack seats sit out.
- A hand ends when one live player remains or after showdown. All-in players
  receive the remaining board automatically through bounded street changes.

## No-limit actions and reopening

The active seat may Check when not facing a wager; Call up to the lesser of
the amount owed and its stack; Fold when facing a wager; Bet/Raise to a legal
target; or move All-in. The minimum opening target is the 10-credit big blind.
After a full wager, the next full raise target is the current bet plus the last
full raise increment.

A smaller all-in raise is legal when it is that player's maximum target. It
requires other seats to call or fold but does not reopen raising for a seat
that already completed action. A later full raise reopens action. Every action
checks turn, stack, call amount, target bounds, minimum increment, and reopen
rights. AI progression stops after 64 steps if an invariant is ever broken.

## Best five cards and pots

The evaluator chooses the best five of five to seven cards. Categories ascend
from High Card, One Pair, Two Pair, Three of a Kind, Straight, Flush, Full
House, Four of a Kind, to Straight Flush. Category-specific tiebreak vectors
are compared lexicographically; an Ace may be low only in A-2-3-4-5.

The complete 2,598,960 five-card space is audited in tests against the
canonical counts: 1,302,540 high-card hands; 1,098,240 pairs; 123,552 two pair;
54,912 trips; 10,200 straights; 5,108 flushes; 3,744 full houses; 624 quads;
and 40 straight flushes.

Pots are built at each distinct contribution tier. Folded contributions remain
in a pot while folded seats are ineligible. Each pot is awarded independently
to its best eligible hand and ties split evenly. Odd chips move one at a time
clockwise beginning with the first winning live seat left of the dealer.
Uncontested pots settle without revealing folded private cards. No rake is
taken, so total table chips are conserved except for the explicit new-table
reset.

## Deterministic AI and privacy

AI decisions use only that seat's cards, community cards, legal actions, pot
and call size, stack pressure, street/position, and seeded variation. Preflop
uses a bounded pair/high-card/suited/connected score. Postflop uses the tested
evaluator and bounded call/raise thresholds. It is credible recreational play,
not a professional or unbeatable claim.

The presentation API exposes a privacy-safe public table. Human cards remain
visible; opponent cards are represented only by a count until showdown;
non-folded showdown cards are revealed; folded cards never are. The view does
not receive the deck or use private cards to enable actions. Dealer/blind
markers, stacks, contributions, recent actions, pot/split state, legal buttons,
and sizing bounds all come from the tested API.
