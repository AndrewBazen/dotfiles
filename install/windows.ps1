Write-Host "`n🪟 Running Windows-specific setup..."

# Get the directory where this script is located
$DOTFILES_DIR = Split-Path -Parent $PSScriptRoot
if (-not $DOTFILES_DIR) {
    $DOTFILES_DIR = Split-Path -Parent $MyInvocation.MyCommand.Path
}
Write-Host "Dotfiles directory: $DOTFILES_DIR"

# Ensure winget exists
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Error "Winget is not installed. Please install it from the Microsoft Store."
    exit 1
}

# Install Scoop
if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
    Write-Host "🧙 Installing Scoop..."
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
    Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
} else {
    Write-Host "✅ Scoop already installed."
}

# Install Scoop apps
Write-Host "📦 Installing CLI tools via Scoop..."
scoop bucket add extras
scoop bucket add main
scoop install git gh neovim curl lua starship fzf fd ripgrep gcc lazygit

# Install Node.js via winget
Write-Host "🔧 Installing Node.js 20.x via winget..."
winget install --id OpenJS.NodeJS.LTS -e --source winget

# Install Nerd Font
Write-Host "🔤 Installing JetBrainsMono Nerd Font..."
winget install --id NerdFonts.JetBrainsMono -e --source winget

# set nerd font as default in powershell profile
$fontName = "JetBrainsMono Nerd Font"
$fontPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts"
$fontValue = (Get-ItemProperty -Path $fontPath).$fontName
if ($fontValue) {
    $fontValue = $fontValue -replace '\s+', ' '
    $fontValue = $fontValue.Trim()
    Write-Host "✅ Font '$fontName' found in registry."
} else {
    Write-Error "❌ Font '$fontName' not found in registry. Please install it manually."
}

# Set up PowerShell profile for Starship
Write-Host "🌟 Configuring Starship prompt..."
$profilePath = "$PROFILE"
if (-not (Test-Path -Path $profilePath)) {
    New-Item -ItemType File -Path $profilePath -Force | Out-Null
}
if (-not (Get-Content $profilePath | Select-String "starship init powershell")) {
    Add-Content $profilePath "`nInvoke-Expression (&starship init powershell)"
    Write-Host "✅ Starship added to PowerShell profile."
} else {
    Write-Host "✅ Starship already in PowerShell profile."
}

# Ensure .config directory exists
$configPath = "$HOME\\.config"
if (-not (Test-Path $configPath)) {
    New-Item -ItemType Directory -Path $configPath -Force | Out-Null
}

# Link Starship config
Write-Host "📄 Linking Starship config..."
$starshipConfPath = "$configPath\starship.toml"
$starshipSource = "$DOTFILES_DIR\starship\starship.toml"
if (Test-Path $starshipSource) {
    if (-not (Test-Path $starshipConfPath)) {
        New-Item -ItemType SymbolicLink -Path $starshipConfPath -Target $starshipSource -Force
        Write-Host "✅ Starship config symlinked."
    } else {
        Write-Host "✅ Starship config already exists."
    }
} else {
    Write-Host "⚠️ Starship config source not found at $starshipSource"
}

# Link Neovim config
Write-Host "📝 Linking Neovim config..."
$nvimTarget = "$DOTFILES_DIR\nvim"
$nvimConfigPath = "$HOME\AppData\Local\nvim"
if (Test-Path $nvimTarget) {
    if (-not (Test-Path $nvimConfigPath)) {
        New-Item -ItemType SymbolicLink -Path $nvimConfigPath -Target $nvimTarget -Force
        Write-Host "✅ Neovim config symlinked."
    } else {
        Write-Host "✅ Neovim config already exists."
    }
} else {
    Write-Host "⚠️ Neovim config source not found at $nvimTarget"
}

# Link Git config
Write-Host "🔧 Linking Git config..."
$gitTarget = "$DOTFILES_DIR\git\.gitconfig"
$gitConfPath = "$HOME\.gitconfig"
if (Test-Path $gitTarget) {
    if (-not (Test-Path $gitConfPath)) {
        New-Item -ItemType SymbolicLink -Path $gitConfPath -Target $gitTarget -Force
        Write-Host "✅ Git config symlinked."
    } else {
        Write-Host "✅ Git config already exists."
    }
} else {
    Write-Host "⚠️ Git config source not found at $gitTarget"
}

Write-Host "`n✅ Windows setup complete! Restart your terminal to apply everything."
