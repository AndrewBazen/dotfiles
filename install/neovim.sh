#!/bin/bash

set -e

echo "🔧 Installing Neovim..."

if command -v pacman &>/dev/null; then
    echo "Detected Arch Linux."
    sudo pacman -Syu --noconfirm neovim

elif command -v dnf &>/dev/null; then
    echo "Detected Fedora."
    sudo dnf install -y neovim

elif command -v apt &>/dev/null; then
    echo "Detected Debian/Ubuntu."

    # Remove old neovim if installed via apt
    if dpkg -l | grep -q "^ii.*neovim"; then
        echo "Removing old Neovim from apt..."
        sudo apt remove --purge -y neovim
        sudo apt autoremove -y
    fi

    # Install via snap for latest version
    echo "Installing Neovim via snap (latest stable)..."
    if ! command -v snap &>/dev/null; then
        echo "Installing snapd..."
        sudo apt update
        sudo apt install -y snapd
    fi

    sudo snap install nvim --classic
    
    # Ensure snap bin is in PATH
    if [[ ":$PATH:" != *":/snap/bin:"* ]]; then
        export PATH="$PATH:/snap/bin"
    fi

else
    echo "Unsupported OS or package manager."
    exit 1
fi

echo "✅ Neovim installed successfully:"
nvim --version | head -n 1