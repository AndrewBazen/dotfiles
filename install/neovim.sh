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

    if command -v nvim &>/dev/null; then
        echo "Removing old Neovim..."
        sudo apt remove --purge -y neovim
        sudo apt autoremove -y
    fi

    cd /tmp

    echo "Downloading latest Neovim AppImage..."
    if ! wget https://github.com/neovim/neovim/releases/latest/download/nvim.appimage; then
        echo "❗ Latest AppImage not available. Falling back to v0.10.0..."
        wget https://github.com/neovim/neovim/releases/download/v0.10.0/nvim.appimage
    fi

    chmod +x nvim.appimage
    sudo mv nvim.appimage /usr/local/bin/nvim

else
    echo "Unsupported OS or package manager."
    exit 1
fi

echo "✅ Neovim installed successfully:"