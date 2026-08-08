# Validation Evidence

This file records the complete local acceptance pass performed on Windows x64 on 2026-08-08. Generated artifacts remain ignored and are reproducible from the documented scripts.

## 0.2.0 expansion baseline

Before expansion implementation, both Debug and Release
`scripts/validate.ps1` passes completed again on 2026-08-08. Each configuration
passed the native CMake/raylib build, `rocketc check`, all 10 existing Rocket
tests, and `rocketc fmt --check` for `src` and `tests`. This is the regression
baseline for every game milestone in `EXPANSION_PLAN.md`.

## Rocket and native application

- Debug `scripts/validate.ps1`: CMake/raylib build, Rocket check, 10/10 tests, and `src`/`tests` formatting checks passed.
- Release `scripts/validate.ps1`: the same matrix passed 10/10 tests.
- The test set covers the Blackjack rules, deterministic multi-round flows, balances and bounds, persistence recovery, scripted GUI flow, and native resource/audio/asset lifetimes described in `TESTING.md`.
- `Scroll2Roll.exe --headless-smoke` exits successfully from a relocated package without the source checkout.

## Expansion milestone E1 - European Roulette

- Focused Roulette engine tests verify every required bet geometry and failure
  path, exact payouts including zero behavior, simultaneous wagers,
  table/position limits, deterministic wheel results, undo/clear/repeat/rebet,
  bounded history, and 15-round balance invariants.
- The scripted GUI test verifies keyboard and mouse chip placement, help,
  selection, undo, engine-locked animation, settlement, save-v2 persistence,
  rebet, clear, and safe lobby return.
- The complete Rocket suite passes 13/13 with all 10 original Blackjack and
  infrastructure regressions preserved.
- Debug and Release `scripts/validate.ps1` each pass the native build,
  `rocketc check`, all 13 tests, and both formatting checks after the complete
  Roulette integration.
- Source website validation passes for the updated 0.2.0 Blackjack and European
  Roulette claims. No package publication or deployment was performed.

## Expansion milestone E2 - Plinko

- `plinko_math_test.rocket` verifies every row count from 8 through 16 for all
  three risk levels: exact binomial outcome counts, symmetric multiplier
  arrays, intended risk ordering, valid configuration, payout rounding, and
  theoretical return between 95.99% and 96.00%. Every audited table is
  published in `PLINKO_MATH.md`.
- `plinko_session_test.rocket` verifies explicit-seed 50/50 paths, bucket/path
  invariants, 1-10-ball batch bounds, prepaid wagers, configuration locking,
  insufficient-balance errors, exact settlement, bounded history, and 12
  consecutive rounds without a negative balance.
- `plinko_gui_flow_test.rocket` verifies responsive lobby routing, help,
  keyboard and mouse configuration, engine-committed multi-ball animation,
  bounded settlement, save-v2 persistence, next round, safe lobby return, and
  native resource cleanup.
- The complete Rocket suite passes 16/16 with all 10 original Blackjack and
  infrastructure regressions plus all Roulette tests preserved.
- Debug and Release `scripts/validate.ps1` each pass the native build,
  `rocketc check`, all 16 tests, and both formatting checks after complete
  Plinko integration.
- Source website validation passes for the updated Blackjack, European
  Roulette, and Plinko claims. No package publication or deployment was
  performed.

## Expansion milestone E3 - Chicken / Coop Climb

- `chicken_rules_test.rocket` verifies the fixed 10-rung tables for Low 4/5,
  Medium 2/3, and High 1/2 per-step survival; every chosen cash-out depth has
  an exact theoretical return of 95.99% or 96.00%. It also verifies risk
  ordering, wager bounds, depth bounds, and floor settlement against
  `COOP_CLIMB_MATH.md`.
- `chicken_session_test.rocket` verifies deterministic hidden paths, all legal
  and illegal transitions, configuration locking, first- and final-rung
  cash-outs, first-rung failure, insufficient balance behavior, 25 consecutive
  rounds, nonnegative balances, and 20-result history bounding.
- `chicken_gui_flow_test.rocket` runs at the 800x600 minimum and verifies lobby
  routing, help, keyboard and mouse risk/wager changes, start, advance,
  cash-out/failure, save-v2 persistence, next round, lobby return, rendering,
  and native resource cleanup.
- The complete Rocket suite passes 19/19 with all 16 prior Blackjack,
  infrastructure, Roulette, and Plinko regressions preserved.
- Debug and Release `scripts/validate.ps1` each pass the native build,
  `rocketc check`, all 19 tests, and both formatting checks after complete Coop
  Climb integration.
- Source website validation passes with Coop Climb added alongside the three
  prior complete games. No package publication or deployment was performed.

## Visual Studio Community 2026

The installed Rocket Language 2.0.3 extension was exercised from this repository with `src/main.rocket` active:

- all seven Rocket commands were present; Build, Run, Test, Debug, environment validation, and options were available, while Stop became available only during an active process;
- GUI Build refreshed `.rocketc/Scroll2Roll.exe`, its PDB, and its Rocket source map;
- GUI Test refreshed all 10 test executables and returned to idle;
- GUI Run launched the native Scroll2Roll process, Stop terminated it, and no PowerShell, Windows Terminal, `cmd`, `conhost`, or external debug-console child was created;
- the Visual Studio-hosted `rocket-lsp.exe` remained attached to the repository;
- a framed LSP session analyzed 33 project files and verified qualified completion, hover, definition, two references, prepare-rename/rename edits, workspace symbols, 1,360 semantic-token integers, and a live diagnostic without protocol errors;
- an unsaved invalid edit navigated through Error List to `src/main.rocket` line 18; Undo restored clean state and the on-disk SHA-256 was unchanged;
- Go To Definition navigated a Blackjack call at `cards.rocket` line 32 to `blackjack_value` at line 19;
- Debug stopped at a Rocket source breakpoint, F11 entered `src.app.application.run`, the call stack exposed six frames, the Locals collection represented `status = 0`, and Stop returned to design mode with no game process left;
- formatting is enforced by `rocketc fmt` in both validation configurations; the frozen LSP exposes its whole-document formatter through the `source.format.rocket` code-action contract rather than Visual Studio's generic `Edit.FormatDocument` command.

## Version 0.1.0 Windows package baseline

The prior 0.1.0 acceptance run of `scripts/package-windows.ps1` created `out/package/Scroll2Roll-0.1.0-windows-x64.zip`. The archive included the executable, README, notices, version, controls, troubleshooting, and per-file checksums. It excluded source dependencies, generated bindings, compiler/build trees, `.vs`, `.rocketc`, caches, objects, PDBs, and machine paths. The updated script now targets 0.2.0; its final archive evidence will be recorded only after all five expansion games pass.

`scripts/test-package.ps1` extracts the archive into ignored `out/relocation`, scans for forbidden content, and runs the relocated headless smoke path. The final archive is 1,507,358 bytes with SHA-256 `6408d68501e02005164ff2bb016026d71b90ae6e49dfe43e2f324c0dc96d4ac7`.

No trusted code signature is claimed.

## Static website

- The source `website/` validation passes for its three files.
- The staged `out/cloudflare-site` validation passes with the release archive included.
- The script enforces Cloudflare Pages Free's 20,000-file and 25-MiB-per-asset ceilings and rejects browser-playable or real-money wording.
- No Cloudflare deployment, Git push, GitHub release, or other publication was performed.
