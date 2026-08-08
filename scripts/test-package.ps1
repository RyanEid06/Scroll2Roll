[CmdletBinding()]
param([string]$Archive = '')

$ErrorActionPreference = 'Stop'
$repository = Split-Path $PSScriptRoot -Parent
if (-not $Archive) { $Archive = Join-Path $repository 'out\package\Scroll2Roll-0.2.0-windows-x64.zip' }
$Archive = [System.IO.Path]::GetFullPath($Archive)
if (-not (Test-Path -LiteralPath $Archive)) { throw "Package archive not found: $Archive" }

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

$executable = Join-Path $relocationRoot 'Scroll2Roll.exe'
& $executable --headless-smoke
if ($LASTEXITCODE -ne 0) { throw "Relocated headless smoke failed with exit $LASTEXITCODE" }

Write-Output "Relocated package smoke passed: $relocationRoot"
