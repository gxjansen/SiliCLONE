#!/bin/bash

apply_macos_settings() {
    echo "Applying macOS settings..."

    # Apply settings based on configuration
    [ "$SHOW_HIDDEN_FILES" = true ] && defaults write com.apple.finder AppleShowAllFiles -bool true
    [ "$SHOW_STATUS_BAR" = true ] && defaults write com.apple.finder ShowStatusBar -bool true
    [ "$SHOW_PATH_BAR" = true ] && defaults write com.apple.finder ShowPathbar -bool true
    [ "$KEEP_FOLDERS_ON_TOP" = true ] && defaults write com.apple.finder _FXSortFoldersFirst -bool true
    [ "$DISABLE_AUTO_CORRECT" = true ] && defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
    [ "$ENABLE_TAP_TO_CLICK" = true ] && defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

    defaults write NSGlobalDomain KeyRepeat -int "$KEY_REPEAT_RATE"
    defaults write NSGlobalDomain InitialKeyRepeat -int "$INITIAL_KEY_REPEAT"

    defaults write com.apple.finder FXPreferredViewStyle -string "$FINDER_VIEW_STYLE"

    [ "$DISABLE_EXTENSION_CHANGE_WARNING" = true ] && defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
    [ "$AVOID_DS_STORE_ON_NETWORK" = true ] && defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
    [ "$AVOID_DS_STORE_ON_USB" = true ] && defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
    [ "$DISABLE_OPEN_APP_PROMPT" = true ] && defaults write com.apple.LaunchServices LSQuarantine -bool false

    # Set Arc as default browser if configured
    if [ "$SET_ARC_AS_DEFAULT_BROWSER" = true ]; then
        open -a "Arc" --args --make-default-browser
    fi

    # Restart affected applications
    for app in "Finder" "Dock" "SystemUIServer"; do
        killall "${app}" &> /dev/null
    done

    echo "macOS settings applied successfully."
}
