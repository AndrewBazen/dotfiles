# Custom Aliases - Cross-platform compatible

# Shortcuts
alias ll='ls -lah'
alias gs='git status'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias vim='nvim'
alias vi='nvim'
alias ..='cd ..'
alias ...='cd ../..'

# System update - platform-specific
if [[ "$(uname)" == "Darwin" ]]; then
    alias update='brew update && brew upgrade'
elif command -v apt &>/dev/null; then
    alias update='sudo apt update && sudo apt upgrade -y'
elif command -v dnf &>/dev/null; then
    alias update='sudo dnf upgrade --refresh -y'
elif command -v pacman &>/dev/null; then
    alias update='sudo pacman -Syu'
fi

# Weather
alias weather='curl wttr.in'

# Safety
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Quick navigation
alias dotfiles='cd $HOME/dotfiles 2>/dev/null || cd $(dirname $(readlink -f ~/.zshrc 2>/dev/null || echo ~/.zshrc))/..'
