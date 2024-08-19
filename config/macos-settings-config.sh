#!/bin/bash

apply_macos_settings_impl() {
    # Set default browser
    open -a "Arc" --args --make-default-browser
    
    # Show hidden files in Finder
    defaults write com.apple.finder AppleShowAllFiles -bool true

    # Show status bar in Finder
    defaults write com.apple.finder ShowStatusBar -bool true

    # Show path bar in Finder
    defaults write com.apple.finder ShowPathbar -bool true

    # Keep folders on top when sorting by name
    defaults write com.apple.finder _FXSortFoldersFirst -bool true

    # Disable auto-correct
    defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

    # Enable tap-to-click
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

    # Set fast key repeat rate
    defaults write NSGlobalDomain KeyRepeat -int 2
    defaults write NSGlobalDomain InitialKeyRepeat -int 15

    # Use list view in all Finder windows by default
    defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

    # Disable the warning when changing a file extension
    defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

    # Avoid creating .DS_Store files on network or USB volumes
    defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
    defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

    # Disable the "Are you sure you want to open this application?" dialog
    defaults write com.apple.LaunchServices LSQuarantine -bool false

    # Restart affected applications
    for app in "Finder" "Dock" "SystemUIServer" "Arc"; do
        killall "${app}" &> /dev/null
    done

    echo "macOS settings applied successfully."
}
