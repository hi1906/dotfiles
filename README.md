# dotfiles

Personal macOS configuration for an M1 Pro MacBook Pro. Reproducible setup using Homebrew, GNU Stow, and a small bootstrap script. Wipe the machine, run two commands, get back to work.

## Stack

- **Shell:** zsh + [Starship](https://starship.rs) prompt
- **Terminal:** [Ghostty](https://ghostty.org)
- **Package manager:** [Homebrew](https://brew.sh) (managed via `Brewfile`)
- **Dotfile manager:** [GNU Stow](https://www.gnu.org/software/stow/)
- **Editor:** VS Code

## What's in here

```
.
├── Brewfile              # All CLI tools and GUI apps
├── install.sh            # Bootstrap script
├── macos/defaults.sh     # System preferences via `defaults write`
├── zsh/.zshrc            # Shell config, aliases, plugin loading
├── starship/starship.toml
├── git/.gitconfig
├── git/.gitignore_global
└── ssh/.ssh/config       # Host aliases for homelab + GitHub
```

## Bootstrap a fresh Mac

```bash
# 1. Install Xcode Command Line Tools
xcode-select --install

# 2. Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 3. Generate SSH key and add to GitHub
ssh-keygen -t ed25519 -C "your-email@example.com"
pbcopy < ~/.ssh/id_ed25519.pub  # paste into github.com/settings/keys

# 4. Clone this repo
git clone git@github.com:hi1906/dotfiles.git ~/dotfiles
cd ~/dotfiles

# 5. Run the bootstrap
./install.sh

# 6. Apply macOS preferences
bash macos/defaults.sh

# 7. Restart terminal
exec zsh
```

## Daily workflows

**Update everything:**
```bash
brew update && brew upgrade && brew cleanup
```

**Add a new tool:**
1. Add to `Brewfile`
2. `brew bundle --file=~/dotfiles/Brewfile`
3. Commit and push

**Remove tools not in `Brewfile`:**
```bash
brew bundle cleanup --file=~/dotfiles/Brewfile --force
```

## Notable tools

| Category | Tool |
|---|---|
| Shell prompt | starship |
| Modern CLI | bat, eza, fd, ripgrep, fzf, zoxide |
| Cloud / IaC | awscli, azure-cli, terraform, kubectl, helm, ansible |
| Security | nmap, wireshark, sqlmap, hydra, john, hashcat |
| Containers | docker, docker-compose, lazydocker |
| GUI | Ghostty, VS Code, Docker Desktop, VMware Fusion, 1Password, Raycast, Burp Suite, Tailscale |

## Notes

- Git email is set via `git config --global user.email` rather than committed to this repo.
- SSH private keys are never committed — only the `~/.ssh/config` file is managed here.
- macOS defaults are kept as a separate optional script — review before running.
