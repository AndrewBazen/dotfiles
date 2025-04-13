# PATH additions
export PATH="$HOME/.local/bin:$PATH"

# Source aliases if exists
[ -f "$HOME/.aliases" ] && source "$HOME/.aliases"

# Starship prompt
if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
fi

# Set default editor to Neovim
export EDITOR="nvim"

# History settings
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

# Better directory navigation
setopt AUTO_CD

# Enable completion
autoload -Uz compinit
compinit

# Use syntax highlighting if available
if [[ -r "${HOME}/.local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  source "${HOME}/.local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# Use autosuggestions if available
if [[ -r "${HOME}/.local/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
  source "${HOME}/.local/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

lg()
{
    export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir

    lazygit "$@"

    if [ -f $LAZYGIT_NEW_DIR_FILE ]; then
            cd "$(cat $LAZYGIT_NEW_DIR_FILE)"
            rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
    fi
}export PATH=$PATH:/snap/bin
