# Windows Packaging

Scroll2Roll 0.3.1 “Casino Freeze” is packaged as a portable, local, unsigned Windows x64 ZIP.
From the repository root, use the frozen Rocket checkout explicitly:

```powershell
.\scripts\package-windows.ps1 -RocketRoot "<frozen-rocket>"
.\scripts\test-package.ps1
```

The default packaging path performs a Release native build and creates ignored
`out/package/Scroll2Roll-0.3.1-windows-x64.zip`. For the owner-directed 2026-08-21
no-build handoff only, the already-built post-Group-4 executable was packaged
explicitly with:

```powershell
.\scripts\package-windows.ps1 -RocketRoot "<frozen-rocket>" -UseExistingExecutable
.\scripts\test-package.ps1
```

That local review archive is exactly 51,516,900 bytes (49.13 MiB) with SHA-256:

```text
e27cc112aa7a50dde1acea8d369aeb594ab88552f7668625df7c37008f1d0115
```

It reuses executable SHA-256
`56351380ac66fd98703b6750ad289e2966610e3010a93d1922f9f8be83b4f9c9`.
`-UseExistingExecutable` emits a warning and is not fresh Release-build or
Debug/Release-suite evidence.

The current package has an exact 48-file allowlist:

- `Scroll2Roll.exe`, `README.md`, `NOTICE.md`, `THIRD_PARTY_NOTICES.md`,
  `VERSION.txt`, `CONTROLS.md`, and `TROUBLESHOOTING.md`;
- `RAYLIB_LICENSE.txt` copied from the pinned raylib 6.0 source;
- `SHA256SUMS.txt`, which recursively covers every other packaged file;
- `assets/MANIFEST.md` and `assets/ui/IMAGEGEN_PROMPTS.md`;
- both reviewed ImageGen cover atlases;
- all 31 reviewed runtime textures from `assets/games/group1-v1/` through
  `assets/games/group4-v1/`;
- Manrope variable and static Medium fonts, `OFL.txt`, and `METADATA.pb`.

The package script verifies the reviewed asset hashes before staging. The test
script verifies the archive sidecar, rejects unsafe checksum paths, expands into
ignored `out/relocation`, enforces the exact allowlist, recomputes every
recursive internal checksum and reviewed asset hash, recognizes the full pinned
raylib license, and rejects source/build/dependency trees plus native
development artifacts. It then runs `Scroll2Roll.exe --headless-smoke` with the
relocated package as the working directory, outside the source layout. All of
those gates pass for the archive above.

The application resolves its fonts and all UI/game textures relative to the package root.
Moving only `Scroll2Roll.exe` intentionally activates its explicit degraded
resource fallback and is not a valid installation. Extract and keep the complete
archive together.

The post-art archive is larger than Cloudflare Pages' 25 MiB single-file
ceiling. It is intentionally not staged under `website/downloads/`; publishing
requires a separately owner-approved distribution location. The tracked site
shows its exact local integrity metadata but does not expose a broken download.

Builds, staging folders, archives, hashes, relocation trees, executables, PDBs,
maps, objects, caches, dependencies, and user saves remain out of Git. This is a
local acceptance artifact: no upload, public release, trusted signature, or
deployment is performed or claimed. Owner visual approval and a fresh Release
validation pass are also not claimed.
