# Scroll2Roll Project Context and Chat Handoff

Read this file and `MASTER_PLAN.md` completely at the start of every Scroll2Roll chat. Update this file after every meaningful milestone; never describe unverified functionality as complete.

## Project identity

- Product: Scroll2Roll
- Repository: `https://github.com/RyanEid06/Scroll2Roll.git`
- Local workspace: `C:\Users\Administrator\Desktop\Projects\Scroll2Roll`
- Application: downloadable Windows desktop casino
- Language: frozen Rocket 2.0
- Graphics/input/audio: Rocket's reviewed raylib 6.0 integration
- Target: Windows x64
- IDE: Visual Studio Community 2026 with Rocket Language 2.0.3
- Current version: 0.1.0

## Product vision and completed scope

Scroll2Roll is a polished, local, single-player, play-money casino shell that can add owner-approved games one at a time. Version 0.1.0 completes Blackjack first with a branded startup experience, reusable lobby and settings, deterministic headless engine tests, a native raylib table, versioned local persistence, portable Windows packaging, and a prepared Cloudflare product/download website.

All 13 implementation and validation milestones in `MASTER_PLAN.md` are complete locally. No push, release publication, Cloudflare deployment, or signing was performed.

## Explicit non-goals

- No real-money gambling or monetary value.
- No accounts, payments, purchases, deposits, withdrawals, or cryptocurrency.
- No online multiplayer or gambling service.
- No browser implementation of the Rocket casino.
- No Rocket syntax, compiler, runtime ABI, LSP, diagnostic, package, CodeView/PDB, source-map, or Phase 19 changes.
- No additional casino game implementation before future owner direction.
- No push, publication, deployment, or unsupported signing claim without owner approval.

## Rocket and raylib constraints

Rocket 2.0 remains frozen and the original Rocket repository remains untouched by casino implementation. Scroll2Roll adapts to four-space indentation, single-line call/signature/expression syntax, explicit `Result` failures, deterministic package layout, the Windows x64 C ABI, and the reviewed primitive-only raylib adapter. Casino behavior stays in Rocket. Native C++ is restricted to primitive raylib adaptation and validated resource tokens. The configurable Rocket checkout supplies pinned MSVC, Ninja, LLVM/Clang 22.1.6, and raylib 6.0; Scroll2Roll does not download a second raylib copy.

## Implemented functionality

- The authoritative master plan is preserved byte-for-byte as `docs/MASTER_PLAN.md`.
- The untouched original failing draft is preserved under `legacy/Blackjack-v1`.
- A modular rendering-independent Blackjack engine implements checked cards, exact hand values, a deterministic six-deck shoe, cut-card reshuffling, table limits, player/AI betting, legal actions, Hit, Stand, Double Down, Split, Double After Split, a four-hand maximum, split-Ace one-card behavior, no standard resplit, Late Surrender, dealer stand on soft 17, naturals, exact 3:2 settlement, and deterministic AI/basic-strategy progression.
- Complete and consecutive rounds have bounded transitions and nonnegative play-money balances.
- A small `src/blackjack/api.rocket` facade is the only rules boundary used by the visual table.
- The raylib application implements startup, reusable lobby routing, settings, exit confirmation, keyboard/mouse controls, honest Roulette/Poker future placeholders, zero-to-five AI players, dealer and split-hand presentation, hidden/revealed hole card, disabled illegal actions, outcomes, next round, restart, and lobby return.
- Versioned local persistence stores display/audio preferences, AI count, first-run state, and approved play-money progress at `%LOCALAPPDATA%\Scroll2Roll\settings.s2r`, with safe missing/invalid/older-data recovery.
- The static website and Cloudflare Pages staging flow are implemented without claiming browser play.
- Release packaging includes the native executable, version, notices, controls, troubleshooting, and checksums, and passes relocated headless smoke validation.

## Architecture

Dependency direction is one way:

1. Shared Blackjack model values.
2. Cards/hand evaluation, rules, shoe, settlement, and strategy.
3. The engine state machine and presentation-facing API.
4. Versioned local persistence isolated from rules.
5. Reusable router, design tokens, components, lobby, settings, and Blackjack view.
6. The safe Rocket raylib wrapper over a primitive C++ adapter.

Rendering never owns Blackjack rules. The C++ adapter never owns application or casino state. Deterministic headless tests do not require a real window or audio device.

## Verified evidence

- The Rocket repository was clean on `master` at `cbf7b1a` before Scroll2Roll changes, and no casino file was placed there.
- The source master plan and `docs/MASTER_PLAN.md` both have SHA-256 `48D1E92041299ED413FA6947E4342783B29B142041D1A445C049EA259D50C4C9`.
- The preserved original `legacy/Blackjack-v1/src/blackjack.rocket` has SHA-256 `11D7291C9F222C77BCCC5A7AF8C457F0083FC6BE42DB3CA6458B80B5C3FAB5CC` and still reproduces its original Rocket parser failure.
- Debug and Release validation each pass build/check, 10/10 Rocket tests, and formatting checks.
- Visual Studio GUI Build/Run/Test/Stop/Debug, Error List navigation, Go To Definition, source breakpoints, stepping, six-frame call stack, one represented scalar local, clean stop, and terminal-free processes were verified from this repository.
- A framed Scroll2Roll LSP session verified project discovery, completion, hover, definition, references, rename, symbols, semantic tokens, and live diagnostics without protocol errors.
- The portable package passes forbidden-content scanning and a relocated `--headless-smoke` launch outside the source checkout.
- The final `Scroll2Roll-0.1.0-windows-x64.zip` is 1,507,358 bytes with SHA-256 `6408d68501e02005164ff2bb016026d71b90ae6e49dfe43e2f324c0dc96d4ac7`.
- Source and staged website validation pass current Cloudflare Pages Free file-count and per-asset limits.
- Detailed evidence and exact commands are in `docs/VALIDATION.md`.

## Deliberate limitations

- Version 0.1.0 is unsigned. Windows may show an unknown-publisher warning; trusted code signing is not claimed.
- The game is local-only and play-money-only. Credits are not transferable and have no cash value.
- Roulette and Poker are noninteractive future placeholders, not implemented games.
- The packaged application uses procedural UI art and a short generated tone; it does not ship a screenshot-baseline suite or external art/audio catalog.
- The frozen Rocket debugger represented the scalar `status` local during acceptance; managed locals such as the argument array may display as unavailable in the native debugger.
- The frozen LSP's formatter is exposed through its `source.format.rocket` code-action contract and the reproducible `rocketc fmt` workflow; Visual Studio's generic `Edit.FormatDocument` command is not advertised for Rocket documents.
- No public release, Cloudflare site, remote download, external production user, or certificate signature is claimed.

## Visual design tokens

- Background: `#080B14`
- Panel: `#111827`
- Primary/gold: `#F5C542`
- Secondary/emerald: `#10B981`
- Danger/red: `#EF4444`
- Primary text: `#F3F4F6`
- Muted text: `#9CA3AF`
- Border: `#293241`

Spacing, typography, component states, borders, timing, and responsive layout values are centralized in `src/app/theme.rocket`.

## Milestones

- Completed: repository foundation and original-draft preservation.
- Completed: Rocket 2.0 repair, modular Blackjack engine, focused tests, and deterministic round flows.
- Completed: reviewed raylib integration, reusable shell, full visual Blackjack, settings, and local persistence.
- Completed: Visual Studio Community 2026 repository acceptance.
- Completed: Windows packaging, relocated smoke validation, static website, and Cloudflare Pages preparation.
- Current: final local commits and owner review.
- Next: only with explicit owner approval, push the local commits and publish/deploy the prepared release/site. Later games require separate owner direction.

## Major decisions

- Preserve the draft under `legacy/Blackjack-v1` so the repaired implementation never destroys historical evidence.
- Use integer credits and even bet units so Blackjack 3:2 payouts remain exact.
- Keep the casino economy local and deliberately small; persistence contains only versioned preferences, first-run state, AI count, and play-money progress.
- Keep rendering dependent on the tested Blackjack API instead of duplicating game rules.
- Keep the native adapter narrow and reusable; new UI operations were added only when demonstrated necessary.
- Keep the Cloudflare site static and separate from native application behavior. The current archive fits Pages Free's verified 25 MiB per-asset limit.

## Files that must remain out of Git

Generated bindings, `.rocketc`, `out`, `build`, `.vs`, Visual Studio experimental state, downloaded dependencies, compiler/toolchain trees, native objects, executables, DLLs, libraries, PDBs, packages, caches, local configuration, and real user save data.

## New-chat handoff

Read `AGENTS.md`, `docs/MASTER_PLAN.md`, and this file completely. Inspect Git status and preserve user changes. The complete 0.1.0 implementation is locally validated; continue only from **Milestones**. Use frozen Rocket 2.0 and the pinned raylib integration, rerun proportionate validation for changes, update this handoff, make logical local commits, and do not push, publish, deploy, sign, or start another game without explicit owner approval.
