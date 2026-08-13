# Asset and Animation Implementation Plan

## Purpose

This is the owner-approved next phase after `owner-art-20260812`: integrate
the reviewed artwork into the native games while improving each game interior
and its state-driven animation at the same time. The goal is a coherent,
modern, tactile Scroll2Roll experience--not a layer of decorative images over
the current UI.

The implementation must preserve every existing engine rule, privacy boundary,
input contract, saved-data guarantee, and safe action boundary. Images and
motion only present engine-owned state; they never decide an outcome, alter a
collision, reveal private information, or delay a legal action beyond the
existing committed presentation policy.

## Execution order and ownership

Complete these groups **in order in the same checkout**:

1. Group 1: Midnight Crossing, Crash, Coop Climb.
2. Group 2: Blackjack, No-Limit Texas Hold'em, European Roulette.
3. Group 3: Slots, Plinko, Mines.
4. Group 4: Dice, HiLo, then the all-eleven acceptance pass.

Do not run two groups concurrently in the shared checkout. Although their
games differ, they share the renderer, resource ownership, game-layout and
component contracts, test baselines, documentation, and packaging evidence.
Parallel work is permitted only when the owner explicitly provides isolated
worktrees and authorizes the merge order.

Within a group, integrate art and animation together, one game at a time. A
game is complete only after its visual composition, asset lifecycle,
reduced-motion version, interaction states, focused tests, full Debug/Release
tests, and actual native capture review are all complete.

## Asset promotion workflow

1. Start with the staged material in `owner-art-20260812/accepted/`, its source
   counterpart in `source/`, and `ASSET_AUDIT.md`.
2. Select only assets that fit the final game geometry. Do not bulk-copy the
   staging folder into production.
3. Promote a selected original to an intentionally named, versioned runtime
   asset location. Keep its unmodified source, prompt/provenance, dimensions,
   SHA-256, license/use confirmation, and acceptance decision in the asset
   manifest.
4. Slice atlases only once the target cell bounds are verified. Preserve the
   atlas and record every derived region; never resample or crop the only copy.
5. Load resources once through the existing resource owner, provide a graceful
   procedural/degraded fallback, and unload every resource exactly once. No
   loading, decoding, allocation, or file I/O belongs in the frame loop.
6. Do not commit the `owner-art-*` staging folder. Commit only promoted runtime
   assets and their durable provenance when they are actually used.

## Animation contract

Build or extend shared, deterministic presentation helpers before duplicating
per-game effects. Use the existing public/committed timestamps and fixed-tick
state rather than wall-clock guesses or private engine values.

- Support normal and reduced-motion profiles. Reduced motion keeps state,
  hierarchy, focus, and result clarity, but removes camera shake, looping
  particles, long interpolation, and nonessential motion.
- Respect the compact bottom dock and wide action rail contracts. Effects may
  never cover legal controls, game totals, exact values, focus, or the Back
  policy.
- Drive alpha, position, scale, rotation, glow, and particle lifetime from
  bounded helpers. Clamp all values, use stable seeds where variation is
  needed, and clean up temporary state at settlement/reset/exit.
- Keep collision bounds and exact board/card/reel regions code-owned. Visual
  art may decorate those regions but must not replace geometry or hit testing.
- Motion states must be readable without color alone and keyboard focus must
  remain visible during animation.
- Do not fake activity, players, wagers, outcomes, countdown pressure, or
  remote data.

## Per-game animation direction

| Games | Required visual and animation work |
| --- | --- |
| Midnight Crossing | Use city, car, tram, raft/log, and chicken assets in code-owned lanes. Animate public fixed-tick wheel/traffic motion, water wakes, carried-on-log feedback, collision response, and checkpoint flare without changing hazard geometry. |
| Crash | Use the large rocket, flight environment, and effects. Animate only committed/public launch, engine flame, trail, altitude depth, cash-out and crash burst; keep the hidden crash point private. |
| Coop Climb | Use observatory, platform, and chicken assets to make ten code-owned steps physical. Animate only current/safe/failed/secured presentation and the telescope summit; never reveal future path state. |
| Blackjack | Add room, felt/rail, shoe, chip and table props around the existing exact table. Animate committed deal/flip, chips, active hand and honest settlement response without changing card/action legality. |
| Hold'em | Add lounge, felt/rail, seats, chips, markers and pot visual weight. Animate committed deal, street reveal, chip-to-pot, fold, showdown and payout without exposing private rival cards. |
| Roulette | Use salon, wheel, ball and chip material while retaining exact existing betting hit regions. Animate predetermined spin, ball orbit/landing and collection from locked result only. |
| Slots | Use the cabinet, arcade and exact symbols with strict reel-cell clipping. Animate source-owned sequential stops, paylines, bonus/free-spin and result effects from committed symbols only. |
| Plinko | Use enclosure, chamber and prop materials around procedural pegs and engine paths. Animate committed ball interpolation, contact spark and landing pulse only; no artwork may alter paths/bins. |
| Mines | Use cavern, tile and mine/gem materials with closed tiles visually identical. Animate focus, reveal, safe glow, failure response and cash-out without leaking hidden mines. |
| Dice | Use vault and signal-display artwork for the exact 0000-9999 result. Animate bounded drum roll, settle and win/loss pulse; do not present it as ordinary six-sided dice. |
| HiLo | Use prediction room, card tray and effect atlas around procedural cards. Animate committed card slide/flip, direction energy, correct/equal/loss and cash-out response while future cards remain private. |

## Required validation for every group

- Inspect the current game, its resource ownership, and the relevant engine/API
  before editing. Do not duplicate rules in rendering.
- Run focused game tests plus the complete Debug and Release suites after the
  group. Fix regressions before proceeding.
- Review dark and light themes at every required viewport, including 800x600,
  compact active state, keyboard focus, disabled controls, reduced motion, and
  representative win/loss/cash-out states where applicable.
- Verify resource lifetime, fallback behavior, texture clipping, target asset
  dimensions, and no per-frame allocation or loading.
- Capture real native screens for owner review. Do not refresh website captures,
  package artifacts, checksums, or visual claims until Group 4's final native
  review is accepted.
- Update `docs/PROJECT_CONTEXT.md` with evidence only after each group.

## Completion boundary

Group 4 includes the final coherence audit across all eleven games, full
Debug/Release validation, native captures for owner review, and only then the
website/package/documentation evidence refresh. A successful local validation
is not public release, deployment, push, signing, or owner visual approval.

## Ready-to-run `/goal` prompts

### Group 1

```text
/goal Implement Group 1 of docs/ASSET_ANIMATION_IMPLEMENTATION_PLAN.md: Midnight Crossing, Crash, and Coop Climb. Read AGENTS.md, docs/MASTER_PLAN.md, docs/PROJECT_CONTEXT.md, docs/GAME_VISUAL_REFINEMENT_PLAN.md, docs/OWNER_ASSET_GENERATION_PROMPTS.md, and this plan completely before changing anything. Integrate only appropriate reviewed assets from owner-art-20260812/accepted, promote runtime assets with provenance, and build each game's final composition and committed/reduced-motion animation together. Preserve engine rules, private state, fixed-tick geometry, controls, and resource-lifetime requirements. Work one game at a time, validate focused tests and full Debug/Release suites, inspect actual native dark/light captures at all required viewports, update PROJECT_CONTEXT with verified evidence, and do not implement Groups 2-4, push, publish, package, or claim owner approval.
```

### Group 2

```text
/goal Implement Group 2 of docs/ASSET_ANIMATION_IMPLEMENTATION_PLAN.md: Blackjack, No-Limit Texas Hold'em, and European Roulette. First verify Group 1 is complete and preserve it. Read AGENTS.md, docs/MASTER_PLAN.md, docs/PROJECT_CONTEXT.md, docs/GAME_VISUAL_REFINEMENT_PLAN.md, docs/OWNER_ASSET_GENERATION_PROMPTS.md, and this plan completely. Integrate only reviewed art that fits exact table geometry and improve final visual composition plus committed/reduced-motion animation together. Preserve tested game rules, private card boundaries, roulette hit regions, legal actions, resource ownership, and responsive accessibility. Validate each game and the full Debug/Release suites; inspect real native dark/light captures, focused/disabled states, compact and wide layouts; document only verified evidence. Do not start Groups 3-4, push, publish, package, or claim owner approval.
```

### Group 3

```text
/goal Implement Group 3 of docs/ASSET_ANIMATION_IMPLEMENTATION_PLAN.md: Slots, Plinko, and Mines. First verify and preserve Groups 1-2. Read AGENTS.md, docs/MASTER_PLAN.md, docs/PROJECT_CONTEXT.md, docs/GAME_VISUAL_REFINEMENT_PLAN.md, docs/OWNER_ASSET_GENERATION_PROMPTS.md, and this plan completely. Promote and integrate reviewed assets with provenance, building composition and committed/reduced-motion animation together. Preserve source-owned reel results and clipping, procedural Plinko pegs and engine paths, private Mines layouts and identical closed tiles, exact controls, and resource lifecycle rules. Complete focused plus full Debug/Release validation and actual native dark/light, compact/wide, active/focus/disabled review before handoff. Update PROJECT_CONTEXT only with verified evidence. Do not begin Group 4, push, publish, package, or claim owner approval.
```

### Group 4

```text
/goal Implement Group 4 of docs/ASSET_ANIMATION_IMPLEMENTATION_PLAN.md: Dice and HiLo, then complete the final all-eleven visual acceptance pass. First verify and preserve Groups 1-3. Read AGENTS.md, docs/MASTER_PLAN.md, docs/PROJECT_CONTEXT.md, docs/GAME_VISUAL_REFINEMENT_PLAN.md, docs/OWNER_ASSET_GENERATION_PROMPTS.md, and this plan completely. Integrate reviewed Dice and HiLo assets with their committed/reduced-motion animation, preserving exact 0000-9999 signals, private future cards, equal-rank loss clarity, legal actions, and resource ownership. Then audit all eleven games for coherent visual quality, responsive accessibility, asset manifests/hashes, lifetimes, and no per-frame loading; run full Debug/Release validation and capture representative native screens for the owner. Only after native review is final may you refresh website/package/documentation evidence. Do not push, publish, deploy, sign, or claim owner visual approval without explicit owner permission.
```
