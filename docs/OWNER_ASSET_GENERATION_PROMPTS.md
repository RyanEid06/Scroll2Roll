# Owner Asset Generation Prompts

Generate one listed asset at a time. Do not ask an image model for every game
in one image: movable objects must remain separate so Rocket can animate them.
Keep the untouched original output outside the repository until it is reviewed.

## Master prompt

Paste this first, then append one game prompt below:

```text
Create original production art for Scroll2Roll, a local-only, single-player,
play-money Windows game collection. Use a cohesive premium 2.5D illustrated
style: modern polished materials, clean readable silhouettes, slightly playful
but not childish, dark-navy foundation, selective cobalt, violet, cyan,
emerald, gold, coral and burgundy, soft upper-left rim lighting, controlled
bloom and convincing depth. Make finished game art, not a UI mockup, stock
photo, flat icon, or real-money casino advertisement.

Follow the requested camera angle exactly. Do not crop objects. No words,
letters, numbers, labels, logos, brands, watermarks, signatures, currency,
crypto, provider imagery, people, dealers, fake players, UI, buttons, menus,
device frames, or copied game characters/assets. The application renders exact
text, card ranks, numbers and values itself.

ISOLATED OBJECT means true transparent-background RGBA PNG, sRGB, 2048x2048,
with at least 12% transparent padding on every edge and no matte halo.
OBJECT SHEET means true transparent RGBA PNG, sRGB, 4096x2048, exact 4-column
by 2-row equal grid, one object per cell, clean transparent gutters, consistent
scale/view/light, and 10% internal padding. BACKGROUND means sRGB PNG,
2560x1440, no UI, with important details outside the gameplay center and outer
10% kept expendable. MATERIAL means perfectly seamless sRGB PNG, 1024x1024,
flat even lighting and no perspective. Return PNG, never JPEG, at maximum
quality. Generate only the requested deliverable.
```

## Per-game prompts and filenames

### Midnight Crossing

```text
Generate these separately, strict orthographic top-down view:
1. BACKGROUND `midnight-city-base.png`: horizontal moonlit city gameplay lanes;
two asphalt roads with curbs and dashed markings, brass tram rails, planted safe
median, two canals with stone banks and water reflections, far checkpoint,
sidewalk/street-lamp/building-edge ambience. Empty lanes; no moving objects.
2. OBJECT SHEET `midnight-vehicles.png`: eight original right-facing vehicles:
coral hatchback, cyan sedan, gold compact taxi without markings, violet coupe,
emerald van, navy wagon, red pickup, ivory electric compact. Roofs, windows,
lights and wheels readable around 80x48 px.
3. OBJECT SHEET `midnight-actors.png`: long tram, short tram, long log, short
log, timber raft, original chicken courier facing up, facing left, and startled.
The friendly chicken has an amber body, blue scarf and tiny lantern and is not
based on an existing character.
```

### Crash

```text
Generate separately:
1. ISOLATED OBJECT `crash-rocket.png`: original sleek compact rocket, three-
quarter side view pointing up-right about 25 degrees; cobalt body, ivory nose,
gold trim, violet fins, cyan engine core; no flame or trail.
2. BACKGROUND `crash-flight-background.png`: deep-space/high-atmosphere scene,
curved horizon low in frame, sparse layered stars, violet nebula, cyan glow and
subtle flight-deck edge framing; quiet central flight path; no rocket or graph.
3. OBJECT SHEET `crash-effects.png`: compact cyan flame, long cyan-violet flame,
gold boost flare, speed streaks, cyan exhaust puff, violet exhaust puff,
coral-gold crash burst, small glowing debris cluster, matching up-right travel.
```

### Coop Climb

```text
Generate separately, nearly front-facing 2.5D view:
1. BACKGROUND `coop-observatory.png`: tall whimsical brass observatory tower,
ten clear mounting levels, central ladder route, telescope summit, lanterns,
gears, pipes, clouds and dawn stars; no character or platforms.
2. OBJECT SHEET `coop-chicken.png`: same original amber chicken explorer with
blue scarf and brass harness in eight poses: idle, step up, ladder grip,
balanced, safe, cautious, surprised fail, summit celebration.
3. OBJECT SHEET `coop-platforms.png`: ordinary coop platform, reinforced safe
platform, current glowing platform, cracked fail platform, ladder segment,
lantern, equipment crate, ornate telescope base; no outcome text/icons.
```

### Blackjack

```text
Generate separately, three-quarter top-down table lighting:
1. BACKGROUND `blackjack-room.png`: premium indigo card room, brass lamps,
violet ceiling light, subtle empty seating and architectural depth; quiet center
for a curved table; no foreground table, cards, chips or people.
2. OBJECT SHEET `blackjack-props.png`: black/brass card shoe, empty chip tray,
violet chip stack, gold stack, mixed tall stack, discard holder, plain dealer
marker, soft table-light glow; no denominations or readable cards.
3. MATERIAL `blackjack-felt.png`: seamless deep emerald woven felt.
4. MATERIAL `blackjack-rail.png`: seamless dark cognac padded leather with
subtle brass piping. No table markings; Rocket draws exact cards and rules.
```

### No-Limit Texas Hold'em

```text
Generate separately, three-quarter top-down table lighting:
1. BACKGROUND `holdem-lounge.png`: premium violet/burgundy poker lounge, brass
lamps, empty perimeter chairs, soft architectural depth; quiet center for oval
table; no people, foreground table, cards or chips.
2. OBJECT SHEET `holdem-props.png`: seat-rim accent, violet chips, emerald
chips, gold chips, mixed pot pile, plain ivory dealer button, plain gold blind
marker, current-player seat glow; no letters or denominations.
3. MATERIAL `holdem-felt.png`: seamless tournament emerald felt.
4. MATERIAL `holdem-rail.png`: seamless burgundy padded leather with fine brass
piping. Exact cards, pots and markers remain procedural.
```

### European Roulette

```text
Generate separately, three-quarter top-down view:
1. ISOLATED OBJECT `roulette-wheel.png`: large unnumbered European single-zero
wheel base, dark walnut/brass rim, dimensional spindle, ivory separators,
burgundy/near-black pockets and one emerald zero material; no ball or numbers.
2. BACKGROUND `roulette-room.png`: original burgundy-violet salon, curved dark
architecture, brass highlights and restrained chandelier bokeh; no giant wheel.
3. OBJECT SHEET `roulette-props.png`: ivory ball, violet chip, gold chip, cyan
chip, three matching short stacks, mixed stack, gold landing glow; no values.
```

### Slots

```text
Generate separately, front-facing view:
1. ISOLATED OBJECT `slots-cabinet.png`: original brass-and-midnight art-deco
cabinet built around exactly five equal reel windows and three visible rows,
violet lamps, cyan accents, glass bezel and control deck; blank marquee and
empty reel cells; no symbols or text.
2. OBJECT SHEET `slots-symbols.png`, exact order: cyan Pebble, ivory Quill,
coral Lantern, gold/cobalt Compass without letters, emerald Scroll without
writing, violet radiant ribbon-star Wild emblem without a word, ivory crescent
Moon, brass Gear. Strong silhouettes readable around 100 px.
3. BACKGROUND `slots-arcade.png`: midnight art-deco arcade, brass arches,
violet/cyan lights, distant abstract machines; quiet center for cabinet.
```

### Plinko

```text
Generate separately, front-facing view:
1. ISOLATED OBJECT `plinko-enclosure.png`: original cyan/indigo machine frame,
side rails, entry chute, glass rim, blank lower bin housings, violet/gold lamps;
empty triangular center for exact procedural pegs and paths.
2. OBJECT SHEET `plinko-props.png`: ivory peg, cyan-lit peg, gold ball, violet
ball, ball shadow, contact spark, gold landing pulse, cyan landing pulse.
3. BACKGROUND `plinko-chamber.png`: layered cyan-indigo arcade chamber,
subtle machinery and reflections; quiet center; no machine or pegs.
```

### Mines

```text
Generate separately, front-facing with slight top-down depth:
1. BACKGROUND `mines-cavern.png`: violet/orange treasure cavern, obsidian walls,
cyan crystal veins, lantern niches, brass braces and edge props; large quiet
square for a 5x5 board.
2. OBJECT SHEET `mines-tiles.png`: same-size closed tile, hover, keyboard focus,
pressed, empty open recess, safe open recess, cracked fail recess, settled
neutral recess. Closed states must reveal no hidden outcome.
3. OBJECT SHEET `mines-objects.png`: cyan gem, violet gem, emerald gem, original
brass mechanical mine, harmless burst, reveal glow, stone fragments, dust puff.
```

### Dice

```text
Generate separately. This game uses exact 0000-9999 signals, not six-sided dice:
1. BACKGROUND `dice-vault.png`: cobalt/violet mechanical signal vault, circular
chamber, brass probability arcs, gears, glass reflections and cyan lights;
quiet center and threshold-band area; no digits or dice.
2. OBJECT SHEET `dice-displays.png`: cyan-edged blank two-digit mechanical
drum/window, violet version, cyan side view, violet side view, blank settled
face, abstract rolling-streak face without digits, win pulse, loss pulse.
```

### HiLo

```text
Generate separately, front-facing with slight top-down depth:
1. BACKGROUND `hilo-room.png`: midnight astral prediction room, violet circular
altar, subtle coral/cyan direction light, brass lamps and abstract distant card
shapes; quiet zones for deck, current card, probabilities and sequence; no
readable cards or arrows.
2. OBJECT SHEET `hilo-props.png`: violet card shoe, face-down card stack with
original gold orbit pattern, single face-down card, coral lower energy arc,
cyan higher arc, red equal-loss pulse, gold correct pulse, emerald cash-out
particles. No readable card faces.
```

## Delivery record

For each output, preserve the original and provide its prompt ID/filename,
generator and model/version if shown, generation date, exact final prompt,
whether references were attached, and confirmation that it may be used in
Scroll2Roll. Do not resize, crop, compress, or remove backgrounds from the only
copy before delivery.

