# Scroll2Roll

Scroll2Roll is a local, single-player, play-money Windows casino application written in Rocket 2.0. Blackjack is its first complete game, built behind a reusable raylib-powered casino shell for later owner-directed games.

The native application targets Windows x64. It has no accounts, deposits, withdrawals, purchases, cryptocurrency, online multiplayer, real-money wagering, or browser-playable claim. Virtual credits have no monetary value.

## Project status

Implementation is being executed against the authoritative [master plan](docs/MASTER_PLAN.md). The untouched original Blackjack draft is preserved under `legacy/Blackjack-v1`; its initial Rocket 2.0 compiler failure is recorded in [project context](docs/PROJECT_CONTEXT.md).

Read `AGENTS.md`, `docs/MASTER_PLAN.md`, and `docs/PROJECT_CONTEXT.md` before changing the project.

## Planned developer entry points

- `rocketc check .`, `rocketc build .`, and `rocketc test .` validate the Rocket package.
- CMake accepts configurable `ROCKET_ROOT` and `ROCKETC` inputs for the pinned raylib integration.
- Repository scripts will provide repeatable validation, packaging, and relocation checks.
- `website/` will contain the static Cloudflare product and download site; it is not the casino implementation.

No release has been published and no code-signing claim is made.

