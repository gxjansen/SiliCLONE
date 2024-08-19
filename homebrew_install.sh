#!/bin/bash

# Function to install Homebrew
install_homebrew() {
    if ! step_completed "install_homebrew"; then
        if ! command_exists brew; then
            log "Installing Homebrew..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || handle_error "Failed to install Homebrew"
        else
            log "Homebrew is already installed."
        fi
        mark_step_completed "install_homebrew"
    else
        log "Skipping Homebrew installation (already completed)"
    fi
}

# Function to install Homebrew packages
install_homebrew_packages() {
    local scenario="$1"
    if ! step_completed "install_homebrew_packages"; then
        log "Installing Homebrew packages..."
        # Install common packages
        for formula in "${COMMON_HOMEBREW_FORMULAE[@]}"; do
            brew install "$formula" || handle_error "Failed to install $formula"
        done

        for cask in "${COMMON_HOMEBREW_CASKS[@]}"; do
            brew install --cask "$cask" || handle_error "Failed to install $cask"
        done

        for font in "${COMMON_HOMEBREW_FONTS[@]}"; do
            brew install --cask "$font" || handle_error "Failed to install $font"
        done

        # Install scenario-specific packages
        if [ "$scenario" == "desktop" ]; then
            for formula in "${DESKTOP_HOMEBREW_FORMULAE[@]}"; do
                brew install "$formula" || handle_error "Failed to install $formula"
            done

            for cask in "${DESKTOP_HOMEBREW_CASKS[@]}"; do
                brew install --cask "$cask" || handle_error "Failed to install $cask"
            done

            for font in "${DESKTOP_HOMEBREW_FONTS[@]}"; do
                brew install --cask "$font" || handle_error "Failed to install $font"
            done
        elif [ "$scenario" == "laptop" ]; then
            for formula in "${LAPTOP_HOMEBREW_FORMULAE[@]}"; do
                brew install "$formula" || handle_error "Failed to install $formula"
            done

            for cask in "${LAPTOP_HOMEBREW_CASKS[@]}"; do
                brew install --cask "$cask" || handle_error "Failed to install $cask"
            done

            for font in "${LAPTOP_HOMEBREW_FONTS[@]}"; do
                brew install --cask "$font" || handle_error "Failed to install $font"
            done
        fi
        mark_step_completed "install_homebrew_packages"
    else
        log "Skipping Homebrew packages installation (already completed)"
    fi
}

# Function to set up Homebrew auto-update
setup_homebrew_autoupdate() {
    if ! step_completed "setup_homebrew_autoupdate"; then
        log "Setting up Homebrew auto-update..."
        brew autoupdate start 43200 --upgrade --cleanup --immediate --sudo || handle_error "Failed to set up Homebrew auto-update"
        mark_step_completed "setup_homebrew_autoupdate"
    else
        log "Skipping Homebrew auto-update setup (already completed)"
    fi
}
