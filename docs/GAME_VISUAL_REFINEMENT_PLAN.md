# Four-Chat Game Visual Refinement Plan

## Authority and purpose

This is the owner-directed visual refinement plan for the eleven existing
Scroll2Roll games. It does not replace `docs/MASTER_PLAN.md` or
`UI_OVERHAUL.md`; those remain authoritative. It records the owner's higher
visual bar after reviewing the accepted native captures: modern, smooth, fun,
and built from convincing game objects and surrounding places rather than flat
panels or geometric stand-ins.

The existing engines, rules, deterministic outcomes, privacy boundaries,
balances, persistence, keyboard/mouse flows, responsive layout contract, and
48/48 accepted Debug/Release baseline must be preserved. Engineering acceptance
of the current captures is not owner visual approval.

All four chats must read this file completely before acting. Work through the
groups in order in one shared checkout. Do not run two implementation chats at
the same time in the same worktree. Each chat must finish with a clean,
validated handoff before the next begins.

## Instructions shared by all four chats

1. Read `AGENTS.md`, `docs/MASTER_PLAN.md`, `docs/PROJECT_CONTEXT.md`,
   `UI_OVERHAUL.md`, `docs/UI_OVERHAUL_FOUNDATION.md`,
   `docs/VISUAL_DESIGN.md`, and this file completely. Read the relevant game
   math/design, controls, architecture, testing, and building documents.
2. Inspect Git status and preserve all owner work, especially the untracked
   owner file `SCROLL2ROLL_MASTER_PLAN.md`. Never change the frozen Rocket
   repository.
3. Launch and inspect each assigned game in representative ready, active, and
   settled states before editing. Treat the tracked website capture as context,
   not as sufficient visual QA.
4. Work only on the games assigned to the current group. Shared theme,
   resource, layout, component, adapter, packaging, and test files may be
   changed only for a demonstrated group need. Document shared changes because
   later chats inherit them.
5. Keep rules and outcomes in the existing engines/APIs. Rendering consumes
   only committed, privacy-safe public state. Never duplicate payout logic,
   inspect hidden outcomes, choose an animation result, or alter settlement.
6. Preserve the shared stage-plus-dock/action-rail layout and all supported
   window sizes. Improve the stage and its physical world without turning the
   action rail into the visual focus.
7. Prefer a small number of strong, layered focal assets plus procedural,
   state-driven effects. Do not solve a game by placing a single flat screenshot
   behind it. Objects that move independently must be separate textures or
   procedural elements.
8. Keep both dark and light modes intentional. Maintain legibility, minimum
   practical 44-pixel actions, keyboard focus, disabled states, reduced motion,
   safe Back behavior, help, and result/history access.
9. Do not ship copyrighted casino-provider art, copied characters, logos,
   watermarks, baked-in labels, or assets without recorded provenance. Update
   `assets/MANIFEST.md` and packaging allowlists/hashes for every accepted
   runtime asset.
10. Keep texture loading, font loading, render targets, and allocations out of
    the frame loop. Every resource needs one owner, a degraded fallback, and a
    tested cleanup path.
11. Update focused view/GUI/resource tests and run the relevant focused tests
    while iterating. Before handoff run complete Debug and Release validation.
12. Capture and inspect dark and light screens at 800x600, 1024x768, 1280x720,
    1600x900, 1920x1080, and the current maximized size. Include ready, active,
    and settled/result states where they materially differ. Record honest
    observations in `docs/VALIDATION.md`.
13. Update `docs/PROJECT_CONTEXT.md` after the group is genuinely complete.
    Do not claim owner visual approval unless the owner explicitly gives it.
14. Do not push, publish, deploy, release, purchase, or claim signing without
    explicit owner approval.

## Owner-generated asset workflow

Owner-generated images are welcome and can materially improve the games. They
are most useful as separate reusable layers: cars, road tiles, lane markings,
tram, logs, player/chicken mascot, rocket, exhaust elements, slot cabinet,
symbol set, table rails, chips, pegs, gems, mines, and environmental props.

Copy-ready specifications and per-game prompts are in
`docs/OWNER_ASSET_GENERATION_PROMPTS.md`. Use them one numbered asset at a time.

Before asking the owner to generate anything, the current chat must provide a
compact asset brief containing:

- intended game and exact object;
- proposed runtime filename and approximate displayed size;
- camera/view angle, such as strict top-down, three-quarter, or front-facing;
- transparent cutout, tileable texture, background plate, or sprite sheet;
- source resolution and required safe padding;
- lighting direction, palette, and dark/light-theme behavior;
- required variants or animation frames;
- a clear instruction to omit text, logos, branding, watermarks, UI, and crop;
- whether the image must line up with engine geometry or collision bounds.

Preferred delivery is lossless PNG with transparency for movable objects and
high-resolution PNG for intentional background plates. A complete flattened
scene is acceptable only for noninteractive distant ambience. Roads, tables,
boards, reels, and other interactive surfaces should normally be layered so
Rocket can place objects, focus, results, and motion accurately.

On receipt, inspect every file at original resolution. Reject or repair bad
silhouettes, inconsistent perspective, unwanted text, halos, cut-off parts,
lighting mismatch, AI artifacts, or insufficient resolution. Record the
creator/tool, date, prompt or description when available, dimensions, hash,
license/ownership note, theme compatibility, and fallback policy. Optimize a
reviewed runtime copy rather than committing unnecessary generation sources.

Do not block all progress waiting for art. Geometry, state mapping, animation,
fallbacks, tests, and an exact asset brief can proceed first. Do not call a weak
procedural stand-in final when an approved focal asset is still required.

## Group 1 — Living worlds and motion

Assigned games: **Midnight Crossing, Crash, and Coop Climb**.

These games share the greatest need for environmental depth, layered scenery,
moving objects, particles, and camera-aware motion. Complete them before the
table and cabinet groups because they currently sit furthest below the owner's
target.

### Midnight Crossing

Current weaknesses:

- Cars read as rounded pink rectangles instead of vehicles.
- Road lanes are flat bands without markings, curbs, sidewalks, intersections,
  street furniture, or convincing depth.
- Logs are simple capsules and canals lack banks, water texture, reflections,
  wakes, and readable current.
- The tram lacks rails, windows, structure, lighting, and a believable route.
- The player marker is too small and abstract; the stage lacks personality.
- Collision, checkpoint, and cash-out moments have little visual impact.

Required work:

- Build a layered top-down city: road asphalt, lane markings, curbs, sidewalk,
  median/checkpoint, rail lane, canal banks, water, distant buildings or props,
  and night lighting.
- Replace geometric hazards with clear top-down cars in several silhouettes
  and colors, plus a distinct tram and dimensional logs/platforms.
- Give the approved player character—courier or original chicken mascot—a
  readable silhouette, facing/movement feedback, shadow, and safe/hit state.
- Add engine-position-driven wheel motion, traffic light streaks, water wakes,
  carried-on-log feedback, collision response, and checkpoint flare. Cosmetic
  motion must never change collision geometry or ticks.
- Keep every hazard readable in light mode and at 800x600; scenery may not hide
  lane boundaries or safe zones.

High-value owner assets: top-down vehicle set, tram, log/platform set, player
or chicken mascot, tileable asphalt and road-marking layers, canal/water and
bank layers, street props, and distant city background.

### Crash

Current weaknesses:

- The stage is mostly an empty grid and the rocket is tiny.
- The craft has little dimensional form, personality, or sense of speed.
- The curve, multiplier, rocket, and surrounding flight space feel detached.
- Exhaust, smoke, altitude cues, camera energy, and crash payoff are weak.

Required work:

- Make a large original rocket the focal object while keeping the exact
  multiplier and legal Cash Out action instantly readable.
- Create a layered flight environment with parallax stars/clouds or a stylized
  atmosphere, grid/trajectory depth, altitude/speed cues, and restrained camera
  drift tied only to public presentation time.
- Add bright engine flame, exhaust/smoke particles, glow, trail, subtle shake,
  and a satisfying committed crash burst. Reduced motion must retain clarity
  without camera shake or long interpolation.
- Improve the curve's scale, labeling, and relationship to the rocket without
  revealing the hidden crash point.
- Strengthen launch, in-flight, cashed-out, and crashed states without fake
  players, live bets, or fabricated activity.

High-value owner assets: three-quarter or side-view rocket with clean
transparent silhouette, optional damage/burst variant, exhaust elements, cloud
or nebula layers, stars, and flight-deck framing.

### Coop Climb

Current weaknesses:

- The observatory ambience is attractive, but progression is presented mostly
  as stacked interface bars.
- Coops, ladder, explorer/chicken, equipment, and summit are not sufficiently
  physical or animated.
- Safe, current, failed, and secured states rely too heavily on text and color.

Required work:

- Turn the ten steps into a readable brass tower/ladder path with physical
  platforms or coops, depth, and a clear climb direction.
- Add an original chicken/explorer character, climbing motion, equipment,
  platform lighting, and a visually rewarding telescope summit.
- Give safe/current/fail/secured states distinct object states and effects
  without exposing future outcomes.
- Improve cash-out tension through lighting and motion, never deceptive urgency
  or outcome leakage.
- Preserve all ten multipliers and states at the minimum viewport.

High-value owner assets: original chicken/explorer cutout or small sprite
sheet, modular coop/platform, ladder/tower pieces, telescope summit, lanterns,
clouds/stars, and observatory foreground props.

Group 1 finishes only after all three games pass focused tests, complete Debug
and Release validation, and actual dark/light state review at every viewport.

## Group 2 — Physical casino tables

Assigned games: **Blackjack, No-Limit Texas Hold'em, and European Roulette**.

These games share felt, padded rails, cards, chips, table lighting, casino-room
ambience, dealing/spinning motion, and physical material cues. Preserve one
coherent Scroll2Roll table vocabulary while keeping each game distinct.

### Blackjack

Current weaknesses:

- The table silhouette is credible, but the felt is extremely empty.
- Cards, chips, bets, and seat positions are too small to carry the scene.
- AI seats feel like labels rather than occupied positions.
- The shoe, chip rack, betting circles, rule markings, and room surroundings
  are weak or absent.
- Deal, flip, wager, win, loss, push, Blackjack, and bust feedback lack impact.

Required work:

- Enrich the curved table with padded rail material, felt texture, betting
  circles, rule lettering, dealer zone, shoe, chip tray, and embedded lighting.
- Increase card and chip presence while preserving up to five AI players and
  multiple split hands at all viewports.
- Make AI/player/dealer positions physical and clearly hierarchical without
  implying online humans.
- Add committed card slide/flip, chip movement, active-hand light, and honest
  result effects proportional to the outcome.
- Keep ranks, suits, totals, legal actions, and disabled actions readable.

High-value owner assets: seamless felt and padded-rail textures, dealer shoe,
chip tray, chip stack layers, table-room background, and subtle casino props.
Cards should remain procedural unless a complete consistent rank/suit atlas is
provided and verified.

### No-Limit Texas Hold'em

Current weaknesses:

- The oval table exists, but opponents look like rectangular information
  panels placed over felt.
- Seats, chip stacks, pot, dealer/blind markers, and community zone lack weight.
- The room is sparse and betting/dealing moments feel static.

Required work:

- Build convincing seat positions into the oval rail with stacks, name/AI
  plates, dealer/small-blind/big-blind markers, fold/all-in states, and table
  lighting.
- Strengthen the central community-card and pot areas, including contribution-
  tier/split-pot presentation.
- Add committed dealing, chip-to-pot, street reveal, showdown, fold, and payout
  motion while never exposing private rival cards early.
- Make the human seat and current actor unmistakable without overwhelming the
  table.
- Retain readable raise-to sizing, recent actions, and every legal control.

High-value owner assets: oval felt/rail materials, seat or chair accents, chip
stacks, pot markers, dealer button set, lounge background, and table lamps.

### European Roulette

Current weaknesses:

- This is the strongest existing game, but the small wheel still reads as a
  simplified icon beside a mostly flat grid.
- Wheel pockets, ball, spindle, chip stacks, cloth material, and spin lighting
  need more dimension.
- The background wheel illustration competes with the functional wheel.

Required work:

- Increase the functional wheel's presence and give it dimensional pockets,
  spindle, rim, ball track, highlights, and a readable predetermined landing.
- Refine the full single-zero betting cloth, chip hierarchy, hover/focus,
  placed-bet stacks, and result/history presentation.
- Add committed wheel acceleration/deceleration, ball orbit/bounce, landing
  light, and payout collection without changing the locked result.
- Rebalance ambience so the interactive wheel and cloth dominate rather than a
  decorative background image.
- Preserve precise edge/intersection/rail mouse hit regions and keyboard parity.

High-value owner assets: roulette wheel material layers or a clean angled wheel
base, ball, chips, burgundy room ambience, and cloth/felt texture. Functional
number geometry and the final ball position remain engine-aligned rendering.

Group 2 finishes only after the three games pass focused tests, complete Debug
and Release validation, and actual dark/light state review at every viewport.

## Group 3 — Arcade cabinets and tactile boards

Assigned games: **Slots, Plinko, and Mines**.

These games share framed machines/boards, tactile cells, repeated symbols,
lighting, reveal/landing effects, and strict clipping.

### Slots

Current weaknesses:

- The outer frame suggests a cabinet, but it lacks physical depth, glass,
  controls, lamps, and surrounding arcade/casino context.
- Several symbols look like simple line art and spinning cells read as purple
  stripes.
- Paylines, reel depth, free spins, Bonus, and wins lack spectacle.

Required work:

- Build a convincing five-reel art-deco cabinet with bezel, glass, reel wells,
  lights, control deck, Spin/Stop affordance, and restrained surrounding arcade
  ambience.
- Replace all eight symbols—Pebble, Quill, Lantern, Compass, Scroll, Wild, Moon,
  and Gear—with a coherent high-quality original set that remains readable at
  the smallest reel cell.
- Add fluid precommitted reel motion, ordered stops, cell clipping, illuminated
  paylines, engine-proven win frames, free-spin/Bonus presentation, and outcome-
  proportional celebration.
- Preserve five paylines, Turbo timing, finite autoplay/Stop, and exact results.

High-value owner assets: front-facing cabinet shell separated from reels,
eight-symbol transparent atlas, lamp/button layers, payline glow, coin/spark
effects, and a distant midnight arcade background.

### Plinko

Current weaknesses:

- Correct triangular geometry, but the peg field floats in a mostly empty dark
  chamber.
- Pegs, token, frame, glass, bins, and landing areas lack physical depth.
- Bounce feedback and settlement are visually quiet.

Required work:

- Create a complete physical Plinko machine: dimensional enclosure, glass,
  side rails, backing material, pegs, entry chute, multiplier bins, and lights.
- Give balls/token size, shadow, glow, trail, convincing contact feedback, and
  satisfying committed landings.
- Add depth and surrounding arcade/casino framing without obscuring the exact
  symmetric board or multiplier labels.
- Preserve 8–16 rows, all risk tables, 1–10 balls, exact engine paths, and
  compact separation between stage and controls.

High-value owner assets: front-facing machine/enclosure layers, peg and ball
cutouts, glass/light overlays, bin materials, and chamber/arcade background.
Peg positions and ball paths must remain procedural and engine-aligned.

### Mines

Current weaknesses:

- The game is primarily a clean 5x5 button grid.
- The cavern is so subdued that it contributes little atmosphere.
- Hidden tiles, gems, mines, focus, reveal, cash-out, and failure lack tactile
  material and impact.

Required work:

- Build an inset treasure board with dimensional stone/metal tiles, bevels,
  shadows, seams, and a richer cavern environment.
- Create original gems and mechanical mines with distinct silhouettes, reveal
  dust, glow, fragments, and restrained failure response.
- Strengthen keyboard focus and hidden/revealed states without leaking committed
  mine locations.
- Improve potential payout, multiplier, streak/history, cash-out, and result
  presentation while the 5x5 board remains dominant.
- Keep unrevealed tiles visually identical regardless of private engine value.

High-value owner assets: tile material set, gem variants, mechanical mine,
cavern walls/floor, treasure props, dust/debris, and glow overlays.

Group 3 finishes only after the three games pass focused tests, complete Debug
and Release validation, balanced reel/board clipping, resource cleanup, and
actual dark/light state review at every viewport.

## Group 4 — Precision games, cohesion, and final acceptance

Assigned games: **Dice and HiLo**, followed by the final all-eleven visual,
website-capture, package, and documentation audit.

### Dice

Current weaknesses:

- The dimensional background die gives the screen atmosphere, but the two
  central number boxes look like generic panels rather than game objects.
- Roll/settle motion and the relationship between the exact 0000–9999 result,
  threshold, under/over choice, probability, and payout can feel disconnected.
- The stage needs stronger physical betting-surface cues and result feedback.

Required work:

- Turn the central result objects into dimensional signal dice/drums/displays
  that clearly combine into one exact four-digit result.
- Improve roll, tumble, anticipation, settle, win/loss pulse, and finite-auto
  rhythm while every outcome remains precommitted and Stop stays visible.
- Strengthen the probability band, threshold marker, under/over direction, and
  exact result hierarchy.
- Add subtle vault/table materials and lighting without reducing numeric
  clarity or turning the game into ordinary six-sided dice.

High-value owner assets: dimensional signal dice or mechanical number drums,
vault/betting-surface background, rim-light overlays, and small result effects.

### HiLo

Current weaknesses:

- It already has strong card-room ambience, but the table/altar still feels
  partially like a set of panels.
- The current card, deck, exact counts, visible sequence, and Higher/Lower
  actions need more physical integration and motion.
- Correct predictions, equal-rank losses, ordinary losses, and cash-outs need
  stronger distinct feedback.

Required work:

- Build a physical prediction table/altar with deck shoe, card landing zone,
  lower/equal/higher arcs, and integrated count/multiplier display.
- Add committed card slide/flip, deck motion, sequence placement, directional
  energy, correct/loss/equal-loss response, and cash-out presentation.
- Keep `EQUAL RANK = LOSS` prominent, all future cards private, and the current
  card/rank/suit readable at every viewport.
- Make Higher and Lower the unmistakable primary actions while preserving exact
  remaining-card counts.

High-value owner assets: table/altar background layers, deck shoe, card-room
props, directional light/energy overlays, and result particles. Card faces can
continue using the shared procedural system.

### Final cohesion and acceptance work

After Dice and HiLo pass their own gates, audit all eleven games together:

- verify consistent shell, typography, action hierarchy, focus, disabled
  states, balance, Back policy, help, history, and dark/light behavior;
- verify each game still has a distinct palette, silhouette, environment,
  signature objects, and motion language;
- ensure no cars, roads, logs, chickens, rockets, tables, chips, reels, symbols,
  dice, tiles, pegs, or other owner-visible focal objects remain crude stand-ins;
- verify asset manifests, hashes, package allowlists, degraded modes, resource
  lifetime, and no loading/allocation in the frame loop;
- rerun all focused and complete Debug/Release validation;
- capture final representative screens for owner review and explicitly request
  visual approval without assuming it;
- only after native captures are final, refresh the website's tracked game
  screenshots and visual claims;
- rebuild and validate the real portable package, recursive hashes, forbidden-
  content scan, relocated smoke, source site, staged site, and responsive browser
  QA;
- update every affected document with exact verified evidence and no stale
  package hash or overclaim.

Group 4 finishes only when the native visual pass is complete, the full suite
passes in Debug and Release, the final website/package evidence matches the
actual files, and representative screenshots have been shown to the owner. A
public release or owner visual approval remains a separate explicit decision.

## Suggested prompts for the four chats

Use one prompt per new chat:

1. `Implement Group 1 from docs/GAME_VISUAL_REFINEMENT_PLAN.md completely. Follow all shared instructions, request precisely specified owner assets when they materially improve the result, validate, and hand off cleanly.`
2. `Implement Group 2 from docs/GAME_VISUAL_REFINEMENT_PLAN.md completely. Preserve the completed Group 1 work, follow all shared instructions, validate, and hand off cleanly.`
3. `Implement Group 3 from docs/GAME_VISUAL_REFINEMENT_PLAN.md completely. Preserve Groups 1 and 2, request precisely specified owner assets where useful, validate, and hand off cleanly.`
4. `Implement Group 4 and the final all-game acceptance work from docs/GAME_VISUAL_REFINEMENT_PLAN.md completely. Preserve Groups 1–3 and present final native screenshots for owner visual approval.`
