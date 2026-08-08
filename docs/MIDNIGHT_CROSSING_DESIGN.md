# Midnight Crossing Simulation and Payout Contract

Midnight Crossing is Scroll2Roll's original real-time Cross the Road
presentation. It is a bounded skill-and-timing game, not a predetermined ladder.
The seeded world fixes hazard positions, directions, and speeds; player movement
and timing determine collision, support, checkpoint, and cash-out outcomes.

## Fixed simulation

- The world is 900 integer units wide with eight lanes numbered 0 through 7.
- Lanes 0 and 4 are safe; lanes 1 and 2 contain cars; lane 3 contains a tram;
  lanes 5 and 6 are canals requiring moving-log support; lane 7 is a checkpoint.
- A grid input moves 100 units sideways or one lane forward/backward. Sideways
  and backward movement never awards score.
- The engine advances hazards at 20 fixed ticks per second using integer
  positions. Render time is accumulated outside the view and requests no more
  than eight engine ticks per frame; excess accumulated time is discarded.
- Cars are 70/100 units long with base speeds 6/8 units per tick. The tram is
  280 units long at 12 units per tick. Logs are 180/240 units long at 4/5 units
  per tick. Directions and initial offsets are deterministic for a seed.
- Difficulty is `min(1 + checkpoints, 4)` and multiplies hazard/log movement.
  Collision and water support are resolved by the engine after every move and
  fixed tick.

The player fails on a car/tram overlap, on entering water without log support,
or when a moving log no longer supports the player. Pause stops engine ticks and
movement. A run is finite at five checkpoints.

## Checkpoints and payout

The pass is prepaid. Reaching lane 7 awards a checkpoint, resets the player to
the safe start, increases difficulty, and exposes this cash-out value:

| Checkpoints | Multiplier basis points | Display multiplier |
| ---: | ---: | ---: |
| 0 | 10000 | 1.00x (cash-out locked) |
| 1 | 12500 | 1.25x |
| 2 | 15000 | 1.50x |
| 3 | 17500 | 1.75x |
| 4 | 20000 | 2.00x |
| 5 | 22500 | 2.25x automatic completion |

Settlement is `floor(pass * multiplier_basis_points / 10000)`. A collision or
support failure returns zero. The player may cash out after checkpoints 1-4;
checkpoint 5 settles automatically. Because timing and input determine results,
the game does not publish a chance-only theoretical return. Credits are local
play money with no monetary value.
