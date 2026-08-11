# Scroll2Roll

Scroll2Roll is a local, single-player, play-money Windows casino application written in Rocket 2.0. Blackjack, European Roulette, Plinko, Chicken presented as Coop Climb, Cross the Road presented as Midnight Crossing, No-Limit Texas Hold'em, Mines, Dice, HiLo, Crash, and Slots are complete behind a reusable raylib-powered casino shell.

The native application targets Windows x64. It has no accounts, deposits, withdrawals, purchases, cryptocurrency, online multiplayer, real-money wagering, or browser-playable claim. Virtual credits have no monetary value.

## Project status

The version-0.1.0 master-plan baseline remains preserved, and version 0.2.0 passed local acceptance with six complete games. All five owner-approved 0.3.0 games are complete with exact integer math, deterministic settlement, full keyboard/mouse flows, privacy-safe projections, and save-v1/save-v2 migration to save-v3. The owner later rejected the native 0.3.0 visual presentation and mandated a full shell-plus-eleven-interior overhaul in `UI_OVERHAUL.md`. The foundation, asset/component, responsive shell, and first four interior milestones now pass 46/46 tests in Debug and Release. The accepted native presentation includes original ImageGen art, licensed bundled Manrope Medium, save-v4 theme/reduced-motion migration, tested resource ownership, branded startup, responsive eleven-card lobby, persistent state-safe Back, exact game guides, and complete responsive Blackjack, European Roulette, No-Limit Hold'em, and HiLo interiors. The remaining seven legacy interiors remain visually unaccepted until their replacement milestones finish. Exact evidence is recorded in `docs/VALIDATION.md`. The untouched original Blackjack draft remains under `legacy/Blackjack-v1`.

Read `AGENTS.md`, `docs/MASTER_PLAN.md`, `docs/EXPANSION_PLAN.md`, and `docs/PROJECT_CONTEXT.md` before changing the project.

## Developer entry points

- `scripts/build.ps1` configures and builds the native Rocket/raylib application.
- `scripts/validate.ps1` runs the build, Rocket check, the complete test suite, and formatting checks.
- `scripts/package-windows.ps1` creates the portable Windows x64 archive.
- `scripts/test-package.ps1` extracts the archive to an ignored relocation directory and runs its headless smoke path.
- `scripts/prepare-cloudflare-site.ps1` stages the validated package with the static website.
- `scripts/test-website.ps1` checks required claims and Cloudflare Pages asset limits.

The scripts accept portable `-RocketRoot` and `-Rocketc` inputs; no machine-specific path is committed. See [building](docs/BUILDING.md), [testing](docs/TESTING.md), and [validation evidence](docs/VALIDATION.md).

`website/` is the static three-page profile, native-game catalog, and verified
download site. Its optional nickname/avatar profile is non-authenticated and
stored only in browser `localStorage`; it does not create an online account or
upload personal data. The site is not a browser implementation of the Rocket
casino.

No release has been pushed, published, deployed, or signed. Those actions require explicit owner approval.
