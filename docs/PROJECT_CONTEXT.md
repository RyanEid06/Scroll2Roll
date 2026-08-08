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

## Product vision and current scope

Scroll2Roll will provide a polished reusable casino shell and add games one at a time. Version 1 completes Blackjack first, with a branded startup experience, lobby, settings, local play-money presentation, reusable controls, deterministic engine tests, native packaging, and a Cloudflare-hosted product/download website.

Current scope is execution of the complete first-release master plan. The current milestone is repository foundation and preservation of the original draft.

## Explicit non-goals

- No real-money gambling or monetary value.
- No accounts, payments, purchases, deposits, withdrawals, or cryptocurrency.
- No online multiplayer or gambling service.
- No browser implementation of the Rocket casino.
- No Rocket syntax, compiler, runtime ABI, LSP, diagnostic, package, CodeView/PDB, source-map, or Phase 19 changes.
- No additional unfinished casino games before Blackjack is complete.
- No push, publication, deployment, or unsupported signing claim without owner approval.

## Rocket and raylib constraints

Rocket 2.0 is frozen. Scroll2Roll adapts to its four-space indentation, single-line call/signature/expression syntax, explicit `Result` failures, deterministic package layout, Windows x64 C ABI, and reviewed primitive-only raylib adapter. Casino behavior remains in Rocket. Native C++ code is restricted to primitive policy/ABI adaptation and resource-token validation. The pinned Rocket checkout supplies MSVC, Ninja, LLVM/Clang 22.1.6, and raylib 6.0; no arbitrary raylib download is permitted.

## Hosting decision

The Rocket application is a portable native Windows executable. Cloudflare will host a small static product/download website, screenshots, documentation, and release links. The site must never imply that the native application runs in a browser. Release-file placement will be chosen only after checking current Cloudflare free-tier asset limits.

## Architecture

The planned dependency direction is:

1. Rules-free shared model values and small module APIs.
2. Cards, hand evaluation, shoe, rules, betting, legal actions, turns, dealer, settlement, and strategy modules.
3. A presentation-facing Blackjack game API that owns state transitions.
4. Local settings/persistence isolated from game rules.
5. A reusable application router, design tokens, components, lobby, and Blackjack screen.
6. The safe Rocket raylib wrapper over a primitive-only C++ adapter.

Rendering never owns Blackjack rules, and deterministic headless tests do not require raylib.

## Implemented functionality

- Empty GitHub repository cloned into the required isolated sibling workspace.
- Authoritative master plan copied byte-for-byte to `docs/MASTER_PLAN.md`.
- Untouched original draft copied to `legacy/Blackjack-v1` without moving or changing the Rocket-repository source.
- Permanent documentation and repository policy established.

No Blackjack feature is currently claimed complete.

## Verified evidence

- Rocket repository was clean on `master` at `cbf7b1a` before Scroll2Roll changes.
- Scroll2Roll remote clone reported an empty repository and created local `main` with no commits.
- `docs/MASTER_PLAN.md` and the source plan both have SHA-256 `48D1E92041299ED413FA6947E4342783B29B142041D1A445C049EA259D50C4C9`.
- The untouched draft reproduces Rocket parser diagnostics; `rocketc test` reports `0 passed; 1 failed` because the package does not compile.

## Known limitations

- The active repaired engine, comprehensive test suite, raylib UI, persistence, packaging, website, and Visual Studio project validation are not implemented yet.
- The original draft is monolithic, uses invalid multiline Rocket syntax, contains corrupted README tree characters, and has a test helper that hides invalid card construction.

## Visual design tokens

- Background: `#080B14`
- Panel: `#111827`
- Primary/gold: `#F5C542`
- Secondary/emerald: `#10B981`
- Danger/red: `#EF4444`
- Primary text: `#F3F4F6`
- Muted text: `#9CA3AF`
- Border: `#293241`

Spacing, typography, component states, borders, animation timing, and responsive layout values will be centralized in named tokens.

## Milestones

- Completed: authoritative discovery, repository separation, clone, original-draft preservation, initial failure reproduction, master-plan preservation.
- Current: finish repository foundation and commit recoverable baseline history.
- Next: import the reviewed raylib scaffold, repair and modularize the headless Blackjack engine, then add comprehensive deterministic tests.

## Major decisions

- Preserve the draft under `legacy/Blackjack-v1` so repairs can proceed without losing original evidence.
- Use integer credits and even bet units so Blackjack 3:2 payouts remain exact.
- Keep the casino economy local and deliberately small; persistence will store only versioned settings and approved play-money progress.
- Keep the Cloudflare site static and separate from native Rocket application behavior.

## Files that must remain out of Git

Generated bindings, `.rocketc`, `out`, `build`, `.vs`, Visual Studio experimental state, downloaded dependencies, compiler/toolchain trees, native objects, executables, DLLs, libraries, PDBs, packages, caches, local configuration, and real user save data.

## New-chat handoff

Read `AGENTS.md`, `docs/MASTER_PLAN.md`, and this file completely. Inspect Git status and preserve user changes. Continue from **Milestones**, use frozen Rocket 2.0 and the pinned raylib integration, validate each claim, update this handoff after meaningful progress, make logical local commits, and do not push or publish.

