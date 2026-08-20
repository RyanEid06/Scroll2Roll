# Scroll2Roll

Scroll2Roll is a local, single-player, play-money Windows casino application written in Rocket 2.0. Blackjack, European Roulette, Plinko, Chicken presented as Coop Climb, Cross the Road presented as Midnight Crossing, No-Limit Texas Hold'em, Mines, Dice, HiLo, Crash, and Slots are complete behind a reusable raylib-powered casino shell.

The native application targets Windows x64. It has no accounts, deposits, withdrawals, purchases, cryptocurrency, online multiplayer, real-money wagering, or browser-playable claim. Virtual credits have no monetary value.

## Project status

The version-0.1.0 master-plan baseline remains preserved, and version 0.2.0 passed local acceptance with six complete games. All five owner-approved 0.3.0 games are complete with exact integer math, deterministic settlement, full keyboard/mouse flows, privacy-safe projections, and safe save-v1/save-v2/save-v3 migration to save-v4. The owner later rejected the native 0.3.0 visual baseline and mandated the complete shell-plus-eleven-interior overhaul in `UI_OVERHAUL.md`. Its accepted baseline passes 48/48 tests in Debug and Release. Post-art animation Groups 1-4 are now integrated across all eleven games; Group 4 has focused checks and final native Dice/HiLo evidence, while the owner explicitly waived another all-eleven build/test pass. The application includes original ImageGen covers, licensed bundled Manrope Medium, purpose-designed dark/light themes, reduced motion, tested resource ownership, branded startup, a responsive eleven-card lobby, persistent state-safe Back, exact game guides, and eleven responsive game interiors with committed-result animation. The aligned static site uses verified native captures, and the package workflow now includes and verifies all reviewed runtime artwork, fonts, notices, recursive checksums, and relocated launch. Scroll2Roll 0.3.1 “Casino Freeze” records that final repository state as a local unsigned freeze candidate. It is too large for the current static-host per-file ceiling, so distribution is pending owner approval. Exact evidence is recorded in `docs/VALIDATION.md`; fresh post-Group-4 Debug/Release acceptance and owner visual approval are not claimed. The untouched original Blackjack draft remains under `legacy/Blackjack-v1`.

Read `AGENTS.md`, `docs/MASTER_PLAN.md`, `docs/EXPANSION_PLAN.md`, and `docs/PROJECT_CONTEXT.md` before changing the project.

## Developer entry points

- `scripts/build.ps1` configures and builds the native Rocket/raylib application.
- `scripts/validate.ps1` runs the build, Rocket check, the complete test suite, and formatting checks.
- `scripts/package-windows.ps1` creates the portable Windows x64 archive.
- `scripts/test-package.ps1` extracts the archive to an ignored relocation directory and runs its headless smoke path.
- `scripts/prepare-cloudflare-site.ps1` stages an eligible validated package with the static website and rejects archives above the host limit.
- `scripts/test-website.ps1` checks required claims and Cloudflare Pages asset limits.

The scripts accept portable `-RocketRoot` and `-Rocketc` inputs; no machine-specific path is committed. See [building](docs/BUILDING.md), [testing](docs/TESTING.md), and [validation evidence](docs/VALIDATION.md).

`website/` is the static three-page profile, native-game catalog, and package-
evidence site. Its optional nickname/avatar profile is non-authenticated and
stored only in browser `localStorage`; it does not create an online account or
upload personal data. The site is not a browser implementation of the Rocket
casino.

No release has been pushed, published, deployed, or signed. Those actions require explicit owner approval.
