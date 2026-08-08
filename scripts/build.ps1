[CmdletBinding()]
param(
    [ValidateSet('Debug', 'Release')]
    [string]$Configuration = 'Debug',
    [string]$RocketRoot = $env:ROCKET_ROOT,
    [string]$Rocketc = ''
)

$ErrorActionPreference = 'Stop'
$repository = Split-Path $PSScriptRoot -Parent
if (-not $RocketRoot) {
    throw 'Set -RocketRoot or ROCKET_ROOT to the frozen Rocket 2.0 checkout.'
}
$RocketRoot = [System.IO.Path]::GetFullPath($RocketRoot)
if (-not $Rocketc) {
    $Rocketc = Join-Path $RocketRoot 'out\build\windows-release\rocketc.exe'
}
$Rocketc = [System.IO.Path]::GetFullPath($Rocketc)
$activation = Join-Path $RocketRoot 'dependencies\activate.ps1'
if (-not (Test-Path -LiteralPath $activation)) { throw "Rocket activation script not found: $activation" }
if (-not (Test-Path -LiteralPath $Rocketc)) { throw "Rocket compiler not found: $Rocketc" }

. $activation
$buildRoot = Join-Path $repository ("out\build\windows-" + $Configuration.ToLowerInvariant())
cmake -S $repository -B $buildRoot -G Ninja "-DCMAKE_BUILD_TYPE=$Configuration" "-DROCKET_ROOT=$RocketRoot" "-DROCKETC=$Rocketc"
if ($LASTEXITCODE -ne 0) { throw 'CMake configuration failed.' }
cmake --build $buildRoot
if ($LASTEXITCODE -ne 0) { throw 'Scroll2Roll build failed.' }

Write-Output "Scroll2Roll $Configuration build completed."
