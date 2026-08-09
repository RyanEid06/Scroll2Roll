# Scroll2Roll 0.3.0 Implementation Mandate

## Authority and objective

This file records owner approval to begin the Scroll2Roll 0.3.0 expansion now.
Do not stop after planning, analysis, architecture notes, or scaffolding. Continue
through implementation, testing, packaging, documentation, and logical local
commits until every acceptance gate in this document passes or a genuine,
fully investigated blocker prevents further progress.

Implement five complete games in this order:

1. Mines.
2. Dice.
3. HiLo.
4. Crash.
5. Slots.

Complete each game fully before beginning the next. Preserve all completed
Scroll2Roll 0.2.0 games and functionality.

This mandate extends but does not weaken `MASTER_PLAN.md`,
`EXPANSION_PLAN.md`, or `PROJECT_CONTEXT.md`. If wording conflicts, preserve
the stricter privacy, safety, native-only, testing, and frozen-Rocket boundary.

## Required startup procedure

Work only in:

`C:\Users\Administrator\Desktop\Projects\Scroll2Roll`

Before editing:

- Read `AGENTS.md`, `MASTER_PLAN.md`, `EXPANSION_PLAN.md`, this file, and
  `PROJECT_CONTEXT.md` completely.
- Read the relevant architecture, building, testing, controls, visual design,
  packaging, Cloudflare, and validation documentation.
- Inspect Git status and recent history.
- Inspect the current application shell, all six games, persistence, tests,
  package workflow, website, and verified 0.2.0 archive evidence.
- Preserve all user changes.
- Do not modify the frozen Rocket repository.

This is an implementation task. Do not produce another plan and stop. Make
reasonable in-scope decisions, record them in the documentation, and keep
working through the gates below.

## Existing functionality that must remain complete

- Blackjack.
- European Roulette.
- Plinko.
- Coop Climb.
- Midnight Crossing.
- No-Limit Texas Hold'em.
- The reusable native lobby, settings, help, routing, and exit flows.
- Keyboard and mouse support.
- Local play-credit persistence and safe recovery.
- Native raylib resource-lifetime and clean-shutdown behavior.
- The repaired standard raylib frame lifecycle.
- The local-profile, Play, and Download website experience.
- Windows packaging, relocation checks, and Cloudflare staging.
- Every existing regression test.

Do not weaken or remove existing behavior or tests to make the expansion pass.

## Permanent product boundaries

- Scroll2Roll is local, single-player, account-free, and play-money-only.
- Use integer play credits such as `Credits 1,250`, never `$`, currency, cash,
  prizes, or transferable value.
- No accounts, authentication, deposits, withdrawals, payments, purchases,
  cryptocurrency, real-money wagering, or gambling services.
- No networking, cloud saves, multiplayer, fake live players, fake usernames,
  fake user activity, analytics, advertising, or trackers.
- The website's profile remains non-authenticated and browser-local.
- The native Rocket application is not browser-playable.
- The native target remains Windows x64. Support resolution-aware desktop
  keyboard and mouse interaction; do not turn the native game into a mobile or
  web implementation.
- Avoid manipulative urgency, dark patterns, or language designed to encourage
  compulsive play. The experience should be clear, responsive, satisfying,
  premium, and non-misleading.
- Any auto-play or auto-roll feature must be explicitly enabled, finite,
  bounded, easy to stop, and terminate on insufficient credits or its requested
  count.
- Use original Scroll2Roll procedural artwork, layouts, symbols, effects, and
  sounds. Do not copy a casino provider's branding, characters, artwork,
  source, sound, layout, or exact presentation.
- Do not push, deploy, publish, create a release, or claim trusted signing
  without explicit owner approval.

## Version and persistence

- The expansion version is `0.3.0`.
- Preserve valid version-1 and version-2 settings and play-credit progress.
- If new persisted fields are needed, introduce `scroll2roll-save-3` with
  explicit, tested migration from valid save-v1 and save-v2 data.
- Missing, truncated, corrupt, or unsupported save data must recover safely
  with an explicit message.
- Persist credits only at engine-defined settled or safe boundaries.
- Never silently refund, settle, or create credits from a renderer or router.

## Architecture and shared systems

Preserve the existing one-way dependency direction:

1. Small shared values and deterministic utilities where reuse is genuine.
2. A rendering-independent model, rules, engine, and settlement layer per game.
3. A deliberately small presentation-facing API per game.
4. Versioned persistence independent of game rules.
5. Reusable routing, theme, components, overlays, and per-game views.
6. The safe Rocket raylib wrapper over the primitive C++ adapter.

Rules, probabilities, random outcomes, legal actions, settlement, and payouts
must never live in views, the application router, or C++. Views render engine
state and emit intents through a game's API.

Additional requirements:

- Do not create a monolithic shared casino engine.
- Reuse existing credits, deterministic random, history, components, settings,
  and audio systems only where genuine duplication exists.
- Maintain unique `.rocket` source basenames.
- Keep all operations atomic on failure.
- Balances must never become negative.
- Use integer ratios or basis points for fractional multipliers.
- Document every rounding rule.
- Bound every state loop, animation, automated batch, and simulation tick.
- Commit every random result in the engine before its presentation animation.
- Animation must never reroll, change, or select an outcome.
- Add raylib adapter operations only when a demonstrated UI requirement cannot
  be met with the existing reviewed boundary, and test every addition.

## Milestone 1: Mines

Implement a complete 5-by-5 Mines game:

- Allow a validated play-credit wager and 1-24 mine selection before starting.
- Prepay the wager and deterministically commit the complete mine layout when
  the round begins.
- Reveal tiles one at a time without exposing unrevealed mine positions.
- A safe tile increases the current multiplier and potential payout.
- A mine ends the round and loses the prepaid wager.
- Permit cash-out only after at least one safe reveal.
- Derive each multiplier from the exact probability of surviving the revealed
  safe-tile count and a documented play-money return factor.
- Use integer basis points and document floor rounding.
- Include balance, wager, mine count, safe count, multiplier, potential payout,
  result history, help, restart, next round, and safe lobby return.
- Provide original tile, gem, and mine presentation with bounded reveal and
  settlement animations.

Test mine-layout uniqueness, mine-count bounds, exact survival probabilities,
every multiplier, rounding, deterministic seeds, safe reveals, mine failure,
cash-out legality, duplicate reveals, insufficient credits, locked settings,
atomic errors, privacy, consecutive rounds, history bounds, nonnegative
balances, animation agreement, keyboard and mouse flows, restart, persistence,
and lobby return.

## Milestone 2: Dice

Implement a complete Roll Under / Roll Over game:

- Use a documented integer roll domain so probability boundaries do not depend
  on floating-point comparison.
- Validate target, direction, wager, win count, and loss count exactly.
- Display the exact probability, multiplier, potential payout, result, and
  recent history.
- Calculate multipliers from exact win probability and a documented play-money
  return factor using integer arithmetic and explicit rounding.
- Lock each result before the short result animation.
- Support fast manual rounds.
- A finite auto-roll batch may be included, with a small documented maximum,
  explicit stop control, and automatic stop on insufficient credits, a loss or
  win condition if configured, or the requested count.

Test every target boundary and direction, exact probabilities and multipliers,
deterministic results, payout rounding, insufficient credits, invalid settings,
atomic failures, auto-roll bounds and stop conditions, long-session balance
invariants, history bounds, animation agreement, keyboard and mouse flows,
help, persistence, restart, and lobby return.

## Milestone 3: HiLo

Implement a complete Higher / Lower card game:

- Use a checked standard 52-card deck and deterministic Fisher-Yates shuffle.
- Begin with one visible card and keep all future cards private.
- Allow only mathematically possible Higher or Lower actions.
- Equal rank is a loss and must be stated prominently in help and at the table.
- A correct prediction advances the sequence and increases the multiplier.
- A wrong prediction ends the round and loses the wager.
- Permit cash-out after at least one correct prediction.
- Derive each step multiplier from the exact remaining-deck probability and a
  documented play-money return factor with explicit integer rounding.
- Reshuffle only at a documented new-round boundary.
- Include balance, wager, current card, remaining cards, legal predictions,
  current multiplier, potential payout, sequence history, help, restart, next
  round, and safe lobby return.

Test deck uniqueness and exhaustion, exact higher/lower/tie counts for every
rank and remaining-deck state, disabled impossible actions, deterministic
shuffle and draws, tie loss, correct/wrong predictions, cash-out legality,
privacy, payout math, insufficient credits, consecutive rounds, balance and
history bounds, animation agreement, keyboard and mouse flows, persistence,
restart, and lobby return.

## Milestone 4: Crash

Implement a complete local single-player Crash game:

- Validate and prepay the wager before a round begins.
- Precommit a deterministic crash threshold using a documented, tested
  probability distribution and play-money return model.
- Start at 1.00x and advance through bounded fixed simulation ticks.
- Allow the player to cash out only before the committed crash point.
- Settle using the engine's exact integer multiplier at the accepted cash-out
  tick.
- The view may animate an original graph and gradually intensify colors and
  sound, but presentation may not alter timing or outcome.
- Respect existing audio settings and keep all effects bounded.
- Reveal the crash point after settlement and maintain bounded recent history.
- Do not show fake users, fake bets, simulated live activity, or multiplayer
  language.
- If automatic cash-out is included, it must be an explicit single-round target
  validated before the round, not an unbounded automated betting system.

Test the distribution contract, deterministic thresholds, fixed-tick behavior,
cash-out immediately before/at/after the crash boundary, automatic cash-out,
invalid and unaffordable wagers, atomic failure, payout rounding, long-frame
tick caps, pause/help behavior if supported, consecutive rounds, history and
balance bounds, animation agreement, keyboard and mouse flows, persistence,
restart, and lobby return.

## Milestone 5: Slots

Implement an original complete 5-reel by 3-row Scroll2Roll slot machine:

- Define an explicit original symbol catalog.
- Define exact reel strips or auditable per-reel symbol weights.
- Define a fixed, readable payline set.
- Define the complete paytable, bet units, total bet calculation, wild rules,
  scatter rules, free-spin rules, bonus rules, and multiplier rules.
- Publish and test the exact theoretical return from the implemented reel model
  and paytable. Do not state an RTP that is not recomputed from source data.
- Prepay the spin and commit every reel stop and bonus result before animation.
- Animate reels with sequential bounded stops and highlight only engine-proven
  winning paylines.
- Include wager controls, total bet, Spin, win amount, payline results, free
  spins, bonus state, multiplier, history, help, restart, and lobby return.
- Turbo may shorten presentation but may not alter an outcome.
- Autoplay, if included, must use a small explicit maximum spin count, have a
  visible stop control, and terminate on insufficient credits, user stop, or
  requested count.
- Small wins settle promptly. Larger celebrations must remain bounded,
  skippable where practical, and may not obscure the actual settlement.
- Use original procedural symbols rather than copied provider art.

Test reel data, stop bounds, deterministic spins, every payline, every symbol
award, overlapping wins, wild substitution, scatter behavior, free spins,
bonuses, multipliers, exact RTP calculation, total-bet validation, insufficient
credits, atomic errors, Turbo agreement, autoplay bounds and stopping, long
sessions, balance invariants, animation agreement, keyboard and mouse flows,
help, persistence, restart, and lobby return.

## Native application presentation

- Extend the responsive lobby from six to eleven completed game cards.
- Preserve the established dark navy, panel, gold, emerald, red, text, muted,
  and border tokens.
- Give each new game an original accent while retaining shared components and
  navigation.
- Support the existing minimum window size without overlaps or clipped actions.
- Maintain clear focus, hover, pressed, disabled, active, result, and error
  states.
- Provide keyboard and mouse parity for a complete flow in every game.
- Provide visible rules, probability or return information, rounding behavior,
  help, outcomes, restart, and lobby return.
- Preserve clean shutdown, missing-audio behavior, resource-lifetime safety,
  and standard `EndDrawing()` frame control.

## Website and download experience

- Preserve the local-only profile onboarding and profile edit/reset behavior.
- Expand the Play catalog to all eleven completed native games.
- Give every new card original Scroll2Roll illustration and accurate native
  launcher language.
- Continue stating clearly that the games do not run in the browser.
- Do not add website wagering, game simulation, accounts, payments, networking,
  analytics, or trackers.
- Keep responsive phone layouts, keyboard navigation, visible focus, reduced
  motion, contrast, CSP, local-only avatar validation, and static Cloudflare
  Pages compatibility.
- After the native 0.3.0 package is produced and verified, update the Download
  page with the real archive name, exact byte size, exact SHA-256, installation,
  system requirements, unsigned-build disclosure, and troubleshooting.
- Never invent package metadata or claim trusted signing.

## Per-game acceptance gate

Do not begin the next game until the current game has:

- A rendering-independent engine and deliberately small API.
- Complete required rules and exact payout math.
- Deterministic seeded outcomes.
- Atomic failures, nonnegative balances, and bounded loops.
- Complete native view, help, results, restart, and lobby return.
- Keyboard and mouse scripted full-round coverage.
- Focused success, failure, privacy, and boundary tests.
- Safe persistence boundaries.
- All earlier game and infrastructure tests still passing.
- Debug and Release validation passing.
- Updated relevant documentation and `PROJECT_CONTEXT.md`.
- A logical local Git commit.

## Final validation

Before handoff, run and record:

- Debug native generation/build and complete validation.
- Release native generation/build and complete validation.
- `rocketc check`.
- The complete old and new Rocket test suite.
- Source and test formatting checks.
- Deterministic complete sessions for all eleven games.
- Save-v1 and save-v2 migration to save-v3 if introduced, save-v3 round-trip,
  and missing/corrupt/unsupported recovery.
- Scripted keyboard and mouse flows for all eleven games.
- Native adapter, resource lifetime, audio stress, missing asset, and clean
  shutdown tests.
- Windows 0.3.0 packaging.
- Package checksum and forbidden-content validation.
- Sanitized relocated package smoke testing outside the checkout.
- Source website validation.
- Fresh staged-site validation with the actual verified archive.
- A final Git diff, ignored-file, and working-tree audit.

Because native application files will change, both Debug and Release gates and
the entire existing 26-test baseline plus every new test are mandatory.

## Documentation and Git

- Update architecture, roadmap, testing, controls, visual design, building,
  packaging, Cloudflare, troubleshooting, validation, and other relevant docs.
- Update `PROJECT_CONTEXT.md` after every meaningful milestone.
- Record exact commands, total test count, package byte size, SHA-256, and
  limitations honestly.
- Keep generated builds, packages, staged sites, caches, dependencies, native
  binaries, maps, PDBs, machine paths, and user saves out of Git.
- Make logical local commits after each completed game and final acceptance.
- Finish with a clean working tree.
- Do not push, deploy, publish, create a release, or claim signing without
  explicit owner approval.

## Definition of done

Scroll2Roll 0.3.0 is complete only when all five games are fully playable and
tested, all six prior games remain complete, the eleven-game lobby and website
are accurate, migration and packaging are verified, source and staged website
checks pass with the real package, documentation reflects only verified facts,
every milestone is committed logically, the working tree is clean, and the
frozen Rocket repository remains unchanged.
