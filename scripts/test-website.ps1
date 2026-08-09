[CmdletBinding()]
param([string]$Site = '')

$ErrorActionPreference = 'Stop'
$repository = Split-Path $PSScriptRoot -Parent
if (-not $Site) { $Site = Join-Path $repository 'website' }
$Site = [System.IO.Path]::GetFullPath($Site)

$requiredFiles = @('index.html', 'play.html', 'download.html', 'styles.css', 'app.js', '_headers')
foreach ($file in $requiredFiles) {
    if (-not (Test-Path -LiteralPath (Join-Path $Site $file))) { throw "Website file is missing: $file" }
}

$profileHtml = Get-Content -Raw -LiteralPath (Join-Path $Site 'index.html')
$playHtml = Get-Content -Raw -LiteralPath (Join-Path $Site 'play.html')
$downloadHtml = Get-Content -Raw -LiteralPath (Join-Path $Site 'download.html')
$css = Get-Content -Raw -LiteralPath (Join-Path $Site 'styles.css')
$script = Get-Content -Raw -LiteralPath (Join-Path $Site 'app.js')
$headers = Get-Content -Raw -LiteralPath (Join-Path $Site '_headers')
$allHtml = "$profileHtml`n$playHtml`n$downloadHtml"

foreach ($html in @($profileHtml, $playHtml, $downloadHtml)) {
    foreach ($required in @('<!doctype html>', 'charset="utf-8"', 'name="viewport"', 'class="skip-link"', 'app.js', 'styles.css')) {
        if ($html -notmatch [regex]::Escape($required)) { throw "A website page is missing required structure: $required" }
    }
}

foreach ($required in @('Create Account', 'local-only', 'no password', 'type="file"', 'accept="image/png,image/jpeg,image/webp"', 'data-avatar-preview', 'aria-live="polite"')) {
    if ($profileHtml -notmatch [regex]::Escape($required)) { throw "Profile page is missing required content: $required" }
}
if ($profileHtml -match 'type\s*=\s*["'']password["'']') { throw 'The local profile must not request a password.' }

foreach ($game in @('Blackjack', 'European Roulette', 'Plinko', 'Coop Climb', 'Midnight Crossing', 'No-Limit Texas Hold', 'Mines', 'Dice', 'HiLo', 'Crash', 'Slots')) {
    if ($playHtml -notmatch [regex]::Escape($game)) { throw "Play catalog is missing a completed game: $game" }
}
$cardCount = ([regex]::Matches($playHtml, 'class="game-card"')).Count
if ($cardCount -ne 11) { throw "Play catalog must contain exactly eleven rectangular game cards; found $cardCount." }
foreach ($required in @('games do not run in the browser', 'Download or launch on Windows', 'Edit profile', 'Reset', 'play-money')) {
    if ($playHtml -notmatch [regex]::Escape($required)) { throw "Play page is missing required launcher language: $required" }
}

$expectedHash = 'fd2b4ec31734dcb6e51707c862a439966e5771cbda136dcd4f6b09726082688b'
foreach ($required in @('Scroll2Roll-0.3.0-windows-x64.zip', '1,919,372 bytes', '1.83 MiB', $expectedHash, 'Windows x64', 'Installation', 'System requirements', 'Unsigned-build disclosure', 'unknown-publisher', 'Troubleshooting', 'SHA256SUMS.txt')) {
    if ($downloadHtml -notmatch [regex]::Escape($required)) { throw "Download page is missing verified package content: $required" }
}

foreach ($required in @('localStorage', 'scroll2roll.localProfile.v1', 'MAX_AVATAR_BYTES', '1572864', 'image/png', 'image/jpeg', 'image/webp', 'fileSignatureMatches', 'decodeImage', 'removeItem', 'textContent')) {
    if ($script -notmatch [regex]::Escape($required)) { throw "Profile script is missing a required local-safety control: $required" }
}
if ($script -match '\b(fetch|XMLHttpRequest|WebSocket|sendBeacon)\b') { throw 'Website profile code must not transmit data or use a network API.' }
if ($allHtml -match '(?i)<script[^>]+src=["'']https?://' -or $allHtml -match '(?i)<img[^>]+src=["'']https?://') { throw 'Website must not load external scripts or images.' }
if ($allHtml -match '(?i)deposit now|withdraw winnings|real-money wagering available|play in your browser|browser-playable casino') { throw 'Website contains a prohibited product claim.' }

foreach ($required in @(':focus-visible', 'prefers-reduced-motion', '@media (max-width:', '--gold:', '--focus:')) {
    if ($css -notmatch [regex]::Escape($required)) { throw "Stylesheet is missing an accessibility or design requirement: $required" }
}
foreach ($required in @("script-src 'self'", "connect-src 'none'", "object-src 'none'", "frame-ancestors 'none'", "payment=()")) {
    if ($headers -notmatch [regex]::Escape($required)) { throw "Security headers are missing required policy: $required" }
}

$archive = Join-Path $Site 'downloads\Scroll2Roll-0.3.0-windows-x64.zip'
if (Test-Path -LiteralPath $archive) {
    $archiveItem = Get-Item -LiteralPath $archive
    if ($archiveItem.Length -ne 1919372) { throw "Staged archive size changed: $($archiveItem.Length) bytes." }
    $archiveHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $archive).Hash.ToLowerInvariant()
    if ($archiveHash -ne $expectedHash) { throw "Staged archive SHA-256 changed: $archiveHash" }
}

$files = Get-ChildItem -Recurse -File -LiteralPath $Site
if ($files.Count -gt 20000) { throw 'Website exceeds the Cloudflare Pages Free file-count limit.' }
if ($files | Where-Object Length -gt 25MB) { throw 'Website contains an asset larger than the Cloudflare Pages 25 MiB limit.' }
Write-Output "Static website validation passed for $($files.Count) files."
