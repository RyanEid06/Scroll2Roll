/goal Build Scroll2Roll as a complete, production-quality, downloadable Windows casino application written in Rocket 2.0, beginning with a fully playable Blackjack game and a reusable casino interface for adding more games later.

## Repository and workspace

GitHub repository:
https://github.com/RyanEid06/Scroll2Roll.git

The GitHub repository is currently empty.

Workspace separation:
- Keep `C:\Users\Administrator\Desktop\Projects\Rocket` exclusively for the Rocket language, compiler, toolchain, editor integration, and language documentation.
- Create a separate sibling directory:
  `C:\Users\Administrator\Desktop\Projects\Scroll2Roll`
- Clone the Scroll2Roll GitHub repository directly into that directory.
- All casino source code, visuals, assets, tests, documentation, build files, packages, and Cloudflare website configuration belong inside the Scroll2Roll repository.
- Do not place or commit casino code inside the Rocket repository.
- Scroll2Roll may reference the Rocket compiler and SDK through configurable paths, but never commit a path specific to this laptop.
- Preserve all existing user work unless I explicitly authorize removing it.

Existing Blackjack draft:
`C:\Users\Administrator\Desktop\Projects\Rocket\Blackjack-v1`

Copy the Blackjack draft into the Scroll2Roll repository. Do not move or delete the original. Preserve it until the repaired version has been committed and thoroughly verified in the new repository.

Before changing anything:
- Inspect both repositories and their current Git status.
- Read the new repository’s instructions and documentation if any exist.
- Read these files from the Rocket repository:
  - `AGENTS.md`
  - `docs/PROJECT_CONTEXT.md`
  - `docs/SPEC.md`
  - `docs/TOOLING.md`
  - `docs/RAYLIB_TUTORIAL.md`
  - `docs/DEBUGGING.md`
  - `examples/raylib_showcase/README.md`
  - `examples/raylib_showcase/rocket.toml`
  - `scripts/new-raylib-app.ps1`
- Preserve all existing user changes.
- Do not push or publish anything until I explicitly approve it.

## Project identity

- Product name: Scroll2Roll
- Application type: downloadable Windows desktop casino
- Primary language: Rocket 2.0
- Graphics, input, and audio: Rocket’s reviewed raylib 6.0 integration
- Initial game: Blackjack
- Platform: Windows x64
- Development environment: Visual Studio Community 2026 with the Rocket Language 2.0.3 extension
- Version 1: local, single-player, play-money entertainment
- No real-money gambling
- No deposits, withdrawals, payments, purchases, or cryptocurrency
- No accounts
- No online multiplayer
- No gambling services
- No claims that virtual chips have monetary value

## Long-term vision

Scroll2Roll should become a polished downloadable casino application containing multiple play-money games.

Blackjack is the first complete game, but the architecture must support adding more games later without rebuilding the application shell each time.

The long-term Scroll2Roll application should contain:
- a branded startup experience
- a reusable casino lobby
- game-selection cards or tiles
- reusable navigation
- a shared visual design system
- settings
- audio controls
- local play-money balances and progress
- a consistent layout across games
- individual game screens
- local save data
- reusable animation, input, button, panel, and modal components
- packaging and update documentation
- a Cloudflare-hosted product website and download page

Do not implement several unfinished games at once. Complete Blackjack first, establish the reusable shell, and then add future games one at a time under owner direction.

## Platform and hosting decision

The casino application itself must remain written in Rocket.

Rocket 2.0 currently compiles to native Windows x64 executables. It does not currently compile to JavaScript or WebAssembly.

Therefore:
- Scroll2Roll will initially be a downloadable Windows application.
- It will not initially run directly inside a browser.
- Cloudflare will host the Scroll2Roll website, screenshots, documentation, release information, and download experience.
- Do not claim that the native Rocket game is browser-playable.
- Do not rewrite the casino in React, TypeScript, JavaScript, or another language merely to make it browser-playable.
- A small static Cloudflare website may use normal HTML and CSS because it is only the product/download website, not the casino implementation.
- Keep all Blackjack and casino application behavior in Rocket.
- If browser-playable support is requested later, stop and explain the choices:
  1. Add a future WebAssembly/Emscripten target to Rocket.
  2. Create a separately approved browser port.
- Do not silently begin Rocket Phase 19.
- Do not alter the frozen Rocket 2.0 language to accommodate this application.

## Frozen Rocket constraints

Rocket 2.0 is complete and frozen.

Do not change:
- Rocket syntax
- the compiler contract
- the runtime ABI
- the C++ stage0 bootstrap compiler
- the LLVM production backend
- the LSP protocol
- diagnostic formats
- package formats
- CodeView or PDB contracts
- source-map contracts

Scroll2Roll must adapt to Rocket 2.0. Rocket must not be changed to accept invalid application code.

The pinned Windows x64 environment is already installed:
- MSVC x64
- Ninja
- LLVM/Clang 22.1.6
- raylib 6.0

The complete Rocket raylib Debug validation has already passed 10/10.

Do not download or install another arbitrary raylib package. Use the pinned, reviewed Rocket integration.

## Known state of the Blackjack draft

The existing Blackjack draft has useful game-design work, but it is not currently valid Rocket 2.0 source.

Known problems:
- `rocketc check` fails.
- The draft uses multiline calls, function signatures, and expressions that Rocket 2.0 does not permit.
- The current test reports 0 passed and 1 failed because the package cannot compile.
- `src/blackjack.rocket` is approximately 2,146 lines.
- The game engine is too monolithic.
- The README contains corrupted tree-drawing characters.
- The test card helper silently substitutes an Ace when card construction fails, which can hide test errors.
- Existing Blackjack feature claims have not yet been proven by a passing comprehensive test suite.
- There is not yet a raylib visual layer.

Treat the draft as an implementation starting point, not as verified completed code.

## Permanent project documentation

Create these files early:

- `AGENTS.md`
- `README.md`
- `docs/MASTER_PLAN.md`
- `docs/PROJECT_CONTEXT.md`
- `docs/ROADMAP.md`
- `docs/ARCHITECTURE.md`
- `docs/BUILDING.md`
- `docs/TESTING.md`
- `docs/VISUAL_DESIGN.md`
- `docs/CLOUDFLARE.md`

Copy this complete master plan verbatim into `docs/MASTER_PLAN.md` in the
Scroll2Roll repository. Treat that file as the durable product mandate and do
not shorten or replace it with a temporary summary. `AGENTS.md` must require
future chats to read both `docs/MASTER_PLAN.md` and `docs/PROJECT_CONTEXT.md`
before changing the project.

`AGENTS.md` must instruct every future chat or contributor to read `docs/PROJECT_CONTEXT.md` and the relevant project documentation before planning or changing Scroll2Roll.

`docs/PROJECT_CONTEXT.md` must become the durable handoff document for every future chat.

It must contain:
- project identity
- repository URL
- local workspace location
- long-term product vision
- current scope
- explicit non-goals
- Rocket and raylib constraints
- Windows x64 target
- Cloudflare hosting decision
- current architecture
- implemented functionality
- verified test evidence
- known limitations
- visual design tokens
- completed milestones
- current milestone
- immediate next task
- major decisions and their reasons
- files that must remain out of Git
- a concise new-chat handoff section

Update `docs/PROJECT_CONTEXT.md` after every meaningful milestone. Never leave it describing stale or unverified functionality.

`docs/ROADMAP.md` must describe the future product direction without promising unsupported features. It should show:
- repository foundation
- repaired Blackjack engine
- comprehensive Blackjack tests
- modular game architecture
- raylib application shell
- complete Blackjack visuals and interaction
- reusable Scroll2Roll lobby
- local persistence and settings
- Windows packaging
- Cloudflare product/download website
- later games selected one at a time by the owner

## Milestone 1: Repository foundation

- Clone the empty repository.
- Copy the original Blackjack draft without deleting it from the Rocket workspace.
- Add a suitable `.gitignore` covering:
  - `.vs`
  - `out`
  - `.rocketc`
  - generated bindings
  - downloaded dependencies
  - compiled executables
  - object files
  - PDB files
  - temporary packages
  - Visual Studio experimental state
  - local configuration
  - machine-specific files
- Create the permanent documentation described above.
- Copy this complete plan into `docs/MASTER_PLAN.md` before implementation and
  keep it under version control as the authoritative long-term goal.
- Record the original draft state and known compiler failure.
- Preserve recoverable history before beginning large rewrites.
- Create logical local commits when appropriate.
- Do not push until I explicitly approve it.

## Milestone 2: Repair the Blackjack engine

Make the existing headless engine valid Rocket 2.0.

- Repair multiline calls, signatures, expressions, and all other invalid syntax.
- Use frozen Rocket 2.0 syntax exactly.
- Do not modify the compiler.
- Do not hide diagnostics.
- Do not remove game behavior merely to obtain a passing build.
- Investigate genuine logic errors.
- Run:
  - `rocketc check`
  - `rocketc build`
  - `rocketc test`
- Continue until the package checks, builds, and tests successfully.

## Milestone 3: Modularize Blackjack

Split the approximately 2,146-line engine into a maintainable, dependency-safe structure.

A suitable design may include:
- public game model and types
- cards and hand evaluation
- shoe creation and deterministic shuffling
- table rules
- betting
- action legality
- player actions
- round state transitions
- dealer behavior
- settlement and payouts
- AI/basic strategy
- local persistence model
- presentation-facing game API
- application entry point

Requirements:
- avoid circular imports
- keep public APIs intentionally small
- keep game rules independent from raylib
- do not duplicate rules in the visual layer
- keep deterministic behavior available for testing
- use integer credits so 3:2 payouts remain exact
- return clear `Result` errors for invalid operations
- keep game state serializable or otherwise suitable for future local saves
- document module ownership and dependencies

## Milestone 4: Comprehensive Blackjack tests

Create focused tests for:
- valid and invalid cards
- deck composition
- six-deck shoe composition
- deterministic shuffling
- shoe exhaustion
- cut-card reshuffling
- hard totals
- soft totals
- multiple Aces
- bust detection
- natural Blackjack
- split-hand 21 not counting as a natural
- dealer Blackjack
- dealer standing on soft 17
- table minimum bets
- table maximum bets
- invalid bet units
- insufficient balance
- changing bets
- Hit
- Stand
- Double Down
- Split
- Late Surrender
- illegal actions
- Double after split
- maximum split hands
- split Aces receiving one card
- Ace resplitting restrictions
- Blackjack 3:2 payouts
- ordinary wins
- losses
- pushes
- player busts
- dealer busts
- surrender payouts
- dealer settlement
- next-round cleanup
- AI/basic-strategy choices
- complete deterministic rounds
- multiple consecutive rounds
- balances never becoming negative
- safety-loop termination

Test helpers must fail clearly when test setup is invalid. Never substitute fallback values that can hide a failed setup.

Do not claim a Blackjack feature is complete until it has passing tests.

## Milestone 5: Integrate raylib

Use Rocket’s existing raylib 6.0 reference application and safe adapter.

Before implementing the visual interface, audit the existing safe raylib
wrapper against Scroll2Roll’s actual UI requirements. If operations such as
text measurement, current window dimensions, window resizing, mouse-wheel
input, texture regions, clipping, texture rotation, improved music controls,
or richer deterministic GUI-testing hooks are genuinely missing, extend the
Scroll2Roll-owned safe adapter narrowly and add focused tests. Keep these
changes inside Scroll2Roll unless they expose a broadly reusable Rocket defect.
Do not add speculative language or compiler features, and do not delay the
application for capabilities it has not demonstrated a need for.

- Generate the raylib application scaffold in a temporary location if necessary.
- Integrate the required scaffold into Scroll2Roll without overwriting the repaired engine.
- Use configurable `ROCKET_ROOT` and `ROCKETC` CMake inputs.
- Do not commit machine-specific absolute paths.
- Keep native adapter code policy-only.
- Keep casino behavior, game state, rendering decisions, input, animation, and audio policy in Rocket.
- Do not place Blackjack logic in C++.
- Keep deterministic headless tests.
- Add raylib test support for scripted input and resource-lifetime checks.
- Verify correct cleanup of:
  - windows
  - frames
  - textures
  - fonts
  - sounds
  - audio devices
  - temporary buffers
- Preserve the existing reproducible CMake and script workflows.

## Milestone 6: Scroll2Roll design system

Use this visual identity:

- Main background: very dark navy `#080B14`
- Panels: dark blue-gray `#111827`
- Primary accent: gold `#F5C542`
- Secondary accent: emerald `#10B981`
- Danger/red: casino red `#EF4444`
- Primary text: off-white `#F3F4F6`
- Muted text: gray `#9CA3AF`
- Borders: dark gold/gray `#293241`

Design direction:
- premium
- modern
- dark
- polished
- readable
- original
- accessible contrast
- restrained animation
- clear visual hierarchy
- consistent controls
- not copied from an existing online casino

Centralize:
- colors
- spacing
- font sizes
- panel styling
- button states
- border styling
- animation timings
- responsive layout values

Use named design tokens. Do not scatter literal values throughout the code.

The final artwork is not ready. Initially use polished raylib shapes, text, cards, chips, icons, panels, and simple procedural effects.

Do not download or generate copyrighted casino artwork.

Structure assets so custom artwork can replace placeholders later without rewriting the game engine.

## Milestone 7: Reusable casino application shell

Create the first reusable Scroll2Roll wrapper around Blackjack.

It should include:
- branded startup screen
- Scroll2Roll logo treatment or clean text branding
- main casino lobby
- navigation
- game-selection cards
- Blackjack as the first available game
- placeholders marked honestly for future games
- settings
- audio controls
- local play-money balance presentation
- reusable panels
- reusable buttons
- reusable modals
- loading/error states
- back-to-lobby flow
- exit confirmation
- resolution-aware layout
- keyboard support
- mouse support

The application shell must be reusable when future games are added.

Do not tightly couple the lobby to Blackjack.

Create a clear registration or routing mechanism so another game can be added later without rewriting the shell.

Do not invent an elaborate shared casino economy without documenting it and receiving owner approval. Version 1 remains local and play-money only.

## Milestone 8: Fully playable visual Blackjack

Build a complete Blackjack experience inside the Scroll2Roll shell.

Include:
- dealer area
- dealer up card
- hidden hole card
- reveal behavior
- human player area
- up to five AI players
- multiple split hands
- active-hand highlighting
- readable cards
- card suits and ranks
- hand totals
- soft-total indication where appropriate
- player chip balance
- selected bet
- table limits
- chip or betting controls
- Deal
- Hit
- Stand
- Double
- Split
- Surrender
- disabled states for illegal actions
- AI turn progression
- dealer progression
- round-result messaging
- win, loss, push, Blackjack, bust, and surrender presentation
- next-round flow
- restart flow
- return-to-lobby flow
- keyboard controls
- mouse controls
- clean shutdown

The visual layer must call the tested Blackjack engine API. It must not implement a second copy of the rules.

Prioritize correctness, clarity, and stable state transitions before complex animation.

## Milestone 9: Local persistence and settings

Add appropriate local-only persistence for:
- settings
- audio preferences
- display preferences
- play-money progress if approved by the documented design
- first-run state
- safe recovery from missing or invalid save data

Requirements:
- no accounts
- no cloud authentication
- no real-money value
- no secret or sensitive data
- no silent corruption
- version saved data if future migrations may be needed
- test invalid and older save data behavior
- document where local data is stored and how to reset it

## Milestone 10: Visual Studio Community 2026 workflow

Use the installed Rocket Language 2.0.3 extension.

Verify from the Scroll2Roll repository:
- nearest `rocket.toml` discovery
- GUI Build
- GUI Run
- GUI Test
- Stop Rocket
- Debug Rocket Project
- Rocket Output pane
- Error List diagnostics
- clickable file and source locations
- completion
- hover
- definitions
- references
- rename
- symbols
- semantic tokens
- formatting
- live diagnostics
- source breakpoints
- stepping
- call stacks
- represented locals
- clean stopping

Ordinary development must not open PowerShell, Windows Terminal, conhost, or an external Visual Studio debug console.

Also preserve command-line, script, and CMake workflows so development is reproducible without relying only on the GUI.

## Milestone 11: Windows packaging

Produce a portable Windows x64 Scroll2Roll package.

Include:
- the executable
- required assets
- required notices
- controls documentation
- troubleshooting information
- version information
- checksums
- any required runtime files

Requirements:
- do not include downloaded raylib source
- do not include compiler build directories
- do not include `.vs`, `.rocketc`, experimental state, caches, or local paths
- test the package from a sanitized or relocated directory
- verify the game launches and plays without the source checkout
- do not claim trusted code signing unless a real certificate is used

## Milestone 12: Cloudflare product and download website

Create a small, polished static website for Scroll2Roll inside the Scroll2Roll repository.

This website is not the casino implementation. It is the product and download website.

It may use ordinary:
- HTML
- CSS
- minimal JavaScript if needed

It should contain:
- Scroll2Roll branding
- the same color system
- product description
- Blackjack feature summary
- screenshots or placeholder screenshot areas
- system requirements
- installation instructions
- version information
- download action
- controls
- troubleshooting link
- privacy statement explaining that version 1 is local and account-free
- clear play-money-only language
- no suggestion of real-money gambling

Prepare it for Cloudflare’s free hosting tier.

Keep Cloudflare configuration inside the Scroll2Roll repository.

Do not add paid Cloudflare products without approval.

Verify current Cloudflare limits before choosing where large release files are hosted. If a package exceeds an applicable free-tier static-asset limit, report it and present safe alternatives instead of silently changing hosting services.

Do not claim that the Rocket executable runs inside the browser.

## Milestone 13: Final validation

Run all relevant:
- Rocket checks
- Rocket builds
- Rocket tests
- Blackjack engine tests
- native adapter tests
- raylib tests
- resource-lifetime tests
- deterministic input tests
- persistence tests
- packaging tests
- sanitized relocation tests
- static website checks
- focused regression tests

Demonstrate:
- launching Scroll2Roll from Visual Studio
- opening the casino lobby
- selecting Blackjack
- placing and changing a bet
- dealing a round
- using each legal action
- observing disabled illegal actions
- AI players completing their turns
- dealer completion
- correct settlement
- beginning another round
- returning to the lobby
- saving and restoring approved local settings
- stopping the game normally
- debugging game logic in Rocket source
- running the packaged version outside the source checkout

Before handoff:
- inspect the complete Git diff
- confirm no generated, downloaded, experimental, or machine-specific files are staged
- update all documentation
- update `docs/PROJECT_CONTEXT.md`
- record commands and results
- identify limitations honestly
- list files ready to commit
- prepare logical commits
- do not push or publish until I explicitly approve

## Final acceptance criteria

Scroll2Roll is ready for its first milestone release only when:

- the Blackjack engine compiles under frozen Rocket 2.0
- all Blackjack tests pass
- the engine is modular and independent from rendering
- raylib is integrated through the reviewed safe boundary
- the reusable Scroll2Roll casino shell exists
- Blackjack is fully playable through the graphical interface
- the chosen color theme is applied consistently
- keyboard and mouse controls work
- multiple rounds work correctly
- game resources clean up safely
- Visual Studio Build, Run, Test, Stop, and Debug work
- a portable Windows package passes relocation testing
- the Cloudflare product/download website is prepared
- project documentation accurately describes the present and future goals
- future chats can resume correctly from `docs/PROJECT_CONTEXT.md`
- no unsupported browser-playable claim is made
- no real-money functionality exists
- no generated or machine-specific files are included in Git

Do not stop after creating an environment or scaffold.

Continue through:
- importing the draft
- repairing compilation
- correcting logic bugs
- modularization
- comprehensive testing
- raylib integration
- the reusable casino wrapper
- complete visual Blackjack
- Visual Studio validation
- Windows packaging
- Cloudflare website preparation
- durable documentation

If a genuine blocker appears, investigate it fully, preserve evidence, and report it accurately. Do not silently weaken requirements or claim unfinished features are complete.
