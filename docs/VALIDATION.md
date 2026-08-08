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

## Windows package

`scripts/package-windows.ps1` builds the Release configuration and creates `out/package/Scroll2Roll-0.1.0-windows-x64.zip`. The archive includes the executable, README, notices, version, controls, troubleshooting, and per-file checksums. It excludes source dependencies, generated bindings, compiler/build trees, `.vs`, `.rocketc`, caches, objects, PDBs, and machine paths.

`scripts/test-package.ps1` extracts the archive into ignored `out/relocation`, scans for forbidden content, and runs the relocated headless smoke path. The final archive is 1,507,358 bytes with SHA-256 `6408d68501e02005164ff2bb016026d71b90ae6e49dfe43e2f324c0dc96d4ac7`.

No trusted code signature is claimed.

## Static website

- The source `website/` validation passes for its three files.
- The staged `out/cloudflare-site` validation passes with the release archive included.
- The script enforces Cloudflare Pages Free's 20,000-file and 25-MiB-per-asset ceilings and rejects browser-playable or real-money wording.
- No Cloudflare deployment, Git push, GitHub release, or other publication was performed.
