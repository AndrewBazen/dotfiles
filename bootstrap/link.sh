#!/bin/bash

set -e

echo "🔗 Linking dotfiles..."

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Get user home directory (handle sudo case)
if [ -n "$SUDO_USER" ]; then
    USER_HOME=$(getent passwd "$SUDO_USER" | cut -d: -f6)
else
    USER_HOME="$HOME"
fi

# Link .zshrc
if [ -f "$DOTFILES_DIR/zsh/.zshrc" ]; then
    ln -sf "$DOTFILES_DIR/zsh/.zshrc" "$USER_HOME/.zshrc"
    echo "  ✓ .zshrc linked"
fi

# Link Neovim config
mkdir -p "$USER_HOME/.config/nvim"
if [ -f "$DOTFILES_DIR/nvim/init.lua" ]; then
    ln -sf "$DOTFILES_DIR/nvim/init.lua" "$USER_HOME/.config/nvim/init.lua"
    echo "  ✓ nvim/init.lua linked"
fi
if [ -d "$DOTFILES_DIR/nvim/lua" ]; then
    ln -sf "$DOTFILES_DIR/nvim/lua" "$USER_HOME/.config/nvim/lua"
    echo "  ✓ nvim/lua linked"
fi
if [ -f "$DOTFILES_DIR/nvim/stylua.toml" ]; then
    ln -sf "$DOTFILES_DIR/nvim/stylua.toml" "$USER_HOME/.config/nvim/stylua.toml"
    echo "  ✓ nvim/stylua.toml linked"
fi

# Link Starship config
mkdir -p "$USER_HOME/.config"
if [ -f "$DOTFILES_DIR/starship/starship.toml" ]; then
    ln -sf "$DOTFILES_DIR/starship/starship.toml" "$USER_HOME/.config/starship.toml"
    echo "  ✓ starship.toml linked"
fi

# Link Tmux config
if [ -f "$DOTFILES_DIR/tmux/.tmux.conf" ]; then
    ln -sf "$DOTFILES_DIR/tmux/.tmux.conf" "$USER_HOME/.tmux.conf"
    echo "  ✓ .tmux.conf linked"
fi

# Link Git config
if [ -f "$DOTFILES_DIR/git/.gitconfig" ]; then
    ln -sf "$DOTFILES_DIR/git/.gitconfig" "$USER_HOME/.gitconfig"
    echo "  ✓ .gitconfig linked"
fi

# Link aliases
if [ -f "$DOTFILES_DIR/system/aliases.sh" ]; then
    ln -sf "$DOTFILES_DIR/system/aliases.sh" "$USER_HOME/.aliases"
    echo "  ✓ .aliases linked"
fi

echo "✅ Dotfiles linking complete."
