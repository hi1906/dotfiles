#!/usr/bin/env bash
# =============================================================================
# install.sh — bootstrap a fresh Mac from this dotfiles repo
# =============================================================================
# Prerequisites (manual):
#   1. Xcode CLT installed: xcode-select --install
#   2. Homebrew installed: see https://brew.sh
#   3. SSH key generated and added to GitHub
#   4. This repo cloned to ~/dotfiles
#
# Then: cd ~/dotfiles && ./install.sh
# =============================================================================

set -euo pipefail

DOTFILES_DIR="${HOME}/dotfiles"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

info()    { echo -e "${BLUE}==>${NC} $1"; }
success() { echo -e "${GREEN}✓${NC} $1"; }
warn()    { echo -e "${YELLOW}!${NC} $1"; }
error()   { echo -e "${RED}✗${NC} $1"; }

# -----------------------------------------------------------------------------
# Sanity checks
# -----------------------------------------------------------------------------
if [[ "$(uname)" != "Darwin" ]]; then
  error "This script is for macOS only."
  exit 1
fi

if ! command -v brew &>/dev/null; then
  error "Homebrew not found. Install from https://brew.sh first."
  exit 1
fi

if [[ ! -d "${DOTFILES_DIR}" ]]; then
  error "Expected dotfiles at ${DOTFILES_DIR}"
  exit 1
fi

cd "${DOTFILES_DIR}"

# -----------------------------------------------------------------------------
# Install packages from Brewfile
# -----------------------------------------------------------------------------
info "Installing packages from Brewfile (this can take a while)..."
brew bundle --file="${DOTFILES_DIR}/Brewfile"
success "Brew bundle complete."

# -----------------------------------------------------------------------------
# Stow dotfiles
# -----------------------------------------------------------------------------
info "Symlinking dotfiles with GNU Stow..."

# Back up existing files that would conflict
BACKUP_DIR="${HOME}/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"
mkdir -p "${BACKUP_DIR}"

backup_if_exists() {
  local file="$1"
  if [[ -e "${file}" && ! -L "${file}" ]]; then
    warn "Backing up existing ${file} to ${BACKUP_DIR}"
    mv "${file}" "${BACKUP_DIR}/"
  fi
}

backup_if_exists "${HOME}/.zshrc"
backup_if_exists "${HOME}/.gitconfig"
backup_if_exists "${HOME}/.gitignore_global"
backup_if_exists "${HOME}/.ssh/config"

# Stow each package
for pkg in zsh git ssh; do
  info "Stowing ${pkg}..."
  stow -v -R -t "${HOME}" "${pkg}"
done
success "Dotfiles stowed."

# -----------------------------------------------------------------------------
# Starship config
# -----------------------------------------------------------------------------
info "Linking Starship config..."
mkdir -p "${HOME}/.config"
ln -sfn "${DOTFILES_DIR}/starship/starship.toml" "${HOME}/.config/starship.toml"
success "Starship configured."

# -----------------------------------------------------------------------------
# Fix SSH permissions
# -----------------------------------------------------------------------------
info "Setting SSH permissions..."
chmod 700 "${HOME}/.ssh"
chmod 600 "${HOME}/.ssh/config" 2>/dev/null || true
chmod 600 "${HOME}/.ssh/id_ed25519" 2>/dev/null || true
chmod 644 "${HOME}/.ssh/id_ed25519.pub" 2>/dev/null || true
success "SSH permissions set."

# -----------------------------------------------------------------------------
# macOS defaults (optional — run separately)
# -----------------------------------------------------------------------------
warn "macOS defaults not applied automatically."
warn "Review and run manually: bash ${DOTFILES_DIR}/macos/defaults.sh"

# -----------------------------------------------------------------------------
# Done
# -----------------------------------------------------------------------------
echo
success "Bootstrap complete!"
echo
echo "Next steps:"
echo "  1. Restart your terminal (or run: exec zsh)"
echo "  2. Set git email: git config --global user.email 'you@example.com'"
echo "  3. Review and run macOS defaults: bash macos/defaults.sh"
echo "  4. Sign into apps: 1Password, Tailscale, Docker, GitHub CLI (gh auth login)"
