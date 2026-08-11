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
