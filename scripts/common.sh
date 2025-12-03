#!/usr/bin/env bash
# ============================================================================
# 🛠️  Common Utilities for Infrastructure Scripts
# ============================================================================
# Shared colors, formatting, and helper functions used across all scripts
# ============================================================================

# ============================================================================
# COLORS
# ============================================================================

readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly MAGENTA='\033[0;35m'
readonly CYAN='\033[0;36m'
readonly BOLD='\033[1m'
readonly RESET='\033[0m'

# ============================================================================
# GLOBAL VARIABLES
# ============================================================================

# System information
readonly OS="$(uname -s | tr '[:upper:]' '[:lower:]')"
readonly ARCH="$(uname -m)"

IS_WSL=false
if [[ -f /proc/version ]] && grep -qi microsoft /proc/version 2>/dev/null; then
    IS_WSL=true
fi

# ============================================================================
# HELPERS
# ============================================================================

print_header() {
    echo -e "\n${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo -e "${BOLD}${CYAN}$1${RESET}"
    echo -e "${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}\n"
}

print_system_info() {
    print_header "💻 System Information"
    echo -e "${CYAN}OS:${RESET}           ${OS}"
    echo -e "${CYAN}Architecture:${RESET} ${ARCH}"
    echo -e "${CYAN}Is WSL:${RESET}       $($IS_WSL && echo "${GREEN}Yes${RESET}" || echo "${YELLOW}No${RESET}")"
    echo ""
}

print_success() { echo -e "${GREEN}✅ $1${RESET}"; }
print_info()    { echo -e "${BLUE}ℹ️  $1${RESET}"; }
print_warning() { echo -e "${YELLOW}⚠️  $1${RESET}"; }
print_error()   { echo -e "${RED}❌ $1${RESET}"; }
print_step()    { echo -e "${MAGENTA}🔧 $1${RESET}"; }

prompt_user() {
    local prompt_message="$1"
    local default_response="${2:-N}"

    local response
    read -rp "$(echo -e "${CYAN}${prompt_message} (Y/N) [Default: $default_response]: ${RESET}")" response
    echo "${response:-$default_response}"
}

cleanup() {
    local exit_code=$?
    if [ $exit_code -ne 0 ]; then
        print_error "Script failed with exit code $exit_code"
    fi
}
