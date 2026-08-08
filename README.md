# Scroll2Roll

Scroll2Roll is a local, single-player, play-money Windows casino application written in Rocket 2.0. Blackjack is its first complete game, built behind a reusable raylib-powered casino shell for later owner-directed games.

The native application targets Windows x64. It has no accounts, deposits, withdrawals, purchases, cryptocurrency, online multiplayer, real-money wagering, or browser-playable claim. Virtual credits have no monetary value.

## Project status

The complete version-0.1.0 master-plan implementation is present and locally validated. It includes the modular Blackjack engine, deterministic tests, raylib desktop UI, reusable casino shell, versioned local persistence, Windows packaging workflow, and prepared static product/download website. The untouched original Blackjack draft remains preserved under `legacy/Blackjack-v1`; its initial Rocket 2.0 compiler failure is recorded in [project context](docs/PROJECT_CONTEXT.md).

Read `AGENTS.md`, `docs/MASTER_PLAN.md`, and `docs/PROJECT_CONTEXT.md` before changing the project.

## Developer entry points

- `scripts/build.ps1` configures and builds the native Rocket/raylib application.
- `scripts/validate.ps1` runs the build, Rocket check, all 10 tests, and formatting checks.
- `scripts/package-windows.ps1` creates the portable Windows x64 archive.
- `scripts/test-package.ps1` extracts the archive to an ignored relocation directory and runs its headless smoke path.
- `scripts/prepare-cloudflare-site.ps1` stages the validated package with the static website.
- `scripts/test-website.ps1` checks required claims and Cloudflare Pages asset limits.

The scripts accept portable `-RocketRoot` and `-Rocketc` inputs; no machine-specific path is committed. See [building](docs/BUILDING.md), [testing](docs/TESTING.md), and [validation evidence](docs/VALIDATION.md).

`website/` is the static product/download site. It is not a browser implementation of the Rocket casino.

No release has been pushed, published, deployed, or signed. Those actions require explicit owner approval.
