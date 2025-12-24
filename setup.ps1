# PowerShell setup script for Windows
# Run this script directly from PowerShell (preferably as Administrator for symlinks)
#
# Usage:
#   Set-ExecutionPolicy Bypass -Scope Process -Force
#   .\setup.ps1

Write-Host "`n🚀 Dotfiles Setup for Windows" -ForegroundColor Cyan
Write-Host "==============================`n"

# Check if running as Administrator (recommended for creating symlinks)
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "⚠️  Not running as Administrator. Some symlinks may fail." -ForegroundColor Yellow
    Write-Host "   Consider running PowerShell as Administrator.`n" -ForegroundColor Yellow
}

# Run the install script
$installScript = Join-Path $PSScriptRoot "install\windows.ps1"
if (Test-Path $installScript) {
    & $installScript
} else {
    Write-Error "Could not find install script at: $installScript"
    exit 1
}

Write-Host "`n✅ Setup complete! Restart your terminal for all changes to apply." -ForegroundColor Green

