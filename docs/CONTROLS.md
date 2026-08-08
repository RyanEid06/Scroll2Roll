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

## Settings

- `M`: toggle audio.
- `Left` / `Right`: change volume.
- `Down` / `Up`: change the number of AI players from zero to five.
- `B` or `Escape`: save locally and return to the lobby.
