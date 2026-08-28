param(
    [string]$Source = (Join-Path $PSScriptRoot '..\HowGamesShouldLookUi\BlackJack\BlackjackProductionPack'),
    [string]$Destination = (Join-Path $PSScriptRoot '..\assets\games\blackjack-reference-v1')
)

$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Drawing

$sourceRoot = [System.IO.Path]::GetFullPath($Source)
$destinationRoot = [System.IO.Path]::GetFullPath($Destination)

if (-not (Test-Path -LiteralPath $sourceRoot -PathType Container)) {
    throw "Blackjack production pack was not found at $sourceRoot"
}

[System.IO.Directory]::CreateDirectory($destinationRoot) | Out-Null

Copy-Item -LiteralPath (Join-Path $sourceRoot 'blackjack-permanent-scene-1280x720.png') -Destination (Join-Path $destinationRoot 'blackjack-permanent-scene-1280x720.png') -Force
Copy-Item -LiteralPath (Join-Path $sourceRoot 'fonts\Inter-SemiBold.otf') -Destination (Join-Path $destinationRoot 'Inter-SemiBold.otf') -Force
Copy-Item -LiteralPath (Join-Path $sourceRoot 'fonts\EBGaramond12-Regular.ttf') -Destination (Join-Path $destinationRoot 'EBGaramond12-Regular.ttf') -Force
Copy-Item -LiteralPath (Join-Path $sourceRoot 'fonts\fonts-inter-LICENSE.txt') -Destination (Join-Path $destinationRoot 'fonts-inter-LICENSE.txt') -Force
Copy-Item -LiteralPath (Join-Path $sourceRoot 'fonts\fonts-ebgaramond-extra-LICENSE.txt') -Destination (Join-Path $destinationRoot 'fonts-ebgaramond-extra-LICENSE.txt') -Force

function New-Atlas {
    param(
        [string[]]$Files,
        [int]$Columns,
        [int]$Rows,
        [int]$CellWidth,
        [int]$CellHeight,
        [string]$Output,
        [switch]$ScaleToCell
    )

    $bitmap = [System.Drawing.Bitmap]::new($Columns * $CellWidth, $Rows * $CellHeight, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
    $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
    try {
        $graphics.Clear([System.Drawing.Color]::Transparent)
        $graphics.CompositingMode = [System.Drawing.Drawing2D.CompositingMode]::SourceCopy
        $graphics.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
        $graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
        $graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality

        for ($index = 0; $index -lt $Files.Count; $index++) {
            $image = [System.Drawing.Image]::FromFile($Files[$index])
            try {
                $column = $index % $Columns
                $row = [Math]::Floor($index / $Columns)
                $x = $column * $CellWidth
                $y = $row * $CellHeight
                if ($ScaleToCell) {
                    $graphics.DrawImage($image, $x, $y, $CellWidth, $CellHeight)
                }
                else {
                    if ($image.Width -ne $CellWidth -or $image.Height -ne $CellHeight) {
                        throw "Unexpected atlas source dimensions for $($Files[$index]): $($image.Width)x$($image.Height)"
                    }
                    $graphics.DrawImageUnscaled($image, $x, $y)
                }
            }
            finally {
                $image.Dispose()
            }
        }

        $bitmap.Save($Output, [System.Drawing.Imaging.ImageFormat]::Png)
    }
    finally {
        $graphics.Dispose()
        $bitmap.Dispose()
    }
}

$suits = @('spades', 'hearts', 'diamonds', 'clubs')
$ranks = @('a', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'j', 'q', 'k')
$cardFiles = foreach ($suit in $suits) {
    foreach ($rank in $ranks) {
        Join-Path $sourceRoot "cards\$rank-$suit.png"
    }
}
$cardFiles += Join-Path $sourceRoot 'cards\card-back.png'
New-Atlas -Files $cardFiles -Columns 13 -Rows 5 -CellWidth 116 -CellHeight 168 -Output (Join-Path $destinationRoot 'blackjack-cards-atlas.png')

$chipFiles = @()
foreach ($selected in @($false, $true)) {
    foreach ($value in @(10, 25, 50, 100, 250, 500)) {
        $suffix = if ($selected) { '-selected' } else { '' }
        $chipFiles += Join-Path $sourceRoot "chips\chip-$value$suffix.png"
    }
}
New-Atlas -Files $chipFiles -Columns 6 -Rows 2 -CellWidth 160 -CellHeight 160 -Output (Join-Path $destinationRoot 'blackjack-chips-atlas.png')

$componentFiles = @(
    'components\phase-status-pill.png',
    'components\seat-tab-inactive.png',
    'components\seat-tab-active.png',
    'components\seat-tab-dealer.png',
    'objects\Scroll2Roll-full-logo.png',
    'components\primary-purple-button-normal.png',
    'components\primary-purple-button-hover.png',
    'components\primary-purple-button-keyboard-focus.png',
    'components\primary-purple-button-disabled.png',
    'components\standard-button-normal.png',
    'components\standard-button-hover.png',
    'components\standard-button-keyboard-focus.png',
    'components\standard-button-disabled.png',
    'components\action-hit.png',
    'components\action-stand.png',
    'components\action-double.png',
    'components\action-split.png',
    'components\action-surrender.png',
    'objects\Scroll2Roll-compact-SR-logo.png'
) | ForEach-Object { Join-Path $sourceRoot $_ }
New-Atlas -Files $componentFiles -Columns 5 -Rows 4 -CellWidth 480 -CellHeight 96 -Output (Join-Path $destinationRoot 'blackjack-components-atlas.png') -ScaleToCell

$iconFiles = @(
    'icons\credits-coin-icon.png',
    'icons\light-icon.png',
    'icons\help-icon.png',
    'icons\settings-icon.png',
    'icons\blackjack-navigation-icon.png',
    'icons\all-games-navigation-icon.png',
    'icons\information-icon.png',
    'icons\table-limits-icon.png',
    'icons\deal-icon.png',
    'icons\bet-amount-icon.png',
    'icons\current-bet-icon.png',
    'icons\hit-icon.png',
    'icons\stand-icon.png',
    'icons\double-down-icon.png',
    'icons\split-icon.png',
    'icons\surrender-icon.png'
) | ForEach-Object { Join-Path $sourceRoot $_ }
New-Atlas -Files $iconFiles -Columns 8 -Rows 2 -CellWidth 72 -CellHeight 72 -Output (Join-Path $destinationRoot 'blackjack-icons-atlas.png')

Get-ChildItem -LiteralPath $destinationRoot -File | Sort-Object Name | ForEach-Object {
    $hash = Get-FileHash -LiteralPath $_.FullName -Algorithm SHA256
    '{0}  {1}' -f $hash.Hash, $_.Name
}
