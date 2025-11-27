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

# Add custom paths to PATH
export PATH="$HOME/.local/bin:$HOME/scripts:$PATH"

# Set KUBECONFIG to include all environment configs
if [ -f "$HOME/.kube/config" ]; then
    export KUBECONFIG="$HOME/.kube/config"
elif [ -d "$HOME/.kube" ]; then
    # Fallback to individual configs if merged doesn't exist
    # Dynamically find all config.* files
    KUBE_CONFIGS=""
    for config_file in "$HOME/.kube"/config.*; do
        if [ -f "$config_file" ] && [[ "$config_file" != *.backup ]]; then
            KUBE_CONFIGS="${KUBE_CONFIGS:+$KUBE_CONFIGS:}$config_file"
        fi
    done
    [ -n "$KUBE_CONFIGS" ] && export KUBECONFIG="$KUBE_CONFIGS"
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
alias vim='nvim'
alias nano='nvim'
alias pico='nvim'

# ============================================================================
# ZSH CONFIGURATION
# ============================================================================

# Disable beep
setopt NO_BEEP

# Allow ctrl-S for forward search
stty -ixon

# Enable emacs key bindings
bindkey -e

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
