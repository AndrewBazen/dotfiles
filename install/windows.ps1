Write-Host "🪟 Running Windows-specific setup..."

# Check for winget
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host "Winget is not installed. Please install it from the Microsoft Store."
    exit 1
}

# Update existing packages
Write-Host "🔄 Updating installed packages..."
winget upgrade --all

# Install essential packages
Write-Host "📦 Installing base packages..."
winget install --id Git.Git -e --source winget
winget install --id Neovim.Neovim -e --source winget
winget install --id Starship.Starship -e --source winget
winget install --id Lua.Lua -e --source winget
winget install --id curl.curl -e --source winget
winget install --id Microsoft.WindowsTerminal -e --source winget

# Install JetBrains Nerd Font
Write-Host "🔤 Installing JetBrains Nerd Font..."
winget install --id NerdFonts.JetBrainsMono -e --source winget

# Optional: Add Starship init to PowerShell profile
$profilePath = "$HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
if (-not (Test-Path -Path $profilePath)) {
    New-Item -ItemType File -Path $profilePath -Force
}
if (-not (Get-Content $profilePath | Select-String "starship init powershell")) {
    Add-Content $profilePath 'Invoke-Expression (&starship init powershell)'
}

Write-Host "✅ Windows setup complete. Restart your terminal to see changes."
