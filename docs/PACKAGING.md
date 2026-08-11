# Windows Packaging

Scroll2Roll 0.3.0 is packaged as a portable, local, unsigned Windows x64 ZIP.
From the repository root, use the frozen Rocket checkout explicitly:

```powershell
.\scripts\package-windows.ps1 -RocketRoot "<frozen-rocket>"
.\scripts\test-package.ps1
```

The packaging script performs a Release native build and creates ignored
`out/package/Scroll2Roll-0.3.0-windows-x64.zip`. The accepted local UI-overhaul
archive built on 2026-08-11 is exactly 6,963,264 bytes (6.64 MiB) with SHA-256:

```text
83b4e94c24c196782cb04f209193303a6bd602a8a3e7b2b3a8e99548ec02d597
```

The package has an exact 17-file allowlist:

- `Scroll2Roll.exe`, `README.md`, `NOTICE.md`, `THIRD_PARTY_NOTICES.md`,
  `VERSION.txt`, `CONTROLS.md`, and `TROUBLESHOOTING.md`;
- `RAYLIB_LICENSE.txt` copied from the pinned raylib 6.0 source;
- `SHA256SUMS.txt`, which recursively covers every other packaged file;
- `assets/MANIFEST.md` and `assets/ui/IMAGEGEN_PROMPTS.md`;
- both reviewed ImageGen cover atlases;
- Manrope variable and static Medium fonts, `OFL.txt`, and `METADATA.pb`.

The package script verifies the reviewed asset hashes before staging. The test
script verifies the archive sidecar, rejects unsafe checksum paths, expands into
ignored `out/relocation`, enforces the exact allowlist, recomputes every
recursive internal checksum and reviewed asset hash, recognizes the full pinned
raylib license, and rejects source/build/dependency trees plus native
development artifacts. It then runs `Scroll2Roll.exe --headless-smoke` with the
relocated package as the working directory, outside the source layout. All of
those gates pass for the archive above.

The application resolves its fonts and atlases relative to the package root.
Moving only `Scroll2Roll.exe` intentionally activates its explicit degraded
resource fallback and is not a valid installation. Extract and keep the complete
archive together.

Builds, staging folders, archives, hashes, relocation trees, executables, PDBs,
maps, objects, caches, dependencies, and user saves remain out of Git. This is a
local acceptance artifact: no upload, public release, trusted signature, or
deployment is performed or claimed.
