# Building Scroll2Roll

## Requirements

- Windows x64
- Visual Studio Community 2026 with the Desktop C++ workload
- Rocket Language 2.0.3 extension for GUI workflows
- The pinned Rocket 2.0 checkout and its reviewed MSVC/Ninja/LLVM 22.1.6/raylib 6.0 dependencies

Do not download a separate raylib distribution.

## Headless Rocket workflow

From the repository root, with `rocketc` available:

```powershell
rocketc check .
rocketc build .
rocketc test .
rocketc fmt . --check
```

## Native raylib workflow

CMake will accept portable inputs rather than a committed laptop path:

```powershell
cmake -S . -B out/build/windows-release -G Ninja -DCMAKE_BUILD_TYPE=Release -DROCKET_ROOT="<rocket-checkout>" -DROCKETC="<rocket-compiler>"
cmake --build out/build/windows-release
```

The exact implemented scripts and targets will be recorded here as milestones complete.

