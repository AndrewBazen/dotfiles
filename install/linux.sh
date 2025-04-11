#!/bin/bash

set -e

echo "🐧 Running Linux-specific setup..."

# Update & upgrade
echo "🔄 Updating system..."
sudo apt update && sudo apt upgrade -y

# Install essential packages
echo "📦 Installing base packages..."
sudo apt install -y \
    zsh \
    curl \
    git \
    wget \
    neovim \
    lua5.4 \
    unzip \
    build-essential \
    ca-certificates \
    gnupg \
    lsb-release \
    fzf \
    ripgrep \
    treesitter \

# Install JetBrains Nerd Font
echo "🔤 Installing JetBrains Nerd Font..."
FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"
wget -O "$FONT_DIR/JetBrainsMonoNerdFont-Regular.ttf" https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip
unzip -o "$FONT_DIR/JetBrainsMonoNerdFont-Regular.ttf" -d "$FONT_DIR"
fc-cache -fv

# Install Starship prompt
echo "🌟 Installing Starship..."
curl -sS https://starship.rs/install.sh | sh -s -- -y

# Add Starship to .zshrc if not already added
if ! grep -q 'eval "$(starship init zsh)"' ~/.zshrc 2>/dev/null; then
    echo 'eval "$(starship init zsh)"' >> ~/.zshrc
fi

# Set Zsh as default shell if not already
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "🐚 Changing default shell to Zsh..."
    chsh -s $(which zsh)
fi
