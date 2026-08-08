[CmdletBinding()]
param(
    [string]$Archive = '',
    [string]$Output = ''
)

$ErrorActionPreference = 'Stop'
$repository = Split-Path $PSScriptRoot -Parent
if (-not $Archive) { $Archive = Join-Path $repository 'out\package\Scroll2Roll-0.2.0-windows-x64.zip' }
$Archive = [System.IO.Path]::GetFullPath($Archive)
if (-not (Test-Path -LiteralPath $Archive)) { throw "Release archive not found: $Archive" }
$maxPagesAsset = 25MB
if ((Get-Item -LiteralPath $Archive).Length -gt $maxPagesAsset) {
    throw 'The release exceeds Cloudflare Pages current 25 MiB per-asset limit. Use an owner-approved R2 or GitHub Releases download instead.'
}

$outRoot = [System.IO.Path]::GetFullPath((Join-Path $repository 'out'))
if (-not $Output) { $Output = Join-Path $outRoot 'cloudflare-site' }
$output = [System.IO.Path]::GetFullPath($Output)
if (-not $output.StartsWith($outRoot + [System.IO.Path]::DirectorySeparatorChar, [System.StringComparison]::OrdinalIgnoreCase)) {
    throw "Unsafe Cloudflare staging directory: $output"
}
if (Test-Path -LiteralPath $output) {
    try {
        Remove-Item -LiteralPath $output -Recurse -Force
    } catch {
        throw "The staging directory is in use and could not be refreshed: $output. Stop its local preview or pass -Output with a fresh path under $outRoot."
    }
}
New-Item -ItemType Directory -Force -Path $output | Out-Null

$expectedFiles = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)
$websiteRoot = [System.IO.Path]::GetFullPath((Join-Path $repository 'website'))
foreach ($sourceFile in Get-ChildItem -LiteralPath $websiteRoot -File -Recurse) {
    if (-not $sourceFile.FullName.StartsWith($websiteRoot + [System.IO.Path]::DirectorySeparatorChar, [System.StringComparison]::OrdinalIgnoreCase)) {
        throw "Unsafe website source path: $($sourceFile.FullName)"
    }
    $relative = $sourceFile.FullName.Substring($websiteRoot.Length).TrimStart([System.IO.Path]::DirectorySeparatorChar)
    $destination = Join-Path $output $relative
    New-Item -ItemType Directory -Force -Path (Split-Path $destination -Parent) | Out-Null
    Copy-Item -LiteralPath $sourceFile.FullName -Destination $destination -Force
    [void]$expectedFiles.Add($relative)
}
$downloads = Join-Path $output 'downloads'
New-Item -ItemType Directory -Force -Path $downloads | Out-Null
$stagedArchive = Join-Path $downloads 'Scroll2Roll-0.2.0-windows-x64.zip'
$archiveHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $Archive).Hash
if (-not (Test-Path -LiteralPath $stagedArchive) -or (Get-FileHash -Algorithm SHA256 -LiteralPath $stagedArchive).Hash -ne $archiveHash) {
    Copy-Item -LiteralPath $Archive -Destination $stagedArchive -Force
}
[void]$expectedFiles.Add('downloads\Scroll2Roll-0.2.0-windows-x64.zip')

foreach ($stagedFile in Get-ChildItem -LiteralPath $output -File -Recurse) {
    if (-not $stagedFile.FullName.StartsWith($output + [System.IO.Path]::DirectorySeparatorChar, [System.StringComparison]::OrdinalIgnoreCase)) {
        throw "Unsafe staged file path: $($stagedFile.FullName)"
    }
    $relative = $stagedFile.FullName.Substring($output.Length).TrimStart([System.IO.Path]::DirectorySeparatorChar)
    if (-not $expectedFiles.Contains($relative)) { Remove-Item -LiteralPath $stagedFile.FullName -Force }
}

Write-Output "Prepared Cloudflare Pages directory: $output"
