[CmdletBinding()]
param(
    [string]$RocketRoot = $env:ROCKET_ROOT,
    [string]$Rocketc = ''
)

$ErrorActionPreference = 'Stop'
$repository = Split-Path $PSScriptRoot -Parent
& (Join-Path $PSScriptRoot 'build.ps1') -Configuration Release -RocketRoot $RocketRoot -Rocketc $Rocketc

$packageRoot = [System.IO.Path]::GetFullPath((Join-Path $repository 'out\package'))
$stage = [System.IO.Path]::GetFullPath((Join-Path $packageRoot 'Scroll2Roll-0.3.0-windows-x64'))
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

$raylibLicense = Join-Path $RocketRoot 'dependencies\installed\raylib-6.0\LICENSE'
if (-not (Test-Path -LiteralPath $raylibLicense -PathType Leaf)) {
    throw "Pinned raylib license missing: $raylibLicense"
}
Copy-Item -LiteralPath $raylibLicense -Destination (Join-Path $stage 'RAYLIB_LICENSE.txt')

$assetHashes = [ordered]@{
    'assets\MANIFEST.md' = '2655E57EE40AD07A11BBF2FF849B9DD8B528DED6EC8294BA264B2EB016651FF4'
    'assets\fonts\manrope\Manrope-wght.ttf' = 'D0639BE45D0AF36E798172419D7BD173C4BD4F29E2B76CBB69DB1D11BF8B0A40'
    'assets\fonts\manrope\Manrope-Medium.ttf' = '98EE850D1D257F4BB2328C24DFFF392F85A351A61ED7F600DBA140BCBB5313F9'
    'assets\fonts\manrope\OFL.txt' = 'E01B637272E0CBDFB240184DD98EA5CC671556D9894DAE2668D92AB2C906787C'
    'assets\fonts\manrope\METADATA.pb' = '368BEDA3AA55B0AFE90EDC142D67CF37E743258C76481D520172AFBC148C6CCA'
    'assets\ui\IMAGEGEN_PROMPTS.md' = '89853C25DBD121FDE3A78DC3AF01F2F70CF222ED88D0A7A8B9B7495006340177'
    'assets\ui\scroll2roll-cover-atlas-a.png' = 'DD9D2B43D3CE4B0B39378DC6F1B211D5FC4D7F6750D552BE535B6545917B9052'
    'assets\ui\scroll2roll-cover-atlas-b.png' = 'D594D31752824E905B4E7D2E8BC6D262E4D97EC4E7BCAC5BB8253F8C67C502AC'
}
foreach ($relative in $assetHashes.Keys) {
    $source = Join-Path $repository $relative
    if (-not (Test-Path -LiteralPath $source -PathType Leaf)) { throw "Required package asset missing: $relative" }
    $actualHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $source).Hash
    if ($actualHash -ne $assetHashes[$relative]) { throw "Reviewed asset hash changed: $relative" }
    $destination = Join-Path $stage $relative
    New-Item -ItemType Directory -Force -Path (Split-Path $destination -Parent) | Out-Null
    Copy-Item -LiteralPath $source -Destination $destination
}

$checksumPath = Join-Path $stage 'SHA256SUMS.txt'
$lines = Get-ChildItem -LiteralPath $stage -File -Recurse | Sort-Object FullName | ForEach-Object {
    $hash = (Get-FileHash -Algorithm SHA256 -LiteralPath $_.FullName).Hash.ToLowerInvariant()
    $relative = $_.FullName.Substring($stage.Length + 1).Replace('\', '/')
    "$hash  $relative"
}
Set-Content -LiteralPath $checksumPath -Value $lines -Encoding ascii

$archive = Join-Path $packageRoot 'Scroll2Roll-0.3.0-windows-x64.zip'
if (Test-Path -LiteralPath $archive) { Remove-Item -LiteralPath $archive -Force }
Compress-Archive -Path (Join-Path $stage '*') -DestinationPath $archive -CompressionLevel Optimal
$archiveHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $archive).Hash.ToLowerInvariant()
Set-Content -LiteralPath (Join-Path $packageRoot 'Scroll2Roll-0.3.0-windows-x64.zip.sha256') -Value "$archiveHash  Scroll2Roll-0.3.0-windows-x64.zip" -Encoding ascii

Write-Output "Package: $archive"
Write-Output "SHA-256: $archiveHash"
