[CmdletBinding()]
param([string]$Site = '')

$ErrorActionPreference = 'Stop'
$repository = Split-Path $PSScriptRoot -Parent
if (-not $Site) { $Site = Join-Path $repository 'website' }
$Site = [System.IO.Path]::GetFullPath($Site)
$index = Join-Path $Site 'index.html'
$css = Join-Path $Site 'styles.css'
if (-not (Test-Path -LiteralPath $index) -or -not (Test-Path -LiteralPath $css)) { throw 'Website index or stylesheet is missing.' }
$html = Get-Content -Raw -LiteralPath $index
foreach ($required in @('play-money', 'Windows x64', 'Blackjack', 'Privacy', 'Installation', 'Troubleshooting', 'Scroll2Roll-0.1.0-windows-x64.zip')) {
    if ($html -notmatch [regex]::Escape($required)) { throw "Website is missing required text: $required" }
}
if ($html -match 'browser.playable|deposit now|withdraw winnings') { throw 'Website contains a prohibited product claim.' }
$files = Get-ChildItem -Recurse -File -LiteralPath $Site
if ($files.Count -gt 20000) { throw 'Website exceeds the Cloudflare Pages Free file-count limit.' }
if ($files | Where-Object Length -gt 25MB) { throw 'Website contains an asset larger than the Cloudflare Pages 25 MiB limit.' }
Write-Output "Static website validation passed for $($files.Count) files."
