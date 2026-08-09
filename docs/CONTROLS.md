# Scroll2Roll Controls

## Global and lobby

- `Enter`: continue from startup or open Blackjack from the lobby.
- `S`: open Settings from the lobby.
- `Escape`: open the exit confirmation in the lobby; return from Settings or a ready/settled Blackjack table.
- Mouse: select lobby tiles and controls.

## Blackjack

- `Left` / `Down`: reduce the bet by 10 credits.
- `Right` / `Up`: increase the bet by 10 credits.
- `Enter`: deal from the betting phase.
- `H`: Hit.
- `S`: Stand.
- `D`: Double Down when enabled.
- `P`: Split when enabled.
- `R`: Late Surrender when enabled; restart the table after settlement.
- `N`: begin the next round after settlement.
- `B`: return to the lobby from betting or settlement.

Disabled controls indicate actions rejected by the tested Blackjack engine. Split Aces receive one card each, the dealer stands on soft 17, and Blackjack pays 3:2.

## European Roulette

- Mouse: place chips on number centers, shared edges (splits), intersections
  (corners), the street/six-line rail, basket, columns, dozens, and outside
  boxes.
- `Tab`: cycle the keyboard bet type.
- `Left` / `Right`: select a valid target for that bet type.
- `Up` / `Down`: cycle chip denominations.
- `Enter`: place the selected chip on the keyboard target.
- `S`: spin after at least one wager.
- `H`: undo the last chip placement.
- `D`: clear and refund all unspun bets.
- `R`: repeat/rebet the last settled layout when affordable.
- `N`: start the next betting round after settlement.
- `P`: open or close complete rules and payout help.
- `B` / `Escape`: return to the lobby only when no wager or spin is live.

The seeded winning pocket is locked by the engine before animation. The visual
wheel cannot reroll or alter settlement.

## Plinko

- `Left` / `Right`: choose 8-16 peg rows.
- `Tab`: cycle Low, Medium, and High risk.
- `Down` / `Up`: reduce or increase the per-ball bet by 5 credits.
- `M`: cycle a bounded batch of 1-10 balls.
- `Enter`: prepay and drop the configured batch.
- `P`: open or close the rules and return help.
- `N`: begin the next round after settlement.
- `B` / `Escape`: return to the lobby only while ready or settled.
- Mouse: use every configuration, drop, help, next-round, and lobby control.

Each animation follows a seeded path already fixed by the engine. Rows, risk,
bet, and batch size are locked during a drop. Exact multiplier and expected-
return tables are documented in `PLINKO_MATH.md`.

## Chicken / Coop Climb

- `Tab`: cycle Low, Medium, and High risk before a round.
- `Down` / `Up`: reduce or increase the wager by 5 credits.
- `Enter`: secure the pass, then advance onto the next hidden rung.
- `S`: cash out after at least one safe rung.
- `P`: open or close complete rules and probability help.
- `N`: begin the next round after cash-out or failure.
- `B` / `Escape`: return to the lobby only while ready or settled.
- Mouse: use every risk, wager, start, advance, cash-out, help, next-round, and lobby control.

The engine commits the finite 10-rung path when the wager is prepaid. Future
safe/fail values remain hidden; the original observatory UI reveals only an
attempted rung. Exact tables are documented in `COOP_CLIMB_MATH.md`.

## Cross the Road / Midnight Crossing

- Arrow keys: move one bounded grid step left, right, forward, or backward.
- Mouse direction pad: equivalent four-direction movement.
- `Down` / `Up` before a run: reduce or increase the pass by 5 credits.
- `Enter`: prepay the configured pass and start the run.
- `P`: pause the fixed-tick engine and open/close complete help.
- `S`: cash out after at least one checkpoint.
- `N`: begin the next run after failure, cash-out, or completion.
- `B` / `Escape`: return to the lobby only while ready or settled.

Forward movement reaches checkpoints; sideways/backward movement is defensive
and does not farm score. Cars/trams collide, canal lanes require logs, and logs
carry the player on engine ticks. See `MIDNIGHT_CROSSING_DESIGN.md`.

## No-Limit Texas Hold'em

- `Enter`: deal while ready; Check or Call on the human turn.
- `D`: Fold when facing a wager.
- `Left` / `Right`: decrease or increase the raise-to target by 10 credits.
- `R`: Bet/Raise to the displayed legal target; start an explicit new table
  while ready or settled.
- `H`: move All-in when legal.
- `P`: open or close complete rules, pot, privacy, and AI help.
- `N`: deal the next hand after settlement.
- `B` / `Escape`: return to the lobby only while ready or settled.
- Mouse: use Deal, sizing, Fold, Check/Call, Bet/Raise, All-in, Next, New Table,
  Help, and Lobby controls.

Blinds are 5/10. The table shows dealer/blind markers, private human cards,
hidden opponent cards, community cards, contribution-tier pots, split state,
recent actions, stacks, and disabled illegal actions. See `HOLDEM_DESIGN.md`.

## Mines

- `Down` / `Up` before a round: reduce or increase the wager by 5 credits.
- `Left` / `Right` before a round: choose 1-24 mines.
- `Enter`: start; during a round, reveal the keyboard-focused tile.
- Arrow keys during a round: move focus across the 5-by-5 board.
- Mouse: configure, start, and reveal any hidden tile directly.
- `S`: cash out after at least one safe gem.
- `P`: open or close exact probability, return, and rounding help.
- `N`: prepare the next board after cash-out or a mine.
- `R`: restart the table at a ready or settled safe boundary.
- `B` / `Escape`: return to the lobby only while ready or settled.

The complete unique layout is committed when the wager is prepaid. A 0.18-
second reveal or 0.24-second settlement animation never chooses or changes the
result. Exact combinatorial math is documented in `MINES_MATH.md`.

## Dice

- `Tab`: toggle Roll Under / Roll Over.
- `Left` / `Right`: move the exact target by 1.00 percentage point.
- `Down` / `Up`: change the wager by 5 credits.
- `M`: cycle the finite requested auto-roll count from 1-20.
- `H` / `D`: cycle the optional win/loss stop counts from 0-20.
- `Enter`: lock and settle one fast manual roll.
- `S`: start finite auto-roll; while active, stop it explicitly.
- `P`: toggle exact probability, return, and rounding help.
- `N`: ready the next roll; `R`: safe restart; `B` / `Escape`: lobby.

Results are integers from 0-9,999. Auto-roll locks one outcome before each
bounded animation and cannot continue past any configured stop. See
`DICE_MATH.md`.

## Settings

- `M`: toggle audio.
- `Left` / `Right`: change volume.
- `Down` / `Up`: change the number of AI players from zero to five.
- `B` or `Escape`: save locally and return to the lobby.
