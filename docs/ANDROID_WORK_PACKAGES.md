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

**Test:** Fix labels and thresholds before viewing results. On one real phone, perform at least 100 deliberate eligible swipes and 100 other gestures per app; also run 30 minutes per app of normal feeds, comments, taps, autoplay/passive viewing, and non-Shorts YouTube. Include fast/slow swipes, switches, lock, service restart, and permission revocation. Record ground truth and per-app versions without retaining private content.

**GO:** Each app independently reaches at least 98% precision and 90% recall on labeled eligible swipes, with zero falsely qualifying minutes in negative controls. Lock, switch, and revocation stop qualification. The minute rule is measurable and explainable. Repeat signal checks on a second phone before WP4 acceptance.

**NO-GO:** An app fails, feed context cannot be distinguished, permission loss is unsafe, or the minute rule is materially misleading. Stop for owner decision. Foreground app time remains an alternative product proposal only.

**Friend assignment:** Run and label the fixed sessions; independently inspect false positives. **Lead:** Codex Astra, xhigh.

## WP1 — Permission, privacy, and Play preflight

Produce an in-app disclosure and consent flow stating the exact observed signal, eligible apps, purpose, local retention, what is not collected, revocation steps, and what earning stops afterward. Consent is affirmative and precedes enabling the service. Never call Scroll2Roll an accessibility tool. Review current Play AccessibilityService declaration, user-data, age-rating, and simulated-gambling requirements against the actual feature. Reference: https://support.google.com/googleplay/android-developer/answer/10964491?hl=en and https://support.google.com/googleplay/android-developer/answer/9214102?hl=en .

**GO:** Truthful disclosure and a credible declaration path, with unresolved review risk recorded. This does not claim Google approval. **NO-GO:** Required access cannot be justified or a clear policy blocker appears; stop for owner direction. **Friend:** Review copy as a new user. **Lead:** Codex Astra, high; ChatGPT high for copy.

## WP2 — Bounded Rocket Android architecture spike

Time-box to 10 working days after the toolchain and physical phone are available. Prove Rocket code can build into an APK, launch, draw a scene and texture, handle tap/drag, survive repeated pause/resume and surface recreation, and shut down cleanly. Measure memory and frame pacing.

**Architecture A GO:** Every behavior works repeatedly on a real phone within the limit, using a small maintainable Kotlin platform bridge without major Rocket compiler/runtime/ABI expansion. **Otherwise choose B:** native Android v1, using deterministic fixtures and parity tests from existing Scroll2Roll game behavior. Record the blocker and cost. Do not extend the spike into a months-long Rocket platform project. **Friend:** Record physical-device lifecycle results. **Lead:** Codex Astra, xhigh.

## WP3 — Wallet and earning ledger

Create one versioned local credit authority. The Android observer supplies eligible intervals and permission state, never credit amounts. Normalize overlap, persist credited intervals and partial-minute remainder, then award exactly 3 integer credits per completed minute once. Use system-derived or monotonic timing where available, handle reboot, and distrust wall-clock changes. Missing or ambiguous evidence earns nothing; local-only storage cannot guarantee resistance to a fully controlled device.

Engines propose validated wager/settlement operations, and only the wallet commits them atomically. Views display amounts but never compute payouts. Keep balances nonnegative and bounded, recover safely from corrupt data, and define interruption handling for an unsettled hand.

**GO:** Deterministic tests for 59/60/119/120 seconds, repeated/overlapping scans, restart, reboot, timezone/DST, clock rollback, permission change, insufficient funds, overflow, corrupt save, and interrupted write. No tested interval awards twice and no failed wager partially changes balance. **Friend:** Independently calculate scripted balances. **Lead:** Codex Sol, high.

## WP4 — Blackjack product MVP

Build a restrained portrait lobby, permission state, wallet/history, help, settings, and touch-playable Blackjack. Temporary original art is sufficient. Preserve tested Blackjack rules, exact 3:2 settlement, legal actions, hidden dealer information, and deterministic fixtures. Demonstrate: scroll → earn → open app → wager → play → settle → close → reopen with the correct balance.

**GO:** Full loop on a real phone, including interruptions, revocation, low balance, repeated rounds, save/reopen, readable controls, and reduced-motion result clarity. Stabilize on one older/low-end and one modern phone; reopen WP0 if the second phone changes signal behavior. **Friend:** Play full hands and identify unclear actions. **Lead:** Codex Astra, high.

## WP5 — Owner product and distribution checkpoint

Review the MVP, measured signal accuracy, wallet evidence, user comprehension, privacy flow, and device results. Seek review of a representative permission-bearing Play build where the submission process allows; policy reading alone is not store approval. The owner chooses the first public-release game count and whether to fund mass migration. Do not migrate broadly while earning or distribution is unresolved. **Friend:** Check store claims against actual behavior. **Lead:** Codex Astra, high.

## WP6 — Existing-game migration

Migrate the remaining ten existing games one at a time. For each: connect tested rules and wallet; define public state, legal actions, wager and settlement; adapt portrait controls and help; integrate original layered art with provenance and bounded resource ownership; animate only committed results; run focused and full regression tests. Each game must work on a real phone in ready, active, and result states.

Follow the repository's visual groups sequentially in the shared checkout: (1) Midnight Crossing, Crash, Coop Climb; (2) final Blackjack art, Texas Hold'em, Roulette; (3) Slots, Plinko, Mines; (4) Dice, HiLo. The functional Blackjack MVP precedes final Group 2 art. Friends can prepare independent art and QA in parallel, but one integrator accepts a group before the next is merged. **Lead:** Codex Sol/Astra, high per game.

## WP7 — Economy and device acceptance

Independently calculate and test payout math for every included wagered configuration. Difficulty may change disclosed challenge or risk, never rewrite a committed result. Run long sessions, permissions, restart, reduced-motion, accessibility, memory, heat, battery, and frame-pacing tests on at least three representative device/OS combinations. Fix and repeat affected cases.

**GO:** No reproducible lost wager, duplicate credit, hidden-state leak, inaccessible required action, crash, or material low-end lag. **Friends:** Shared device sheet and independent math review. **Lead:** Codex Astra for economy; Codex Sol for QA.

## WP8 — Android release decision

Prepare accurate privacy text, Data safety and permission declarations, age rating, reviewed package, help, and store copy. The owner reviews evidence and separately authorizes any submission or publication. iPhone is outside this WP. **Friend:** Compare final copy and captures with the build. **Lead:** Codex Astra, high.

## Postponed decisions and Windows reference

Video Poker and Guess the Number are later updates, not Android v1 commitments. Also postpone iPhone, accounts, sync, purchases, transfers, cash-out, prizes, and full art production before the MVP. Consider a daily earning cap or diminishing return only from MVP evidence and an explicit owner decision; disclose it if adopted.

Preserve the Windows 0.3.1 reference commit/tag, source, tests, assets, documents, and historical validation. Android WPs do not maintain Windows packaging or desktop UI. Extract deterministic rule fixtures when migrating each game. Do not describe the Windows build or Rocket preview as an Android app.

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
