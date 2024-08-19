#!/bin/bash

# Function to install Mac App Store packages
install_mas_packages() {
    local scenario="$1"
    if ! step_completed "install_mas_packages"; then
        log "Installing Mac App Store packages..."

        # Check if user is signed in to the App Store
        if ! mas account > /dev/null; then
            handle_error "Please sign in to the App Store and try again."
        fi

        # Install common packages
        for package in "${COMMON_MAS_PACKAGES[@]}"; do
            IFS='::' read -ra APP <<< "$package"
            mas install "${APP[0]}" || handle_error "Failed to install ${APP[1]}"
        done

        # Install scenario-specific packages
        if [ "$scenario" == "desktop" ]; then
            for package in "${DESKTOP_MAS_PACKAGES[@]}"; do
                IFS='::' read -ra APP <<< "$package"
                mas install "${APP[0]}" || handle_error "Failed to install ${APP[1]}"
            done
        elif [ "$scenario" == "laptop" ]; then
            for package in "${LAPTOP_MAS_PACKAGES[@]}"; do
                IFS='::' read -ra APP <<< "$package"
                mas install "${APP[0]}" || handle_error "Failed to install ${APP[1]}"
            done
        fi
        mark_step_completed "install_mas_packages"
    else
        log "Skipping Mac App Store packages installation (already completed)"
    fi
}
