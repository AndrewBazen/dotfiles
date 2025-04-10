#!/bin/bash

# Exit immediately if a command fails
set -e

echo "🚀 Starting system setup..."

# Update & upgrade
echo "🔄 Updating system..."
sudo apt update && sudo apt upgrade -y

# Install basic packages
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
    lsb-release

# Install Starship prompt
echo "🌟 Installing Starship..."
curl -sS https://starship.rs/install.sh | sh -s -- -y

# Add Starship to .zshrc
echo 'eval "$(starship init zsh)"' >> ~/.zshrc

# Set Zsh as default shell
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "🐚 Changing default shell to Zsh..."
    chsh -s $(which zsh)
fi

# Clone your dotfiles repo if you have one (optional)
# echo "📁 Cloning dotfiles..."
# git clone https://github.com/yourusername/dotfiles.git ~/dotfiles

# Source your configs if needed
# source ~/dotfiles/zshrc

echo "✅ Setup complete. You might want to reboot or start a new terminal session."

