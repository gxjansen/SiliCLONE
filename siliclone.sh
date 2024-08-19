#!/bin/bash

set -e

# Global variables
VERBOSE=false
LOG_FILE="siliclone_log.txt"
STEP_FILE=".siliclone_progress"
SCRIPT_URL="https://raw.githubusercontent.com/yourusername/your-repo/main/siliclone.sh"
CONFIG_URL="https://raw.githubusercontent.com/yourusername/your-repo/main/config"

# Source utility functions
source "utils.sh"

# Function to update the script and configurations
update_script() {
    log "Updating script and configurations..."
    local temp_script="/tmp/siliclone.sh"
    curl -fsSL "$SCRIPT_URL" -o "$temp_script" || handle_error "Failed to download updated script"
    if [ -f "$temp_script" ]; then
        mv "$temp_script" "$0"
        chmod +x "$0"
        log "Script updated successfully"
    fi

    mkdir -p config
    for config_file in homebrew_packages.sh mas_packages.sh macos_settings.sh app_settings.sh user_settings.sh; do
        curl -fsSL "$CONFIG_URL/$config_file" -o "config/$config_file" || handle_error "Failed to download $config_file"
    done
    log "Configurations updated successfully"
}

# Main execution
main() {
    log "Starting SiliCLONE..."

    # Parse command-line arguments
    while [[ "$#" -gt 0 ]]; do
        case $1 in
            --verbose) VERBOSE=true ;;
            --update) update_script; exit 0 ;;
            --resume) RESUME=true ;;
            *) handle_error "Unknown parameter passed: $1" ;;
        esac
        shift
    done

    # Source user-specific settings
    source_config "config/user_settings.sh"

    # Choose installation scenario
    if [ ! -f "$STEP_FILE" ] || [ "$RESUME" != true ]; then
        echo "Choose installation scenario:"
        echo "1) Desktop"
        echo "2) Laptop"
        read -p "Enter your choice (1 or 2): " scenario_choice

        case $scenario_choice in
            1) scenario="desktop" ;;
            2) scenario="laptop" ;;
            *) handle_error "Invalid choice. Exiting." ;;
        esac
        echo "scenario=$scenario" > "$STEP_FILE"
    else
        log "Resuming previous installation..."
        scenario=$(grep "^scenario=" "$STEP_FILE" | cut -d= -f2)
    fi

    # Source configuration files
    source_config "config/homebrew_packages.sh"
    source_config "config/mas_packages.sh"
    source_config "config/macos_settings.sh"
    source_config "config/app_settings.sh"

    # Run installation steps
    source "homebrew_install.sh"
    source "mas_install.sh"
    source "key_setup.sh"
    source "system_setup.sh"

    install_homebrew
    install_homebrew_packages "$scenario"
    install_mas_packages "$scenario"
    setup_ssh_key
    setup_gpg_key
    apply_macos_settings
    apply_app_settings
    cleanup
    setup_homebrew_autoupdate

    log "SiliCLONE completed successfully!"
}

# Run the main function
main "$@"
