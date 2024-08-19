#!/bin/bash

set -e

REPO_URL="https://raw.githubusercontent.com/yourusername/your-repo/main"
SCRIPT_FILES=(
    "siliclone.sh"
    "utils.sh"
    "homebrew_install.sh"
    "mas_install.sh"
    "key_setup.sh"
    "system_setup.sh"
)
CONFIG_FILES=(
    "user_settings.sh"
    "homebrew_packages.sh"
    "mas_packages.sh"
    "macos_settings.sh"
    "app_settings.sh"
)

# Create a temporary directory
temp_dir=$(mktemp -d)
echo "Created temporary directory: $temp_dir"

# Download main script files
for file in "${SCRIPT_FILES[@]}"; do
    echo "Downloading $file..."
    curl -sSL "$REPO_URL/$file" -o "$temp_dir/$file"
done

# Create config directory and download config files
mkdir -p "$temp_dir/config"
for file in "${CONFIG_FILES[@]}"; do
    echo "Downloading config/$file..."
    curl -sSL "$REPO_URL/config/$file" -o "$temp_dir/config/$file"
done

# Make the main script executable
chmod +x "$temp_dir/siliclone.sh"

# Change to the temporary directory and run the main script
cd "$temp_dir"
./siliclone.sh "$@"

# Clean up
echo "Cleaning up..."
rm -rf "$temp_dir"
