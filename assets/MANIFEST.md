# Runtime Asset Manifest

Every owner-visible runtime asset is listed here. Paths are relative to the
application/package root. SHA-256 values identify the exact reviewed source.
The application owns these resources through `src/app/ui_resources.rocket` and
uses explicit procedural degraded modes for any failed load.

## Bundled typography

| Runtime path | Purpose | Source and rights | SHA-256 |
| --- | --- | --- | --- |
| `assets/fonts/manrope/Manrope-wght.ttf` | Unmodified Manrope variable family, weights 200-800; display, heading, body, label, numeric, caption roles | Google Fonts `ofl/manrope`, retrieved 2026-08-09; Copyright 2018/2019 The Manrope Project Authors; SIL Open Font License 1.1 | `D0639BE45D0AF36E798172419D7BD173C4BD4F29E2B76CBB69DB1D11BF8B0A40` |
| `assets/fonts/manrope/Manrope-Medium.ttf` | Static weight-500 production instance used by raylib because its TTF loader does not select variable-font axes | Generated locally from the exact unmodified `Manrope-wght.ttf` above with FontTools 4.59.0 `varLib.instancer`, `wght=500`, on 2026-08-11; same SIL Open Font License 1.1 | `98EE850D1D257F4BB2328C24DFFF392F85A351A61ED7F600DBA140BCBB5313F9` |
| `assets/fonts/manrope/OFL.txt` | Required redistributed copyright/license | Exact Google Fonts license file, retrieved 2026-08-09 | `E01B637272E0CBDFB240184DD98EA5CC671556D9894DAE2668D92AB2C906787C` |
| `assets/fonts/manrope/METADATA.pb` | Human-readable upstream family metadata | Exact Google Fonts metadata, retrieved 2026-08-09 | `368BEDA3AA55B0AFE90EDC142D67CF37E743258C76481D520172AFBC148C6CCA` |

Primary upstream URLs:

- `https://raw.githubusercontent.com/google/fonts/main/ofl/manrope/Manrope%5Bwght%5D.ttf`
- `https://raw.githubusercontent.com/google/fonts/main/ofl/manrope/OFL.txt`
- `https://raw.githubusercontent.com/google/fonts/main/ofl/manrope/METADATA.pb`

The upstream variable file is bundled unmodified. The static Medium runtime
instance changes only the variable weight coordinate and remains under the
same OFL license. The OFL notice must remain in source and every portable
package containing either font. Scroll2Roll does not imply endorsement by the
Manrope authors, Google Fonts, or FontTools.

## Original ImageGen artwork

| Runtime path | Dimensions | Cells | Provenance / rights basis | SHA-256 |
| --- | --- | --- | --- | --- |
| `assets/ui/scroll2roll-cover-atlas-a.png` | 1536x1024 | Blackjack, European Roulette, Plinko, Coop Climb, Midnight Crossing, Texas Hold'em | Generated specifically for Scroll2Roll with OpenAI ImageGen on 2026-08-09; generation `exec-1bb025af-9d20-458c-907f-63941af5f9f2`; no external image input | `DD9D2B43D3CE4B0B39378DC6F1B211D5FC4D7F6750D552BE535B6545917B9052` |
| `assets/ui/scroll2roll-cover-atlas-b.png` | 1536x1024 | Brand hero, Mines, Dice, HiLo, Crash, Slots | Generated specifically for Scroll2Roll with OpenAI ImageGen on 2026-08-09; generation `exec-0e2406d9-680b-49ed-8fb2-b0811f830ecc`; no external image input | `D594D31752824E905B4E7D2E8BC6D262E4D97EC4E7BCAC5BB8253F8C67C502AC` |

These are owner-commissioned generated outputs, not copied casino-provider art,
stock imagery, gallery previews, commercial templates, or edits of the supplied
references. The generation prompts are preserved in `ui/IMAGEGEN_PROMPTS.md`.
Service terms applicable to the owner's ImageGen use provide the rights basis;
the images are not assigned a third-party stock license or represented as
public-domain works.

Both atlases were inspected at original resolution before acceptance. Review
found clean 3x2 separation, coherent family lighting/materials, recognizable
silhouettes, useful crops, no watermark, no provider branding, no stray prose,
and no copied interface. Playing-card ranks and slot/dice faces are intentional
game-object markings. Runtime sampling uses six 512x512 source regions per
atlas, including the narrow dark gutters inside the generated composition.

## Group 1 versioned game artwork

These files are byte-identical promotions from the visually reviewed
`owner-art-20260812/accepted/` staging set. They were staged on 2026-08-12 and
audited on 2026-08-13 as original Scroll2Roll artwork with no external image,
provider art, copied interface, logo, watermark, odds, or outcome baked in.
The owner directed this local Group 1 integration on 2026-08-14. That direction
is the use basis for this repository work; it is not a claim of final visual
approval, public release approval, or a third-party/public-domain license.

The staging records identify these as generated originals and preserve the
owner briefs in `docs/OWNER_ASSET_GENERATION_PROMPTS.md`, but do not contain
exact generator, model, generation-run, or per-file prompt identifiers. Those
details are therefore recorded as unavailable rather than inferred. Full-frame
backgrounds are their own reviewed source. Transparent runtime PNGs are the
reviewed alpha conversions of the retained flat-chroma source counterparts
listed below; the runtime files themselves are unmodified after acceptance.

| Runtime path | Game / purpose | Dimensions | Reviewed source decision | SHA-256 |
| --- | --- | --- | --- | --- |
| `assets/games/group1-v1/midnight-city-base.png` | Midnight Crossing environment under code-owned eight-lane geometry | 1672x941 | Accepted full-frame source; promoted unchanged | `EAC30CC1E57FDEC41F6089016918455081D74E9F1C7020E146C483ADA03B1AFB` |
| `assets/games/group1-v1/midnight-car-coral.png` | Midnight Crossing top-down road hazard | 1619x971 | Accepted alpha conversion; promoted unchanged | `51FD49B13DF802AD9D46CD34E1016BEC080CF1630A3B327B13CDEE9DD4727369` |
| `assets/games/group1-v1/midnight-car-cyan.png` | Midnight Crossing top-down road-hazard variant | 1619x971 | Accepted alpha conversion; promoted unchanged | `2119640D8D2DD1201325092AC0C3FB53070851DCBA904898067FB6E0055B4919` |
| `assets/games/group1-v1/midnight-tram.png` | Midnight Crossing rail hazard | 1810x869 | Accepted alpha conversion; promoted unchanged | `E130C11623ACB76717CE8BB32331F912F797F21BF0D433441D85BC1039D93F86` |
| `assets/games/group1-v1/midnight-log-raft.png` | Midnight Crossing moving canal support | 1402x1122 | Accepted alpha conversion; promoted unchanged | `F85C1A759ED35AE2BB3AC4B010BB8C6D749704D34CC07E45C6FDD67D08FA3792` |
| `assets/games/group1-v1/chicken-explorer-topdown.png` | Shared Midnight Crossing / Coop Climb explorer | 1254x1254 | Accepted alpha conversion; promoted unchanged | `59FA498AE754B1568B9B16B14FD3F373540CC98ED2AB8868C5C46ED9BC0FC7F6` |
| `assets/games/group1-v1/crash-flight-background.png` | Crash flight environment behind the public multiplier curve | 1672x941 | Accepted full-frame source; promoted unchanged | `208295182A7954AC3F3DC53F980BC70AEB35EA39D89B16360A2419DAD500B9A4` |
| `assets/games/group1-v1/crash-rocket.png` | Crash public launch / flight / cash-out craft | 1369x1149 | Accepted alpha conversion; promoted unchanged | `60B3B7EA5BABD0E34B75F02DD22296882A553D109E9C3915FFB386590C587AAD` |
| `assets/games/group1-v1/crash-vfx-burst.png` | Crash settled crash marker | 1329x1183 | Accepted alpha conversion; promoted unchanged | `EABE7CB3F84AC602B0D702567FE460CC7BFE64C2ACC56FDE9E6604E8F2780305` |
| `assets/games/group1-v1/coop-observatory-background.png` | Coop Climb physical ten-step observatory | 1672x941 | Accepted full-frame source; promoted unchanged | `59EB14B375D714D8D85248E7F479712626A9A43D5B8BE12BAAA654F272A71991` |
| `assets/games/group1-v1/coop-climb-platform.png` | Coop Climb repeated code-owned step prop | 1254x1254 | Accepted alpha conversion; promoted unchanged | `0F5305CB1653C6B86019641F4A3CCB82A3FCA811CEB21E2C552341EF5CBB73F7` |

Retained alpha-source counterparts in the ignored owner-art staging package:

| Source counterpart | Dimensions | SHA-256 |
| --- | --- | --- |
| `midnight-car-coral-source.png` | 1619x971 | `7E37F774B391FF78FAAFE094D3EB9B831431665A966B59C7C03C8930E34D9D6F` |
| `midnight-car-cyan-source.png` | 1619x971 | `F4C9959F4CEA034AEDF3B127820DF323C41C18F9BB1064241F73C3BEC25BF3E7` |
| `midnight-tram-source.png` | 1810x869 | `3B3FBFCD315C67CD5D418DA24BA640F9B2938492BED2D43AA6DFF793A4C83AB1` |
| `midnight-log-raft-source.png` | 1402x1122 | `4AF0A96DD94D86A3C522F0CD9DDFCDC1BE1947EB980A707D1309CE3B265D8A0C` |
| `chicken-explorer-topdown-source.png` | 1254x1254 | `0842FA4DE133387A09E94470284ABF482807CAEF253F8D4CE54DD9534E93F497` |
| `crash-rocket-source.png` | 1369x1149 | `64CCDC7178EAE2CE3E55D59225FA472891F5D6D08797D680D4E6CFBD5A6C1264` |
| `crash-vfx-burst-source.png` | 1329x1183 | `6E00095E01B569EBC2081D272153C09F0074E93D25CBF2DB5960A154DAE77858` |
| `coop-climb-platform-source.png` | 1254x1254 | `A2FA493D92E88DA68B97CB5FFA6DE3D34E4E44026C50FA3655FE6878411F724E` |

`src/app/ui_resources.rocket` is the sole runtime owner. It loads these eleven
textures once, exposes explicit readiness flags, keeps procedural degraded
rendering for every game, and unloads every successful texture exactly once.
The focused adapter test verifies all promoted loads and returns the texture
and font live counts to zero.

## Owner-provided Group 2 runtime artwork

These seven files are byte-identical promotions from the visually reviewed
`owner-art-20260812/accepted/` staging set. The owner directed this local Group
2 implementation on 2026-08-14. That direction is the use basis for this
repository work; it is not a claim of final visual approval, publication
approval, or a third-party/public-domain license. The staging package retains
the same provenance limits documented above: exact generator, model,
generation-run, and per-file prompt identifiers are unavailable and are not
inferred.

| Runtime path | Game / purpose | Dimensions | Reviewed source decision | SHA-256 |
| --- | --- | --- | --- | --- |
| `assets/games/group2-v1/blackjack-room-background.png` | Blackjack room framing behind the code-owned table | 1369x1149 | Accepted full-frame source; promoted unchanged | `3C79825E666278D077C263587F5BB59CBBC4A43BC8AD2AD91F14FD8FD9192CBB` |
| `assets/games/group2-v1/blackjack-dealing-shoe.png` | Blackjack physical dealing shoe | 1402x1122 | Accepted alpha conversion; promoted unchanged | `9F0040E8B708CB52EA53E1FDA3F77D6549FD5C34162D4D3009CF365EB394984D` |
| `assets/games/group2-v1/casino-chip-stack.png` | Blackjack physical wager stack | 1254x1254 | Accepted alpha conversion; promoted unchanged | `1578715EBF69AB7804517F111A7B7E8D57D02AD388D856FA859C2CA3040FA674` |
| `assets/games/group2-v1/holdem-lounge-background.png` | Hold'em lounge framing behind the code-owned oval | 1672x941 | Accepted full-frame source; promoted unchanged | `BCAF36EFC9E3F1A7D5CF5459A24B00BC3B09A771DF9F633CF313048C0CD2FE98` |
| `assets/games/group2-v1/holdem-props-atlas.png` | Hold'em chip stacks, pot, dealer/blind markers, and actor ring | 1536x1024 | Accepted alpha conversion; promoted unchanged | `446301089F381CE7057CDFBE64F01B7BCC6FEC0FFD7DE83AD8522BE0305ABB3B` |
| `assets/games/group2-v1/roulette-room-background.png` | Roulette salon framing behind the code-owned betting layout | 1672x941 | Accepted full-frame source; promoted unchanged | `CE98C2A5F623E34D53E71F227B80E961B3D9A6C588B23B7478F3E363FC87F114` |
| `assets/games/group2-v1/roulette-wheel.png` | European Roulette 37-pocket physical wheel under the engine-locked ball | 1402x1122 | Accepted alpha conversion; promoted unchanged | `ACFFC6F576ED69FAFCB60ED9592E42E617EC0F99EA2BE9EFF22F1A4A6CE6ED22` |

The retained Hold'em atlas is sliced as a 4x2 grid of 384x512 source regions:
cells 0-2 are black, green, and gold chip stacks; cell 3 is intentionally
blank; cell 4 is the mixed pot pile; cell 5 is the ivory dealer marker; cell 6
is the gold blind marker; and cell 7 is the cyan current-actor ring. The
runtime keeps the original atlas intact and selects these regions only when
drawing.

Retained alpha-source counterparts in the ignored owner-art staging package:

| Source counterpart | Dimensions | SHA-256 |
| --- | --- | --- |
| `blackjack-dealing-shoe-source.png` | 1402x1122 | `7AC6416F556C4027B0CC3AD21CAD37704D7623F1F952660571988287B4D07CDA` |
| `casino-chip-stack-source.png` | 1254x1254 | `031F9832CB6172C44D3750DA09C2F2709547242DF2716C525BBCAEF02A91ED43` |
| `holdem-props-atlas-source.png` | 1536x1024 | `B856CB77444AC12E5DFEAF1A7803FB2D4E4941720995C37E1F8CAB0838A8D28C` |
| `roulette-wheel-source.png` | 1402x1122 | `82FE6BAEB403CFE3F982F6EE1AE876448829D6F586AEE336D1C49C784C89FBE5` |

Two reviewed Group 2 candidates remain in ignored staging and were not
promoted. `premium-table-surface.png`
(`8C5999DE975A725095C578339D658B18D80A0713C0571095E752D718E0249EC3`)
contains a baked rectangular table that does not match the responsive
code-owned Blackjack/Hold'em geometry. `roulette-ball-cradle.png`
(`91AA84BB02A7FDBB3BF75AAB4DBDD2F8AEFA6B07210FFA6DADE92F1AF1F23A5F`)
is a decorative cradle rather than an isolated ball that can align to the
engine's canonical 37-pocket order. Their exclusion preserves exact hit
regions, responsive table geometry, and outcome ownership.

`src/app/ui_resources.rocket` loads the Group 2 textures once alongside Group
1, exposes explicit readiness flags, preserves procedural degraded rendering,
and unloads every successful handle exactly once. The adapter-backed resource
test verifies one font plus twenty production textures and returns all live
counts to zero.

## Legacy test assets

`assets/orbit.ppm` and `assets/about.txt` predate the overhaul and remain test or
repository fixtures. They are not owner-visible production cover art.

## Acceptance and fallback

- Font load validates file existence, rejects invalid/default-font substitution,
  measures with the loaded font, and falls back explicitly to raylib's default
  font only in degraded mode.
- Atlas load/draw/unload uses validated resource handles. A missing or corrupt
  atlas produces a distinct polished procedural glyph for every game rather
  than a blank card.
- The package must include the exact listed paths, the Manrope license, this
  manifest, and notices. Relocation tests must run without the source checkout.
- Regenerated, downloaded, intermediate, experimental, cached, and rejected
  image outputs remain outside Git.
