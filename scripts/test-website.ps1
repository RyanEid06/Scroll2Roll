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

$captureHashes = [ordered]@{
    'native-blackjack.png' = 'c320e8f8ed075120061fc6c41907489f7db29b019b6da6e05aaf7f4b3e9e79e3'
    'native-coop-climb.png' = 'f2945df03adf2cfbc90c140b0725d9f18e8e24d379f56fbcc30dd0297445d469'
    'native-crash.png' = '7b7af2c5e00f1cc344fe94d279174b71fb05b0dbafc395e79fb9891b942f6c5c'
    'native-dice.png' = 'ee52a02765feac1b8618a41aac67b063dd106bff031bec467e838b81b47fd81b'
    'native-hilo.png' = '5d0d1ccce2271ba9d0031e53141e28d8487ebdf9dd4c1f0fd567aeaebb039701'
    'native-holdem.png' = 'd42cc91652275d0a02dc8440e8d4bfcf07fc960771f8989e9c8fa614daf3abdc'
    'native-lobby-dark.png' = 'dc8fc7c2be6cf8206bcd776ae1cd8b19ff752e4b8237432a27db792eb70e27e4'
    'native-lobby-light.png' = '28bbff734df9889f86f800ca1f02cbe977629ef4f6a72ee31fab63402c582169'
    'native-midnight-crossing.png' = '95bcd27013d98bc53e897cce66f1d2688ac4f378d2ab6edff8bfc6a13d851fe3'
    'native-mines.png' = 'd746973b2dca0b4a3526c9c6a0d4bb9af04de356881f49977d4a051152c3ed49'
    'native-plinko.png' = '7796728907b7573a837be2ca182244a6c1cee50e03672ed8297aeedcb27be796'
    'native-roulette.png' = '22906a231a195f1018c2938b1e01ae01bce2322f4a90ec84aa38ce57a1b5547e'
    'native-slots.png' = '410df3ea6a6241ed66b67585645077aea718e08632882ac000bbf0239f7b894c'
}
foreach ($name in $captureHashes.Keys) {
    $capture = Join-Path $Site (Join-Path 'assets' $name)
    if (-not (Test-Path -LiteralPath $capture -PathType Leaf)) { throw "Verified native capture is missing: $name" }
    $actualHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $capture).Hash.ToLowerInvariant()
    if ($actualHash -ne $captureHashes[$name]) { throw "Verified native capture hash changed: $name" }
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

foreach ($required in @('Create Local Profile', 'local-only', 'no password', 'type="file"', 'accept="image/png,image/jpeg,image/webp"', 'data-avatar-preview', 'aria-live="polite"')) {
    if ($profileHtml -notmatch [regex]::Escape($required)) { throw "Profile page is missing required content: $required" }
}
if ($profileHtml -match 'type\s*=\s*["'']password["'']') { throw 'The local profile must not request a password.' }

foreach ($game in @('Blackjack', 'European Roulette', 'Plinko', 'Coop Climb', 'Midnight Crossing', 'No-Limit Texas Hold', 'Mines', 'Dice', 'HiLo', 'Crash', 'Slots')) {
    if ($playHtml -notmatch [regex]::Escape($game)) { throw "Play catalog is missing a completed game: $game" }
}
$cardCount = ([regex]::Matches($playHtml, 'class="game-card"')).Count
if ($cardCount -ne 11) { throw "Play catalog must contain exactly eleven equal-quality game cards; found $cardCount." }
foreach ($name in $captureHashes.Keys) {
    if ($playHtml -notmatch [regex]::Escape("assets/$name")) { throw "Play catalog does not reference verified native capture: $name" }
}
foreach ($required in @('games do not run in the browser', 'Download or launch on Windows', 'Actual native application', 'verified captures', 'Edit profile', 'Reset', 'play-money')) {
    if ($playHtml -notmatch [regex]::Escape($required)) { throw "Play page is missing required launcher language: $required" }
}

$expectedBytes = 6963264
$expectedHash = '83b4e94c24c196782cb04f209193303a6bd602a8a3e7b2b3a8e99548ec02d597'
foreach ($required in @('Scroll2Roll-0.3.0-windows-x64.zip', '6,963,264 bytes', '6.64 MiB', $expectedHash, 'Windows x64', 'Installation', 'System requirements', 'Unsigned-build disclosure', 'unknown-publisher', 'Troubleshooting', 'SHA256SUMS.txt')) {
    if ($downloadHtml -notmatch [regex]::Escape($required)) { throw "Download page is missing verified package content: $required" }
}

foreach ($required in @('localStorage', 'scroll2roll.localProfile.v1', 'MAX_AVATAR_BYTES', '1572864', 'image/png', 'image/jpeg', 'image/webp', 'fileSignatureMatches', 'decodeImage', 'removeItem', 'textContent')) {
    if ($script -notmatch [regex]::Escape($required)) { throw "Profile script is missing a required local-safety control: $required" }
}
if ($script -match '\b(fetch|XMLHttpRequest|WebSocket|sendBeacon)\b') { throw 'Website profile code must not transmit data or use a network API.' }
if ($allHtml -match '(?i)<script[^>]+src=["'']https?://' -or $allHtml -match '(?i)<img[^>]+src=["'']https?://') { throw 'Website must not load external scripts or images.' }
if ($allHtml -match '(?i)deposit now|withdraw winnings|real-money wagering available|play in your browser|browser-playable casino') { throw 'Website contains a prohibited product claim.' }

foreach ($required in @(':focus-visible', 'prefers-reduced-motion', '@media (max-width:', '--blue:', '--violet:', '--gold:', '--focus:', '.game-capture', '.hero-preview')) {
    if ($css -notmatch [regex]::Escape($required)) { throw "Stylesheet is missing an accessibility or design requirement: $required" }
}
foreach ($required in @("script-src 'self'", "connect-src 'none'", "object-src 'none'", "frame-ancestors 'none'", "payment=()")) {
    if ($headers -notmatch [regex]::Escape($required)) { throw "Security headers are missing required policy: $required" }
}

$archive = Join-Path $Site 'downloads\Scroll2Roll-0.3.0-windows-x64.zip'
if (Test-Path -LiteralPath $archive) {
    $archiveItem = Get-Item -LiteralPath $archive
    if ($archiveItem.Length -ne $expectedBytes) { throw "Staged archive size changed: $($archiveItem.Length) bytes." }
    $archiveHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $archive).Hash.ToLowerInvariant()
    if ($archiveHash -ne $expectedHash) { throw "Staged archive SHA-256 changed: $archiveHash" }
}

$files = Get-ChildItem -Recurse -File -LiteralPath $Site
if ($files.Count -gt 20000) { throw 'Website exceeds the Cloudflare Pages Free file-count limit.' }
if ($files | Where-Object Length -gt 25MB) { throw 'Website contains an asset larger than the Cloudflare Pages 25 MiB limit.' }
Write-Output "Static website validation passed for $($files.Count) files."
