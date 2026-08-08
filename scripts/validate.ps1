[CmdletBinding()]
param(
    [ValidateSet('Debug', 'Release')]
    [string]$Configuration = 'Debug',
    [string]$RocketRoot = $env:ROCKET_ROOT,
    [string]$Rocketc = ''
)

$ErrorActionPreference = 'Stop'
$repository = Split-Path $PSScriptRoot -Parent
& (Join-Path $PSScriptRoot 'build.ps1') -Configuration $Configuration -RocketRoot $RocketRoot -Rocketc $Rocketc
if (-not $Rocketc) { $Rocketc = Join-Path ([System.IO.Path]::GetFullPath($RocketRoot)) 'out\build\windows-release\rocketc.exe' }

& $Rocketc check $repository
if ($LASTEXITCODE -ne 0) { throw 'rocketc check failed.' }
& $Rocketc test $repository
if ($LASTEXITCODE -ne 0) { throw 'rocketc test failed.' }
& $Rocketc fmt (Join-Path $repository 'src') --check
if ($LASTEXITCODE -ne 0) { throw 'rocketc fmt src --check failed.' }
& $Rocketc fmt (Join-Path $repository 'tests') --check
if ($LASTEXITCODE -ne 0) { throw 'rocketc fmt tests --check failed.' }

Write-Output "Scroll2Roll $Configuration validation completed."
