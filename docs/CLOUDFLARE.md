# Cloudflare Website

`website/` is the implemented static Scroll2Roll profile, product-catalog, and
download website. It is not a browser port of the casino.

The three-page experience uses plain HTML, CSS, and dependency-free JavaScript:

- `index.html` creates or edits a non-authenticated local browser profile with a
  validated nickname and optional PNG/JPEG/WebP avatar.
- `play.html` presents all eleven completed native games in original Scroll2Roll
  cards and directs visitors honestly to the Windows application.
- `download.html` presents the verified 0.3.0 archive, byte size, SHA-256,
  installation, requirements, unsigned-build disclosure, and troubleshooting.

`app.js` stores only the nickname and optional avatar data URL in browser
`localStorage`. It validates nickname length/characters, avatar MIME type,
1.5-MiB size, file signature, and browser image decoding. It makes no network
requests. Returning visitors keep the profile, may edit it, or may reset it.
The Content Security Policy permits only same-origin scripts and blocks all
connections, frames, objects, and payment capabilities.

Cloudflare's official static-asset limits, rechecked on 2026-08-09, permit 20,000 files per version on the Free plan and 25 MiB per asset. The verified 1,919,372-byte 0.3.0 archive is far below the per-asset limit, so `scripts/prepare-cloudflare-site.ps1` safely stages it under `downloads/`. See <https://developers.cloudflare.com/workers/platform/limits/> and the 2026 Pages file-limit update at <https://developers.cloudflare.com/changelog/post/2026-01-23-pages-file-limit-increase/>.

`scripts/test-website.ps1` checks the three-page structure, all eleven game cards,
local-profile safety controls, accessibility/reduced-motion hooks, prohibited
browser/real-money claims, security headers, verified archive metadata, file
count, and asset sizes. When the staged archive is present, it recomputes and
checks its exact byte size and SHA-256. `wrangler.toml` points at `website/`;
staged deployment content is generated under ignored `out/cloudflare-site`.
`prepare-cloudflare-site.ps1 -Output <path-under-out>` may select a fresh ignored
staging directory when a local Windows preview still holds the default folder.

The six-file source site and seven-file staged site both pass. The staged tree
contains `downloads/Scroll2Roll-0.3.0-windows-x64.zip` and independently checks
its 1,919,372-byte size and SHA-256
`fd2b4ec31734dcb6e51707c862a439966e5771cbda136dcd4f6b09726082688b`.
Browser checks at 1280 pixels confirm two 581-by-280-pixel catalog cards per row;
390-pixel checks confirm one-column Play and Download layouts without horizontal
overflow, all eleven titles, exact download metadata, profile create/reset, and
zero console errors.

Deployment is intentionally not performed until the owner explicitly approves publishing.
