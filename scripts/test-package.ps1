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

$checksumPath = Join-Path $relocationRoot 'SHA256SUMS.txt'
if (-not (Test-Path -LiteralPath $checksumPath)) { throw 'SHA256SUMS.txt is missing from the package.' }
$verifiedNames = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)
foreach ($line in Get-Content -LiteralPath $checksumPath) {
    if ($line -notmatch '^([0-9a-fA-F]{64})  ([^\\/]+)$') { throw "Invalid internal checksum line: $line" }
    $expectedHash = $Matches[1].ToLowerInvariant()
    $name = $Matches[2]
    $file = Join-Path $relocationRoot $name
    if (-not (Test-Path -LiteralPath $file -PathType Leaf)) { throw "Checksummed package file is missing: $name" }
    $actualHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $file).Hash.ToLowerInvariant()
    if ($actualHash -ne $expectedHash) { throw "Internal checksum mismatch: $name" }
    if (-not $verifiedNames.Add($name)) { throw "Duplicate internal checksum entry: $name" }
}
foreach ($file in Get-ChildItem -LiteralPath $relocationRoot -File) {
    if ($file.Name -ne 'SHA256SUMS.txt' -and -not $verifiedNames.Contains($file.Name)) {
        throw "Package file is missing an internal checksum: $($file.Name)"
    }
}

$executable = Join-Path $relocationRoot 'Scroll2Roll.exe'
& $executable --headless-smoke
if ($LASTEXITCODE -ne 0) { throw "Relocated headless smoke failed with exit $LASTEXITCODE" }

Write-Output "Relocated package smoke passed: $relocationRoot"
