[CmdletBinding()]
param(
    [string]$RocketRoot = $env:ROCKET_ROOT,
    [string]$Rocketc = '',
    [switch]$UseExistingExecutable
)

$ErrorActionPreference = 'Stop'
$repository = Split-Path $PSScriptRoot -Parent
$executable = Join-Path $repository '.rocketc\Scroll2Roll.exe'
if ($UseExistingExecutable) {
    if (-not (Test-Path -LiteralPath $executable -PathType Leaf)) {
        throw "Existing executable missing: $executable"
    }
    Write-Warning 'Packaging the existing executable without a new Release build. This is a local review candidate, not fresh Release-validation evidence.'
} else {
    & (Join-Path $PSScriptRoot 'build.ps1') -Configuration Release -RocketRoot $RocketRoot -Rocketc $Rocketc
}

$packageRoot = [System.IO.Path]::GetFullPath((Join-Path $repository 'out\package'))
$stage = [System.IO.Path]::GetFullPath((Join-Path $packageRoot 'Scroll2Roll-0.3.0-windows-x64'))
if (-not $stage.StartsWith($packageRoot + [System.IO.Path]::DirectorySeparatorChar, [System.StringComparison]::OrdinalIgnoreCase)) {
    throw "Unsafe package stage: $stage"
}
if (Test-Path -LiteralPath $stage) { Remove-Item -LiteralPath $stage -Recurse -Force }
New-Item -ItemType Directory -Force -Path $stage | Out-Null

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
    'assets\MANIFEST.md' = '507D61F2F19D3D3BD2A6EF7D12CAB072F2F5144A64B766C80D003DA5CCC6255B'
    'assets\fonts\manrope\Manrope-wght.ttf' = 'D0639BE45D0AF36E798172419D7BD173C4BD4F29E2B76CBB69DB1D11BF8B0A40'
    'assets\fonts\manrope\Manrope-Medium.ttf' = '98EE850D1D257F4BB2328C24DFFF392F85A351A61ED7F600DBA140BCBB5313F9'
    'assets\fonts\manrope\OFL.txt' = 'E01B637272E0CBDFB240184DD98EA5CC671556D9894DAE2668D92AB2C906787C'
    'assets\fonts\manrope\METADATA.pb' = '368BEDA3AA55B0AFE90EDC142D67CF37E743258C76481D520172AFBC148C6CCA'
    'assets\games\group1-v1\chicken-explorer-topdown.png' = '59FA498AE754B1568B9B16B14FD3F373540CC98ED2AB8868C5C46ED9BC0FC7F6'
    'assets\games\group1-v1\coop-climb-platform.png' = '0F5305CB1653C6B86019641F4A3CCB82A3FCA811CEB21E2C552341EF5CBB73F7'
    'assets\games\group1-v1\coop-observatory-background.png' = '59EB14B375D714D8D85248E7F479712626A9A43D5B8BE12BAAA654F272A71991'
    'assets\games\group1-v1\crash-flight-background.png' = '208295182A7954AC3F3DC53F980BC70AEB35EA39D89B16360A2419DAD500B9A4'
    'assets\games\group1-v1\crash-rocket.png' = '60B3B7EA5BABD0E34B75F02DD22296882A553D109E9C3915FFB386590C587AAD'
    'assets\games\group1-v1\crash-vfx-burst.png' = 'EABE7CB3F84AC602B0D702567FE460CC7BFE64C2ACC56FDE9E6604E8F2780305'
    'assets\games\group1-v1\midnight-car-coral.png' = '51FD49B13DF802AD9D46CD34E1016BEC080CF1630A3B327B13CDEE9DD4727369'
    'assets\games\group1-v1\midnight-car-cyan.png' = '2119640D8D2DD1201325092AC0C3FB53070851DCBA904898067FB6E0055B4919'
    'assets\games\group1-v1\midnight-city-base.png' = 'EAC30CC1E57FDEC41F6089016918455081D74E9F1C7020E146C483ADA03B1AFB'
    'assets\games\group1-v1\midnight-log-raft.png' = 'F85C1A759ED35AE2BB3AC4B010BB8C6D749704D34CC07E45C6FDD67D08FA3792'
    'assets\games\group1-v1\midnight-tram.png' = 'E130C11623ACB76717CE8BB32331F912F797F21BF0D433441D85BC1039D93F86'
    'assets\games\group2-v1\blackjack-dealing-shoe.png' = '9F0040E8B708CB52EA53E1FDA3F77D6549FD5C34162D4D3009CF365EB394984D'
    'assets\games\group2-v1\blackjack-room-background.png' = '3C79825E666278D077C263587F5BB59CBBC4A43BC8AD2AD91F14FD8FD9192CBB'
    'assets\games\group2-v1\casino-chip-stack.png' = '1578715EBF69AB7804517F111A7B7E8D57D02AD388D856FA859C2CA3040FA674'
    'assets\games\group2-v1\holdem-lounge-background.png' = 'BCAF36EFC9E3F1A7D5CF5459A24B00BC3B09A771DF9F633CF313048C0CD2FE98'
    'assets\games\group2-v1\holdem-props-atlas.png' = '446301089F381CE7057CDFBE64F01B7BCC6FEC0FFD7DE83AD8522BE0305ABB3B'
    'assets\games\group2-v1\roulette-room-background.png' = 'CE98C2A5F623E34D53E71F227B80E961B3D9A6C588B23B7478F3E363FC87F114'
    'assets\games\group2-v1\roulette-wheel.png' = 'ACFFC6F576ED69FAFCB60ED9592E42E617EC0F99EA2BE9EFF22F1A4A6CE6ED22'
    'assets\games\group3-v1\mines-cavern-background.png' = '01E38A658CEB02FCC0761C76C8B4A588F7B5C956FF8EE8FC52F739D3AD2F369D'
    'assets\games\group3-v1\mines-mechanical-mine.png' = '95E2C926C8BA8AB77626C859ED93A08F0E79A6B3208A4DF2C7C09234A94F01D2'
    'assets\games\group3-v1\mines-tile-state-atlas.png' = 'EDA3BBBE4B5C8E85D2D7FEB6C60798BA89C35B0B222342C8F41446D92D10F9FD'
    'assets\games\group3-v1\plinko-chamber-background.png' = '88B0ABC3F2BEA1EE6983A0D5D408E81CAFE5A7DC31DB0B88965D7389FC4262CD'
    'assets\games\group3-v1\plinko-enclosure.png' = 'C02D115E71CB5B33EB74BA1EC84AA0E50411A9570B57D7389007B7BA920DF73E'
    'assets\games\group3-v1\slots-arcade-background.png' = '3585327806689834A0731D119543A8D8DD260F6A4FAFA543E941F1AFFA869802'
    'assets\games\group3-v1\slots-cabinet.png' = '5A9AF713B1D779F07E75C04A68280B9A66A20FFD14F87921D510825264383F24'
    'assets\games\group3-v1\slots-symbols-exact.png' = '5B595FB2ED3C6ABD6CD4B55DE86A78340D862A562EC4EE8C24329104527621FA'
    'assets\games\group4-v1\dice-signal-display.png' = '9530712FC8B61FB8A144D6AF8D9EAD23A9E3AF20C21CA250C3EB1F84E57D6FF2'
    'assets\games\group4-v1\dice-vault-background.png' = 'D50BC2BABBD1D90789E6876110DFEA4818EC1A8944D0FDCD408BC77DD1CCC3F8'
    'assets\games\group4-v1\hilo-card-tray.png' = '299556A9590FBE180869B5E535771B7DEE92B5095D73BC50537F6DB53B73FA8C'
    'assets\games\group4-v1\hilo-effects-atlas.png' = '40B51A210378B265F0D73E91921091EEE8BD45C853EB3915CB7B71C9D6D36399'
    'assets\games\group4-v1\hilo-prediction-room.png' = '52155E8BDB90468884A7AB41BCCFECABDF69F9119E199D4DDCBBFC44FEAF5EF9'
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
