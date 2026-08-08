# Cloudflare Website

`website/` is the implemented static Scroll2Roll product and download website. It is not a browser port of the casino.

The site uses HTML and CSS, shares the application color tokens, and includes product identity, tested Blackjack capabilities, an honest CSS product preview, Windows requirements, installation, version, controls, troubleshooting, privacy, play-money-only language, and a release download action.

Cloudflare's official Pages limits, checked on 2026-08-08, permit 20,000 files per site and 25 MiB per asset on the Free plan. The prepared 0.1.0 archive is far below that per-asset limit, so `scripts/prepare-cloudflare-site.ps1` safely stages it under `downloads/`. See <https://developers.cloudflare.com/pages/platform/limits/>. Workers static assets use the same 25 MiB per-file ceiling: <https://developers.cloudflare.com/workers/platform/limits/>.

`scripts/test-website.ps1` checks required product language, prohibited browser/real-money claims, file count, and asset sizes. `wrangler.toml` points at `website/`; staged deployment content is generated under ignored `out/cloudflare-site`.

Deployment is intentionally not performed until the owner explicitly approves publishing.
