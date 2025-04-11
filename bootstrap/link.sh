#!/bin/bash

set -e

echo "🔗 Linking dotfiles..."

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Link .zshrc
ln -sf "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"

# Link Neovim config
mkdir -p "$HOME/.config/nvim"
ln -sf "$DOTFILES_DIR/nvim/init.lua" "$HOME/.config/nvim/init.lua"
ln -sf "$DOTFILES_DIR/nvim/lua" "$HOME/.config/nvim/lua"

# Link Starship config
mkdir -p "$HOME/.config"
ln -sf "$DOTFILES_DIR/starship/starship.toml" "$HOME/.config/starship.toml"

# Link Git config
ln -sf "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"

# Optional: Link aliases if exists
if [ -f "$DOTFILES_DIR/system/aliases.sh" ]; then
    ln -sf "$DOTFILES_DIR/system/aliases.sh" "$HOME/.aliases"
fi

echo "✅ Dotfiles linking complete."
