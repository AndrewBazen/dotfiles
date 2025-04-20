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
$packages = @(
    "Git.Git",
    "Neovim.Neovim",
    "Starship.Starship",
    "Lua.Lua",
    "curl.curl",
    "Microsoft.WindowsTerminal",
    "Microsoft.VisualStudioCode",
    "GitHub.cli",
    "npm.npm",
    "Microsoft.PowerShell",
    "tmux.tmux",
    "Ripgrep.ripgrep",
    "BurntSushi.ripgrep",
    "fd-find.fd",
    "Fzf.Fzf",
    "LazyGit.LazyGit"
)

foreach ($package in $packages) {
    Write-Host "Installing $package..."
    winget install --id $package -e --source winget
}

# Install JetBrains Nerd Font
Write-Host "🔤 Installing JetBrains Nerd Font..."
winget install --id NerdFonts.JetBrainsMono -e --source winget

# Install Node.js 20.x
Write-Host "🔧 Installing Node.js 20.x..."
winget install --id OpenJS.NodeJS.LTS -e --source winget

# Add Starship init to PowerShell profile
Write-Host "🌟 Configuring Starship prompt..."
$profilePath = "$HOME\Program Files\PowerShell\Microsoft.PowerShell_profile.ps1"
if (-not (Test-Path -Path $profilePath)) {
    New-Item -ItemType File -Path $profilePath -Force
}
if (-not (Get-Content $profilePath | Select-String "starship init powershell")) {
    Add-Content $profilePath 'Invoke-Expression (&starship init powershell)'
}

# linking starship.toml
Write-Host "📄 Linking Starship configuration..."
$starshipConfPath = "$HOME\.config\starship.toml"
if (-not (Test-Path $starshipConfPath)) {
    New-Item -ItemType SymbolicLink -Path $starshipConfPath -Target "$HOME\dotfiles\starship\starship.toml"
    Write-Host "Starship configuration symlink created successfully."
} else {
    Write-Host "Starship configuration symlink already exists."
}


# Configure Tmux
Write-Host "📦 Setting up Tmux configuration..."
$tmuxConfPath = "$HOME\.tmux.conf"
if (-not (Test-Path $tmuxConfPath)) {
    New-Item -ItemType SymbolicLink -Path $tmuxConfPath -Target "$HOME\dotfiles\tmux\.tmux.conf"
    Write-Host "Tmux configuration symlink created successfully."
} else {
    Write-Host "Tmux configuration symlink already exists."
}

Write-Host "✅ Windows setup complete. Restart your terminal to see changes."
