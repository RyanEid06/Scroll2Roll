# Cloudflare Website

`website/` is the implemented static Scroll2Roll profile, native-game catalog,
and verified-download website. It is not a browser port of the casino.

The three-page experience uses plain HTML, CSS, and dependency-free JavaScript:

- `index.html` creates or edits a non-authenticated local browser profile with a
  validated nickname and optional PNG/JPEG/WebP avatar.
- `play.html` presents all eleven complete native games through actual verified
  native captures and directs visitors honestly to the Windows application.
- `download.html` presents the exact local post-art 0.3.0 review-package byte
  size and SHA-256, installation, requirements, unsigned-build disclosure, and
  troubleshooting. Distribution remains disabled pending owner approval.

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
external request. Dice and HiLo were refreshed from the final Group 4 native
review; the already-accepted Groups 1-3 and lobby captures were preserved. The
Play page states that games do not run in the browser.

Cloudflare's official static-asset limits, rechecked on 2026-08-09, permit
20,000 files per version on the Free plan and 25 MiB per asset. The current
51,516,832-byte (49.13 MiB) post-art package is above that ceiling, so it is not
staged under `downloads/`. `scripts/prepare-cloudflare-site.ps1` rejects it and
directs the owner to approve R2, GitHub Releases, or another suitable download
location before publishing. See
<https://developers.cloudflare.com/workers/platform/limits/> and the 2026 Pages
file-limit update at
<https://developers.cloudflare.com/changelog/post/2026-01-23-pages-file-limit-increase/>.

`scripts/test-website.ps1` checks the three-page structure, exactly eleven game
cards, all 13 capture hashes/references, local-profile safety controls,
accessibility/reduced-motion hooks, semantic palette hooks, prohibited
browser/real-money claims, security headers, exact archive metadata, file count,
and asset sizes. When the staged archive is present, it recomputes and checks
its exact 51,516,832-byte size and SHA-256
`00ded10da4c66879b461fccf26c9e1cf97f505c7e899f4e7f5ef52716010c3c9`.

The prior 19-file source-site and 20-file staged-site/browser acceptance remains
the Groups 1-3 baseline. The post-art source site is refreshed and statically
validated, but no oversized archive is staged and no new browser acceptance or
deployment is claimed under the owner's no-retest/no-build direction.

`wrangler.toml` points at `website/`; staged deployment content is generated
under ignored `out/`. `prepare-cloudflare-site.ps1 -Output <path-under-out>` may
select a fresh ignored staging directory when a local preview holds another
folder open. Deployment is intentionally not performed until the owner
explicitly approves publishing.
