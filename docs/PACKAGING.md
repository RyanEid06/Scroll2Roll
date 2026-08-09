# Windows Packaging

Scroll2Roll 0.3.0 is packaged as a portable, local, unsigned Windows x64 ZIP.
From the repository root, use the frozen Rocket checkout explicitly:

```powershell
.\scripts\package-windows.ps1 -RocketRoot "<frozen-rocket>"
.\scripts\test-package.ps1
```

The packaging script performs a Release native build and creates ignored
`out/package/Scroll2Roll-0.3.0-windows-x64.zip`. The verified local acceptance
archive is 1,919,372 bytes (1.83 MiB) with SHA-256:

```text
fd2b4ec31734dcb6e51707c862a439966e5771cbda136dcd4f6b09726082688b
```

The archive contains `Scroll2Roll.exe`, `README.md`, `NOTICE.md`,
`THIRD_PARTY_NOTICES.md`, `VERSION.txt`, `CONTROLS.md`, `TROUBLESHOOTING.md`,
and `SHA256SUMS.txt`. The internal checksum file is generated from the staged
files before compression.

`test-package.ps1` expands the archive into ignored `out/relocation`, rejects
source/build/dependency trees and native development artifacts, and runs
`Scroll2Roll.exe --headless-smoke` outside the source layout. The 0.3.0 archive
passed both checks on 2026-08-09.

Builds, staging folders, archives, hashes, relocation trees, executables, PDBs,
maps, objects, caches, dependencies, and user saves remain out of Git. This is
a local acceptance artifact: no upload, public release, trusted signature, or
deployment is claimed.
