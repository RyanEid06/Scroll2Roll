[CmdletBinding()]
param([string]$Archive = '')

$ErrorActionPreference = 'Stop'
$repository = Split-Path $PSScriptRoot -Parent
if (-not $Archive) { $Archive = Join-Path $repository 'out\package\Scroll2Roll-0.3.0-windows-x64.zip' }
$Archive = [System.IO.Path]::GetFullPath($Archive)
if (-not (Test-Path -LiteralPath $Archive)) { throw "Package archive not found: $Archive" }

$sidecar = "$Archive.sha256"
if (-not (Test-Path -LiteralPath $sidecar)) { throw "Package checksum sidecar not found: $sidecar" }
$sidecarLine = (Get-Content -Raw -LiteralPath $sidecar).Trim()
if ($sidecarLine -notmatch '^([0-9a-fA-F]{64})  ([^\\/]+)$') { throw 'Package checksum sidecar has an invalid format.' }
$archiveHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $Archive).Hash.ToLowerInvariant()
if ($Matches[1].ToLowerInvariant() -ne $archiveHash -or $Matches[2] -ne (Split-Path $Archive -Leaf)) {
    throw 'Package checksum sidecar does not match the archive.'
}

$relocationRoot = [System.IO.Path]::GetFullPath((Join-Path $repository 'out\relocation'))
if (-not $relocationRoot.StartsWith([System.IO.Path]::GetFullPath((Join-Path $repository 'out')) + [System.IO.Path]::DirectorySeparatorChar, [System.StringComparison]::OrdinalIgnoreCase)) {
    throw "Unsafe relocation root: $relocationRoot"
}
if (Test-Path -LiteralPath $relocationRoot) { Remove-Item -LiteralPath $relocationRoot -Recurse -Force }
New-Item -ItemType Directory -Force -Path $relocationRoot | Out-Null
Expand-Archive -LiteralPath $Archive -DestinationPath $relocationRoot

$forbidden = Get-ChildItem -Recurse -Force -LiteralPath $relocationRoot | Where-Object {
    $_.Name -in @('.vs', '.rocketc', 'generated', 'dependencies', 'out') -or $_.Extension -in @('.obj', '.o', '.pdb', '.ilk')
}
if ($forbidden) { throw "Forbidden package content: $($forbidden.FullName -join ', ')" }

$expectedFiles = @(
    'Scroll2Roll.exe',
    'README.md',
    'NOTICE.md',
    'THIRD_PARTY_NOTICES.md',
    'VERSION.txt',
    'CONTROLS.md',
    'TROUBLESHOOTING.md',
    'RAYLIB_LICENSE.txt',
    'SHA256SUMS.txt',
    'assets/MANIFEST.md',
    'assets/fonts/manrope/Manrope-wght.ttf',
    'assets/fonts/manrope/Manrope-Medium.ttf',
    'assets/fonts/manrope/OFL.txt',
    'assets/fonts/manrope/METADATA.pb',
    'assets/ui/IMAGEGEN_PROMPTS.md',
    'assets/ui/scroll2roll-cover-atlas-a.png',
    'assets/ui/scroll2roll-cover-atlas-b.png'
)
$expectedNames = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)
foreach ($name in $expectedFiles) { [void]$expectedNames.Add($name) }
foreach ($file in Get-ChildItem -LiteralPath $relocationRoot -File -Recurse) {
    $relative = $file.FullName.Substring($relocationRoot.Length + 1).Replace('\', '/')
    if (-not $expectedNames.Contains($relative)) { throw "Unexpected package file: $relative" }
    [void]$expectedNames.Remove($relative)
}
if ($expectedNames.Count -ne 0) { throw "Required package files are missing: $($expectedNames -join ', ')" }

$assetHashes = [ordered]@{
    'assets/MANIFEST.md' = '2655e57ee40ad07a11bbf2ff849b9dd8b528ded6ec8294ba264b2eb016651ff4'
    'assets/fonts/manrope/Manrope-wght.ttf' = 'd0639be45d0af36e798172419d7bd173c4bd4f29e2b76cbb69db1d11bf8b0a40'
    'assets/fonts/manrope/Manrope-Medium.ttf' = '98ee850d1d257f4bb2328c24dfff392f85a351a61ed7f600dba140bcbb5313f9'
    'assets/fonts/manrope/OFL.txt' = 'e01b637272e0cbdfb240184dd98ea5cc671556d9894dae2668d92ab2c906787c'
    'assets/fonts/manrope/METADATA.pb' = '368beda3aa55b0afe90edc142d67cf37e743258c76481d520172afbc148c6cca'
    'assets/ui/IMAGEGEN_PROMPTS.md' = '89853c25dbd121fde3a78dc3af01f2f70cf222ed88d0a7a8b9b7495006340177'
    'assets/ui/scroll2roll-cover-atlas-a.png' = 'dd9d2b43d3ce4b0b39378dc6f1b211d5fc4d7f6750d552be535b6545917b9052'
    'assets/ui/scroll2roll-cover-atlas-b.png' = 'd594d31752824e905b4e7d2e8bc6d262e4d97ec4e7bcac5bb8253f8c67c502ac'
}
foreach ($relative in $assetHashes.Keys) {
    $actualHash = (Get-FileHash -Algorithm SHA256 -LiteralPath (Join-Path $relocationRoot $relative)).Hash.ToLowerInvariant()
    if ($actualHash -ne $assetHashes[$relative]) { throw "Reviewed package asset hash changed: $relative" }
}
$raylibLicense = Get-Content -Raw -LiteralPath (Join-Path $relocationRoot 'RAYLIB_LICENSE.txt')
if ($raylibLicense -notmatch 'Copyright \(c\) 2013-2026 Ramon Santamaria' -or $raylibLicense -notmatch 'Permission is granted to anyone') {
    throw 'The complete pinned raylib license is missing or unrecognized.'
}

$checksumPath = Join-Path $relocationRoot 'SHA256SUMS.txt'
if (-not (Test-Path -LiteralPath $checksumPath)) { throw 'SHA256SUMS.txt is missing from the package.' }
$verifiedNames = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)
foreach ($line in Get-Content -LiteralPath $checksumPath) {
    if ($line -notmatch '^([0-9a-fA-F]{64})  ([A-Za-z0-9._/-]+)$') { throw "Invalid internal checksum line: $line" }
    $expectedHash = $Matches[1].ToLowerInvariant()
    $name = $Matches[2]
    if ($name.StartsWith('/') -or $name.Contains('//') -or ($name.Split('/') | Where-Object { $_ -in @('', '.', '..') })) {
        throw "Unsafe internal checksum path: $name"
    }
    $file = [System.IO.Path]::GetFullPath((Join-Path $relocationRoot $name))
    if (-not $file.StartsWith($relocationRoot + [System.IO.Path]::DirectorySeparatorChar, [System.StringComparison]::OrdinalIgnoreCase)) {
        throw "Unsafe internal checksum target: $name"
    }
    if (-not (Test-Path -LiteralPath $file -PathType Leaf)) { throw "Checksummed package file is missing: $name" }
    $actualHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $file).Hash.ToLowerInvariant()
    if ($actualHash -ne $expectedHash) { throw "Internal checksum mismatch: $name" }
    if (-not $verifiedNames.Add($name)) { throw "Duplicate internal checksum entry: $name" }
}
foreach ($file in Get-ChildItem -LiteralPath $relocationRoot -File -Recurse) {
    $relative = $file.FullName.Substring($relocationRoot.Length + 1).Replace('\', '/')
    if ($relative -ne 'SHA256SUMS.txt' -and -not $verifiedNames.Contains($relative)) {
        throw "Package file is missing an internal checksum: $relative"
    }
}

$executable = Join-Path $relocationRoot 'Scroll2Roll.exe'
Push-Location -LiteralPath $relocationRoot
try {
    & $executable --headless-smoke
    if ($LASTEXITCODE -ne 0) { throw "Relocated headless smoke failed with exit $LASTEXITCODE" }
} finally {
    Pop-Location
}

Write-Output "Relocated package smoke passed: $relocationRoot"
