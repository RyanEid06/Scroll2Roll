[CmdletBinding()]
param(
    [string]$RocketRoot = $env:ROCKET_ROOT,
    [string]$Rocketc = ''
)

$ErrorActionPreference = 'Stop'
$repository = Split-Path $PSScriptRoot -Parent
& (Join-Path $PSScriptRoot 'build.ps1') -Configuration Release -RocketRoot $RocketRoot -Rocketc $Rocketc

$packageRoot = [System.IO.Path]::GetFullPath((Join-Path $repository 'out\package'))
$stage = [System.IO.Path]::GetFullPath((Join-Path $packageRoot 'Scroll2Roll-0.2.0-windows-x64'))
if (-not $stage.StartsWith($packageRoot + [System.IO.Path]::DirectorySeparatorChar, [System.StringComparison]::OrdinalIgnoreCase)) {
    throw "Unsafe package stage: $stage"
}
if (Test-Path -LiteralPath $stage) { Remove-Item -LiteralPath $stage -Recurse -Force }
New-Item -ItemType Directory -Force -Path $stage | Out-Null

$executable = Join-Path $repository '.rocketc\Scroll2Roll.exe'
if (-not (Test-Path -LiteralPath $executable)) { throw "Built executable missing: $executable" }
Copy-Item -LiteralPath $executable -Destination (Join-Path $stage 'Scroll2Roll.exe')
foreach ($file in @('README.md', 'NOTICE.md', 'THIRD_PARTY_NOTICES.md', 'VERSION.txt')) {
    Copy-Item -LiteralPath (Join-Path $repository $file) -Destination $stage
}
Copy-Item -LiteralPath (Join-Path $repository 'docs\CONTROLS.md'),(Join-Path $repository 'docs\TROUBLESHOOTING.md') -Destination $stage

$checksumPath = Join-Path $stage 'SHA256SUMS.txt'
$lines = Get-ChildItem -LiteralPath $stage -File | Sort-Object Name | ForEach-Object {
    $hash = (Get-FileHash -Algorithm SHA256 -LiteralPath $_.FullName).Hash.ToLowerInvariant()
    "$hash  $($_.Name)"
}
Set-Content -LiteralPath $checksumPath -Value $lines -Encoding ascii

$archive = Join-Path $packageRoot 'Scroll2Roll-0.2.0-windows-x64.zip'
if (Test-Path -LiteralPath $archive) { Remove-Item -LiteralPath $archive -Force }
Compress-Archive -Path (Join-Path $stage '*') -DestinationPath $archive -CompressionLevel Optimal
$archiveHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $archive).Hash.ToLowerInvariant()
Set-Content -LiteralPath (Join-Path $packageRoot 'Scroll2Roll-0.2.0-windows-x64.zip.sha256') -Value "$archiveHash  Scroll2Roll-0.2.0-windows-x64.zip" -Encoding ascii

Write-Output "Package: $archive"
Write-Output "SHA-256: $archiveHash"
