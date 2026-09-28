# Scroll2Roll Android work packages

**Status:** owner-approved roadmap, not Android implementation.
**Product:** Android-first phone casino. Qualifying scrolling in TikTok, Instagram Reels, and YouTube Shorts earns local, non-transferable credits to play existing games.
**First product milestone:** a complete earning-to-Blackjack loop.
**Owner decision:** 2026-09-28. This replaces the earlier WP0–WP13 ordering and automatic app-time fallback.

## Starting point and boundaries

The Windows 0.3.1 casino has eleven games: Blackjack, European Roulette, Plinko, Coop Climb, Midnight Crossing, No-Limit Texas Hold'em, Mines, Dice, HiLo, Crash, and Slots. Preserve its source, tests, assets, documentation, and Git history as a reference, without maintaining Windows packaging during the Android rewrite. The Rocket 3.5 package is a Windows lobby/settings/Blackjack-table preview without wagers. Rocket has no established Android target. The sparse checkout omits tracked historical game sources from disk; use an isolated full checkout when migration begins.

Credits have no cash value. They cannot be bought, sold, transferred, withdrawn, or redeemed for cash or prizes. There are no accounts or cross-device sync in the first release. Use “Scroll to earn credits,” never “scroll for money.” Do not add app-time earning, a daily cap, or a different reward rate silently.

The wallet alone commits balance changes. Game engines own rules, legal actions, payouts, and hidden outcomes. Views receive public state and animate only committed results. Preserve deterministic tests, integer payouts, privacy-safe projections, reduced-motion behavior, original art provenance, bounded resources, and real-device evidence. Do not inspect or store video content, captions, DMs, account names, screenshots, or unrelated app activity.

## Dependency map

WP0 scrolling signal → WP1 permission/Play preflight → WP2 Android architecture → WP3 wallet → WP4 Blackjack MVP → WP5 owner/distribution checkpoint → WP6 existing games → WP7 economy/device acceptance → WP8 release decision.

Policy research and friend-led test preparation may overlap WP0. A failed WP0 stops the original concept for an owner choice: redesign the earning signal, choose an honestly named app-time product, or cancel. App time is not an automatic fallback. A failed Rocket spike selects native Android architecture B. A blocked distribution path stops mass migration.

Each WP handoff records the exact branch/build, what works, changed files or art provenance, reproducible tests with actual results, device/OS/app versions where relevant, known limits, a short demonstration, and the next gate. Update PROJECT_CONTEXT.md at meaningful milestones. Screenshots alone do not establish completion.

## WP0 — Disposable scrolling-signal experiment

**Goal:** Determine whether Android can reliably distinguish short-video-feed swipes from ordinary activity in all three apps before investing in a casino port.

**Entry:** Record the current repository commit and Windows reference. Confirm one physical Android phone, its OS and selected app versions, and the local toolchain. Estimate disk use and ask before an operation that could exceed 20 GiB. Do not expand the sparse checkout or build Rocket merely for this spike.

**Build:** A tiny disposable Kotlin Android app with an AccessibilityService limited to the three eligible packages and a diagnostic screen displaying candidate events and permission state. No wallet, casino, Rocket, or production earning. Record only package, event type, timestamp, and minimal non-content fields required for classification; do not upload telemetry.

**Proposed qualifying minute:** Count foreground, unlocked time between consecutive confirmed eligible short-feed swipes when their gap is at most 30 seconds. Do not count time after the last observed swipe. Accumulate 60 qualifying seconds for a proposed 3-credit award. This is a test hypothesis, not a claim that Android can observe every second of scrolling. Check whether users understand it and whether it honestly matches the product promise.

**Test:** Fix ground-truth labels, detector rules, metrics, and thresholds before viewing a validation run. On one real phone, perform at least 100 deliberate eligible swipes and 100 other gestures per app; also run 30 minutes per app of normal feeds, comments, taps, autoplay/passive viewing, and non-Shorts YouTube. Include fast/slow swipes, switches, lock, service restart, and permission revocation. Record ground truth, OS version, and the tested version of each app for every run without retaining private content. Discovery/debug runs may guide engineering, but any detector, classifier, heuristic, view-identification rule, or threshold changed after inspecting a validation run invalidates that run as GO evidence. Validate the revised detector on fresh sessions that were never used to tune it.

**Provisional signal GO:** On the first physical phone, each app independently reaches at least 98% precision and 90% recall on labeled eligible swipes, with zero falsely qualifying minutes in negative controls. Lock, switch, and revocation stop qualification. The minute rule is measurable and explainable. Repeat the full per-app signal gate on a second materially different Android phone before WP4 acceptance; the first-phone result alone never completes cross-device validation.

**NO-GO:** An app fails, feed context cannot be distinguished, permission loss is unsafe, or the minute rule is materially misleading. Stop for owner decision. Foreground app time remains an alternative product proposal only. Treat detection behavior as app-version-sensitive. Prefer stable non-content event characteristics over fragile view IDs, labels, hierarchy positions, or content text. If an app update materially changes the signal, or confidence drops below the accepted threshold, disable earning for that app until fresh validation passes. Show an honest per-app unavailable state, such as “Instagram earning temporarily unavailable — compatibility check required.” Never guess, use stale assumptions, or silently switch the affected app to foreground-time earning.

**Friend assignment:** Run and label the fixed sessions; independently inspect false positives. **Lead:** Codex Astra, xhigh.

## WP1 — Permission, privacy, and Play preflight

Produce an in-app disclosure and consent flow stating the exact observed signal, eligible apps, purpose, local retention, what is not collected, revocation steps, and what earning stops afterward. Consent is affirmative and precedes enabling the service. Never call Scroll2Roll an accessibility tool. Review current Play AccessibilityService declaration, user-data, age-rating, and simulated-gambling requirements against the actual feature. Reference: https://support.google.com/googleplay/android-developer/answer/10964491?hl=en and https://support.google.com/googleplay/android-developer/answer/9214102?hl=en .

**GO:** Truthful disclosure and a credible declaration path, with unresolved review risk recorded. This does not claim Google approval. **NO-GO:** Required access cannot be justified or a clear policy blocker appears; stop for owner direction. **Friend:** Review copy as a new user. **Lead:** Codex Astra, high; ChatGPT high for copy.

## WP2 — Bounded Rocket Android architecture spike

Time-box to 10 working days after the toolchain and physical phone are available. Prove Rocket code can build into an APK, launch, draw a scene and texture, handle tap/drag, survive repeated pause/resume and surface recreation, and shut down cleanly. Measure memory and frame pacing.

**Architecture A GO:** Every behavior works repeatedly on a real phone within the limit, using a small maintainable Kotlin platform bridge without major Rocket compiler/runtime/ABI expansion. **Otherwise choose B:** native Android v1, using deterministic fixtures and parity tests from existing Scroll2Roll game behavior. Record the blocker and cost. Do not extend the spike into a months-long Rocket platform project. **Friend:** Record physical-device lifecycle results. **Lead:** Codex Astra, xhigh.

## WP3 — Wallet and earning ledger

Create one versioned local credit authority. The Android observer supplies eligible intervals and permission state, never credit amounts. Normalize overlap, persist credited intervals and partial-minute remainder, then award exactly 3 integer credits per completed minute once. Use system-derived or monotonic timing where available, handle reboot, and distrust wall-clock changes. Missing or ambiguous evidence earns nothing; local-only storage cannot guarantee resistance to a fully controlled device. WP0 proves whether eligible scrolling can be detected; this WP separately proves that qualifying time produces the exact credit once and only once. Detector accuracy percentages cannot substitute for ledger tests.

Engines propose validated wager/settlement operations, and only the wallet commits them atomically. Views display amounts but never compute payouts. Keep balances nonnegative and bounded, recover safely from corrupt data, and define interruption handling for an unsettled hand.

**GO:** Deterministic tests for 59/60/119/120 seconds, repeated/overlapping scans, restart, reboot, timezone/DST, clock rollback, permission change, insufficient funds, overflow, corrupt save, and interrupted write. No tested interval awards twice and no failed wager partially changes balance. **Friend:** Independently calculate scripted balances. **Lead:** Codex Sol, high.

## WP4 — Blackjack product MVP

Build a restrained portrait lobby, permission state, wallet/history, help, settings, and touch-playable Blackjack. Temporary original art is sufficient. Preserve tested Blackjack rules, exact 3:2 settlement, legal actions, hidden dealer information, and deterministic fixtures. Demonstrate: scroll → earn → open app → wager → play → settle → close → reopen with the correct balance.

**GO:** Full loop on a real phone, including interruptions, revocation, low balance, repeated rounds, save/reopen, readable controls, and reduced-motion result clarity. Stabilize on one older/low-end and one modern phone. Repeat the WP0 per-app validation thresholds on the second materially different phone; if an app differs materially or fails, reopen its signal work and disable its earning before accepting this MVP. **Friend:** Play full hands and identify unclear actions. **Lead:** Codex Astra, high.

## WP5 — Owner product and distribution checkpoint

Review the MVP, measured signal accuracy, wallet evidence, user comprehension, privacy flow, and device results. Seek review of a representative permission-bearing Play build where the submission process allows; policy reading alone is not store approval. The owner chooses the first public-release game count and whether to fund mass migration. Do not migrate broadly while earning or distribution is unresolved. **Friend:** Check store claims against actual behavior. **Lead:** Codex Astra, high.

## WP6 — Existing-game migration

Migrate the remaining ten existing games one at a time. For each: connect tested rules and wallet; define public state, legal actions, wager and settlement; adapt portrait controls and help; integrate original layered art with provenance and bounded resource ownership; animate only committed results; run focused and full regression tests. Each game must work on a real phone in ready, active, and result states.

Integrate the existing visual groups sequentially in the shared checkout: (1) Midnight Crossing, Crash, Coop Climb; (2) final Blackjack art, Texas Hold'em, Roulette; (3) Slots, Plinko, Mines; (4) Dice, HiLo. The functional Blackjack MVP precedes final Group 2 art. Independent art preparation and QA may proceed in parallel, but one integrator accepts a group before the next is merged. **Lead:** Codex Sol/Astra, high per game.

## WP7 — Economy and device acceptance

Independently calculate and test payout math for every included wagered configuration. Difficulty may change disclosed challenge or risk, never rewrite a committed result. Run long sessions, permissions, restart, reduced-motion, accessibility, memory, heat, battery, and frame-pacing tests on at least three representative device/OS combinations. Fix and repeat affected cases.

**GO:** No reproducible lost wager, duplicate credit, hidden-state leak, inaccessible required action, crash, or material low-end lag. **Friends:** Shared device sheet and independent math review. **Lead:** Codex Astra for economy; Codex Sol for QA.

## WP8 — Android release decision

Prepare accurate privacy text, Data safety and permission declarations, age rating, reviewed package, help, and store copy. The owner reviews evidence and separately authorizes any submission or publication. iPhone is outside this WP. **Friend:** Compare final copy and captures with the build. **Lead:** Codex Astra, high.

## Postponed decisions and Windows reference

Video Poker and Guess the Number are later updates, not Android v1 commitments. Also postpone iPhone, accounts, sync, purchases, transfers, cash-out, prizes, and full art production before the MVP. Consider a daily earning cap or diminishing return only from MVP evidence and an explicit owner decision; disclose it if adopted.

Preserve the Windows 0.3.1 reference commit/tag, source, tests, assets, documents, and historical validation. Android WPs do not maintain Windows packaging or desktop UI. Extract deterministic rule fixtures when migrating each game. Do not describe the Windows build or Rocket preview as an Android app.

## Ryan and Eddie: parallel development phases

The WPs above remain authoritative; phases coordinate simultaneous work without skipping gates. Ryan maintains the integration branch and owns mechanical merges; Eddie reviews any shared-interface resolution. Engineering load is balanced across the whole program, not by counting files or games. Both own implementation and tests. Before each phase, agree on a small interface, its privacy boundary, fixtures, and one owner for each shared file. Record it in the phase handoff before lane branches diverge. Any later interface change requires both contributors to agree and rerun affected lane and integration tests.

Planned lane paths are android/observer and android/signal for A; android/platform and android/rocket for B; android/wallet and android/earning for C; android/ui and android/games/blackjack for D; android/games/<game>, assets/android/<game>, and corresponding tests for E. These paths are ownership boundaries, not a claim that the directories already exist. If Architecture A or B requires a different physical layout, Ryan and Eddie record the equivalent exact paths before opening that phase's lane branches. Ryan owns shared Android build/manifest files, the game registry, shared UI components, asset manifest, and PROJECT_CONTEXT.md at checkpoints. Eddie consumes their frozen interfaces. Ryan may not alter a shared contract without Eddie's review.

**Git pattern:** This roadmap remains on the planning branch. After WP0 is authorized, create continuing integration branch codex/android from the accepted planning commit. For phase A, create codex/android-a-ryan and codex/android-a-eddie from the same accepted codex/android commit in separate worktrees; repeat the suffix pattern for phases B–F. Do not work in the same checkout. The accepted integration HEAD is the next phase's base. The named integration order below applies to scoped commits, not to bulk merges containing unaccepted later games. Do not create permanent branch forests or push future work without the owner's applicable approval.

| Phase and WPs | Ryan technical lane | Eddie technical lane | Shared contract and integration order |
| --- | --- | --- | --- |
| **A — WP0–WP1 risk validation** | Signal classifier, ground-truth fixtures, accuracy analysis, and permission/disclosure prototype. | Disposable Kotlin AccessibilityService observer, package filter, diagnostic screen, and lifecycle/revocation probe. | Freeze a content-free diagnostic event envelope first. Integrate Eddie observer, then Ryan classifier and consent work; run fresh validation sessions only after the combined detector is fixed. WP1 final wording follows the measured signal. |
| **B — WP2 platform decision** | Android APK host, surface/lifecycle and touch bridge, physical-device harness. | Rocket compile/render/resource proof and focused tests. | Freeze platform callbacks first. Integrate Ryan host, then Eddie Rocket proof; choose A or B within ten working days. |
| **C — WP3 wallet** | Versioned wallet core, atomic transactions, persistence and balance invariants. | Interval normalization, Android earning adapter, replay and fault fixtures. | Freeze eligible-interval and earn-request contract. Integrate Ryan wallet, then Eddie adapter; replay earning and failure cases end to end. |
| **D — WP4–WP5 MVP** | Portrait shell, wallet/permission UI, navigation, touch controls, usability and device evidence. | Blackjack engine parity, legal actions, public state, wager connection and deterministic tests. | Freeze game public-state/action/settlement contract. Integrate Eddie tested engine, then Ryan UI. The owner and distribution checkpoint follows full MVP acceptance. |
| **E — WP6 game migration** | Midnight Crossing; final Blackjack art and Hold'em; Slots; Dice. Ryan owns shared game registry/shell changes. | Crash and Coop Climb; Roulette; Plinko and Mines; HiLo. Eddie owns only his game-scoped engine/view/tests/assets. | Freeze wallet, game-host, shell and asset-lifetime contracts. Integrate games in visual-group order, each with focused and full regression before the next game/group is accepted. |
| **F — WP7–WP8 acceptance** | Device/performance/accessibility matrix, UI fixes, reviewed package and store-copy evidence. | Independent economy math, ledger/game fault tests, privacy and payout regression evidence. | Both evidence sets must pass. Integrate fixes by ownership, repeat affected and full gates, then prepare WP8 review. No submission without owner authorization. |

### Lane boundaries and handoffs

- **Phase A:** Eddie owns the observer module and its service tests; he does not tune Ryan's classifier against the validation set. Ryan owns the classifier/analysis and consent/test materials; he does not change service event collection without a coordinated envelope revision. The shared diagnostic envelope carries only the eligible package, event time/type, minimal approved non-content descriptors, and interactive/foreground state. Eddie hands over reproducible events and revocation evidence; Ryan hands over labels, metrics, disclosure copy, and fresh validation results.
- **Phase B:** Ryan owns Android host/build/lifecycle files and touch tests; Eddie owns the isolated Rocket mobile proof and render/resource tests. Neither edits the other's core area without review. Their agreed bridge covers surface-ready/lost, pointer input, pause/resume, and shutdown. Both hand over physical-device logs and the A/B decision record.
- **Phase C:** Ryan alone owns wallet storage and transaction files; Eddie alone owns interval conversion and replay harness. The observer cannot award credits directly. Eddie hands over deduplicated eligible intervals and fault cases; Ryan hands over atomic wallet API and persistence tests. A changed interval or transaction contract is integrated jointly.
- **Phase D:** Eddie owns Blackjack rule port/parity tests; Ryan owns shell, navigation, and touch presentation. Views consume only the agreed public state and legal actions, and the wallet alone settles balances. Each hands over a demo and focused tests; integration proves the entire scroll-to-reopened-balance loop on real phones.
- **Phase E:** Each game lives in its own engine/view/test/asset area. Ryan alone owns the shared registry, shell, and common components during this phase; Eddie requests any common change through a reviewed interface proposal. Both avoid editing the wallet or another game owner's files. Use game-scoped commits. Integrate Midnight Crossing → Crash → Coop Climb; final Blackjack art → Hold'em → Roulette; Slots → Plinko → Mines; Dice → HiLo. If one lane contains two games, integrate and test its commits separately, not as a bulk merge. Parallel game coding is allowed within the current approved group, but the next group waits for the current group gate.
- **Phase F:** Ryan owns device/UI/performance evidence and fixes; Eddie owns math/ledger/privacy evidence and fixes. Neither certifies the other lane solely from screenshots or assertions. The final handoff records actual devices, game configurations, failures and retests, release-candidate hash, and owner decision.

### Phase synchronization checkpoint

At every phase end: (1) Ryan runs his focused tests; (2) Eddie runs his; (3) Ryan integrates lane commits in the listed order; (4) both resolve interface mismatches; (5) run affected integration and regression tests; (6) update PROJECT_CONTEXT.md; (7) record the exact accepted integration commit; (8) retire temporary branches only after integration is confirmed; (9) do not start a dependent WP whose gate failed. An early-finishing lane may review or add isolated tests, but must not implement blocked downstream work. Preserve unfinished branch work rather than deleting it.

Unavoidable sequential bottlenecks are real observer data before final classifier validation, WP0/WP1 decisions before the Rocket investment, architecture choice before the production client, wallet/Blackjack integration before WP5, visual-group acceptance order, and the owner release decision. A phase cannot pass because only one lane succeeded.

### Per-phase ownership and sync gates

The paths below are planned ownership roots, not a claim that those
directories already exist. Before lane branches open, record exact files (or
equivalent paths if the architecture changes), interface version, fixtures,
integration order, gate evidence, and any workload rebalance on that phase's
Private GitHub Phase Sync issue. Balance meaningful engineering work rather
than file or game counts. Ryan is the integration owner for every phase and
performs the listed sequential integration; Eddie reviews shared-interface
resolution. Ryan also owns shared Android build/manifest files, the game
registry, shared UI components, asset manifest, and `docs/PROJECT_CONTEXT.md`
at checkpoints. Keep current and future phase issues separate: Phase A is the
first active issue; create each later issue only when that phase starts.

| Phase | Ryan primary ownership | Eddie primary ownership | Shared interface and issue | Integration owner/order | Phase exit gate |
| --- | --- | --- | --- | --- | --- |
| **A — WP0–WP1 risk validation** | `android/signal/**`: classifier, labeled ground-truth fixtures, accuracy analysis, validation tooling, and consent/disclosure materials. | `android/observer/**`: disposable Kotlin AccessibilityService, eligible-package filter, diagnostic screen, lifecycle and revocation tests. | Versioned content-free diagnostic envelope: eligible package, event time/type, minimal approved non-content descriptors, interactive/foreground state. `[SYNC] Phase A — WP0–WP1 risk validation` (active first issue). | Ryan integrates Eddie's observer, then Ryan's classifier and consent work. | WP0 first-phone result is provisional only: each app meets precision/recall and zero-false-minute thresholds; lock, switch, and revocation stop qualification. WP1 review records GO/NO-GO and remaining risk. Detector tuning after a validation run requires fresh untouched sessions. Repeat the per-app gate on a second materially different phone before WP4 acceptance. A NO-GO stops for owner direction. |
| **B — WP2 platform decision** | `android/platform/**`: APK host/build, surface and lifecycle, touch bridge, physical-device harness. | `android/rocket/**`: isolated Rocket compile/render/resource proof and focused tests. | Versioned callbacks for surface ready/lost, pointer input, pause/resume, and shutdown. `[SYNC] Phase B — WP2 platform decision` (open at phase start). | Ryan integrates host/bridge, then Eddie's bounded Rocket proof. | Within ten working days on a real phone, prove APK build/launch, scene and texture drawing, tap/drag, repeated pause/resume and surface recreation, clean shutdown, memory, and frame pacing. Select A only if every criterion passes without major compiler/runtime/ABI expansion; otherwise record cost/blocker and choose native Android B. |
| **C — WP3 wallet** | `android/wallet/**`: versioned wallet core, atomic transactions, persistence, balance invariants. | `android/earning/**`: interval normalization, Android earning adapter, replay harness, fault fixtures. | Versioned eligible-interval and earn-request contract. Observer supplies evidence/permission state, never amounts; wallet alone awards credits and commits wager/settlement changes. `[SYNC] Phase C — WP3 wallet` (open at phase start). | Ryan integrates wallet authority, then Eddie's adapter; replay end to end. | Pass WP3 deterministic ledger cases, including 59/60/119/120 seconds, overlap/replay, restart/reboot/time changes, permission changes, insufficient funds, overflow, corrupt saves, and interrupted writes. No interval awards twice; failed wagers cannot partially change balance; balances remain nonnegative and bounded. |
| **D — WP4–WP5 MVP** | `android/ui/**`: portrait shell, wallet/permission UI, navigation, touch controls, usability and device evidence. | `android/games/blackjack/**`: Blackjack rules port/parity, legal actions, public state, wager connection, deterministic tests. | Public-state/action/settlement contract; views consume legal public state, wallet alone settles. `[SYNC] Phase D — WP4–WP5 MVP` (open at phase start). | Ryan integrates Eddie's tested engine, then Ryan's UI. WP5 follows full MVP acceptance. | Demonstrate the complete scroll-to-credit-to-Blackjack-to-reopened-balance loop on real phones, including interruptions, revocation, low balance, repeat rounds, save/reopen, readable controls, and reduced-motion clarity. Before WP4 acceptance repeat the WP0 gate on a second materially different phone; disable any app whose signal fails or differs materially until fresh validation passes. Record the WP5 owner and distribution decision before mass migration. |
| **E — WP6 existing-game migration** | `android/games/midnight-crossing/**`, Blackjack presentation, `android/games/holdem/**`, `android/games/slots/**`, `android/games/dice/**`; shared registry/shell/components/asset manifest. | `android/games/crash/**`, `android/games/coop-climb/**`, `android/games/roulette/**`, `android/games/plinko/**`, `android/games/mines/**`, `android/games/hilo/**`; each lane stays within its game engine/view/tests/assets. | Frozen wallet, game-host, shell, public-state/action, and asset-lifetime contracts; record each game's wager/settlement boundary before migration. `[SYNC] Phase E — WP6 game migration` (open at phase start). | Ryan integrates scoped game commits one at a time in WP6 visual-group order; no bulk merge of later games. | Migrate all ten remaining games one at a time. Each passes focused and full regressions and works on a real phone in ready/active/result states. Preserve groups and order: Midnight Crossing → Crash → Coop Climb; final Blackjack art → Hold'em → Roulette; Slots → Plinko → Mines; Dice → HiLo. Each group gate passes before the next begins. |
| **F — WP7–WP8 acceptance** | Device/performance/accessibility matrix and UI fixes; reviewed package, help, store-copy evidence, and release-candidate assembly. | Independent economy math, ledger/game fault tests, privacy review, payout regression evidence. | Shared acceptance evidence and exact release-candidate hash; fixes stay with the component owner. `[SYNC] Phase F — WP7–WP8 acceptance` (open at phase start). | Ryan integrates scoped owner-assigned fixes; Eddie reviews shared contracts; both rerun affected gates. | Pass WP7 math and three representative device/OS combinations, including long sessions, permissions, restart, reduced motion, accessibility, memory, heat, battery, and frame pacing. No reproducible lost wager, duplicate credit, hidden-state leak, inaccessible required action, crash, or material low-end lag. Prepare WP8 evidence and owner decision; no submission without explicit owner authorization. |

## Progress tracker

| WP | Status | Required evidence |
| --- | --- | --- |
| 0 Scroll signal | Not started | Physical-phone measurements |
| 1 Permission/Play | Not started | Disclosure and policy assessment |
| 2 Architecture | Not started | Physical APK proof and A/B decision |
| 3 Wallet | Not started | Deterministic ledger tests |
| 4 Blackjack MVP | Not started | Full loop on real phones |
| 5 Expansion checkpoint | Not started | Owner and distribution decision |
| 6 Existing games | Not started | Per-game and per-group gates |
| 7 Economy/device | Not started | Independent math and device matrix |
| 8 Release | Not started | Owner submission decision |
