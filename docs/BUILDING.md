# Building Scroll2Roll

## Requirements

- Windows x64
- Visual Studio Community 2026 with the Desktop C++ workload
- Rocket Language 2.0.3 extension for GUI workflows
- The pinned Rocket 2.0 checkout and its reviewed MSVC/Ninja/LLVM 22.1.6/raylib 6.0 dependencies

Do not download a separate raylib distribution.

## Headless Rocket workflow

From the repository root, after activating the pinned Rocket toolchain:

```powershell
rocketc check .
rocketc build .
rocketc test .
rocketc fmt . --check
```

The repository validation script is the preferred complete entry point:

```powershell
$rocketRoot = "C:\path\to\frozen-rocket"
.\scripts\validate.ps1 -Configuration Debug -RocketRoot $rocketRoot
.\scripts\validate.ps1 -Configuration Release -RocketRoot $rocketRoot
```

## Native raylib workflow

CMake will accept portable inputs rather than a committed laptop path:

```powershell
cmake -S . -B out/build/windows-release -G Ninja -DCMAKE_BUILD_TYPE=Release -DROCKET_ROOT="<rocket-checkout>" -DROCKETC="<rocket-compiler>"
cmake --build out/build/windows-release
```

CMake targets are `scroll2roll_build`, `scroll2roll_check`, and `scroll2roll_test`. Native libraries and generated bindings are placed under ignored `.rocketc`/`generated` paths and must never be committed.

The application forces raylib's `SUPPORT_CUSTOM_FRAME_CONTROL` option off.
`rocket_raylib.end_frame` relies on raylib's standard `EndDrawing()` contract to
swap buffers, enforce frame timing, and poll Windows events. The forced setting
also repairs an older CMake cache where that option was enabled.

## Visual Studio Community 2026

Open the repository folder, then open any `.rocket` file. The installed Rocket Language 2.0.3 extension discovers the nearest `rocket.toml`. Its Build, Run, Test, Stop, Debug, environment validation, and options commands are available from the normal Visual Studio UI. Run and Debug use hidden redirected processes and do not open an external terminal.

Set portable Rocket paths through the extension settings or environment:

```powershell
$env:ROCKET_COMPILER = "C:\path\to\frozen-rocket\out\build\windows-release\rocketc.exe"
$env:ROCKET_LANGUAGE_SERVER = "C:\path\to\frozen-rocket\out\build\windows-release\rocket-lsp.exe"
```

To persist those paths for Visual Studio launches, set the same values in the
Windows user environment, then fully restart Visual Studio:

```powershell
[Environment]::SetEnvironmentVariable('ROCKET_COMPILER', 'C:\path\to\frozen-rocket\out\build\windows-release\rocketc.exe', 'User')
[Environment]::SetEnvironmentVariable('ROCKET_LANGUAGE_SERVER', 'C:\path\to\frozen-rocket\out\build\windows-release\rocket-lsp.exe', 'User')
```

The tracked project never stores those machine-specific paths. All compiled
`src` files also use unique basenames because frozen Rocket CodeView records
store only the basename; `scripts/validate.ps1` rejects future collisions before
building.

## Packaging

```powershell
.\scripts\package-windows.ps1 -RocketRoot $rocketRoot
.\scripts\test-package.ps1
.\scripts\prepare-cloudflare-site.ps1
.\scripts\test-website.ps1 -Site .\out\cloudflare-site
```

If a local preview process has the default staged archive open, prepare and
validate a fresh ignored sibling without interrupting that process:

```powershell
.\scripts\prepare-cloudflare-site.ps1 -Output .\out\cloudflare-site-validation
.\scripts\test-website.ps1 -Site .\out\cloudflare-site-validation
```

Generated builds, packages, staged sites, dependencies, PDBs, maps, and user saves remain ignored.
