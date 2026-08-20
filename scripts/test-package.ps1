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
    'assets/games/group1-v1/chicken-explorer-topdown.png',
    'assets/games/group1-v1/coop-climb-platform.png',
    'assets/games/group1-v1/coop-observatory-background.png',
    'assets/games/group1-v1/crash-flight-background.png',
    'assets/games/group1-v1/crash-rocket.png',
    'assets/games/group1-v1/crash-vfx-burst.png',
    'assets/games/group1-v1/midnight-car-coral.png',
    'assets/games/group1-v1/midnight-car-cyan.png',
    'assets/games/group1-v1/midnight-city-base.png',
    'assets/games/group1-v1/midnight-log-raft.png',
    'assets/games/group1-v1/midnight-tram.png',
    'assets/games/group2-v1/blackjack-dealing-shoe.png',
    'assets/games/group2-v1/blackjack-room-background.png',
    'assets/games/group2-v1/casino-chip-stack.png',
    'assets/games/group2-v1/holdem-lounge-background.png',
    'assets/games/group2-v1/holdem-props-atlas.png',
    'assets/games/group2-v1/roulette-room-background.png',
    'assets/games/group2-v1/roulette-wheel.png',
    'assets/games/group3-v1/mines-cavern-background.png',
    'assets/games/group3-v1/mines-mechanical-mine.png',
    'assets/games/group3-v1/mines-tile-state-atlas.png',
    'assets/games/group3-v1/plinko-chamber-background.png',
    'assets/games/group3-v1/plinko-enclosure.png',
    'assets/games/group3-v1/slots-arcade-background.png',
    'assets/games/group3-v1/slots-cabinet.png',
    'assets/games/group3-v1/slots-symbols-exact.png',
    'assets/games/group4-v1/dice-signal-display.png',
    'assets/games/group4-v1/dice-vault-background.png',
    'assets/games/group4-v1/hilo-card-tray.png',
    'assets/games/group4-v1/hilo-effects-atlas.png',
    'assets/games/group4-v1/hilo-prediction-room.png',
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
    'assets/MANIFEST.md' = '507d61f2f19d3d3bd2a6ef7d12cab072f2f5144a64b766c80d003da5ccc6255b'
    'assets/fonts/manrope/Manrope-wght.ttf' = 'd0639be45d0af36e798172419d7bd173c4bd4f29e2b76cbb69db1d11bf8b0a40'
    'assets/fonts/manrope/Manrope-Medium.ttf' = '98ee850d1d257f4bb2328c24dfff392f85a351a61ed7f600dba140bcbb5313f9'
    'assets/fonts/manrope/OFL.txt' = 'e01b637272e0cbdfb240184dd98ea5cc671556d9894dae2668d92ab2c906787c'
    'assets/fonts/manrope/METADATA.pb' = '368beda3aa55b0afe90edc142d67cf37e743258c76481d520172afbc148c6cca'
    'assets/games/group1-v1/chicken-explorer-topdown.png' = '59fa498ae754b1568b9b16b14fd3f373540cc98ed2ab8868c5c46ed9bc0fc7f6'
    'assets/games/group1-v1/coop-climb-platform.png' = '0f5305cb1653c6b86019641f4a3ccb82a3fca811ceb21e2c552341ef5cbb73f7'
    'assets/games/group1-v1/coop-observatory-background.png' = '59eb14b375d714d8d85248e7f479712626a9a43d5b8be12baaa654f272a71991'
    'assets/games/group1-v1/crash-flight-background.png' = '208295182a7954ac3f3dc53f980bc70aeb35ea39d89b16360a2419dad500b9a4'
    'assets/games/group1-v1/crash-rocket.png' = '60b3b7ea5babd0e34b75f02dd22296882a553d109e9c3915ffb386590c587aad'
    'assets/games/group1-v1/crash-vfx-burst.png' = 'eabe7cb3f84ac602b0d702567fe460cc7bfe64c2acc56fde9e6604e8f2780305'
    'assets/games/group1-v1/midnight-car-coral.png' = '51fd49b13df802ad9d46cd34e1016bec080cf1630a3b327b13cdee9dd4727369'
    'assets/games/group1-v1/midnight-car-cyan.png' = '2119640d8d2dd1201325092ac0c3fb53070851dcba904898067fb6e0055b4919'
    'assets/games/group1-v1/midnight-city-base.png' = 'eac30cc1e57fdec41f6089016918455081d74e9f1c7020e146c483ada03b1afb'
    'assets/games/group1-v1/midnight-log-raft.png' = 'f85c1a759ed35ae2bb3ac4b010bb8c6d749704d34cc07e45c6fdd67d08fa3792'
    'assets/games/group1-v1/midnight-tram.png' = 'e130c11623acb76717ce8bb32331f912f797f21bf0d433441d85bc1039d93f86'
    'assets/games/group2-v1/blackjack-dealing-shoe.png' = '9f0040e8b708cb52ea53e1fda3f77d6549fd5c34162d4d3009cf365eb394984d'
    'assets/games/group2-v1/blackjack-room-background.png' = '3c79825e666278d077c263587f5bb59cbbc4a43bc8ad2ad91f14fd8fd9192cbb'
    'assets/games/group2-v1/casino-chip-stack.png' = '1578715ebf69ab7804517f111a7b7e8d57d02ad388d856fa859c2ca3040fa674'
    'assets/games/group2-v1/holdem-lounge-background.png' = 'bcaf36efc9e3f1a7d5cf5459a24b00bc3b09a771df9f633cf313048c0cd2fe98'
    'assets/games/group2-v1/holdem-props-atlas.png' = '446301089f381ce7057cdfbe64f01b7bcc6fec0ffd7de83ad8522be0305abb3b'
    'assets/games/group2-v1/roulette-room-background.png' = 'ce98c2a5f623e34d53e71f227b80e961b3d9a6c588b23b7478f3e363fc87f114'
    'assets/games/group2-v1/roulette-wheel.png' = 'acffc6f576ed69fafcb60ed9592e42e617ec0f99ea2be9eff22f1a4a6ce6ed22'
    'assets/games/group3-v1/mines-cavern-background.png' = '01e38a658ceb02fcc0761c76c8b4a588f7b5c956ff8ee8fc52f739d3ad2f369d'
    'assets/games/group3-v1/mines-mechanical-mine.png' = '95e2c926c8ba8ab77626c859ed93a08f0e79a6b3208a4df2c7c09234a94f01d2'
    'assets/games/group3-v1/mines-tile-state-atlas.png' = 'eda3bbbe4b5c8e85d2d7feb6c60798ba89c35b0b222342c8f41446d92d10f9fd'
    'assets/games/group3-v1/plinko-chamber-background.png' = '88b0abc3f2bea1ee6983a0d5d408e81cafe5a7dc31db0b88965d7389fc4262cd'
    'assets/games/group3-v1/plinko-enclosure.png' = 'c02d115e71cb5b33eb74ba1ec84aa0e50411a9570b57d7389007b7ba920df73e'
    'assets/games/group3-v1/slots-arcade-background.png' = '3585327806689834a0731d119543a8d8dd260f6a4fafa543e941f1affa869802'
    'assets/games/group3-v1/slots-cabinet.png' = '5a9af713b1d779f07e75c04a68280b9a66a20ffd14f87921d510825264383f24'
    'assets/games/group3-v1/slots-symbols-exact.png' = '5b595fb2ed3c6abd6cd4b55de86a78340d862a562ec4ee8c24329104527621fa'
    'assets/games/group4-v1/dice-signal-display.png' = '9530712fc8b61fb8a144d6af8d9ead23a9e3af20c21ca250c3eb1f84e57d6ff2'
    'assets/games/group4-v1/dice-vault-background.png' = 'd50bc2babbd1d90789e6876110dfea4818ec1a8944d0fdcd408bc77dd1ccc3f8'
    'assets/games/group4-v1/hilo-card-tray.png' = '299556a9590fbe180869b5e535771b7dee92b5095d73bc50537f6db53b73fa8c'
    'assets/games/group4-v1/hilo-effects-atlas.png' = '40b51a210378b265f0d73e91921091eee8bd45c853eb3915cb7b71c9d6d36399'
    'assets/games/group4-v1/hilo-prediction-room.png' = '52155e8bdb90468884a7ab41bccfecabdf69f9119e199d4ddcbbfc44feaf5ef9'
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
