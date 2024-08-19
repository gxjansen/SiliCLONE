#!/bin/bash

# Function to apply macOS settings
apply_macos_settings() {
    if ! step_completed "apply_macos_settings"; then
        log "Applying macOS settings..."
        # This function content comes from config/macos_settings.sh
        source "config/macos_settings.sh"
        apply_macos_settings_impl
        mark_step_completed "apply_macos_settings"
    else
        log "Skipping macOS settings application (already completed)"
    fi
}

# Function to apply application settings
apply_app_settings() {
    if ! step_completed "apply_app_settings"; then
        log "Applying application settings..."
        # This function content comes from config/app_settings.sh
        source "config/app_settings.sh"
        apply_app_settings_impl
        mark_step_completed "apply_app_settings"
    else
        log "Skipping application settings (already completed)"
    fi
}

# Function to perform cleanup
cleanup() {
    log "Performing cleanup..."
    brew cleanup || log "Brew cleanup failed" "WARN"
    # Add more cleanup tasks here
}
