# ---------------------------
# Windows Setup Script
# ---------------------------

$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Host "✖ This script requires administrator privileges. Please run as Administrator." -ForegroundColor Red
    Read-Host "Press ENTER to exit"
    exit
}

Write-Host "▶ Starting Windows setup..." -ForegroundColor Green

# ---------------------------
# 1. WINDOWS SYSTEM CONFIGURATION
# ---------------------------
Write-Host "▶ Configuring Windows system settings..." -ForegroundColor Green

# Dark Mode Configuration
Write-Host "→ Enabling dark mode..." -ForegroundColor Cyan
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Value 0 -Type DWord -Force
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Value 0 -Type DWord -Force

# File Explorer Settings
Write-Host "→ Configuring File Explorer..." -ForegroundColor Cyan

# Show hidden files and folders
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -Value 1 -Type DWord -Force

# Show file extensions
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value 0 -Type DWord -Force

# Show full path in title bar
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CamelCase" -Name "ShellState" -Value 1 -Type DWord -Force -ErrorAction SilentlyContinue

# Open File Explorer to This PC instead of Quick Access
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo" -Value 1 -Type DWord -Force

# Show protected operating system files (optional, commented out for safety)
# Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSuperHidden" -Value 1 -Type DWord -Force

# Taskbar Settings
Write-Host "→ Configuring Taskbar..." -ForegroundColor Cyan

# Show all system tray icons
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "EnableAutoTray" -Value 0 -Type DWord -Force

# Disable taskbar search box
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Value 0 -Type DWord -Force

# Disable Task View button
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Value 0 -Type DWord -Force

# Disable News and Interests (Widgets)
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Feeds" -Name "ShellFeedsTaskbarViewMode" -Value 2 -Type DWord -Force -ErrorAction SilentlyContinue

# Privacy Settings
Write-Host "→ Configuring Privacy settings..." -ForegroundColor Cyan

# Disable Activity History
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableActivityFeed" -Value 0 -Type DWord -Force -ErrorAction SilentlyContinue
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "PublishUserActivities" -Value 0 -Type DWord -Force -ErrorAction SilentlyContinue

# Disable Location Tracking
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Name "Value" -Value "Deny" -Type String -Force -ErrorAction SilentlyContinue

# Disable Telemetry
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Value 0 -Type DWord -Force -ErrorAction SilentlyContinue

# Performance Settings
Write-Host "→ Configuring Performance settings..." -ForegroundColor Cyan

# Disable Transparency Effects
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "EnableTransparency" -Value 0 -Type DWord -Force

# Disable Animations (optional - uncomment if you want better performance)
# Set-ItemProperty -Path "HKCU:\Control Panel\Desktop\WindowMetrics" -Name "MinAnimate" -Value 0 -Type String -Force

# Developer Settings
Write-Host "→ Configuring Developer settings..." -ForegroundColor Cyan

# Enable Developer Mode
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" -Name "AllowDevelopmentWithoutDevLicense" -Value 1 -Type DWord -Force -ErrorAction SilentlyContinue

# Enable Long Paths
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" -Name "LongPathsEnabled" -Value 1 -Type DWord -Force -ErrorAction SilentlyContinue

# Power Settings
Write-Host "→ Configuring Power settings..." -ForegroundColor Cyan

# Set power plan to High Performance
powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c

# Configure display timeout
# On battery: 10 minutes
powercfg /change monitor-timeout-dc 10
# Plugged in: 15 minutes
powercfg /change monitor-timeout-ac 15

# Configure sleep timeout
# On battery: 15 minutes
powercfg /change standby-timeout-dc 15
# Plugged in: 30 minutes
powercfg /change standby-timeout-ac 30

# Set power button action to "Do nothing" (0 = Do nothing)
powercfg /setacvalueindex SCHEME_CURRENT 4f971e89-eebd-4455-a8de-9e59040e7347 7648efa3-dd9c-4e3e-b566-50f929386280 0
powercfg /setdcvalueindex SCHEME_CURRENT 4f971e89-eebd-4455-a8de-9e59040e7347 7648efa3-dd9c-4e3e-b566-50f929386280 0

# Set sleep button action to "Do nothing" (0 = Do nothing)
powercfg /setacvalueindex SCHEME_CURRENT 4f971e89-eebd-4455-a8de-9e59040e7347 96996bc0-ad50-47ec-923b-6f41874dd9eb 0
powercfg /setdcvalueindex SCHEME_CURRENT 4f971e89-eebd-4455-a8de-9e59040e7347 96996bc0-ad50-47ec-923b-6f41874dd9eb 0

# Set lid close action to "Do nothing" (0 = Do nothing)
powercfg /setacvalueindex SCHEME_CURRENT 4f971e89-eebd-4455-a8de-9e59040e7347 5ca83367-6e45-459f-a27b-476b1d01c936 0
powercfg /setdcvalueindex SCHEME_CURRENT 4f971e89-eebd-4455-a8de-9e59040e7347 5ca83367-6e45-459f-a27b-476b1d01c936 0

# Apply the settings
powercfg /setactive SCHEME_CURRENT

# Disable hibernation (frees up disk space)
powercfg /hibernate off

# Windows Update Settings
Write-Host "→ Configuring Windows Update..." -ForegroundColor Cyan

# Disable automatic restart after updates
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "NoAutoRebootWithLoggedOnUsers" -Value 1 -Type DWord -Force -ErrorAction SilentlyContinue
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "AUOptions" -Value 3 -Type DWord -Force -ErrorAction SilentlyContinue

# Keyboard Settings
Write-Host "→ Configuring Keyboard settings..." -ForegroundColor Cyan

# Set keyboard repeat rate to fastest
Set-ItemProperty -Path "HKCU:\Control Panel\Keyboard" -Name "KeyboardDelay" -Value 0 -Type String -Force
Set-ItemProperty -Path "HKCU:\Control Panel\Keyboard" -Name "KeyboardSpeed" -Value 31 -Type String -Force

# Startup and Boot Settings
Write-Host "→ Configuring Startup settings..." -ForegroundColor Cyan

# Disable startup delay for user apps
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize" -Name "StartupDelayInMSec" -Value 0 -Type DWord -Force -ErrorAction SilentlyContinue

# Windows Bloatware & Suggestions
Write-Host "→ Disabling Windows bloatware and suggestions..." -ForegroundColor Cyan

# Disable app suggestions in Start Menu
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SystemPaneSuggestionsEnabled" -Value 0 -Type DWord -Force

# Disable suggestions in Settings
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338393Enabled" -Value 0 -Type DWord -Force
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353694Enabled" -Value 0 -Type DWord -Force
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353696Enabled" -Value 0 -Type DWord -Force

# Disable tips and suggestions
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SoftLandingEnabled" -Value 0 -Type DWord -Force

# Cortana Settings
Write-Host "→ Disabling Cortana..." -ForegroundColor Cyan

# Disable Cortana
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "AllowCortana" -Value 0 -Type DWord -Force -ErrorAction SilentlyContinue

# Disable Windows Error Reporting
Write-Host "→ Disabling Windows Error Reporting..." -ForegroundColor Cyan
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting" -Name "Disabled" -Value 1 -Type DWord -Force -ErrorAction SilentlyContinue

# Windows Defender Settings (Optional - only if you use third-party antivirus)
# Write-Host "→ Configuring Windows Defender..." -ForegroundColor Cyan
# Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "DisableAntiSpyware" -Value 1 -Type DWord -Force -ErrorAction SilentlyContinue

Write-Host "✓ System configuration complete!" -ForegroundColor Green
Write-Host "▶ Restarting Explorer to apply changes..." -ForegroundColor Green
Stop-Process -Name explorer -Force
Start-Sleep -Seconds 2

# ---------------------------
# 2. WSL SETUP
# ---------------------------
Write-Host "▶ Checking WSL installation..." -ForegroundColor Green
$wslInstalled = Get-Command wsl -ErrorAction SilentlyContinue

if (-not $wslInstalled) {
    $shouldInstallWSL = Read-Host "WSL is not installed. Do you want to install it? (Y/N)"
    if ($shouldInstallWSL -eq 'Y' -or $shouldInstallWSL -eq 'y') {
        Write-Host "→ Enabling WSL and Virtual Machine Platform features..." -ForegroundColor Cyan

        dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
        dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

        Write-Host "→ Installing WSL..." -ForegroundColor Cyan
        wsl --install -d Ubuntu

        Write-Host "✓ WSL has been installed." -ForegroundColor Green
    }
} else {
    Write-Host "✓ WSL is already installed." -ForegroundColor Green

    $installUbuntu = Read-Host "Do you want to install/update the latest Ubuntu distribution? (Y/N)"
    if ($installUbuntu -eq 'Y' -or $installUbuntu -eq 'y') {
        Write-Host "→ Installing latest Ubuntu..." -ForegroundColor Cyan
        wsl --install -d Ubuntu
        Write-Host "✓ Latest Ubuntu has been installed." -ForegroundColor Green
    }
}


# ---------------------------
# 3. INSTALL APPS
# ---------------------------
$apps = @(
    "7zip.7zip",
    "Discord.Discord",
    "Google.Antigravity",
    "Google.Chrome",
    "Mozilla.Firefox",
    "Microsoft.Teams",
    "Microsoft.VisualStudioCode",
    "Mirantis.Lens",
    "MuhammedKalkan.OpenLens",
    "SlackTechnologies.Slack",
    "TablePlus.TablePlus",
    "VideoLAN.VLC",
    "Warp.Warp"
)

Write-Host "Select apps to install:" -ForegroundColor Yellow
for ($i = 0; $i -lt $apps.Count; $i++) {
    Write-Host " [$($i+1)] $($apps[$i])" -ForegroundColor Gray
}

$selection = Read-Host "Enter numbers separated by commas (e.g., 1,3,5) or 'A' for all, leave empty to skip"
Write-Host ""

$selectedApps = @()

if ($selection -match "^[Aa]") {
    $selectedApps = $apps
} else {
    $selectedNumbers = $selection -split "," | ForEach-Object { $_.Trim() } | Where-Object { $_ -match '^\d+$' }
    foreach ($num in $selectedNumbers) {
        $index = [int]$num - 1
        if ($index -ge 0 -and $index -lt $apps.Count) {
            $selectedApps += $apps[$index]
        }
    }
}

if (-not $selectedApps) {
    Write-Host "… No apps selected. Skipping app installation." -ForegroundColor Yellow
} else {
    foreach ($app in $selectedApps) {
        Write-Host "⭳ Installing $app..." -ForegroundColor Cyan
        winget install --id $app -e --source winget --accept-package-agreements --accept-source-agreements
    }
}

# ---------------------------
# 4. RESTART
# ---------------------------
Write-Host "✔ Windows setup complete!" -ForegroundColor Green
Write-Host "Some changes may require a system restart to take full effect." -ForegroundColor Yellow

$restart = Read-Host "Do you want to restart now? (Y/N)"
if ($restart -eq 'Y' -or $restart -eq 'y') {
    Restart-Computer
}
