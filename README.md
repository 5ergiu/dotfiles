# Dotfiles & Setup Scripts

This repository contains dotfiles and scripts to bootstrap and configure environments, including fresh Windows installations and WSL.

## Windows Setup

To set up a fresh Windows installation, run the following command in **PowerShell (Administrator)**:

```powershell
iwr https://gist.githubusercontent.com/5ergiu/134c145581125090346ce76375097744/raw/bootstrap-windows.ps1?$(Get-Random) | iex
```

### What This Script Does

The `bootstrap-windows.ps1` script performs a comprehensive Windows configuration:

#### 1. System Configuration
- **Dark Mode**: Enables dark mode for apps and system
- **File Explorer**:
  - Shows hidden files and folders
  - Shows file extensions
  - Opens to "This PC" instead of Quick Access
- **Taskbar**:
  - Shows all system tray icons
  - Hides search box
  - Disables Task View button
  - Disables Widgets/News
- **Privacy**:
  - Disables Activity History
  - Disables Location Tracking
  - Disables Telemetry
- **Disable unnecessary Windows services**:
  - SysMain (SuperFetch)
  - Windows Search indexing
- **Performance**:
  - Disables Transparency Effects
  - High Performance power plan
- **Developer Settings**:
  - Enables Developer Mode
  - Enables Long Paths support
- **Power Settings**:
  - Display timeout: 10 min (battery) / 15 min (plugged in)
  - Sleep timeout: 15 min (battery) / 30 min (plugged in)
  - Power/Sleep buttons and lid close set to "Do nothing"
  - Disables hibernation
- **Windows Update**:
  - Prevents automatic restart after updates
- **Keyboard**:
  - Fastest repeat rate
- **Startup**:
  - Disables startup delay for apps
- **Bloatware**:
  - Disables app suggestions
  - Disables Windows tips
  - Disables Cortana
- **Other**:
  - Disables Windows Error Reporting
  - Restarts Explorer to apply changes


## Dotfiles Setup (yadm)

This repository also serves as a dotfiles manager using [yadm](https://yadm.io/). This is a simpler alternative to the full Ansible-based WSL setup if you only need dotfiles management.

### Quick Setup

Install prerequisites (Homebrew & yadm) and clone dotfiles in one command:

```bash
GIT_REPO="https://github.com/5ergiu/dotfiles.git" \
SKIP_PROMPTS=true \
SSH_REPO_URL="git@github.com:5ergiu/dotfiles.git" \
bash <(curl -fsSL https://gist.githubusercontent.com/5ergiu/74d6ac65f5a67489895b36c776c44923/raw/install-dotfiles.sh)
```

This script will:
1. Install Homebrew (if not already installed)
2. Install yadm via Homebrew
3. Clone this repository using yadm

### What the Bootstrap Does

The yadm bootstrap script (`.config/yadm/bootstrap`) automatically:

#### System Verification
- Detects operating system (macOS/Linux) and architecture
- Validates OS compatibility

#### Package Installation
- Installs/updates Homebrew
- Installs packages from your `Brewfile` (git, zsh, neovim, etc.)
- Verifies critical tools are available

#### Shell Configuration
- Sets zsh as your default shell (if not already set)
- Adds zsh to `/etc/shells` if needed
- Verifies `.zshrc` configuration exists

#### Optional Features
- Interactive k3s cluster setup (if k3sup is installed)
- Custom context name support
- Cluster readiness verification

### Manual Setup

If you prefer to install step-by-step:

```bash
# 1. Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 2. Add Homebrew to PATH (choose based on your system)
# macOS (Apple Silicon):
eval "$(/opt/homebrew/bin/brew shellenv)"
# macOS (Intel):
eval "$(/usr/local/bin/brew shellenv)"
# Linux:
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# 3. Install yadm
brew install yadm

# 4. Clone dotfiles
yadm clone https://github.com/5ergiu/dotfiles.git

# 5. Run bootstrap (optional, but recommended)
yadm bootstrap
```

### Managing Dotfiles with yadm

After setup, yadm works just like git:

```bash
# Check status
yadm status

# Add files
yadm add ~/.zshrc

# Commit changes
yadm commit -m "Update zsh config"

# Push to GitHub
yadm push

# Pull latest changes
yadm pull
```

## Notes

- The Windows script requires **Administrator privileges**
- The WSL script requires **sudo access** but should not be run as root
- Some settings may require a system restart to take full effect
- The `?$(Get-Random)` parameter in the PowerShell command prevents caching
- The yadm bootstrap logs all actions to `~/.config/yadm/bootstrap.log`
