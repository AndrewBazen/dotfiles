#!/bin/bash

set -e

echo "🐚 Running Zsh-specific setup..."

# Ensure zsh is installed
if ! command -v zsh &>/dev/null; then
    echo "Zsh is not installed. Exiting."
    exit 1
fi

# Plugin directory
ZSH_PLUGINS_DIR="$HOME/.local/share"

# zsh-syntax-highlighting
if [ ! -d "$ZSH_PLUGINS_DIR/zsh-syntax-highlighting" ]; then
    echo "📥 Installing zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_PLUGINS_DIR/zsh-syntax-highlighting"
fi

# zsh-autosuggestions
if [ ! -d "$ZSH_PLUGINS_DIR/zsh-autosuggestions" ]; then
    echo "📥 Installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH_PLUGINS_DIR/zsh-autosuggestions"
fi


echo "✅ Zsh plugin setup complete."