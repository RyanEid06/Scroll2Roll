# Scroll2Roll Android work packages

**Status:** owner-requested implementation roadmap; no Android feature is claimed complete by this document.
**Project home:** the Scroll2Roll repository, not the Rocket language repository.
**First release:** Android, local single-player, free play credits, thirteen games.
**Last verified starting point:** 2026-09-28 repository context and Rocket 3.5 consumer preview.

This is a task handoff document. Each WP is a separately reviewable outcome. Complete the exit gate and record evidence before calling a WP done. A friend may take a whole WP or one of its explicitly listed assignments; the integrator retains responsibility for tests and merging.

## 1. Current state and boundaries

The 0.3.1 Windows casino has eleven games: Blackjack, European Roulette, Plinko, Coop Climb, Midnight Crossing, No-Limit Texas Hold'em, Mines, Dice, HiLo, Crash, and Slots. Its tested engines, integer-credit rules, source artwork, save migration, and Windows package must remain available. The `rocket35/` package is a separate preview using the frozen `v3.5.0-scroll2roll-baseline`: lobby, settings, and a Blackjack table scene render, but wagers and game rules are not connected. Rocket's current documented production targets do not include Android. A phone runtime architecture is therefore an evidence gate, not an established capability.

**Checkout note:** the current branch uses Git sparse checkout (`assets/fonts/manrope`, `assets/games/blackjack-reference-v1`, and `docs`). The older game sources are tracked in Git but are not currently present on disk. WP0 must expand or use an isolated full checkout before inspecting or migrating those engines. The absence of `src/` in this working tree is not evidence that the historical games were deleted.

The intended finished phone app has those eleven games plus Video Poker and Guess the Number. It is account-free and local-only for version one. Credits cannot be bought, withdrawn, transferred, redeemed, or exchanged for anything of real-world value. No real-money gambling, advertising-based credit purchase, online multiplayer, or social leaderboard is in this roadmap. Android ships first; iPhone needs a separate feasibility decision.

The existing visual refinement and asset-animation instructions remain source material. For phone-specific game visuals, integrate the four groups sequentially in a shared checkout: (1) Midnight Crossing, Crash, Coop Climb; (2) Blackjack, Hold'em, Roulette; (3) Slots, Plinko, Mines; (4) Dice, HiLo. Friends can create or review independent material at the same time, but code and accepted assets enter the shared branch in that order. Separate worktrees and an owner-agreed merge order are required before parallel code integration.

## 2. Ownership and working rules

### Roles

| Role | Owns | Does not unilaterally decide |
| --- | --- | --- |
| Owner | Product approval, visual approval, release decision, availability of test phones and store accounts | Tested implementation claims without evidence |
| Integrator | Current branch, interfaces, merges, validation, context updates, WP gate | Owner's visual or publication approval |
| Android/platform contributor | Build, lifecycle, permissions, usage telemetry, device diagnostics | Casino outcomes or payout math |
| Rocket/game contributor | Engines, public game APIs, exact settlement, deterministic tests | Platform permissions or visual result selection |
| Art contributor | Original layered art, prompts, provenance, sizes, mockups | Game rules or hidden results |
| QA contributor | Repeatable scripts, device matrix, captures, bug reports | Acceptance without reproduction and tests |
| Math reviewer | Independent expected-return calculations and payout review | Arbitrary changes to results after a bet |

One person may hold several roles. Each assignment has a named owner and reviewer in the WP tracker before work starts. Friends should receive a game or artifact boundary, not unrestricted permission to modify the shared checkout.

### Every WP handoff contains

1. A short statement of what now works, what remains incomplete, and the exact build or branch inspected.
2. A list of changed files or delivered art, plus provenance and license details for every asset.
3. Reproducible build and test instructions with actual pass/fail results; a screenshot alone never proves functionality.
4. A screen recording or captures of the relevant ready, active, and settled states where UI changes are involved.
5. Known defects, device/OS versions, measured performance where relevant, and the next WP's entry conditions.
6. An updated `docs/PROJECT_CONTEXT.md` after a meaningful milestone. Generated packages, caches, screenshots for internal review, and local configuration stay out of Git unless explicitly selected as reviewed evidence.

### Release and resource boundaries

No push, publication, deployment, signing claim, or store submission is implied by completing a development WP. Follow the repository's existing approval rules. Before any operation that could use more than 20 GiB of disk space, stop and ask the owner first. Do not install an Android SDK or emulator image as an unbounded background download. Keep the existing Windows casino and Rocket 3.5 preview buildable during the transition.

## 3. Roadmap and dependencies

`WP0 -> WP1 -> WP2 -> WP3 -> WP4 -> WP5 -> WP6 -> WP7 -> WP8 -> WP9 -> WP10 -> WP11 -> WP12 -> WP13` is the integration order. Art briefs, source illustrations, policy research, test plans, and independent math calculations may start early, but their acceptance and code integration wait for the relevant WP. In particular, WP5 is a **functional Blackjack slice** with temporary phone presentation; its final visual refinement happens in Group 2 after Group 1.

| WP | Name | Primary output | Suggested Codex/ChatGPT effort | Relative size |
| --- | --- | --- | --- | --- |
| 0 | Baseline and migration map | Evidence-backed inventory | Codex Sol, medium | Small |
| 1 | Android feasibility | Real-device architecture decision | Codex Astra, xhigh | Large, high risk |
| 2 | Earning signal | Verified-swipe result or honest app-time fallback | Codex Astra, xhigh | Large, high risk |
| 3 | Wallet and ledger | Atomic local credit source of truth | Codex Sol, high | Medium |
| 4 | Phone shell | Portrait navigation, settings, reusable UI | Codex Sol, high; ChatGPT art direction | Large |
| 5 | Blackjack vertical slice | First wallet-connected playable game | Codex Astra, high | Large |
| 6 | Visual Group 1 | Three migrated, polished games | Codex Sol, high | Very large |
| 7 | Visual Group 2 | Three polished table games | Codex Astra, high | Very large |
| 8 | Visual Group 3 | Three polished chance games | Codex Astra, high | Very large |
| 9 | Visual Group 4 | Dice, HiLo, eleven-game cohesion | Codex Sol, high | Large |
| 10 | Two new games | Video Poker and Guess the Number | Codex Astra, high | Large |
| 11 | Fairness and economy audit | Independent return/settlement evidence | Codex Astra, xhigh | Medium |
| 12 | Android acceptance | Thirteen-game device matrix | Codex Sol, high | Very large |
| 13 | Release readiness | Reviewable package and store materials | Codex Astra, high; ChatGPT high for copy | Medium |

The suggested model is for the lead technical task, not a requirement that every small subtask use it. A friend can prepare asset briefs, usability notes, or test runs without coding. Do not run two game-integration WPs concurrently in the same checkout.

## WP0 — Baseline and migration map

**Purpose:** establish exactly what is being preserved and what the phone version must reproduce. This WP is documentation and read-only validation, not a rewrite.

**Entry:** cleanly identify the Scroll2Roll checkout and its current Git status. Read `AGENTS.md`, `docs/MASTER_PLAN.md`, `docs/PROJECT_CONTEXT.md`, `docs/ARCHITECTURE.md`, `docs/TESTING.md`, the relevant math/design documents, and `rocket35/README.md`.

**Lead tasks**

1. Record the current commits/tags for Scroll2Roll and frozen Rocket 3.5, and the build/test commands that currently work. Keep historical validation separate from newly run validation. The 0.3.1 freeze lacks a fresh post-Group-4 full suite, so do not call it newly verified.
2. Record the sparse-checkout patterns and expand to a full checkout or prepare an isolated full checkout without discarding owner changes. Then make a game inventory with engine/API/view boundaries, save fields, wager units, default balance behavior, deterministic seed controls, controls, current art, and test coverage for all eleven games. Flag any source still absent rather than assuming the documented structure is present.
3. Capture representative Windows and Rocket 3.5 preview screens at supported sizes where builds are available. List what a phone must change: portrait geometry, touch controls, text scale, navigation depth, animation cost, and wallet visibility.
4. Build a migration matrix: preserve rule verbatim, adapt public API, replace UI, replace artwork, adapt save data, and retest. Separate mandatory parity from new phone features.
5. Record the thirteen-game target list and the names shown to users. Preserve European Roulette, Coop Climb, and Midnight Crossing as their existing product identities.

**Friend assignment:** a non-coding reviewer takes screenshots and writes a short usability report for each of the eleven games at a phone-sized viewport. Each report should include three confusing actions, the minimum readable labels, and likely one-hand controls. This is research, not approval of the final design.

**Deliverables:** a baseline inventory, migration matrix, evidence index, and prioritized known-risk list in this repository. Existing source and saves stay untouched.

**Exit gate:** a future contributor can point to the rule owner, view owner, math reference, test suite, and expected phone changes for every existing game. The integrator confirms the inventory against actual files and updates project context.

## WP1 — Android feasibility and architecture decision

**Purpose:** answer whether Rocket 3.5 can execute and render on Android before committing to a broad port. Rocket's Linux ARM64 target is not proof of Android support: Android uses its own SDK/NDK, linker, ABI, lifecycle, and graphics integration.

**Entry:** WP0 inventory and a bounded tool/resource estimate. The machine used for planning did not expose an Android SDK, Gradle, Kotlin compiler, or connected phone through its command environment; the executor must verify available tools again. Obtain a physical low-end Android phone and a current phone before claiming a device result.

**Lead tasks**

1. List the exact Rocket compiler, runtime, native adapter, raylib, LLVM target, Android NDK, and Gradle requirements. Check whether each exists without downloading a large SDK first. Estimate disk consumption and stop for owner approval before any operation that may exceed 20 GiB.
2. Attempt the smallest Rocket-on-Android program: start, draw one scene, respond to tap and drag, pause, resume, rotate or explicitly lock orientation, handle surface loss, and exit. Use public Rocket APIs where possible and a minimal Android-native lifecycle bridge where required.
3. Measure frame time, startup time, working memory, resource recreation, and battery/heat qualitatively on both physical devices. Run a several-minute repeated background/foreground cycle, not just one launch.
4. Investigate the boundary for usage-permission status and usage intervals from Android into the game layer. This stage proves the bridge shape; WP2 implements earning behavior.
5. Write a decision record with one selected architecture:
   - **A:** Rocket game logic and renderer on Android, with a small Kotlin/Java platform shell; or
   - **B:** Android-native first-release client if Rocket Android compilation or rendering cannot pass the bounded proof, while the existing Rocket desktop implementation remains the rule reference. Record exactly what must be ported and how parity will be tested.
6. Do not alter the frozen Rocket language checkout to conceal a product integration problem. A concrete compiler defect or missing supported target should be documented separately with reproduction and cost.

**Friend assignment:** a device owner records model, Android version, RAM, refresh rate, thermal behavior, screen recording, and observed lifecycle failures. A second reviewer tries accessibility settings and different display scales.

**Deliverables:** a runnable prototype on a physical phone, a build recipe, measurements, an architecture decision record, and a list of any required Rocket platform work. A desktop screenshot does not satisfy this WP.

**Exit gate:** taps and rendering work after repeated pause/resume on both phones without crash or lost resources; measurements are recorded; the owner can choose the documented A/B route without guessing. If no physical device or toolchain is available, mark WP1 **blocked**, not complete, and keep later phone WPs gated.

## WP2 — Swipe feasibility and the earning signal

**Purpose:** establish what the phone can truthfully measure for Instagram, TikTok, and YouTube. The user preference is to try verified swipes first and fall back to eligible app foreground time when swipe verification is unreliable or cannot pass review.

**Entry:** WP1 architecture decision, Android devices, and an explicit test protocol. Store approval is a release dependency, not a result the prototype can assume.

**Lead tasks**

1. Prototype Android accessibility `TYPE_VIEW_SCROLLED` observation, limited to the three eligible package names. Record event type, package, time, and minimal non-content fields needed for the experiment. Do not collect watched videos, captions, messages, account names, screen images, or unrelated app activity.
2. Test each app's ordinary feed and short-video mode separately. Include deliberate swipes, passive video autoplay, taps, page changes, app switching, screen lock, picture-in-picture, split-screen, and a revoked service. A scroll event is not automatically proof of a short-video swipe.
3. Use a written ground-truth sheet or recording that the tester controls. Calculate detection coverage and false-credit events per app/version/device. Repeat after an app update if its UI or events change. Record accessibility-service battery impact.
4. Prepare an in-app disclosure and consent flow before any sensitive permission request. State what is observed, why, whether it stays on device, how to turn it off, and what earning stops when permission is revoked. Do not mislabel the casino as an accessibility aid. Review Google's current accessibility declaration requirements before distribution.
5. Decide the signal using the evidence: use verified swipes only if every supported app/version/device combination can distinguish eligible short-video scrolling with a reproducible low false-credit rate and the intended distribution channel accepts the use. Otherwise, select the agreed fallback: Android `UsageStatsManager` foreground intervals for the three apps, with user-granted Usage Access.
6. For the fallback, label the feature **eligible app time** in the app and help. Explain that YouTube time includes activity outside Shorts and that the app cannot see which video was watched. No hidden claims about exact scrolling. Only account for time the selected app is foreground and the device is interactive; ignore locked-screen/background time where the platform data permits that distinction.
7. Handle absent permission, device locked state, missing usage records, renamed/removed apps, delayed usage data, and user revocation with a clear unavailable state. Never silently estimate or credit time that cannot be observed.

**Friend assignment:** a friend performs a fixed test script for each app and phone, recording observed swipes and actual credits. Another friend reviews the permission wording as an ordinary user and checks it matches the measured behavior.

**Deliverables:** signal prototype, raw test protocol/results without personal content, comparison table, selected earning mode, consent copy, and store-policy checklist. Source references: [Android usage API](https://developer.android.com/reference/android/app/usage/UsageStatsManager), [Android scroll events](https://developer.android.com/reference/android/view/accessibility/AccessibilityEvent), and [Google Play accessibility policy](https://support.google.com/googleplay/android-developer/answer/10964491?hl=en).

**Exit gate:** the selected signal's limitations are documented; permission refusal and revocation are safe; all three apps and both devices have actual results. If swipe verification fails, the fallback is implemented and named honestly before proceeding. Do not claim store approval until received.

## WP3 — Local wallet and earning ledger

**Purpose:** create a single source of truth for free credits before any phone game takes a wager. The user-facing conversion is exactly **3 credits for each complete eligible minute**.

**Entry:** WP2 signal selected and documented. The wallet design must be compatible with the current integer-credit wagering conventions, including exact Blackjack 3:2 payouts.

**Lead tasks**

1. Define a versioned local save containing balance, applied earning progress, game results needed for recovery, and settings. Keep app-time observations on device; do not create an account or cloud sync. The save format must distinguish a newly installed wallet from an older or corrupted save.
2. Convert eligible intervals into whole earned minutes without double counting overlap across scans, process restarts, or app transitions. Carry uncredited seconds forward only when their provenance is known. The rule for midnight and clock corrections must avoid reissuing prior credits.
3. Apply each earning batch and wager settlement atomically. A failed validation, interrupted write, insufficient balance, invalid result, or arithmetic overflow leaves the previously committed balance intact. Avoid negative balances and cap values at a documented safe integer maximum.
4. Make the wallet the only component that commits balance changes. Engines propose validated wager deductions and settled credits through a small interface; views display values but never compute payouts. Each ledger entry identifies its cause without exposing hidden cards, mine positions, future crash points, or private usage content.
5. Add balance and recent history to the shell, including `+3 app time` or `+3 verified scrolling` according to WP2's selected mode. The first-run explanation says credits have no cash value and cannot be bought or redeemed.
6. Write deterministic tests for exactly 59/60/119/120 seconds, overlapping intervals, repeated scans, permission revocation, restarts, timezone changes, wall-clock rollback, corrupted saves, atomic wager failure, maximum balance, and recovery after a deliberately interrupted write.

**Friend assignment:** a QA friend creates a table of expected balance and history after each scripted earning/wager sequence and checks the app display against it. A math reviewer independently checks the minute conversion and Blackjack wager units.

**Deliverables:** documented wallet interface, versioned save/migration behavior, focused tests, and a simple screen showing balance and history.

**Exit gate:** the same eligible minute cannot be awarded twice in any tested restart or rescan path; failed wagers do not change balance; all balance paths remain nonnegative; corrupt-save behavior is visible and honest.

## WP4 — Portrait phone shell and visual foundation

**Purpose:** establish a reusable phone UI so each game contributes its own stage and controls without reinventing navigation, wallet display, settings, or resource ownership.

**Entry:** WP1 architecture fixed, WP3 wallet interface stable. Review existing `UI_OVERHAUL.md`, `docs/GAME_VISUAL_REFINEMENT_PLAN.md`, `docs/OWNER_ASSET_GENERATION_PROMPTS.md`, and `docs/ASSET_ANIMATION_IMPLEMENTATION_PLAN.md` before approving new artwork.

**Lead tasks**

1. Draw and test portrait-first wireframes for onboarding, consent, lobby, wallet/history, settings, game help, in-game table, round result, and safe Back. Support common narrow screens, tall screens, display scaling, and notches/insets. Keep the primary wager and action controls reachable by one hand.
2. Define reusable game chrome: current credit balance, pending wager, result feedback, accessible action rail, confirmation for abandoning an unsettled wager, help, history, and settings. Legal/disabled controls come from game APIs rather than duplicated view rules.
3. Provide light and dark palettes, contrast checks, practical 44-dp touch targets, visible focus where relevant, readable numerical values, large text behavior, and reduced-motion controls. Where an animation is reduced or skipped, the same committed result must remain obvious.
4. Create an asset pipeline: original source file, prompt or creator, license/use right, dimensions, hash, approved crop/atlas region, phone-resolution variants, and runtime owner. Moving objects such as cards, chips, balls, reel symbols, and tokens must be separate layers or procedural drawing; a single screenshot background is insufficient.
5. Set measured budgets on the two WP1 phones for memory, texture count, startup, and frame pacing. The first targets are a responsive 60 fps where the device supports it and no recurring frame longer than 33 ms during ordinary interaction; revise only with recorded device evidence. Keep loading and texture creation out of each frame, and release resources once on lifecycle teardown.
6. Add automated navigation smoke checks and real-device review at ready/active/result states. Use representative small and large phones; log any clipping, inaccessible controls, or excessive scrolling.

**Friend assignment:** one friend makes art-direction boards and original assets with provenance; another reviews one-hand flows and text size; a third tests reduced motion and light/dark contrast. Art can be prepared before a game WP but is promoted into runtime only during that game's sequential integration.

**Deliverables:** running phone shell, design tokens/components, asset manifest convention, real-device captures, and baseline performance measurements.

**Exit gate:** all shell routes work, wallet values survive navigation/restart, no shell screen clips on test phones, resource lifetime checks pass, and the owner has a reviewable visual baseline. This is not owner approval of all game interiors.

## WP5 — First playable Blackjack slice

**Purpose:** prove the entire phone loop using an existing, well-tested engine: earn credits, enter a game, wager, act, settle, save, and return to the lobby. This WP is deliberately functional; final Group 2 artwork waits until WP7.

**Entry:** WPs 1–4 passed. The existing Blackjack engine and its headless tests are the rules reference. The Rocket 3.5 preview table alone is not a playable baseline.

**Lead tasks**

1. Migrate the existing Blackjack engine and tests to the selected WP1 architecture. Preserve deck/shoe behavior, legal actions, split/double/surrender constraints, dealer soft-17 policy, Blackjack payout, bounded rounds, and AI behavior unless a documented phone-specific requirement makes a tested change necessary.
2. Expose a presentation-safe table: visible player/dealer cards, balance, current bet, legal action set, turn, outcome, and next-round state. The view must not see future cards or choose outcomes.
3. Connect wallet preauthorization and settlement. A tap cannot create two wagers; leaving the screen or backgrounding during a round resumes a valid state or follows a documented refund/forfeit rule that is tested and shown to the user.
4. Implement touch bet adjustment, Deal, Hit, Stand, Double, Split, Surrender where legal, Next, Help, and Back. Disabled actions explain the reason when practical. The UI must show total stake including split/double exposure before confirming an additional wager.
5. Test seeded hands for naturals, pushes, busts, split Aces, split limits, double after split, surrender, dealer progression, insufficient credits, interrupt/resume, and repeated rounds. Compare outcomes with the existing Windows engine fixtures.

**Friend assignment:** a Blackjack player follows a scripted hand sheet on phone, notes unclear chips/actions, and confirms the result display matches the hand. A QA friend checks that rapidly tapping Deal or Double never duplicates a wager.

**Deliverables:** a real-phone playable Blackjack slice, engine parity report, focused tests, save/restart evidence, and a list of final-art needs for WP7.

**Exit gate:** an ordinary user can earn credits and play multiple complete Blackjack rounds on a physical phone; the existing rule fixtures pass; no view-side payout calculation or hidden-card leak exists. Do not mark the table visually final here.

## Shared game-completion checklist for WPs 6–10

Apply this checklist separately to **each** game, even when three games share a WP:

1. Identify the documented Windows rules, exact payout math, seed behavior, API, and tests. Record intended phone differences before editing.
2. Bring engine and tests into the selected Android architecture. Keep decisions, randomness, hidden state, legal actions, and settlement outside the view.
3. Connect the shared wallet through validated begin/settle/cancel operations. Prove insufficient-credit and interruption behavior.
4. Lay out a portrait ready state, active state, result state, help, settings access, and safe return. Use phone touch controls with visible legal/disabled states.
5. Integrate original layered art with source/provenance and bounded texture variants. Animate only committed or public engine state; implement reduced motion and resource teardown.
6. Run focused engine tests, deterministic UI scripts, full regression suite, and real-device review in both themes and at small/large text settings. Record frame/memory measurements on the low-end phone.
7. Update game documentation and project context. The next game starts only after the current game's gate passes.

## WP6 — Visual Group 1: living worlds and motion

**Order:** Midnight Crossing, then Crash, then Coop Climb. **Entry:** WP5 passes and the shared game-completion checklist is established. This follows the repository's Group 1 visual order.

### 6A — Midnight Crossing

- Preserve the deterministic fixed-tick lane world, collision checks, checkpoint and cash-out rules. Touch movement must map to engine steps, not drag the rendered sprite independently from the collision position.
- Design a top-down portrait viewport that keeps the next relevant hazard and current safe area visible. Test continuous movement, quick taps, pause/resume, loss, checkpoint, and return to lobby.
- Layer roads, rails, canals, objects, hazards, and player separately. Keep gameplay geometry legible with reduced motion and low visual effects.
- **Friend brief:** create original top-down road/water/rail components and a hazard readability sheet; test whether a new player can predict the next safe move without reading help.

### 6B — Crash

- Preserve private crash threshold and fixed-tick progression. The graph shows only engine-derived current/public history; it must not reveal a future result.
- Give Cash Out a large, reliable touch target. Test taps near the crash boundary, auto target if retained, app backgrounding, animation lag, and loss/win settlement.
- Keep the curve procedural or layered, with bounded particles and a static reduced-motion presentation.
- **Friend brief:** review the exact moment a cash-out becomes unavailable, the clarity of current multiplier, and whether animation ever appears to contradict settlement.

### 6C — Coop Climb

- Preserve the finite ten-rung path, survival/multiplier profiles, private future hazards, and advance/cash-out legality.
- Show the current rung, potential next reward, and current cash-out value clearly in portrait. Distinguish an unlocked next step from a settled result.
- Use separate ladder, character, environment, and reward assets so each can move without shifting hit regions.
- **Friend brief:** test whether the risk/reward choice is understandable in ten seconds, in both themes and reduced motion.

**Group gate:** all three games meet the shared checklist, full suite passes, Group 1 assets have provenance, and a reviewer inspects real-device ready/active/settled captures. Group 2 cannot start before this gate.

## WP7 — Visual Group 2: physical tables

**Order:** Blackjack final presentation, then No-Limit Texas Hold'em, then European Roulette. **Entry:** WP6 group gate passes. Final Blackjack art builds on, rather than replaces, WP5's tested rule connection.

### 7A — Blackjack finish

- Use a phone-sized table composition with readable cards, dealer/player seats, wager and chip stack, and distinct active hand. Keep all legal actions visible without shrinking them below usable touch size.
- Animate the committed deal, flip, split, chip movement, win/loss/push, and Blackjack outcome. Do not infer or reveal a dealer hole card early.
- Re-run WP5's rules and wallet cases after replacing visuals. Test small text scaling, Split/Double exposure, and reduced motion.
- **Friend brief:** original cards/chips/table props with provenance and a side-by-side clarity review of functional and final tables.

### 7B — No-Limit Texas Hold'em

- Preserve the existing deck, evaluator, betting streets, blinds, side pots, all-ins, and private opponent cards. Keep AI decisions dependent only on each AI player's allowed information.
- Add Easy/Medium/Hard AI profiles through decision policy, documented before tuning. The profiles cannot alter dealt cards, peek at private cards, or silently change legal action limits. Disclose that difficulty affects opponent play and cannot guarantee a house win against every player.
- Build touch sizing for Fold, Check/Call, Bet/Raise, All-in, Next, and New Table. Present pot, current call, minimum full raise, selected total bet, public cards, and the player's private cards without crowding the screen.
- Test side pots, ties, odd chips, short all-ins, order of action, AI progression, and rapid touch input. Include one complete hand per difficulty on each test phone.
- **Friend brief:** one poker-literate reviewer validates terminology/action order; one novice reviewer tests whether the bet-sizing controls are understandable.

### 7C — European Roulette

- Preserve the single-zero wheel, bet coverage and payouts, repeat/rebet behavior, and exact settlement. The artwork must not move or obscure validated betting hit regions.
- Design a portrait betting table with zoom or clearly separated bet selection if the full desktop grid cannot meet touch-size requirements. Show each selected bet's coverage and total stake before Spin.
- Animate the already chosen winning pocket; test undo, clear, repeat, overlapping bets, insufficient balance, and wheel/result agreement.
- **Friend brief:** review every bet target on a phone and supply a hit-target error log rather than a subjective “looks good” note.

**Group gate:** all three meet the shared checklist; no private-card leak, illegal bet, or visual/result mismatch; full suite and device captures pass. Group 3 waits for this gate.

## WP8 — Visual Group 3: cabinets and tactile boards

**Order:** Slots, then Plinko, then Mines. **Entry:** WP7 group gate passes. This follows the repository's Group 3 asset and animation boundary.

### 8A — Slots

- Preserve the fixed reel strips, five paylines, wild/scatter rules, bonus tickets, free-spin bounds, and source-computed theoretical return. The view receives committed stops and payline awards; it does not simulate an alternative result while spinning.
- Make total wager, line wager, active lines, Spin, optional bounded autoplay/turbo, free spins, and result readable on a narrow screen. Display what a bonus changed and what was paid.
- Use separately animated reel symbols and enclosure materials. Keep clipping correct and avoid loading a texture per spin. Reduced motion should jump to the same stopped grid and award.
- Test every award class, bonus trigger, free-spin completion, autoplay stop, insufficient balance, background/resume, and exact ledger entries.
- **Friend brief:** create a symbol sheet with source ownership; review whether every winning line is visually distinguishable without flashing effects.

### 8B — Plinko

- Preserve 8–16 rows, 50/50 paths, the three audited risk tables, integer payouts, and bounded multi-ball batch. Easy/Medium/Hard can be the user-facing names for existing low/medium/high **risk**, but help must explain that these change volatility, not skill or a hidden per-player setting.
- Fit pegs and bins in portrait without making multipliers unreadable. Show selected rows, risk, bet per ball, batch size, total prepaid wager, and eventual bucket award.
- Animate engine-committed paths only. Test path/bin agreement, simultaneous balls, collision-like visuals that do not alter the outcome, rapid repeated drops, and reduced motion.
- **Friend brief:** verify readability of every row/risk combination and mark any bin label that is too small on the low-end device.

### 8C — Mines

- Preserve the 5-by-5 board, private mine positions, exact combinatorial survival math, reveal legality, and cash-out. Every closed tile must look identical until revealed.
- Show mine count, safe reveals, next risk, current cash-out, and available actions while keeping tiles comfortably tappable. Prevent a rapid double-tap from charging or revealing twice.
- Use a tactile board with separate tiles, reveals, and restrained effects. No animation may hint at an unrevealed mine.
- Test loss, cash-out after each valid reveal count, repeated taps, invalid tiles, interrupted reveal, and low-balance handling.
- **Friend brief:** run a blind test for any visual clue about unrevealed mines; review tile hit accuracy with one hand.

**Group gate:** all three meet the shared checklist; theoretical payout tables still match the original documented rules or an explicitly reviewed revision; full suite, device captures, and asset provenance pass. Group 4 waits for this gate.

## WP9 — Visual Group 4: precision games and eleven-game cohesion

**Order:** Dice, then HiLo, then an all-eleven review. **Entry:** WP8 group gate passes.

### 9A — Dice

- Preserve the existing 0000–9999 integer result domain, exact under/over boundaries, basis-point payouts, and finite stoppable auto-roll. Do not depict the outcome as a conventional six-sided die if that would misrepresent the rules.
- Make target, winning probability, multiplier, wager, total auto-roll exposure, and Stop clear before starting. Label Easy/Medium/Hard only if a genuine probability/risk preset is specified and the exact numbers remain visible.
- Use a bounded numerical drum/signal animation that lands on the already committed number. Test boundary targets, exact payout rounding, rapid Stop, low credits, app backgrounding, and reduced motion.
- **Friend brief:** review whether a new player correctly predicts what “under” and “over” mean at the boundary values.

### 9B — HiLo

- Preserve the checked deck, remaining-card counts, equal-rank loss rule, cumulative multipliers, cash-out, and hidden future cards.
- Show only drawn cards and legal predictions. The user must see the cost of a tie and the current cash-out value without revealing the next card or obscuring the card rank.
- Separate card, deck, table, and win/loss effects. Test equal rank, impossible predictions, deck exhaustion, multi-step sequence, restart, and reduced motion.
- **Friend brief:** check card readability and ask three testers to explain what happens on a tie before they play.

### 9C — Cohesion review

- Walk all eleven games through first entry, help, wager, action, win, loss, next round, Back, and wallet history. Compare terminology, amount formatting, animation length, control placement, and error messages.
- Review both themes, small/large screens, large text, reduced motion, touch targets, resource lifetimes, and no per-frame loading. Recheck asset hashes and provenance after any resizes or atlas changes.
- Repair cross-game issues in the affected game's WP and rerun its focused tests plus the full regression suite. The accepted Windows game and existing Rocket 3.5 preview remain intact.
- **Friend brief:** give different friends different phones, then merge their findings into one severity-ranked issue list; have one person replay all eleven games as a first-time user.

**Group gate:** eleven existing games are playable and visually reviewed on Android, with full regression and real-device evidence. Do not count Video Poker or Guess the Number until WP10.

## WP10 — Video Poker and Guess the Number

**Purpose:** add two complete games rather than placeholders. Each gets an engine, exact payout contract, deterministic tests, wallet integration, help, art, and phone UI.

### 10A — Video Poker

1. Use a single-player five-card draw: place a wager, deal five cards, choose holds, draw replacements, evaluate the final hand, and settle once. Choose and publish one specific pay table and whether a maximum-bet bonus exists **before** code or art production; the implementation and tests must use that table exactly. No dealer AI is needed.
2. Define deck/shuffle behavior, legal hold selections, when a wager becomes locked, what happens after an interruption, tie-breaking where relevant, and a bounded maximum payout. The engine owns the draw and hand evaluation; the view sees only permitted cards and choices.
3. Calculate theoretical return by exhaustive enumeration or an independently checked exact method for the selected pay table and optimal holding strategy. Tune the table to an expected return below 100% under that strategy; do not manipulate cards based on the player's balance.
4. Build a five-card portrait table with tap-to-hold, Hold labels, Draw, pay-table view, and clear final-hand explanation. Make animation optional and settlement immediate after a committed draw.
5. Test every paying hand, non-paying hand, hold combination class, duplicate-card impossibility, exact settlement, insufficient wager, repeated rounds, and restart during deal/draw.
6. **Friend brief:** a poker-literate reviewer checks the pay table and hand ranking; an art contributor provides original cards and table props using the same approved asset language as Blackjack.

### 10B — Guess the Number

1. Define a transparent round contract before implementation: number range, number of permitted guesses, whether clues are higher/lower, wager size, payout by attempt, and what is shown before commitment. Select a simple finite design with exact odds and a house return below 100% for optimal play.
2. Commit the secret number when a wager starts. Reject out-of-range or duplicate guesses without changing balance or consuming an attempt unless the published rules explicitly say otherwise. Keep the secret hidden until win or exhausted guesses.
3. Build a large number picker/keypad, visible attempts remaining, previous guesses and clues, potential payout, and a clear win/loss reveal. Easy/Medium/Hard may use different ranges or attempt counts only when their exact odds/payouts are disclosed.
4. Test every endpoint, repeated guess, clue direction, final-attempt win/loss, payout rounding, repeated rounds, seed determinism, interrupted round, and wallet atomicity.
5. **Friend brief:** give the written rules to three people who have not seen the code; each should predict a sample round's legal guesses and payout without coaching.

**WP gate:** both games meet the shared game-completion checklist, their expected returns are independently reproduced, and all thirteen phone games pass the full suite. New art has provenance and real-device captures.

## WP11 — Fairness, difficulty, and economy audit

**Purpose:** demonstrate the house advantage through published rules and probabilities, never by quietly changing an already committed result. “House wins more” means positive expected edge over many rounds, not guaranteed profit from each player or session.

**Entry:** all thirteen games exist and have documented payout rules. The game math reviewer must have access to exact tables, not only screenshots.

**Lead tasks**

1. Create a single economy reference listing each wagered game, versioned ruleset, available difficulty/risk profiles, minimum/maximum wager, possible payout, rounding rule, theoretical or modelled player return, and the evidence method.
2. Independently recompute exact chance-game returns where tractable: Roulette coverage, Plinko binomial distributions, Dice integer counts, Mines combinations, Slots reel enumeration, Video Poker draw enumeration, and Guess the Number decision tree. Preserve the existing published math unless an explicit reviewed rule revision is required.
3. For Blackjack, HiLo, Crash, and arcade cash-out games, evaluate return under documented strategies or policies and clearly name the assumptions. For Hold'em, report observed results versus specified AI policies rather than claiming a fixed mathematical house edge for every player.
4. Run seeded high-volume simulations as a cross-check, with tolerances based on variance; do not substitute a simulation for an exact calculation when the exact calculation is practical. Retest after any payout or difficulty change.
5. Check that Easy/Medium/Hard labels mean something visible and consistent: AI strength for Hold'em, risk/volatility presets for Plinko, disclosed odds or challenge differences elsewhere. Do not add difficulty to a game where it adds no meaningful choice.
6. Audit wallet integration for rounding drift, free-spin treatment, repeated action charging, caps, overflow, save/recovery, and the 3-credits-per-minute earning rule. Inspect that animated results equal engine settlements.
7. Prepare plain-language per-game help explaining odds, risk, credits, and no cash value. Do not imply that longer scrolling increases the chance of winning a later game.

**Friend assignment:** an independent math reviewer recomputes at least one representative configuration per game from raw rules, signs a discrepancy list, and challenges any result below 100% that is based only on a small simulation. A QA friend samples displayed payouts against ledger entries.

**Deliverables:** versioned economy table, independent calculations, simulation reports, discrepancy resolutions, and updated help text.

**Exit gate:** no wagered chance-game configuration has an undisclosed expected return or one of 100% or more; known skill-game limits are stated accurately; no animation or user balance changes an already committed result. Any unresolved math discrepancy blocks release.

## WP12 — Real-device acceptance and performance

**Purpose:** decide whether the complete thirteen-game phone app is stable and smooth enough to use, including the background earning feature. Emulator-only or desktop-only evidence cannot pass this WP.

**Entry:** WPs 1–11 pass, all tracked blocking bugs are resolved, and candidate APK/AAB identity is recorded. Test the same candidate throughout a run; rebuilds restart affected cases.

**Device matrix**

- At least one older/low-end Android phone, one midrange phone, and one current phone, with model, OS, RAM, display size, and refresh rate recorded. If only two phones exist, explain the gap and do not claim broad compatibility.
- Test Android settings that materially change the UI: large font/display size, dark/light system theme, reduced motion where supported, battery saver, notifications/interruptions, and portrait orientation/insets.
- Test fresh install, upgrade from a prior phone beta if one exists, force stop, app data clear, permission grant/revoke, and offline mode. The Windows save is not automatically an Android migration source; any import feature needs its own reviewed design.

**Functional scenarios**

1. Earn one, two, and many minutes; switch among eligible apps; lock the screen; revoke and regrant permission; reboot; change clock/timezone; reopen repeatedly; compare expected and actual ledger entries.
2. For every game, run a normal win, normal loss, minimum wager, maximum permitted wager, insufficient credits, restart during a round, Back during a round, repeated rapid taps, help/settings and return, and several consecutive rounds. Use deterministic fixtures for rare outcomes rather than waiting for chance.
3. Verify that private information stays private: unrevealed cards, future Crash threshold, Mines positions, and future paths/cards do not appear in view state, logs, accessibility labels, saved public history, or art layers.
4. Confirm wallet balance and history after each round; no double settlement, silent refund, duplicate earn, negative amount, or partially applied write.
5. Confirm audio, vibration if used, reduced motion, and accessibility labels do not change game outcomes or obstruct actions.

**Performance scenarios**

1. Record startup time, median and 95th-percentile frame time, longest recurring frame stalls, peak memory, texture/resource count, and crashes/ANRs in the lobby and every game ready/active/result state. Investigate any repeatable frame over 33 ms during ordinary interaction; record device-specific exceptions rather than hiding them.
2. Run a long session across all thirteen games with repeated lobby switches and background/resume. Memory should stabilize rather than increase every game entry; no texture/font should load every frame. Repeat with low-memory pressure where possible.
3. Compare battery and heat with earning disabled versus enabled under the same phone/use conditions. The tracker should use system usage queries or bounded event handling, not a constant high-frequency polling loop.
4. Record APK/AAB size and asset breakdown. Compress or reduce individual textures if the low-end phone struggles; preserve readable cards and results. Do not remove needed art merely to improve a synthetic benchmark.

**Friend assignment:** divide the thirteen games among friends for exploratory testing, but make one QA owner maintain the master matrix. Each bug report includes device/OS/build, starting balance/state, exact taps, expected result, actual result, screenshot/recording, and severity. A second tester reproduces critical bugs before closure.

**Deliverables:** signed-off device matrix, measured performance report, issue log with fixes/retests, thirteen-game screen capture set, and release-candidate build hash.

**Exit gate:** no reproducible crash, lost wager, false credit award, hidden-state leak, inaccessible required control, or material low-end lag remains. Every one of thirteen games passes on a real device. Record any supported-device exceptions explicitly.

## WP13 — Android release readiness and iPhone decision

**Purpose:** assemble a reviewable Android release without confusing development completion with publication. Actual submission and publication remain owner-controlled.

**Entry:** WP12 passes and candidate hash is frozen. Recheck current store policies immediately before submission because platform rules can change.

**Lead tasks**

1. Prepare store listing, screenshots captured from the actual candidate, privacy policy, in-app permission disclosure, data safety answers, and a plain description of the credit earning mode. If WP2 chose foreground time, use **app time** in marketing and help; never claim verified short-video swipes.
2. Declare simulated gambling accurately and set the age rating returned by the store questionnaire. Keep minors, purchases, real-money rewards, and unrelated ads outside this release. Review distribution locations and local rules with qualified counsel before making jurisdiction-specific claims.
3. If accessibility observation remains in the release, complete the relevant Google Play accessibility declaration and show a review video of its limited purpose and consent flow. If only Usage Access is used, remove unused accessibility capability and review the permission disclosure accordingly.
4. Build reproducibly, verify version and signing identity, scan package contents for generated files, personal data, accidental secrets, unlicensed assets, and unsupported product claims. Test installation and launch from the packaged artifact on a clean phone.
5. Prepare release notes, rollback instructions, support contact/process, and a bug-report template. Submit for owner review with the exact package hash and acceptance evidence. Do not push, sign, publish, or claim approval solely because this WP's materials are prepared.
6. Create a separate iPhone feasibility brief. Apple Family Controls/Device Activity require user authorization and distribution entitlements and may not expose the same detailed signal. Decide whether an iPhone version can honestly implement the earning rule before scheduling the port. [Apple Family Controls entitlement](https://developer.apple.com/documentation/familycontrols/requesting-the-family-controls-entitlement), [Apple Device Activity](https://developer.apple.com/documentation/deviceactivity/deviceactivityreport).

**Friend assignment:** one friend proofreads store copy against actual app behavior; another conducts a clean-install review using only the package and instructions; a privacy reviewer compares the permission screen, privacy policy, and data safety answers.

**Deliverables:** review packet, packaged build and checksum, store text/screenshots, policy checklist, installation test, support/rollback notes, and iPhone feasibility brief.

**Exit gate:** the owner receives a complete, internally consistent release packet. Publication is a separate owner decision after any required external review. An iPhone schedule is not promised by Android completion.

## 4. Friend-ready assignment cards

Copy one card into a separate task with a named owner, due date, and the relevant WP number. These cards are deliberately narrow so friends can contribute without conflicting edits to the shared code branch.

### Card A — One-game phone usability review

**Input:** selected game, existing controls/help, current Windows capture, target phone.
**Do:** play or walk through ready, active, win, loss, help, and Back. Record unreadable values, ambiguous actions, missed touch targets, and what is not visible when making a risk decision. Sketch a phone layout without changing rules.
**Output:** one-page issue list with priority, annotated captures, device dimensions, and three specific improvements.
**Accept:** another person can reproduce each serious issue. Avoid changing shared code.

### Card B — Original art packet

**Input:** approved art direction, exact game geometry, list of independently moving objects.
**Do:** prepare one background or object family at a time, keep clean originals, note creator/prompt, rights, dimensions, alpha behavior, light/dark use, and expected phone crop. Provide smaller variants only after the source is accepted.
**Output:** untouched sources, runtime candidates, provenance sheet, and previews on a small phone mockup.
**Accept:** no brand marks, copied provider imagery, baked-in payout text, false UI, unlicensed characters, or cropped gameplay objects. The integrator promotes only reviewed assets during the correct game WP.

### Card C — Device and earning test

**Input:** candidate build, written WP2/WP3 protocol, test phone.
**Do:** time known sessions in TikTok, Instagram, and YouTube; separate ordinary feeds and short-video areas; test switches, lock, pause, permission off/on, app restart, and repeated scan. Never upload personal content or account details into the report.
**Output:** device/app versions, timestamped expected-versus-actual credits, false/missed cases, and battery observations.
**Accept:** every credit discrepancy has reproduction steps and the claimed earning mode matches what the app actually measures.

### Card D — Payout cross-check

**Input:** exact rule and payout table for one game, reference tests, seeded sample outcomes.
**Do:** independently derive counts/probabilities or enumerate finite outcomes, recompute expected return, inspect rounding, and compare sample settlements with ledger entries.
**Output:** calculation sheet or review note with assumptions, result, discrepancies, and reviewer name.
**Accept:** no result relies only on “it looks fair” or a small simulation; unresolved differences block the game's gate.

### Card E — Visual acceptance on a real phone

**Input:** game candidate, two themes, reduced-motion setting, small and large font settings.
**Do:** capture ready, active, win, loss, disabled action, and help; inspect card/number contrast, object layering, touch positions, and animation/result agreement.
**Output:** annotated capture set and a concise pass/fail table.
**Accept:** all required actions stay legible and reachable on the tested device. A polished image cannot compensate for a broken game action.

## 5. Practical tracker template

Maintain a small table in the project tracker or a reviewed repository document; do not leave progress scattered only in chat messages.

| Field | Meaning |
| --- | --- |
| WP and subtask | Example: `WP8B Plinko touch layout` |
| Owner and reviewer | Two names; owner implements, reviewer checks evidence |
| Dependency | Exact prior WP or API needed |
| Status | `not started`, `in progress`, `review`, `blocked`, or `accepted` |
| Candidate revision | Commit/hash or asset packet version actually reviewed |
| Tests and devices | Commands/results and model/OS for real-device work |
| Open risks | Concrete issue, severity, next action, owner |
| Handoff link | Design, captures, calculations, and test report |

For game groups, keep a row for each individual game and a separate group gate. Do not advance a group because two of three games pass. If a later shared-component change affects earlier games, rerun the affected earlier tests and update their evidence. Keep unverified achievements labelled as pending.

## 6. Key product rules to protect throughout

- **Play money:** credits have no monetary value and cannot be purchased, redeemed, or transferred. Version one has no accounts or cross-device sync.
- **Earning:** three credits per complete qualifying minute under the signal selected in WP2. A minute is never awarded twice; uncertain time is not invented. The displayed name reflects what is measured.
- **Fairness:** an engine commits outcomes before presentation. A player's win streak or balance never changes a committed result. The house edge arises from disclosed payout rules or documented AI behavior, not secret per-player manipulation.
- **Difficulty:** show what changes. Risk presets change probability/volatility or published payout; AI levels change opponent policy; neither grants hidden knowledge to the house.
- **Privacy:** request only the Android access needed for the selected earning signal, obtain informed consent, keep local data minimal, and make revocation work. Do not inspect messages, video contents, or unrelated apps.
- **Performance:** original imagery is welcome, but texture memory, asset loading, frame pacing, and battery impact must be measured on the low-end phone before acceptance.
- **Continuity:** retain the Windows casino, frozen Rocket baseline, reviewed assets, and accepted rules while the Android version develops. Never describe a preview as a finished thirteen-game phone release.
