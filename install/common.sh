#!/bin/bash

set -e

echo "🌐 Running common setup steps..."

# Setup Git user info if not set
if ! git config --global user.name >/dev/null; then
    git_username=read -p "Enter your Git username: "
    git config --global user.name "$git_username"
fi

if ! git config --global user.email >/dev/null; then
    git_email=read -p "Enter your Git email: "
    git config --global user.email "$git_email"
fi

# Setup basic git settings
git config --global pull.rebase false
git config --global init.defaultBranch main
git config --global color.ui auto

echo "✅ Common setup complete."
