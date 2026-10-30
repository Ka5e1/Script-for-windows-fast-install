# ============================================================
# 1. Ask to open GitHub pages for manual download
# ============================================================
do {
    $answer = Read-Host "`nOpen the GitHub pages for manual download (NVIDIA App, zapret, TgWsProxy)? Press Y to continue, N to skip"
    $answer = $answer.Trim().ToUpper()
} while ($answer -ne 'Y' -and $answer -ne 'N')

if ($answer -eq 'Y') {
    $manualUrls = @(
        "https://www.nvidia.com/en-us/software/nvidia-app/",
        "https://github.com/Flowseal/zapret-discord-youtube/releases",
        "https://github.com/Flowseal/tg-ws-proxy/releases"
    )

    foreach ($url in $manualUrls) {
        Start-Process $url
        Start-Sleep -Seconds 1
    }

    Write-Host "`nGitHub pages opened." -ForegroundColor Green
} else {
    Write-Host "`nGitHub pages skipped." -ForegroundColor DarkYellow
}

# ============================================================
# 2. Ask before starting winget installation
# ============================================================
do {
    $answer = Read-Host "`nReady to start winget installation? Press Y to start, N to cancel"
    $answer = $answer.Trim().ToUpper()
    if ($answer -eq 'N') {
        Write-Host "Installation cancelled. Script exited." -ForegroundColor Red
        exit
    }
} while ($answer -ne 'Y')

# ============================================================
# 3. Install via winget
# ============================================================
Write-Host "`nStarting winget installation..." -ForegroundColor Cyan

$wingetApps = @(
    "FlipperDevicesInc.qFlipper",
    "Bambulab.Bambustudio",
    "BlenderFoundation.Blender",
    "qBittorrent.qBittorrent",
    "Valve.Steam",
    "Opera.OperaGX",
    "SteelSeries.GG",
    "RARLab.WinRAR",
    "Happ.Happ",
    "Discord.Discord",
    "Telegram.TelegramDesktop"
)

foreach ($app in $wingetApps) {
    Write-Host "Installing: $app ..." -ForegroundColor Cyan
    winget install --id $app -e --accept-package-agreements --accept-source-agreements --source winget
    if ($LASTEXITCODE -ne 0) {
        Write-Warning "Failed to install $app"
    }
}

Write-Host "`nAutomatic installation complete." -ForegroundColor Green
