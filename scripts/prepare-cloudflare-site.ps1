[CmdletBinding()]
param([string]$Archive = '')

$ErrorActionPreference = 'Stop'
$repository = Split-Path $PSScriptRoot -Parent
if (-not $Archive) { $Archive = Join-Path $repository 'out\package\Scroll2Roll-0.1.0-windows-x64.zip' }
$Archive = [System.IO.Path]::GetFullPath($Archive)
if (-not (Test-Path -LiteralPath $Archive)) { throw "Release archive not found: $Archive" }
$maxPagesAsset = 25MB
if ((Get-Item -LiteralPath $Archive).Length -gt $maxPagesAsset) {
    throw 'The release exceeds Cloudflare Pages current 25 MiB per-asset limit. Use an owner-approved R2 or GitHub Releases download instead.'
}

$output = [System.IO.Path]::GetFullPath((Join-Path $repository 'out\cloudflare-site'))
if (Test-Path -LiteralPath $output) { Remove-Item -LiteralPath $output -Recurse -Force }
Copy-Item -LiteralPath (Join-Path $repository 'website') -Destination $output -Recurse
$downloads = Join-Path $output 'downloads'
New-Item -ItemType Directory -Force -Path $downloads | Out-Null
Copy-Item -LiteralPath $Archive -Destination (Join-Path $downloads 'Scroll2Roll-0.1.0-windows-x64.zip')

Write-Output "Prepared Cloudflare Pages directory: $output"
