#!/bin/bash

set -e

echo "🌐 Running common setup steps..."

# Setup Git user info if not set
if ! git config --global user.name >/dev/null; then
    read -p "Enter your Git username: " git_username
    git config --global user.name "$git_username"
fi

if ! git config --global user.email >/dev/null; then
    read -p "Enter your Git email: " git_email
    git config --global user.email "$git_email"
fi

# Setup basic git settings
git config --global init.defaultBranch main

echo "✅ Common setup complete."
