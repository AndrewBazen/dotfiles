# Dotfiles

Cross-platform configuration files (dotfiles) for a consistent development environment.

## Supported Platforms

| Platform | Status |
|----------|--------|
| **Linux** (Ubuntu/Debian, Arch, Fedora) | ✅ Fully supported |
| **macOS** | ✅ Fully supported |
| **Windows** | ✅ Fully supported |

## Features

- **LazyVim** - Pre-configured Neovim setup with lazy.nvim
- **Starship** - Cross-shell prompt with Gruvbox theme
- **Zsh** - Configured with syntax highlighting and autosuggestions
- **Tmux** - Terminal multiplexer configuration
- **Git** - Global git configuration with useful aliases

![LazyVim](https://github.com/user-attachments/assets/7e2687c8-8aab-450e-b9fc-e696e036f269)

![Starship prompt](https://github.com/user-attachments/assets/a3e57969-9399-4615-98b7-4ed991b2c8da)

## Quick Start

### Linux / macOS

```bash
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x setup.sh
./setup.sh
```

> **Note:** On Linux, the script requires sudo privileges for package installation.

### Windows (PowerShell)

```powershell
git clone https://github.com/yourusername/dotfiles.git $HOME\dotfiles
cd $HOME\dotfiles
Set-ExecutionPolicy Bypass -Scope Process -Force
.\setup.ps1
```

> **Note:** Run PowerShell as Administrator for symlink creation.

## What Gets Installed

| Tool | Description |
|------|-------------|
| Neovim | Modern Vim-based text editor |
| Starship | Cross-shell prompt |
| Zsh | Shell with plugins (Linux/macOS) |
| fzf | Fuzzy finder |
| ripgrep | Fast grep replacement |
| fd | Fast find replacement |
| lazygit | Terminal UI for git |
| JetBrains Mono Nerd Font | Programming font with icons |

## Configuration Files

After setup, the following symlinks are created:

| Config | Location |
|--------|----------|
| Neovim | `~/.config/nvim` (Linux/macOS) or `%LOCALAPPDATA%\nvim` (Windows) |
| Starship | `~/.config/starship.toml` |
| Zsh | `~/.zshrc` |
| Tmux | `~/.tmux.conf` |
| Git | `~/.gitconfig` |
| Aliases | `~/.aliases` |

## Troubleshooting

Run the diagnostic tool to verify your setup:

```bash
./tools/diagnostic.sh
```

Use verbose mode for detailed output:

```bash
./tools/diagnostic.sh -v
```

## Structure

```
dotfiles/
├── bootstrap/       # Symlink setup scripts
├── git/             # Git configuration
├── install/         # Platform-specific installers
├── nvim/            # Neovim configuration (LazyVim)
├── starship/        # Starship prompt config
├── system/          # Cross-platform aliases
├── tmux/            # Tmux configuration
├── tools/           # Diagnostic utilities
└── zsh/             # Zsh configuration
```

## Contributing

Feel free to submit issues or pull requests to improve these configurations.

## License

This project is licensed under the MIT License.
