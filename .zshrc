# ============================================================================
# ~/.zshrc (YADM-managed)
# Enable completions and common settings
# ============================================================================

# ============================================================================
# SOURCE ALIASES AND SCRIPTS
# ============================================================================

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

# Set the default editor
export EDITOR=nvim
export VISUAL=nvim

# ============================================================================
# ZSH CONFIGURATION
# ============================================================================

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

# Load zoxide
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
fi

# Starship prompt
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
fi
