#!/usr/bin/env bash
# =============================================================================
# macos/defaults.sh — sensible macOS system preferences
# =============================================================================
# Run with: bash ~/dotfiles/macos/defaults.sh
# Some changes require logout or restart to take effect.
# =============================================================================

set -e

echo "Applying macOS defaults..."

# Close any open System Settings to prevent overrides
osascript -e 'tell application "System Settings" to quit' 2>/dev/null || true

# -----------------------------------------------------------------------------
# General UI/UX
# -----------------------------------------------------------------------------
# Expand save & print panels by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

# Save to disk (not iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Disable auto-correct (helpful for terminal/code)
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Disable smart quotes / dashes (annoying in code)
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# -----------------------------------------------------------------------------
# Trackpad / Keyboard
# -----------------------------------------------------------------------------
# Tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Faster key repeat
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# -----------------------------------------------------------------------------
# Finder
# -----------------------------------------------------------------------------
# Show hidden files
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show path bar and status bar
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Search current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable warning when changing file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Avoid creating .DS_Store on network/USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# -----------------------------------------------------------------------------
# Dock
# -----------------------------------------------------------------------------
# Auto-hide dock
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.4

# Smaller dock icons
defaults write com.apple.dock tilesize -int 42

# Don't show recent apps in dock
defaults write com.apple.dock show-recents -bool false

# -----------------------------------------------------------------------------
# Screenshots
# -----------------------------------------------------------------------------
mkdir -p "${HOME}/Screenshots"
defaults write com.apple.screencapture location -string "${HOME}/Screenshots"
defaults write com.apple.screencapture type -string "png"
defaults write com.apple.screencapture disable-shadow -bool true

# -----------------------------------------------------------------------------
# Security
# -----------------------------------------------------------------------------
# Require password immediately after sleep/screensaver
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# -----------------------------------------------------------------------------
# Terminal / Activity Monitor
# -----------------------------------------------------------------------------
# Activity Monitor: show all processes, sort by CPU
defaults write com.apple.ActivityMonitor ShowCategory -int 0
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

# -----------------------------------------------------------------------------
# Restart affected apps
# -----------------------------------------------------------------------------
for app in "Activity Monitor" "Dock" "Finder" "SystemUIServer"; do
  killall "${app}" &>/dev/null || true
done

echo "Done. Some changes require a logout or restart."
