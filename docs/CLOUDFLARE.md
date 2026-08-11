# Cloudflare Website

`website/` is the implemented static Scroll2Roll profile, native-game catalog,
and verified-download website. It is not a browser port of the casino.

The three-page experience uses plain HTML, CSS, and dependency-free JavaScript:

- `index.html` creates or edits a non-authenticated local browser profile with a
  validated nickname and optional PNG/JPEG/WebP avatar.
- `play.html` presents all eleven complete native games through actual verified
  native captures and directs visitors honestly to the Windows application.
- `download.html` presents the accepted asset-bearing 0.3.0 archive, exact byte
  size and SHA-256, installation, requirements, unsigned-build disclosure, and
  troubleshooting.

`app.js` stores only the nickname and optional avatar data URL in browser
`localStorage`. It validates nickname length/characters, avatar MIME type,
1.5-MiB size, file signature, and browser image decoding. It makes no network
requests. Returning visitors keep the profile, may edit it, or may reset it.
The Content Security Policy permits only same-origin scripts/images and blocks
connections, frames, objects, and payment capabilities.

The redesign shares the native navy/blue/violet/cyan/gold identity. Thirteen
tracked PNGs are direct reviewed application captures: dark/light lobby views
and one view for every game interior. Their hashes are pinned by
`scripts/test-website.ps1`; none is a provider image, browser simulation, or
external request. The Play page states that games do not run in the browser.

Cloudflare's official static-asset limits, rechecked on 2026-08-09, permit
20,000 files per version on the Free plan and 25 MiB per asset. The accepted
6,963,264-byte archive is below the per-asset limit, so
`scripts/prepare-cloudflare-site.ps1` stages it under `downloads/`. See
<https://developers.cloudflare.com/workers/platform/limits/> and the 2026 Pages
file-limit update at
<https://developers.cloudflare.com/changelog/post/2026-01-23-pages-file-limit-increase/>.

`scripts/test-website.ps1` checks the three-page structure, exactly eleven game
cards, all 13 capture hashes/references, local-profile safety controls,
accessibility/reduced-motion hooks, semantic palette hooks, prohibited
browser/real-money claims, security headers, exact archive metadata, file count,
and asset sizes. When the staged archive is present, it recomputes and checks
its exact 6,963,264-byte size and SHA-256
`83b4e94c24c196782cb04f209193303a6bd602a8a3e7b2b3a8e99548ec02d597`.

The 19-file source site and fresh 20-file staged site both pass. In-app browser
checks at 1280x720 confirm two 581-by-544-pixel cards per row, fully loaded native
captures, exact metadata, local profile creation/navigation, and clean console
output. Checks at 390x844 confirm one 347-pixel card per row, profile/edit/error
focus feedback, Play and Download layouts, and zero horizontal overflow. QA
found and fixed a narrow-screen preview-height defect before acceptance.

`wrangler.toml` points at `website/`; staged deployment content is generated
under ignored `out/`. `prepare-cloudflare-site.ps1 -Output <path-under-out>` may
select a fresh ignored staging directory when a local preview holds another
folder open. Deployment is intentionally not performed until the owner
explicitly approves publishing.
