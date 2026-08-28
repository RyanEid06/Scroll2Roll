[CmdletBinding()]
param(
    [string]$ProductionPack = (Join-Path $PSScriptRoot '..\HowGamesShouldLookUi\BlackJack\BlackjackProductionPack'),
    [string]$Evidence = (Join-Path $PSScriptRoot '..\out\visual-audit\blackjack-reference-final')
)

$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Drawing

$productionRoot = [System.IO.Path]::GetFullPath($ProductionPack)
$evidenceRoot = [System.IO.Path]::GetFullPath($Evidence)
New-Item -ItemType Directory -Path $evidenceRoot -Force | Out-Null

$states = [ordered]@{
    'betting' = 'blackjack-betting-reference.png'
    'player-turn' = 'blackjack-player-turn-reference.png'
    'split-hands' = 'blackjack-split-hands-reference.png'
    'dealer-turn' = 'blackjack-dealer-turn-reference.png'
    'settled-result' = 'blackjack-settled-result-reference.png'
}

function New-Canvas([int]$Width, [int]$Height) {
    return [System.Drawing.Bitmap]::new($Width, $Height, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
}

function Draw-Fitted([System.Drawing.Graphics]$Graphics, [System.Drawing.Image]$Image, [System.Drawing.Rectangle]$Destination) {
    $Graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $Graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $Graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $Graphics.DrawImage($Image, $Destination)
}

foreach ($state in $states.Keys) {
    $referencePath = Join-Path $productionRoot (Join-Path 'references' $states[$state])
    $capturePath = Join-Path $evidenceRoot ("blackjack-{0}-native-1024x576.png" -f $state)
    if (-not (Test-Path -LiteralPath $referencePath -PathType Leaf)) { throw "Authority reference is missing: $referencePath" }
    if (-not (Test-Path -LiteralPath $capturePath -PathType Leaf)) { throw "Native capture is missing: $capturePath" }

    $reference = [System.Drawing.Image]::FromFile($referencePath)
    $capture = [System.Drawing.Image]::FromFile($capturePath)
    try {
        $scaled = New-Canvas 1280 720
        $scaledGraphics = [System.Drawing.Graphics]::FromImage($scaled)
        try {
            Draw-Fitted $scaledGraphics $capture ([System.Drawing.Rectangle]::new(0, 0, 1280, 720))
        }
        finally {
            $scaledGraphics.Dispose()
        }
        $scaledPath = Join-Path $evidenceRoot ("blackjack-{0}-native-1280x720.png" -f $state)
        $scaled.Save($scaledPath, [System.Drawing.Imaging.ImageFormat]::Png)

        $sideBySide = New-Canvas 2560 720
        $sideGraphics = [System.Drawing.Graphics]::FromImage($sideBySide)
        try {
            Draw-Fitted $sideGraphics $reference ([System.Drawing.Rectangle]::new(0, 0, 1280, 720))
            Draw-Fitted $sideGraphics $scaled ([System.Drawing.Rectangle]::new(1280, 0, 1280, 720))
        }
        finally {
            $sideGraphics.Dispose()
        }
        $sidePath = Join-Path $evidenceRoot ("comparison-{0}-side-by-side.png" -f $state)
        $sideBySide.Save($sidePath, [System.Drawing.Imaging.ImageFormat]::Png)
        $sideBySide.Dispose()

        $overlay = New-Canvas 1280 720
        $overlayGraphics = [System.Drawing.Graphics]::FromImage($overlay)
        $attributes = [System.Drawing.Imaging.ImageAttributes]::new()
        try {
            Draw-Fitted $overlayGraphics $scaled ([System.Drawing.Rectangle]::new(0, 0, 1280, 720))
            $matrix = [System.Drawing.Imaging.ColorMatrix]::new()
            $matrix.Matrix33 = 0.45
            $attributes.SetColorMatrix($matrix)
            $overlayGraphics.DrawImage($reference, [System.Drawing.Rectangle]::new(0, 0, 1280, 720), 0, 0, $reference.Width, $reference.Height, [System.Drawing.GraphicsUnit]::Pixel, $attributes)
        }
        finally {
            $attributes.Dispose()
            $overlayGraphics.Dispose()
        }
        $overlayPath = Join-Path $evidenceRoot ("comparison-{0}-overlay.png" -f $state)
        $overlay.Save($overlayPath, [System.Drawing.Imaging.ImageFormat]::Png)
        $overlay.Dispose()
        $scaled.Dispose()
    }
    finally {
        $capture.Dispose()
        $reference.Dispose()
    }
}

Get-ChildItem -LiteralPath $evidenceRoot -File |
    Where-Object { $_.Name -like 'comparison-*.png' -or $_.Name -like '*-native-1280x720.png' } |
    Sort-Object Name |
    Select-Object Name, Length
