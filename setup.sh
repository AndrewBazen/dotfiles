#!/bin/bash

set -e

echo "Detecting shell environment..."

# Windows PowerShell
if [ -n "$PSModulePath" ]; then
  echo "Detected PowerShell. Running windows.ps1..."
  pwsh -File ./windows.ps1
  exit $?
fi

# Windows CMD
if [ -z "$ComSpec" ] && [[ "$OS" == "Windows_NT" ]]; then
  echo "Detected CMD. Running cmd.bat..."
  cmd /c cmd.bat
  exit $?
fi

# Unix-like Shell (Linux/macOS/WSL)
OS="$(uname)"
echo "Detected OS: $OS"

if [[ "$OS" == "Linux" ]]; then
  source install/common.sh
  source install/linux.sh
elif [[ "$OS" == "Darwin" ]]; then
  source install/common.sh
  source install/macos.sh
else
  echo "Unsupported OS detected: $OS"
  exit 1
fi

echo "Linking dotfiles..."
bash bootstrap/link.sh

echo "✅ Setup complete! Restart your shell or machine for all changes to apply."
