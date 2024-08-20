#!/bin/bash

install_homebrew() {
    if ! command_exists brew; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || handle_error "Failed to install Homebrew"
    else
        echo "Homebrew is already installed."
    fi
}

install_homebrew_packages() {
    local scenario="$1"
    echo "Installing Homebrew packages..."

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
    elif [ "$scenario" == "laptop" ]; then
        for formula in "${LAPTOP_HOMEBREW_FORMULAE[@]}"; do
            brew install "$formula" || handle_error "Failed to install $formula"
        done

        for cask in "${LAPTOP_HOMEBREW_CASKS[@]}"; do
            brew install --cask "$cask" || handle_error "Failed to install $cask"
        done
    fi
}
setup_homebrew_autoupdate() {
    echo "Setting up Homebrew auto-update..."
    brew autoupdate start 43200 --upgrade --cleanup --immediate --sudo || handle_error "Failed to set up Homebrew auto-update"
}
