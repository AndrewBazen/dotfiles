#!/bin/bash

set -e

echo "Detecting shell environment..."

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export DOTFILES_DIR

# Detect OS
OS="$(uname -s)"
echo "Detected OS: $OS"

case "$OS" in
  MINGW*|MSYS*|CYGWIN*)
    echo "Detected Windows (Git Bash/MSYS/Cygwin). Running windows.ps1..."
    echo "Please run the following command in PowerShell as Administrator:"
    echo "  pwsh -ExecutionPolicy Bypass -File \"$DOTFILES_DIR/install/windows.ps1\""
    echo ""
    echo "Or run from PowerShell directly:"
    echo "  Set-ExecutionPolicy Bypass -Scope Process -Force; & \"$DOTFILES_DIR/install/windows.ps1\""
    exit 0
    ;;
  Linux)
    echo "🐧 Running Linux setup..."
    source "$DOTFILES_DIR/install/common.sh"
    source "$DOTFILES_DIR/install/linux.sh"
    ;;
  Darwin)
    echo "🍎 Running macOS setup..."
    source "$DOTFILES_DIR/install/common.sh"
    source "$DOTFILES_DIR/install/macos.sh"
    ;;
  *)
    echo "Unsupported OS detected: $OS"
    exit 1
    ;;
esac

echo "Linking dotfiles..."
bash "$DOTFILES_DIR/bootstrap/link.sh"

echo "✅ Setup complete! Restart your shell or machine for all changes to apply."
