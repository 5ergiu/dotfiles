#!/usr/bin/env bash
# =============================================================================
# Dotfiles Pre-Bootstrap Script
# =============================================================================
# This script installs prerequisites (Homebrew & yadm) and clones dotfiles.
# Run with: bash <(curl -fsSL https://raw.githubusercontent.com/5ergiu/dotfiles/main/pre-bootstrap.sh)
# =============================================================================

set -euo pipefail

# Color definitions
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly CYAN='\033[0;36m'
readonly BOLD='\033[1m'
readonly RESET='\033[0m'

print_success() {
    echo -e "${GREEN}✅ $1${RESET}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${RESET}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${RESET}"
}

print_error() {
    echo -e "${RED}❌ $1${RESET}"
}

print_step() {
    echo -e "${CYAN}🔧 $1${RESET}"
}

print_header() {
    echo -e "\n${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo -e "${BOLD}${CYAN}$1${RESET}"
    echo -e "${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}\n"
}

# =============================================================================
# Main Script
# =============================================================================

print_header "🚀 Dotfiles Pre-Bootstrap"

# Detect OS
OS=$(uname -s)
ARCH=$(uname -m)

print_info "Operating System: $OS"
print_info "Architecture: $ARCH"

if [ "$OS" != "Darwin" ] && [ "$OS" != "Linux" ]; then
    print_error "Unsupported OS: $OS. This script only supports Linux and macOS."
    exit 1
fi

# =============================================================================
# Step 1: Install Homebrew
# =============================================================================

print_step "Checking Homebrew installation..."

if command -v brew >/dev/null 2>&1; then
    print_success "Homebrew is already installed"
    BREW_PREFIX=$(brew --prefix)
else
    print_info "Installing Homebrew..."

    if [ "$OS" = "Linux" ]; then
        if [ ! -w /home/linuxbrew/.linuxbrew ] && [ ! -w /home/linuxbrew ]; then
            print_info "Setting up Homebrew directory permissions..."
            sudo mkdir -p /home/linuxbrew/.linuxbrew
            sudo chown -R $USER:$USER /home/linuxbrew/.linuxbrew
        fi
    fi
    
    # Install Homebrew non-interactively
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Determine Homebrew prefix
    if [ "$OS" = "Darwin" ]; then
        if [ "$ARCH" = "arm64" ]; then
            BREW_PREFIX="/opt/homebrew"
        else
            BREW_PREFIX="/usr/local"
        fi
    else
        BREW_PREFIX="/home/linuxbrew/.linuxbrew"
    fi
    
    # Add Homebrew to PATH for this script
    eval "$($BREW_PREFIX/bin/brew shellenv)"
    
    print_success "Homebrew installed successfully!"
fi

# =============================================================================
# Step 2: Install yadm
# =============================================================================

print_step "Checking yadm installation..."

if command -v yadm >/dev/null 2>&1; then
    print_success "yadm is already installed"
else
    print_info "Installing yadm..."
    brew install yadm
    print_success "yadm installed successfully!"
fi

# =============================================================================
# Step 3: Clone dotfiles
# =============================================================================

print_step "Cloning dotfiles repository..."

DOTFILES_REPO="https://github.com/5ergiu/dotfiles.git"

# Check if yadm repo already exists
if yadm rev-parse --git-dir > /dev/null 2>&1; then
    print_warning "yadm repository already exists!"
    read -rp "$(echo -e "${YELLOW}Do you want to overwrite it? (y/N): ${RESET}")" overwrite
    
    if [[ "$overwrite" =~ ^[Yy]$ ]]; then
        print_info "Removing existing yadm repository..."
        rm -rf "$HOME/.local/share/yadm"
    else
        print_info "Keeping existing repository. Exiting."
        exit 0
    fi
fi

print_info "Cloning from: $DOTFILES_REPO"

if ! yadm clone "$DOTFILES_REPO" --bootstrap; then
    print_error "Failed to clone dotfiles repository"
    exit 1
fi

# =============================================================================
# Completion
# =============================================================================

print_header "✨ Pre-Bootstrap Complete!"

echo -e "${GREEN}${BOLD}Your dotfiles are now set up!${RESET}\n"
echo -e "${CYAN}📝 What was done:${RESET}"
echo -e "  ${GREEN}✓${RESET} Homebrew installed"
echo -e "  ${GREEN}✓${RESET} yadm installed"
echo -e "  ${GREEN}✓${RESET} Dotfiles cloned and bootstrapped"
echo ""
