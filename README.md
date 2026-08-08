# Scroll2Roll

Scroll2Roll is a local, single-player, play-money Windows casino application written in Rocket 2.0. Blackjack, European Roulette, Plinko, Chicken presented as Coop Climb, Cross the Road presented as Midnight Crossing, and No-Limit Texas Hold'em are complete behind a reusable raylib-powered casino shell.

The native application targets Windows x64. It has no accounts, deposits, withdrawals, purchases, cryptocurrency, online multiplayer, real-money wagering, or browser-playable claim. Virtual credits have no monetary value.

## Project status

The version-0.1.0 master-plan baseline remains preserved. Version 0.2.0 is in local acceptance: all six games are fully playable with deterministic settlement, keyboard/mouse flows, privacy-safe Hold'em opponents, and save-v1 migration to save-v2. The current 26-test suite passes, including every original Blackjack regression. The untouched original Blackjack draft remains under `legacy/Blackjack-v1`.

Read `AGENTS.md`, `docs/MASTER_PLAN.md`, `docs/EXPANSION_PLAN.md`, and `docs/PROJECT_CONTEXT.md` before changing the project.

## Developer entry points

- `scripts/build.ps1` configures and builds the native Rocket/raylib application.
- `scripts/validate.ps1` runs the build, Rocket check, the complete test suite, and formatting checks.
- `scripts/package-windows.ps1` creates the portable Windows x64 archive.
- `scripts/test-package.ps1` extracts the archive to an ignored relocation directory and runs its headless smoke path.
- `scripts/prepare-cloudflare-site.ps1` stages the validated package with the static website.
- `scripts/test-website.ps1` checks required claims and Cloudflare Pages asset limits.

The scripts accept portable `-RocketRoot` and `-Rocketc` inputs; no machine-specific path is committed. See [building](docs/BUILDING.md), [testing](docs/TESTING.md), and [validation evidence](docs/VALIDATION.md).

`website/` is the static product/download site. It is not a browser implementation of the Rocket casino.

No release has been pushed, published, deployed, or signed. Those actions require explicit owner approval.
