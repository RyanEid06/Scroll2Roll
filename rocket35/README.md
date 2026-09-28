# Scroll2Roll on Rocket 3.5

This is the first product package using the frozen Rocket 3.5 baseline
`v3.5.0-scroll2roll-baseline` (`1f6ba76f16f3246095d5d573c28d825d8b9367e3`).
It lives beside the existing 0.3.1 casino. The existing game, its engines,
assets, saves, package, and website are preserved while gameplay is migrated.
This preview has a redesigned lobby, an informational settings screen, and a
Blackjack table scene. It does not yet accept wagers or run the Blackjack
engine. The shell combines the existing reviewed table artwork and Manrope font
with Rocket-drawn panels, gradients, typography, and controls. It adds no new
runtime assets.

## Source boundaries

- `src/application.rocket`: window, logical canvas, asset lifetime, main loop,
  and clean shutdown.
- `src/shell.rocket`: navigation state and Rocket UI controls.
- `src/scenes.rocket`: product drawing for lobby, settings, and table.
- `src/main.rocket`: package entry point.

All application code uses public `rocket.*` modules. The package has no
private adapter, copied engine source, or example compatibility wrapper.
The existing table background and Manrope font are loaded once from the
repository's versioned `assets/` tree through `rocket.assets` with an
explicit `SCROLL2ROLL_ROOT`. Their ownership and provenance remain in
`assets/MANIFEST.md`. A 1280×720 logical canvas presents into a resizable,
high-DPI window.

## Windows build and run

Build Rocket 3.5 from the frozen tag first, including its production Raylib
adapter. Use the checkout path as a local parameter; nothing is committed with
a machine-specific path. From the Scroll2Roll repository:

```powershell
$rocket = 'C:\path\to\Rocket'
.\rocket35\scripts\consumer.ps1 -RocketRoot $rocket -Action Check
.\rocket35\scripts\consumer.ps1 -RocketRoot $rocket -Action Build
.\rocket35\scripts\consumer.ps1 -RocketRoot $rocket -Action Run
```

`-Action Smoke` builds the package, renders three frames, saves an ignored
logical screenshot under `out/rocket35/`, and exits cleanly. Use
`-Scene Table`, `Lobby`, or `Settings`. The script finds an installed Visual
Studio C++ toolchain, sets Rocket's native library and artifact paths, and
loads the repository assets with an explicit root. `-Configuration Release`
selects a corresponding Rocket Release build when available.

The three screen captures are preview evidence only. The 1280x720 logical
canvas scales with the Windows window; Android layout, earning credits, and
gameplay remain future work.

## Current next product step

WP0 in docs/ANDROID_WORK_PACKAGES.md is the next task: test short-video
scrolling signals on a physical Android phone with a disposable Kotlin app.
This Rocket 3.5 package is a Windows presentation reference. Blackjack
migration and Rocket Android feasibility wait for the roadmap's gates.
