#!/bin/bash

set -e

VERBOSE=0

while getopts "v" opt; do
  case ${opt} in
    v ) VERBOSE=1;;
    * ) echo "Usage: $0 [-v for verbose]"; exit 1;;
  esac
done

echo "===================================="
echo "🖥  Environment Info"
echo "===================================="

echo "OS: $(uname -a)"
echo "Shell: $SHELL"
echo "User: $(whoami)"

echo "===================================="
echo "🗒  Versions"
echo "===================================="

command -v zsh &>/dev/null && echo "Zsh: $(zsh --version)" || echo "Zsh: Not installed"
command -v nvim &>/dev/null && echo "Neovim: $(nvim --version | head -n 1)" || echo "Neovim: Not installed"
command -v node &>/dev/null && echo "Node.js: $(node --version)" || echo "Node.js: Not installed"
command -v starship &>/dev/null && echo "Starship: $(starship --version)" || echo "Starship: Not installed"

echo "===================================="
echo "🔤 Nerd Font Glyph Test"
echo "===================================="

echo "Symbols: 󰀵 󰌽 󰍲 󰣇 󰣚       "

echo "===================================="
echo "󰴇 Neovim Diagnostics"
echo "===================================="

if command -v nvim &>/dev/null; then
    echo "Running Neovim :checkhealth..."
    if [ $VERBOSE -eq 1 ]; then
        nvim --headless "+checkhealth" +qa
    else
        nvim --headless "+checkhealth" +qa >/dev/null 2>&1 && echo "checkhealth passed."
    fi

    echo "Checking if Lazy.nvim is loaded..."
    if nvim --headless "+lua print(vim.inspect(require('lazy')))" +qa >/dev/null 2>&1; then
        echo "Lazy.nvim is installed."
        echo "Listing loaded plugins..."
        nvim --headless "+lua for name, _ in pairs(require('lazy').plugins()) do print(name) end" +qa
    else
        echo "Lazy.nvim is NOT installed or failed to load."
    fi
else
    echo "Neovim not installed"
fi

echo "===================================="
echo "✅ Setup test complete."
echo "Use ./test-setup.sh -v for verbose output."
echo "===================================="