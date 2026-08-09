/goal Completely redesign the native Scroll2Roll Windows application UI into a polished, colorful, illustration-led casino game browser and game experience inspired by the supplied references. Treat the current native presentation as a rejected baseline. Preserve every tested game engine and all existing functionality, but replace the visual design, application shell, navigation, typography, components, lobby, settings, help, results, and all eleven game presentation layers. Continue until the Definition of Done in this mandate is fully satisfied; do not stop at planning, a mockup, partial scaffolding, or a lobby-only reskin.

# Scroll2Roll Native UI Overhaul Mandate

## Start here

Work only in:

`C:\Users\Administrator\Desktop\Projects\Scroll2Roll`

Before planning or changing anything, read these files completely:

- `AGENTS.md`
- `docs/MASTER_PLAN.md`
- `docs/PROJECT_CONTEXT.md`
- `docs/ARCHITECTURE.md`
- `docs/VISUAL_DESIGN.md`
- `docs/CONTROLS.md`
- `docs/TESTING.md`
- `docs/BUILDING.md`
- `docs/PACKAGING.md`
- `UI_OVERHAUL.md` (this file)

Inspect the current Git status and preserve all user changes. Inspect the actual
native application at several window sizes before editing. Keep the separate
Rocket repository frozen and unchanged. Use frozen Rocket 2.0 and the pinned
raylib 6.0 integration. Do not push, deploy, publish, create a release, or claim
trusted signing without explicit owner approval.

## Why this overhaul exists

The current native application passed functional tests, but its visual quality
was incorrectly described as polished and production-ready. The owner has
rejected that presentation. The rejected lobby has these visible failures:

- It looks like an early prototype made from plain rectangles and text.
- The original six-game layout was not redesigned for eleven games; games
  seven through eleven appear as cramped, inconsistent strips above the main
  cards.
- There are no meaningful game icons, illustrations, thumbnails, or category
  imagery.
- The default bitmap-like typography looks cheap and is difficult to read at
  large desktop resolutions.
- The interface is nearly monochrome despite having nominal accent colors.
- There is weak hierarchy, little depth, poor spacing, weak calls to action,
  and excessive empty space.
- Fixed pixel coordinates do not use the available window or scale gracefully.
- Game navigation lacks a persistent, obvious Back control.
- `Lobby [B]` appears inconsistently and only at selected phases, which is not
  an acceptable discoverable navigation system.
- Settings, help, modals, disabled states, and game controls share the same
  under-designed rectangle treatment.
- Functional click-path tests were treated as visual acceptance. They are not.

Do not preserve the existing appearance for compatibility. Preserve behavior,
rules, deterministic outcomes, privacy, persistence, input parity, and safe
resource ownership, but replace the presentation.

## Owner-provided references

Study the following article and its examples before designing:

- Subframe, “25 Casino Website Design Examples For Inspiration”:
  <https://www.subframe.com/tips/casino-website-design-examples>

The relevant lessons from the article are clear navigation, responsive
composition, engaging high-quality visuals, bold but readable typography,
recognizable game imagery, fast interaction, and strong visual hierarchy.
Translate those principles into a native Rocket/raylib desktop application.

The owner supplied these three positive visual references:

1. Dark Fiery-style casino shell and game-discovery dashboard:
   `C:\Users\ADMINI~1\AppData\Local\Temp\codex-clipboard-d99030e8-03d0-4a96-b3f4-c2e837575479.png`
   - Dark navy application chrome.
   - Compact left navigation and a clear top utility bar.
   - Large illustrated hero area.
   - Dense but orderly horizontal game shelves.
   - Bright, distinct game thumbnails against quiet dark surfaces.
   - Rounded elevated panels, badges, compact controls, and clear grouping.

2. Colorful original game-icon collection:
   `C:\Users\ADMINI~1\AppData\Local\Temp\codex-clipboard-cf0e0ca0-bdf9-4fc0-a4e9-a302e7d1c7c8.png`
   - Large rounded-square covers.
   - One immediately recognizable illustrated object per game.
   - Saturated gradients and a different visual identity for every game.
   - Strong title typography integrated with the cover composition.
   - Consistent family style across Mines, Crash, Roulette, and other games.

3. Bright/light casino dashboard:
   `C:\Users\ADMINI~1\AppData\Local\Temp\codex-clipboard-98ce759a-35f0-4da0-aa43-99379e817879.png`
   - A genuine light theme, not a crude color inversion.
   - Warm white elevated application canvas over a colorful background.
   - Bright hero artwork, category tabs, compact search/filter controls, and
     a clean illustrated game grid.
   - Strong blue accent system, restrained shadows, rounded cards, and dense
   information that remains easy to scan.

The owner also supplied two broader design galleries. Study a representative
range of current projects/items from both before choosing the visual system:

- Behance casino-template project search:
  <https://www.behance.net/search/projects/casino%20template>
- ThemeForest casino-template search:
  <https://themeforest.net/search/casino>

These galleries are inspiration indexes, not asset libraries or permission to
copy a template. They demonstrate the breadth of contemporary casino/gaming UI,
including illustration-led dashboards, responsive grids, focused game stages,
compact control docks, distinctive typography, layered surfaces, strong accent
colors, and game-specific visual identities. Do not buy or download a template
without explicit owner approval, and do not reuse gallery preview images or
commercial template content without a separately verified compatible license.

The owner supplied seven additional visual/spatial references:

1. Polished Crash composition:
   `C:\Users\ADMINI~1\AppData\Local\Temp\codex-clipboard-7ccf1211-058b-45f0-a7d6-d46a89f6649d.png`
   - A large central curve/rocket stage carries the action.
   - The current multiplier is unmistakable and close to the moving object.
   - Compact history pills, a secondary side rail, and bottom action cards keep
     dense information out of the main animation.
   - Bright rocket, flame, yellow action, and pink cancel accents stand out
     against a layered navy/space background.
   - Use the hierarchy and energy, but omit fake players, leaderboards, social
     proof, deposits, or multiple-user betting behavior.

2. Dark Mines composition:
   `C:\Users\ADMINI~1\AppData\Local\Temp\codex-clipboard-03c550fe-a220-4da3-b671-6b77912d93ae.png`
   - Familiar large 5x5 play grid on the right and compact wager/options panel
     on the left.
   - Unopened cells are quiet; gems and mines become saturated focal objects.
   - One strong primary action anchors setup, while play state owns most of the
     screen.
   - Use this spatial convention at a much higher original-art quality and do
     not copy the Stake brand, styling, or assets.

3. Plinko information/layout study:
   `C:\Users\ADMINI~1\AppData\Local\Temp\codex-clipboard-9d1d316f-df52-4d55-9b69-0e7ba7470227.png`
   - A centered triangular peg field and symmetric multiplier bins make the
     game instantly recognizable.
   - Setup controls and secondary statistics stay outside the fall path.
   - Use the readable geometry and outcome-band concept, but improve the crude
     prototype styling, remove irrelevant logos/charts, and preserve only
     Scroll2Roll-supported controls and metrics.

4. Physical blackjack-table study:
   `C:\Users\ADMINI~1\AppData\Local\Temp\codex-clipboard-5e99ff09-3188-466d-a096-6fa903b8661d.png`
   - Curved padded rail, deep felt, dealer/chip-rack zone, betting circles,
     seat positions, rule markings, and embedded accent lights communicate
     blackjack before any label is read.
   - Translate those standard cues into original stylized native artwork; do
     not ship the photograph, casino branding, or photographic clutter.

5. European roulette spatial study:
   `C:\Users\ADMINI~1\AppData\Local\Temp\codex-clipboard-c577e4f2-23a3-4527-8e6b-cefc2969b26b.png`
   - Wheel, full single-zero number grid, outside-bet regions, and selectable
     chips are visible together.
   - The supplied image visibly contains a stock watermark and is strictly a
     reference for recognizable geometry. It must never be copied, cropped,
     edited, bundled, or treated as a free asset.

6. Physical oval card-table study:
   `C:\Users\ADMINI~1\AppData\Local\Temp\codex-clipboard-1d7843fe-0010-4db6-a601-a76e698be34d.png`
   - Oval padded rail, player positions, dealer/equipment zone, central felt,
     and marked betting/card areas create an immediately legible table plan.
   - Apply these spatial cues selectively to Hold'em while keeping the game's
     actual rules, seats, hidden information, and controls authoritative.

7. Chicken-road game-stage study:
   `C:\Users\ADMINI~1\AppData\Local\Temp\codex-clipboard-5a36c876-a548-44e4-a146-e96c8608c549.png`
   - The animated crossing field occupies most of the window; multipliers sit
     directly on the route; configuration and the primary Play action form one
     large, readable bottom dock.
   - Use this stage-versus-dock hierarchy for Midnight Crossing, with original
     scenery and characters. Do not copy its logo, chicken, art, multipliers,
     or brand identity.

The temporary image files may disappear. The descriptions above are durable
requirements and must remain usable without those files.

### Pattern synthesized from all references

The references converge on a consistent design grammar. Apply it deliberately:

- Give the active game stage visual dominance, normally about two-thirds of the
  usable content region, instead of dividing the window into equal text boxes.
- Use predictable zones: persistent shell/navigation, primary stage, compact
  setup/action dock, and secondary history/status. Never float unrelated data
  across the playfield.
- Make each game identifiable from silhouette and spatial metaphor before its
  title is read: curved card table, roulette wheel/grid, peg triangle, tile
  board, crossing lanes, rocket curve, or slot cabinet.
- Build quiet layered surfaces first, then reserve saturated accents, glow, and
  particles for primary actions, current focus, live motion, and real results.
- Use large, polished hero objects and readable numbers rather than many tiny
  decorations. A few high-quality focal assets are better than decorative
  clutter.
- Group controls in the order the user acts: configure wager/options, start,
  then show only legal contextual actions such as Hit, Cash Out, Reveal, Stop,
  or Spin. Keep history and help secondary but easy to reach.
- Combine authentic casino/game conventions with an original stylized finish.
  Do not use realism as an excuse to ship photos or a bland simulator, and do
  not use illustration as an excuse to lose standard table geometry.
- Keep the global shell, typography, spacing, component behavior, and theme
  rules consistent while giving each game a distinct palette, background,
  signature object, and motion language.
- Make depth intentional with gradients, soft shadows, rim light, inset wells,
  raised controls, table rails, material contrast, and restrained bloom. Avoid
  both featureless flatness and excessive visual noise.
- Treat motion as state communication: deal, spin, bounce, cross, reveal, roll,
  climb, launch, crash, and reel-stop sequences must explain what happened and
  remain synchronized with already committed engine results.
- Preserve legibility and contrast in both purpose-designed dark and light
  modes. Vibrant does not mean fluorescent text everywhere.
- Reject copied casino-service conventions that do not belong in Scroll2Roll:
  wallet/deposit controls, cryptocurrency, fake player lists, chat, social
  proof, countdown pressure, or fabricated activity.

The rejected current application screenshot is:

`C:\Users\ADMINI~1\AppData\Local\Temp\codex-clipboard-5d4868bc-fbfe-4def-af04-6cacd0e1dc0f.png`

Use it only as evidence of what must be replaced. Its temporary image file may
not survive indefinitely, so the description of its failures is part of the
durable reference.

## Interpretation rules

Use the references for visual quality, composition, density, navigation,
illustration style, and interaction patterns. Do not copy any reference
pixel-for-pixel, reuse its logo, reproduce provider artwork, or imitate one
brand so closely that Scroll2Roll loses its identity.

Do not import the references’ product behavior. Scroll2Roll must remain:

- local-only
- single-player
- account-free
- play-money-only
- free of deposits, withdrawals, payments, purchases, and cryptocurrency
- free of chat, fake users, fake winners, simulated social activity, referrals,
  bonuses, countdown pressure, or gambling-service claims
- a native Windows application, not a browser-playable casino

The static website remains a separate download/catalog website. The native app
is the priority of this overhaul.

## Required product direction

The result should feel like a modern premium game launcher combined with an
original playful casino cabinet. It should be colorful, highly legible,
responsive, polished, and inviting without looking like a real-money gambling
service.

Use dark mode as the default. Add a first-class light/dark theme switch that is
available from the global application shell and Settings. Persist the selection
locally with safe migration from current saves. Light mode must be designed as
its own semantic palette; never generate it by blindly inverting dark colors.

The entire native application must share one coherent design system, but every
game must have its own recognizable accent colors and illustrated identity.

## Global application shell

Replace the current disconnected screens with a persistent application shell.
It must include:

- A polished Scroll2Roll brand mark and wordmark.
- A persistent top bar or equivalent global chrome.
- An always-visible Back control on every non-lobby screen.
- Current game or section title and optional breadcrumb.
- A clearly labeled play-credit balance pill.
- Light/dark theme toggle with an unmistakable sun/moon treatment.
- Help and Settings access.
- Clear keyboard focus and hover/pressed feedback.
- Consistent safe-area margins and resolution-aware layout.

Back behavior must be explicit and tested:

- At a safe ready or settled boundary, Back returns to the lobby immediately.
- During an active committed wager, Back remains visible; activating it must
  show a clear state-aware modal explaining why immediate navigation is unsafe
  or offer an engine-defined, explicitly tested forfeit/leave action if such a
  rule is deliberately implemented.
- Never silently discard a wager, duplicate credits, expose private outcomes,
  or hide navigation merely because a round is active.
- `Escape` and mouse activation must follow the same policy.

Consider a compact left navigation rail at wider desktop sizes and a simplified
top/navigation treatment at smaller sizes. It may expose Home/All Games and
useful game categories, but must not contain unsupported online or social
features.

## Lobby and game discovery

Completely replace the current lobby. Requirements:

- All eleven games receive equal-quality, consistently sized cards.
- No game may be rendered as a narrow leftover strip or second-class entry.
- Use a responsive grid or shelves that adapt to 800x600, 1280x720, 1600x900,
  1920x1080, and fullscreen layouts.
- Provide scrolling, paging, or responsive density when all cards cannot fit;
  never overlap, clip, or shrink cards into unreadable bars.
- Use a hero/banner area that communicates local play-money entertainment and
  may feature one original Scroll2Roll scene or rotating featured game.
- Provide compact categories or filters such as All, Table, Card, Arcade, and
  Originals only if they improve discovery for eleven games.
- Search is optional; do not add a useless field merely to resemble a website.
- Each card must contain an original illustration, game name, short readable
  descriptor, accent treatment, and an obvious Play action.
- Entire cards should be clickable with keyboard and mouse focus states.
- Hover/focus may reveal secondary information, but the title and action must
  never depend on hover.
- Eliminate giant dead zones and use the available canvas intentionally.

The eleven required cards are:

1. Blackjack
2. European Roulette
3. Plinko
4. Coop Climb
5. Midnight Crossing
6. No-Limit Texas Hold’em
7. Mines
8. Dice
9. HiLo
10. Crash
11. Slots

## Original illustration and asset direction

Create an original, consistent Scroll2Roll cover/icon family. Use the available
ImageGen skill for original bitmap artwork when appropriate, and use procedural
Rocket/raylib artwork where it produces a stronger native result. Do not use
copyrighted provider artwork, logos, copied characters, or unlicensed assets.

Recommended art direction:

- Rounded, playful 3D/clay or polished cel-shaded objects.
- One dominant readable object or scene per card.
- Saturated gradients, soft bloom, rim lighting, and subtle particles.
- Minimal background clutter.
- No text baked into bitmap art; render accessible titles in Rocket.
- Consistent camera, lighting, padding, and quality across all eleven covers.
- Generate/import production-sized assets once and scale them cleanly at run
  time; do not ship unnecessarily huge source images.

Suggested visual identities:

- Blackjack: emerald felt, gold trim, expressive ace/king cards and chips.
- Roulette: magenta/red/violet wheel with gold and ivory ball.
- Plinko: cyan/indigo peg board and glowing falling token.
- Coop Climb: green/amber observatory ladder, friendly explorer motif.
- Midnight Crossing: electric blue city lanes, traffic streaks, moonlit canal.
- Hold’em: deep emerald/maroon table, premium cards and layered chips.
- Mines: violet/orange cavern, jewel and stylized mechanical mine.
- Dice: sky blue/cobalt dice in motion with clean probability motif.
- HiLo: coral/purple opposing cards with clear directional energy.
- Crash: neon green/violet rocket climbing a luminous curve.
- Slots: pink/gold mechanical reels, Scroll2Roll symbols, celebratory glow.

Required supporting assets may include:

- Scroll2Roll brand mark.
- Eleven game cover images or icon compositions.
- One or more original hero/banner scenes.
- Small navigation icons.
- Theme-toggle icons.
- Optional tasteful textures/particles.

Track only optimized runtime assets. Record their origin and licensing. Update
packaging to include them and tests to reject missing assets.

### Non-negotiable asset-quality gate

This mandate does not permit placeholder art, emoji, font glyphs pretending to
be icons, generic monochrome symbols, crude geometric stand-ins, blurred web
images, stretched thumbnails, watermarked images, or eleven cards made from the
same background with a different title. The finished application must contain
real, cohesive visual assets and polished native rendering throughout the lobby
and inside every game.

For every needed visual, choose the strongest lawful option:

1. Generate original production artwork with ImageGen, then inspect it at its
   original resolution, crop it intentionally, remove visual defects, optimize
   it for runtime, and integrate it as a real packaged asset.
2. Create polished procedural/vector-like artwork with raylib when motion,
   scaling, or game-state integration makes that the better result.
3. Download a high-quality asset only from a reputable source that explicitly
   grants compatible commercial reuse. Save the source URL, author, exact
   license, required attribution, and a local license copy. Do not treat an
   image being publicly visible or free to download as permission to ship it.

Mix these approaches where appropriate. Do not force a single asset source if
that lowers quality. Maintain a checked-in asset manifest covering every font,
icon, texture, illustration, sound, and externally sourced visual. Do not copy
the supplied reference artwork, casino brands, characters, logos, or game
thumbnails; create a distinctive Scroll2Roll family with comparable finish.

Before accepting an asset, visually inspect it for inconsistent lighting,
awkward crops, unreadable silhouettes, accidental text, AI artifacts,
watermarks, color mismatch, insufficient resolution, and poor light/dark-theme
compatibility. Reject and regenerate or replace weak work. Core visual assets
must not silently fall back to blank rectangles in the packaged application.

Create an asset inventory before implementation that maps each screen and game
to its required background, hero/cover, table or cabinet surface, objects,
symbols, effects, controls, and sounds. "No suitable asset was already in the
repository" is not a reason to leave a screen visually unfinished.

## Typography

Replace the current default bitmap-style presentation with a professional,
bundled, redistributable font family. Requirements:

- Use a verified open license and include the required license notice.
- Bundle the font; do not depend on a machine-specific Windows font path.
- Provide at least display/heading, body, label, numeric, and caption styles.
- Keep game values and controls readable at every supported size.
- Avoid excessive all-caps and tiny condensed text.
- Use consistent line height and truncation/wrapping behavior.
- Add or extend the narrow Scroll2Roll raylib adapter only if safe font loading,
  measuring, or cleanup operations are genuinely missing.
- Add resource-lifetime and missing-font fallback tests.

## Semantic design tokens

Replace scattered styling decisions with semantic tokens. Do not hardcode one
theme’s colors throughout views.

Dark-mode starting direction:

- canvas/background: `#090B14`
- shell/sidebar: `#0F1324`
- surface: `#151A2D`
- elevated surface: `#1D2440`
- primary text: `#F7F8FF`
- secondary text: `#A2AAC4`
- subtle border: `#2A3354`
- primary blue: `#5B7CFF`
- primary violet: `#8B5CF6`
- cyan accent: `#22D3EE`
- success/credit: `#34D399`
- gold/highlight: `#FBBF24`
- danger: `#FB7185`

Light-mode starting direction:

- canvas/background: `#EEF2FA`
- shell/sidebar: `#FFFFFF`
- surface: `#FFFFFF`
- elevated/selected surface: `#E9EEFF`
- primary text: `#172033`
- secondary text: `#667085`
- subtle border: `#D7DDEA`
- primary blue: `#4F46E5`
- primary violet: `#7C3AED`
- cyan accent: `#0891B2`
- success/credit: `#059669`
- gold/highlight: `#D97706`
- danger: `#E11D48`

These are a starting palette, not permission to apply every accent everywhere.
Verify contrast in both themes. Add semantic tokens for spacing, corner radii,
elevation, focus rings, component heights, icon sizes, text roles, animation
duration, breakpoints, and safe-area geometry.

## Shared component system

Replace the current minimal rectangle/button library with a real reusable
native component system. It should provide, as actually needed:

- application shell/header/navigation rail
- icon button and text button variants
- primary, secondary, quiet, danger, and disabled button states
- game cards with image, gradient overlay, labels, and focus state
- panels/cards with consistent elevation and borders
- balance/stat pills and badges
- tabs/category chips
- toggles, including an accessible theme switch
- steppers and sliders
- tooltips or contextual helper text
- toasts/status messages that do not obscure controls
- state-aware confirmation and information modals
- section headers
- empty/loading/error states
- scroll indicators or pagination controls
- keyboard focus rings

Every component must support dark/light themes, mouse and keyboard interaction,
disabled states, minimum hit targets, readable text, and deterministic testing.
Component visuals must scale with the window and must not rely on HTML/CSS.

## Screen-specific overhaul

### Startup

- Replace the centered text-only splash with a concise branded launch scene.
- Use the new mark, font, subtle motion, and loading/status feedback.
- Keep startup fast and allow reduced motion.

### Settings

- Use the global shell and a clear settings layout.
- Add the persisted dark/light mode selection.
- Retain audio, volume, AI player settings, and reset guidance.
- Use real switches/sliders/steppers with labels and current values.
- Provide a visible Back control.

### Help and modals

- Replace plain overlay boxes with readable, scrollable or paged content where
  necessary.
- Present rules, probability/return, rounding, controls, and privacy clearly.
- Never let help overflow at 800x600.
- Give every modal explicit actions and keyboard focus.

### Game screens

Redesign all eleven views, not just the lobby. Every game screen must use:

- the persistent shell and Back policy
- its own accent palette and subtle themed background
- a strong central play area
- a consistent information/HUD rail
- a clear action/control dock
- obvious primary and secondary actions
- illustrated or polished procedural game objects
- state-aware disabled controls with an understandable reason
- readable outcome, history, potential return, and rules information
- responsive behavior at all required sizes

Specific visual expectations:

- Blackjack: premium felt table, readable cards/chips, clear active-hand and
  dealer hierarchy, visually strong legal-action dock.
- Roulette: convincing wheel/table composition, legible bet geometry, chip
  hierarchy, result/history presentation.
- Plinko: polished peg-board depth, animated committed paths, readable risk and
  multiplier bands.
- Coop Climb: illustrated observatory ascent with a clear safe/fail progression
  and cash-out tension without revealing future outcomes.
- Midnight Crossing: richer city/canal atmosphere, readable hazards and player,
  compact control pad, and uncluttered checkpoint information.
- Hold’em: premium table, clear seats/stacks/markers, readable private/public
  cards, pots, and action rail without exposing hidden cards.
- Mines: tactile gem tiles, strong reveal/focus states, clear wager/mine/payout
  controls, no private mine leakage.
- Dice: expressive dice/result display, clean probability gauge, finite-auto
  status, and visible Stop.
- HiLo: large readable current card, strong Higher/Lower actions, exact counts,
  explicit equal-loss warning, and private future deck.
- Crash: polished curve scene, oversized multiplier, clear hidden/live/settled
  state, visible cash-out action, no fake users or live bets.
- Slots: illustrated cabinet/reels/symbols, clear five-payline presentation,
  visible free-spin/Bonus/Turbo/Auto states, and only engine-proven highlights.

Rendering and animation must consume committed engine/API state. They must
never choose outcomes, recalculate payouts, inspect private information, or
change game timing rules.

### Required in-game finish and motion

The interior of every game must receive the same level of visual attention as
the lobby. Merely placing an existing flat game panel over a new gradient or
background image fails this mandate. Controls, table/cabinet geometry, game
objects, state transitions, result presentation, help, history, and responsive
composition must all be redesigned. The expected standard is immediately
recognizable casino/game presentation with a cohesive original Scroll2Roll
identity, not a first-pass debug UI.

These details are mandatory wherever the underlying game supports them:

- Blackjack must have a curved premium felt table, recognizable card faces and
  suits, layered chip stacks, and smooth committed deal/flip/chip movement.
- Roulette must have a standard European single-zero layout, dimensional
  numbered wheel and ball, proper chips, and a smooth predetermined spin that
  lands on the already committed result.
- Plinko must have board depth, a convincing token/ball, polished pegs,
  committed bounce/trail feedback, and satisfying multiplier landing effects.
- Coop Climb must have layered illustrated scenery, character/equipment motion,
  progress lighting, and a visually rich summit without outcome leakage.
- Midnight Crossing must have atmospheric lanes/canals, smooth traffic/water
  motion, lighting effects, and clear collision/checkpoint transitions.
- Hold'em must have a recognizable oval poker table, seats, stacks, dealer
  marker, pots, and polished card/chip deal and reveal motion while preserving
  all hidden information.
- Mines must have a coherent treasure-cavern or similarly rich environment,
  dimensional unopened tiles, rewarding gem reveals, and polished mine/reveal
  effects rather than a plain numbered grid.
- Dice must have a designed betting surface, dimensional dice with roll/settle
  motion, and an unambiguous probability and over/under presentation.
- HiLo must have polished deck/table art and smooth committed card slide/flip
  transitions around large readable Higher and Lower actions.
- Crash must have a high-quality animated rocket, bright engine flame,
  exhaust/smoke particles, speed/altitude cues, smooth graph/camera motion, and
  a satisfying committed crash sequence. Cosmetic fuel/exhaust must not invent
  a game-engine mechanic.
- Slots must have a convincing cabinet, original high-quality symbol art, fluid
  reel motion and ordered stopping, illuminated paylines, result-accurate win
  pulses, and celebratory effects proportional to the actual outcome.

Animations must be smooth and time-based rather than tied to frame count. Use
easing, interpolation, layering, particles, highlights, controlled screen
motion, and audio feedback where they improve comprehension and feel. Keep the
target frame rate stable on the supported Windows machine, avoid allocation or
texture loading in the frame loop, preload/cache assets correctly, and provide
reduced-motion alternatives. Presentation may dramatize committed results but
must never delay settlement logic, change probability, or fabricate state.

## Responsive desktop behavior

The native app must be intentionally designed and visually checked at:

- 800x600 minimum
- 1024x768
- 1280x720
- 1600x900
- 1920x1080
- maximized/fullscreen on the current Windows display

Requirements:

- No overlap, clipping, negative-width controls, unreadable text, or giant
  accidental empty areas.
- Cards and controls reflow using documented breakpoints.
- Use clamped sizes and content regions instead of scattered fixed coordinates.
- Maintain minimum 44-pixel pointer targets where practical.
- Preserve logical focus order.
- Mouse-wheel scrolling and clipping may be added through the narrow adapter if
  genuinely required; add focused adapter tests and keep policy in Rocket.
- Game boards must prioritize their play area while keeping actions reachable.
- Long help/history content must remain usable at minimum size.

## Motion, sound, and feedback

- Use restrained 120–250 ms transitions for hover, selection, card entry,
  panels, and modal appearance.
- Use more expressive motion only for committed game outcomes.
- Add reduced-motion behavior.
- Never let animation delay or alter settlement.
- Use sound sparingly for primary actions and outcomes, respecting mute/volume.
- Do not use constant flashing, deceptive urgency, fake wins, or aggressive
  reward effects.

## Persistence and migration

Persist the selected theme and any approved UI-only preference. Preserve valid
save-v1 and save-v2 migration to the current format and current save round-trip,
missing/corrupt/unsupported recovery, and play-credit integrity.

If the save format changes:

- document the new version and exact migration behavior
- migrate valid older data safely
- never persist live wagers or private outcome state
- add focused migration and recovery tests
- keep reset instructions current

## Website alignment

After the native application overhaul is complete and validated, align the
static product/download website with the new Scroll2Roll identity:

- reuse the new semantic palette and brand direction
- replace stale screenshots/visual claims with verified new native captures
- retain the local profile, download flow, CSP, accessibility, and exact package
  validation
- keep clear “games do not run in the browser” language
- do not turn the website into a casino simulation

Native UI completion must not be deferred behind website work.

## Architecture constraints

- Keep all casino rules, state, settlement, privacy, and deterministic outcomes
  in the existing rendering-independent Rocket engines and APIs.
- Keep presentation state separate from engine state.
- Do not duplicate game rules in the UI.
- Keep the C++ adapter primitive and policy-free.
- Add native adapter functions only when a demonstrated presentation need
  cannot be expressed through the current safe boundary.
- Keep all compiled Rocket source basenames unique.
- Keep generated bindings, builds, optimized source assets, caches, packages,
  PDBs, maps, dependencies, and user saves out of Git as appropriate.
- Preserve standard raylib `EndDrawing()` frame control and clean shutdown.
- Do not modify the frozen Rocket language/compiler/runtime/tooling repository.

## Required implementation sequence

Use logical milestones and local commits. At minimum:

1. **Visual audit and foundation**
   - Record the rejected baseline honestly in documentation.
   - Inventory adapter, texture, font, scrolling, clipping, and test-hook needs.
   - Define semantic dark/light tokens, responsive layout helpers, asset
     ownership, and visual acceptance criteria.

2. **Assets, typography, themes, and shared components**
   - Produce/import original licensed assets and font.
   - Implement safe resource loading/fallback/cleanup.
   - Implement theme persistence/migration.
   - Replace the shared component system.
   - Add focused component, persistence, and resource tests.

3. **Application shell, startup, settings, and lobby**
   - Implement persistent navigation and Back behavior.
   - Build the responsive eleven-card illustrated lobby and hero.
   - Complete dark/light settings and global interaction states.
   - Visually validate at every target resolution before proceeding.

4. **All eleven game views**
   - Redesign each game’s presentation without changing its tested rules.
   - Preserve keyboard/mouse complete flows and safe persistence boundaries.
   - Add layout/navigation/theme coverage for every game.
   - Make logical commits in reviewable groups; do not leave half-redesigned
     games mixed with the new shell.

5. **Website, packaging, and final acceptance**
   - Align the website after native completion.
   - Rebuild the real Windows package with fonts/assets.
   - Validate checksums, forbidden content, and relocated launch.
   - Validate source/staged site against the actual new archive.
   - Perform final visual, functional, Git, and frozen-Rocket audits.

Do not call the redesign complete after milestone 3. The owner explicitly
requires a complete overhaul; all eleven game views are in scope.

## Testing and visual QA

Preserve the complete accepted functional suite and add coverage for the new
presentation. Required gates include:

- Debug and Release native builds.
- `rocketc check`.
- Complete existing and new Rocket tests.
- Source and test formatting checks.
- All eleven deterministic complete sessions.
- All eleven scripted keyboard and mouse flows.
- Persistent Back visibility and safe behavior on every non-lobby screen.
- Theme toggle, persistence, migration, and both-theme rendering.
- Asset/font success, missing, corrupt, fallback, and cleanup paths.
- Native adapter and resource-lifetime tests.
- Clean shutdown.
- No private outcome leakage from any API/view.
- No duplicate source basenames.
- Layout invariants at every required resolution.
- No overlapping controls, clipped labels, negative geometry, or unreachable
  actions.
- Visual inspection of startup, lobby, settings, modal/help, and every game in
  both dark and light modes.
- A per-game reference-grammar review confirming that the standard spatial
  metaphor is immediately recognizable, the play stage dominates appropriately,
  controls are grouped by action order, and no old flat debug composition
  remains beneath new artwork.
- Screenshots at minimum, standard, and 1080p sizes for review.
- Package contents, internal checksums, archive checksum, forbidden-content
  scan, and relocated headless smoke.
- Source and fresh staged-site validation with the real package.

Functional tests alone are not visual acceptance. Before final handoff, launch
the actual native application and inspect rendered screenshots. Show the owner
representative dark and light screenshots and do not claim “polished” or
“production-ready” without explicit visual approval.

## Documentation

Update all relevant documents, including:

- `README.md`
- `docs/PROJECT_CONTEXT.md`
- `docs/ROADMAP.md`
- `docs/ARCHITECTURE.md`
- `docs/VISUAL_DESIGN.md`
- `docs/CONTROLS.md`
- `docs/TESTING.md`
- `docs/BUILDING.md`
- `docs/PACKAGING.md`
- `docs/TROUBLESHOOTING.md`
- `docs/VALIDATION.md`
- website documentation when website alignment occurs

Record exact assets/licenses, theme tokens, breakpoints, navigation policy,
test counts, commands, screenshots reviewed, package name/bytes/SHA-256, known
limitations, commits, and the fact that no signing or publication is claimed.

## Definition of Done

The UI overhaul is complete only when all of the following are true:

- The rejected rectangle-and-text presentation is gone from the native app.
- The application has a coherent premium Scroll2Roll visual identity.
- Dark and light modes are both purpose-designed, switchable, persisted, and
  fully tested.
- A persistent, obvious Back control exists on every non-lobby screen with safe,
  understandable behavior in every game phase.
- The lobby presents all eleven games as equal-quality illustrated cards in a
  responsive layout with no leftover compact strips.
- All eleven games have original recognizable artwork and redesigned native
  presentation matching the quality level of the references.
- Every game interior has its expected table, board, cabinet, cards, chips,
  balls/tokens, tiles, rocket, reels, symbols, effects, and controls at a
  consistent production-quality finish; a lobby-only reskin cannot pass.
- No placeholder icons, emoji, crude stand-ins, weak repeated thumbnails,
  unlicensed downloads, watermarks, stretched imagery, or unfinished flat
  debug panels remain in any owner-visible screen.
- In-game dealing, spinning, rolling, bouncing, revealing, rocket/exhaust,
  crashing, and reel motion is smooth, result-accurate, performant, and has a
  tested reduced-motion path where appropriate.
- Professional bundled typography replaces the prototype bitmap appearance.
- Startup, shell, settings, controls, help, modals, feedback, and result states
  are redesigned consistently.
- Every required resolution is usable without overlap, clipping, dead space,
  or unreachable actions.
- Existing game rules, deterministic outcomes, privacy, balances, persistence,
  keyboard/mouse flows, audio safety, and clean shutdown remain correct.
- Debug and Release validation and the complete expanded test suite pass.
- Visual QA screenshots in both themes have been inspected and presented to the
  owner for approval.
- A real new local package including all required assets/fonts passes checksum,
  forbidden-content, and relocated smoke validation.
- Source and staged website checks pass against that real package if website
  alignment is included in the milestone.
- Documentation states only verified facts and no longer overclaims visual
  acceptance.
- Generated artifacts remain ignored, the Scroll2Roll tree is clean after
  logical local commits, and the frozen Rocket repository remains unchanged.
- Nothing is pushed, deployed, published, released, or described as signed
  without explicit owner approval.

Do not weaken these requirements to finish faster. If a limitation in frozen
Rocket or the current raylib boundary is encountered, investigate and extend the
Scroll2Roll-owned adapter narrowly with tests. Do not modify Rocket itself and do
not substitute a browser rewrite for the native application overhaul.
