# Troubleshooting

## The application does not start

Scroll2Roll version 0.2.0 targets Windows x64. Extract the complete ZIP to a writable local folder, then run `Scroll2Roll.exe`. Do not run the executable from inside the ZIP.

If Windows displays an unknown-publisher warning, that is expected for this local unsigned build. Scroll2Roll does not claim trusted code signing. Verify the files against `SHA256SUMS.txt` before running.

## Audio is unavailable

The game continues silently if Windows cannot open an audio device. Audio can be disabled or adjusted in Settings.

## Settings are damaged or need resetting

Version 2 stores only local, non-sensitive settings and play-money progress in `%LOCALAPPDATA%\Scroll2Roll\settings.s2r`. Valid version-1 data is migrated automatically. Delete that file while Scroll2Roll is closed to restore defaults. Missing, unsupported, or invalid data is recovered safely.

## Controls appear disabled

The engine enables only legal actions for the active hand. Double Down requires enough remaining credits; Split requires an equal-rank pair and respects the four-hand limit; Surrender is available only as the first action on an unsplit two-card hand.

Roulette disables Spin until a bet is placed, Repeat/Rebet until a settled
layout exists, and lobby return while a wager or spin is live. Use Undo or Clear
before leaving an unspun layout.

Plinko disables configuration during a live drop and disables Drop when the
complete prepaid batch exceeds the available balance. Wait for the bounded
animation to settle, then choose Next or return to the lobby. A batch contains
at most 10 balls and cannot run indefinitely.

Coop Climb locks risk and wager after the pass is secured. Cash Out is disabled
until one rung is safe, and lobby return is disabled while a round is active.
Choose Advance to reveal the next hidden rung or Cash Out with `S`; after a
failure or cash-out, choose Next or Lobby.

Midnight Crossing is real-time only while a run is active and unpaused. Use `P`
to pause safely. Cars and the tram fail on contact; blue canal lanes require a
timber log beneath the player, and moving logs carry the player. Cash Out stays
disabled until the first checkpoint. The fixed-tick guard caps long frames at
eight simulation steps instead of allowing an unbounded catch-up loop.

Hold'em enables actions only for the human turn. Check and Fold are mutually
exclusive; a raise-to target must meet the displayed minimum unless it is the
player's shorter all-in maximum. A short all-in can require another Call but
does not reopen Raise for a player who already acted. Opponent cards remain
hidden until a non-folded showdown, and folded cards are never exposed. If the
human cannot cover the 10-credit big blind, choose New Table to explicitly
restore every seat to the documented 1,000-credit play-money stack.

## Reporting a problem

Record the version, the exact action sequence, and whether the problem occurs in the portable package or a development build. Never attach personal or sensitive data; Scroll2Roll does not need any.
