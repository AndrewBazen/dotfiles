#!/bin/bash

set -e

echo "🍎 Running macOS-specific setup..."

# Check for Homebrew and install if missing
if ! command -v brew &>/dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Update & upgrade
echo "🔄 Updating Homebrew..."
brew update
brew upgrade

# Install essential packages
echo "📦 Installing base packages..."
brew install neovim zsh lua lazygit git curl starship wget unzip fzf fd ripgrep node gh tmux

# Install JetBrains Nerd Font
echo "🔤 Installing JetBrains Nerd Font..."
brew install --cask font-jetbrains-mono-nerd-font

# Run Neovim install script for consistency
echo "🔧 Verifying Neovim installation..."
if ! command -v nvim &>/dev/null; then
    echo "Neovim installation failed."
    exit 1
fi
echo "Neovim: $(nvim --version | head -n 1)"

# Install zsh plugins
echo "🐚 Installing zsh plugins..."
chmod +x ./install/zsh.sh
./install/zsh.sh

# Add Starship to .zshrc if not already added
if ! grep -q 'eval "$(starship init zsh)"' ~/.zshrc 2>/dev/null; then
    echo 'eval "$(starship init zsh)"' >> ~/.zshrc
fi

# Set Zsh as default shell if not already
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "🐚 Changing default shell to Zsh..."
    chsh -s "$(which zsh)"
fi
