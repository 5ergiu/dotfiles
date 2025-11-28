# ============================================================================
# ~/.zshrc (YADM-managed)
# Enable completions and common settings
# ============================================================================

# ============================================================================
# SOURCE ALIASES AND SCRIPTS
# ============================================================================

# source /etc/zshrc if present
[ -f /etc/zshrc ] && source /etc/zshrc

# Auto-source helpers
if [ -d "$HOME/.zsh" ]; then
    for script in "$HOME/.zsh"/*.zsh; do
        [ -f "$script" ] && source "$script"
    done
fi

# ============================================================================
# EXPORTS
# ============================================================================

# GPG TTY for proper passphrase prompts
export GPG_TTY=$(tty)

# Add custom paths to PATH
export PATH="$HOME/.local/bin:$HOME/scripts:$PATH"

# Set KUBECONFIG to include all environment configs
if [ -f "$HOME/.kube/config" ]; then
    export KUBECONFIG="$HOME/.kube/config"
fi

# Expand the history size
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=~/.zsh_history

# Don't put duplicate lines in the history
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt APPEND_HISTORY
setopt SHARE_HISTORY

# Set the default editor
export EDITOR=nvim
export VISUAL=nvim

# ============================================================================
# ZSH CONFIGURATION
# ============================================================================

# Disable beep
setopt NO_BEEP

# Allow ctrl-S for forward search
stty -ixon

# Enable emacs key bindings
bindkey -e

# Universal Homebrew initialization that works on macOS (Intel/Apple Silicon) and Linux
if [[ -x "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
    # Linux
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [[ -x "/opt/homebrew/bin/brew" ]]; then
    # macOS Apple Silicon
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x "/usr/local/bin/brew" ]]; then
    # macOS Intel
    eval "$(/usr/local/bin/brew shellenv)"
fi

# Case-insensitive completion
autoload -Uz compinit
compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu select

# Auto cd when typing directory name
setopt AUTO_CD

# Correction for commands
setopt CORRECT

# Load zoxide
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
fi

# Starship prompt
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
fi
