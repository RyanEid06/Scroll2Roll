param(
    [Parameter(Mandatory = $true)]
    [string]$RocketRoot,
    [ValidateSet('Check', 'Build', 'Run', 'Smoke')]
    [string]$Action = 'Check',
    [ValidateSet('Debug', 'Release')]
    [string]$Configuration = 'Debug',
    [ValidateSet('Table', 'Lobby', 'Settings')]
    [string]$Scene = 'Table'
)

$ErrorActionPreference = 'Stop'
$packageRoot = Split-Path $PSScriptRoot -Parent
$repoRoot = Split-Path $packageRoot -Parent
$rocketPath = (Resolve-Path -LiteralPath $RocketRoot).Path
$buildName = 'windows-' + $Configuration.ToLowerInvariant()
$buildRoot = Join-Path $rocketPath ('out/build/' + $buildName)
$compiler = Join-Path $buildRoot 'rocketc.exe'
$nativeRoot = Join-Path $buildRoot 'native/windows-x64'
$artifacts = Join-Path $repoRoot 'out/rocket35'
$executable = Join-Path $artifacts 'scroll2roll_rocket35/.rocketc/targets/windows-x64/Scroll2Roll35.exe'

if (-not (Test-Path -LiteralPath $compiler)) {
    throw "Rocket compiler not found: $compiler"
}
if ($Action -ne 'Check' -and -not (Test-Path -LiteralPath (Join-Path $nativeRoot 'rocket_raylib_adapter.lib'))) {
    throw "Rocket 3.5 native libraries not found: $nativeRoot"
}

$active = Get-CimInstance Win32_Process -Filter "Name = 'rocketc.exe' OR Name = 'clang.exe' OR Name = 'Scroll2Roll35.exe'" |
    Where-Object { $_.CommandLine -like "*$repoRoot*" }
if ($active) {
    throw 'A Scroll2Roll compiler or app process is already running. Finish that run before starting another.'
}

if ($Action -eq 'Check') {
    & $compiler check $packageRoot
    exit $LASTEXITCODE
}

$env:ROCKET_NATIVE_LIBRARY_ROOT = $nativeRoot
$env:ROCKET_ARTIFACT_ROOT = $artifacts
$env:SCROLL2ROLL_35_PACKAGE = $packageRoot
$env:SCROLL2ROLL_35_COMPILER = $compiler
$vswhere = Join-Path ([Environment]::GetFolderPath('ProgramFilesX86')) 'Microsoft Visual Studio/Installer/vswhere.exe'
if (-not (Test-Path -LiteralPath $vswhere)) {
    throw 'Visual Studio C++ installation locator was not found.'
}
$vsInstall = & $vswhere -latest -products '*' -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationPath
if (-not $vsInstall) {
    throw 'Visual Studio with the C++ tools is required for the native link.'
}
$vsDevCmd = Join-Path $vsInstall 'Common7/Tools/VsDevCmd.bat'
$buildCommand = 'call "' + $vsDevCmd + '" -arch=x64 -host_arch=x64 >nul && "%SCROLL2ROLL_35_COMPILER%" build "%SCROLL2ROLL_35_PACKAGE%"'
& cmd.exe /d /c $buildCommand
if ($LASTEXITCODE -ne 0) {
    exit $LASTEXITCODE
}
if ($Action -eq 'Build') {
    exit 0
}
if (-not (Test-Path -LiteralPath $executable)) {
    throw "Build succeeded but executable was not found: $executable"
}

$env:SCROLL2ROLL_ROOT = $repoRoot
if ($Action -eq 'Smoke') {
    New-Item -ItemType Directory -Force -Path $artifacts | Out-Null
    $env:SCROLL2ROLL_35_SMOKE = '1'
    $env:SCROLL2ROLL_35_SCENE = $Scene.ToLowerInvariant()
    $env:SCROLL2ROLL_35_CAPTURE = Join-Path $artifacts ($Scene.ToLowerInvariant() + '-smoke.png')
} else {
    Remove-Item Env:SCROLL2ROLL_35_SMOKE -ErrorAction SilentlyContinue
    Remove-Item Env:SCROLL2ROLL_35_SCENE -ErrorAction SilentlyContinue
    Remove-Item Env:SCROLL2ROLL_35_CAPTURE -ErrorAction SilentlyContinue
}
& $executable
exit $LASTEXITCODE
