[CmdletBinding()]
param(
    [ValidateSet('Debug', 'Release')]
    [string]$Configuration = 'Debug',
    [string]$RocketRoot = $env:ROCKET_ROOT,
    [string]$Rocketc = ''
)

$ErrorActionPreference = 'Stop'
$repository = Split-Path $PSScriptRoot -Parent
$duplicateSourceNames = Get-ChildItem -LiteralPath (Join-Path $repository 'src') -Filter '*.rocket' -File -Recurse |
    Group-Object Name |
    Where-Object Count -gt 1
if ($duplicateSourceNames) {
    $details = $duplicateSourceNames | ForEach-Object {
        "$($_.Name): $($_.Group.FullName -join ', ')"
    }
    throw "Rocket debug sources must have unique basenames. Duplicate source names: $($details -join '; ')"
}
& (Join-Path $PSScriptRoot 'build.ps1') -Configuration $Configuration -RocketRoot $RocketRoot -Rocketc $Rocketc
if (-not $Rocketc) { $Rocketc = Join-Path ([System.IO.Path]::GetFullPath($RocketRoot)) 'out\build\windows-release\rocketc.exe' }

& $Rocketc check $repository
if ($LASTEXITCODE -ne 0) { throw 'rocketc check failed.' }
$testFiles = @(Get-ChildItem -LiteralPath (Join-Path $repository 'tests') -Filter '*.rocket' -File | Sort-Object Name)
if ($testFiles.Count -eq 0) { throw 'No Rocket tests were found.' }

# Frozen Rocket 2.0 retains substantial compiler state while one `test`
# invocation compiles many sources. Keep every process bounded and sequential.
# The one legacy generic GUI filename is necessarily a substring of the ten
# game-specific GUI filenames, so those eleven are selected as one small batch;
# every other full filename must select exactly one source.
$guiBatchFilter = 'gui_flow_test.rocket'
$guiBatch = @($testFiles | Where-Object { $_.Name.Contains($guiBatchFilter) })
$individualTests = @($testFiles | Where-Object { -not $_.Name.Contains($guiBatchFilter) })
foreach ($testFile in $individualTests) {
    $selected = @($testFiles | Where-Object { $_.Name.Contains($testFile.Name) })
    if ($selected.Count -ne 1) { throw "Test filter is not unique: $($testFile.Name)" }
    Write-Output "Running Rocket test: $($testFile.Name)"
    & $Rocketc test $repository --filter $testFile.Name
    if ($LASTEXITCODE -ne 0) { throw "rocketc test failed: $($testFile.Name)" }
}
if ($guiBatch.Count -gt 0) {
    Write-Output "Running Rocket GUI test batch: $($guiBatch.Count) files"
    & $Rocketc test $repository --filter $guiBatchFilter
    if ($LASTEXITCODE -ne 0) { throw 'rocketc GUI test batch failed.' }
}
Write-Output "Rocket test files passed: $($testFiles.Count)"
$formatRoots = @((Join-Path $repository 'src'), (Join-Path $repository 'tests'))
foreach ($root in $formatRoots) {
    $sourceFiles = Get-ChildItem -LiteralPath $root -Filter '*.rocket' -File -Recurse | Sort-Object FullName
    foreach ($sourceFile in $sourceFiles) {
        & $Rocketc fmt $sourceFile.FullName --check
        if ($LASTEXITCODE -ne 0) { throw "rocketc fmt --check failed: $($sourceFile.FullName)" }
    }
}

Write-Output "Scroll2Roll $Configuration validation completed."
