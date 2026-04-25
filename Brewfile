# =============================================================================
# Brewfile — M1 Pro MacBook Pro
# =============================================================================
# Run with: brew bundle --file=~/dotfiles/Brewfile
# Inspect: brew bundle list --file=~/dotfiles/Brewfile
# Cleanup (remove anything not in this file): brew bundle cleanup --file=~/dotfiles/Brewfile
# =============================================================================

# Taps -----------------------------------------------------------------------
tap "homebrew/bundle"
tap "homebrew/services"
tap "hashicorp/tap"

# Core CLI -------------------------------------------------------------------
brew "git"
brew "gh"                    # GitHub CLI
brew "stow"                  # dotfiles symlink manager
brew "starship"              # shell prompt
brew "zsh-autosuggestions"
brew "zsh-syntax-highlighting"

# Modern CLI replacements ----------------------------------------------------
brew "bat"                   # better cat
brew "eza"                   # better ls
brew "fd"                    # better find
brew "ripgrep"               # better grep
brew "fzf"                   # fuzzy finder
brew "zoxide"                # smarter cd
brew "tldr"                  # simpler man pages
brew "jq"                    # JSON processor
brew "yq"                    # YAML processor
brew "tree"
brew "wget"
brew "htop"

# Dev tooling ----------------------------------------------------------------
brew "python@3.12"
brew "pyenv"
brew "node"
brew "nvm"
brew "go"

# Cloud / IAM / Security CLIs ------------------------------------------------
brew "awscli"
brew "azure-cli"
brew "hashicorp/tap/terraform"
brew "kubectl"
brew "helm"
brew "ansible"

# Security tooling -----------------------------------------------------------
brew "nmap"
brew "wireshark"             # CLI tools (GUI is the cask below)
brew "sqlmap"
brew "hydra"
brew "john"                  # John the Ripper
brew "hashcat"

# Containers -----------------------------------------------------------------
brew "docker"                # CLI only — Docker Desktop is the cask
brew "docker-compose"
brew "lazydocker"

# Casks (GUI apps) -----------------------------------------------------------
cask "ghostty"               # modern terminal
cask "visual-studio-code"
cask "docker"                # Docker Desktop
# cask "vmware-fusion"  # skipped — install manually from Broadcom when needed
cask "1password"
cask "1password-cli"
cask "raycast"
cask "rectangle"             # window management
cask "google-chrome"
cask "firefox"
cask "obsidian"              # notes / second brain
cask "stats"                 # menu bar system monitor
cask "wireshark"             # GUI

# Cybersecurity / IAM-specific GUIs ------------------------------------------
cask "burp-suite"
cask "postman"
cask "tailscale"

# Fonts ----------------------------------------------------------------------
cask "font-jetbrains-mono-nerd-font"
cask "font-fira-code-nerd-font"

# Mac App Store --------------------------------------------------------------
# Requires `mas` and being signed into App Store first
brew "mas"
# mas "Xcode", id: 497799835
# mas "Magnet", id: 441258766
