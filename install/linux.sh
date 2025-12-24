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
    python3 \
    lua5.3 \
    unzip \
    build-essential \
    ca-certificates \
    npm \
    gnupg \
    lsb-release \
    fzf \
    fd-find \
    ripgrep \
    golang
elif [[ "$DISTRO_TYPE" == "arch" ]]; then
  pacman -S --noconfirm \
    zsh \
    curl \
    gcc \
    git \
    wget \
    tmux \
    python-virtualenv \
    lua \
    unzip \
    base-devel \
    ca-certificates \
    npm \
    gnupg \
    fzf \
    fd \
    ripgrep \
    go
elif [[ "$DISTRO_TYPE" == "fedora" ]]; then
  dnf install -y \
    zsh \
    curl \
    gcc \
    git \
    wget \
    tmux \
    python3 \
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
    ripgrep \
    golang
else
  echo "Unsupported Linux distribution. Skipping package installation."
fi

# run nvim shell script to install latest version of neovim
echo "🔧 Installing Neovim..."
chmod +x ./install/neovim.sh
./install/neovim.sh
if command -v nvim &>/dev/null; then
  echo "Neovim installed successfully."
else
  echo "Neovim installation failed."
fi

echo "🔧 Installing Node.js 20.x..."

if command -v pacman &>/dev/null; then
    echo "Detected Arch Linux."
    pacman -Syu --noconfirm nodejs npm

elif command -v dnf &>/dev/null; then
    echo "Detected Fedora."
    curl -fsSL https://rpm.nodesource.com/setup_20.x | bash -
    dnf install -y nodejs

elif command -v apt &>/dev/null; then
    echo "Detected Debian/Ubuntu."
    curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
    apt install -y nodejs

else
    echo "Unsupported OS detected. Installing Node.js 20.x using NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    nvm install 20
    nvm use 20
fi

echo "✅ Node.js installed successfully:"
node -v


#!/bin/bash

set -e

echo "🔧 Installing GitHub CLI (gh)..."

if command -v pacman &>/dev/null; then
    echo "Detected Arch Linux."
    pacman -Syu --noconfirm github-cli

elif command -v dnf &>/dev/null; then
    echo "Detected Fedora."
    dnf install -y 'dnf-command(config-manager)'
    dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
    dnf install -y gh

elif command -v apt &>/dev/null; then
    echo "Detected Debian/Ubuntu."
    type -p curl >/dev/null || apt install curl -y
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | tee /usr/share/keyrings/githubcli-archive-keyring.gpg >/dev/null
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list >/dev/null
    apt update
    apt install gh -y

else
    echo "Unsupported OS. Attempting fallback installer..."
    curl -fsSL https://cli.github.com/install.sh | bash
fi

echo "✅ GitHub CLI installed:"
gh --version



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

# Setup tmux configuration (handled by bootstrap/link.sh)
echo "📦 Tmux configuration will be set up during dotfile linking..."

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

# Install zsh plugins (run as original user, not root)
echo "🐚 Installing zsh plugins..."
chmod +x ./install/zsh.sh
if [ -n "$SUDO_USER" ]; then
  sudo -u "$SUDO_USER" ./install/zsh.sh
else
  ./install/zsh.sh
fi

# Get the actual user's home directory
if [ -n "$SUDO_USER" ]; then
  USER_HOME=$(getent passwd "$SUDO_USER" | cut -d: -f6)
else
  USER_HOME="$HOME"
fi

# Add Starship to .zshrc if not already added
if ! grep -q 'eval "$(starship init zsh)"' "$USER_HOME/.zshrc" 2>/dev/null; then
  echo 'eval "$(starship init zsh)"' >> "$USER_HOME/.zshrc"
fi

# Set Zsh as default shell if not already (for the actual user)
if [ -n "$SUDO_USER" ]; then
  CURRENT_SHELL=$(getent passwd "$SUDO_USER" | cut -d: -f7)
  if [ "$CURRENT_SHELL" != "$(which zsh)" ]; then
    echo "🐚 Changing default shell to Zsh for $SUDO_USER..."
    chsh -s "$(which zsh)" "$SUDO_USER"
  fi
else
  if [ "$SHELL" != "$(which zsh)" ]; then
    echo "🐚 Changing default shell to Zsh..."
    chsh -s "$(which zsh)"
  fi
fi
