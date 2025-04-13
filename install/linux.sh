#!/bin/bash

set -e

echo "🐧 Running Linux-specific setup..."

# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root or use sudo."
  exit 1
fi

# Check distribution and add to environment variable
if grep -q "Ubuntu" /etc/os-release; then
  DISTRO_TYPE="ubuntu"
elif grep -q "Arch" /etc/os-release; then
  DISTRO_TYPE="arch"
elif grep -q "Fedora" /etc/os-release; then
  DISTRO_TYPE="fedora"
elif grep -q "Debian" /etc/os-release; then
  DISTRO_TYPE="debian"
else
  echo "Unsupported Linux distribution."
  exit 1
fi
echo "Detected Linux distribution: $DISTRO_TYPE"

# Update & upgrade based on distribution
echo "🔄 Updating system..."
if [[ "$DISTRO_TYPE" == "ubuntu" || "$DISTRO_TYPE" == "debian" ]]; then
  apt update && apt upgrade -y
elif [[ "$DISTRO_TYPE" == "arch" ]]; then
  pacman -Syu --noconfirm
elif [[ "$DISTRO_TYPE" == "fedora" ]]; then
  dnf upgrade --refresh -y
else
  echo "Unsupported Linux distribution. Skipping system update."
fi

# Install essential packages depending on the distribution
echo "📦 Installing base packages..."
if [[ "$DISTRO_TYPE" == "ubuntu" || "$DISTRO_TYPE" == "debian" ]]; then
  apt install -y \
    zsh \
    curl \
    gcc \
    git \
    wget \
    tmux \
    neovim \
    lua5.3 \
    unzip \
    build-essential \
    ca-certificates \
    npm \
    gnupg \
    lsb-release \
    fzf \
    fd-find \
    ripgrep
elif [[ "$DISTRO_TYPE" == "arch" ]]; then
  pacman -S --noconfirm \
    zsh \
    curl \
    gcc \
    git \
    wget \
    tmux \
    neovim \
    lua \
    unzip \
    base-devel \
    ca-certificates \
    npm \
    gnupg \
    fzf \
    fd \
    ripgrep
elif [[ "$DISTRO_TYPE" == "fedora" ]]; then
  dnf install -y \
    zsh \
    curl \
    gcc \
    git \
    wget \
    tmux \
    neovim \
    lua \
    unzip \
    make \
    automake \
    autoconf \
    gcc-c++ \
    ca-certificates \
    npm \
    gnupg2 \
    lsb-release \
    fzf \
    fd-find \
    ripgrep
else
  echo "Unsupported Linux distribution. Skipping package installation."
fi

# Install JetBrains Nerd Font
echo "🔤 Installing JetBrains Nerd Font..."
FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"
if ! fc-list | grep -i "JetBrains Mono" >/dev/null; then
  wget -O "$FONT_DIR/JetBrainsMono.zip" https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip
  unzip -o "$FONT_DIR/JetBrainsMono.zip" -d "$FONT_DIR"
  rm "$FONT_DIR/JetBrainsMono.zip"
  fc-cache -fv
else
  echo "Font already installed."
fi

# Install Starship prompt
echo "🌟 Installing Starship..."
curl -sS https://starship.rs/install.sh | sh -s -- -y
if command -v starship &>/dev/null; then
  echo "Starship installed successfully."
else
  echo "Starship installation failed."
fi

# setup tmux configuration
echo "📦 Setting up tmux configuration..."
if ln -s "$HOME/dotfiles/tmux/.tmux.conf" ~/.tmux.conf; then
  echo "Tmux configuration symlink created successfully."
else
  echo "Tmux configuration symlink already exists or failed to create."
fi

# Install LazyGit
echo "📦 Installing LazyGit..."
if [[ "$DISTRO_TYPE" == "ubuntu" || "$DISTRO_TYPE" == "debian" ]]; then
  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": *"v\K[^"]*')
  curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
  tar xf lazygit.tar.gz lazygit
  install lazygit -D -t /usr/local/bin/
  rm lazygit.tar.gz lazygit
elif [[ "$DISTRO_TYPE" == "arch" ]]; then
  pacman -S lazygit --noconfirm
elif [[ "$DISTRO_TYPE" == "fedora" ]]; then
  dnf copr enable atim/lazygit -y
  dnf install lazygit -y
else
  echo "Unsupported Linux distribution. Skipping LazyGit installation."
fi
if command -v lazygit &>/dev/null; then
  echo "LazyGit installed successfully."
else
  echo "LazyGit installation failed."
fi

# Install C compiler for Tree-sitter
echo "📦 Installing C compiler for Tree-sitter..."
if [[ "$DISTRO_TYPE" == "ubuntu" || "$DISTRO_TYPE" == "debian" ]]; then
  apt install clang gcc -y
elif [[ "$DISTRO_TYPE" == "arch" ]]; then
  pacman -S clang gcc --noconfirm
elif [[ "$DISTRO_TYPE" == "fedora" ]]; then
  dnf install clang gcc -y
else
  echo "Unsupported Linux distribution. Skipping C compiler installation."
fi
if command -v clang &>/dev/null; then
  echo "clang installed successfully."
else
  echo "clang installation failed."
fi
if command -v gcc &>/dev/null; then
  echo "gcc installed successfully."
else
  echo "gcc installation failed."
fi

# Add Starship to .zshrc if not already added
if ! grep -q "eval '$(starship init zsh)'" ~/.zshrc 2>/dev/null; then
  echo "eval '$(starship init zsh)'" >>~/.zshrc
fi

# Set Zsh as default shell if not already
if [ "$SHELL" != "$(which zsh)" ]; then
  echo "🐚 Changing default shell to Zsh..."
  chsh -s "$(which zsh)"
fi
