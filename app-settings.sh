#!/bin/bash

apply_app_settings() {
    echo "Applying application settings..."

    # Install VS Code / VSCodium extensions
    install_code_extensions

    # Configure Git
    configure_git

    # Configure Zsh
    configure_zsh

    # Install Python packages
    install_python_packages

    # Install Node.js packages
    install_node_packages

    # Install external fonts
    install_external_fonts

    # Download manual installation files
    download_manual_installs

    echo "Application settings applied successfully."
}

install_code_extensions() {
    if command_exists code; then
        cmd="code"
    elif command_exists codium; then
        cmd="codium"
    else
        echo "Neither VS Code nor VSCodium is installed."
        return
    fi

    echo "Installing extensions for $cmd..."
    for extension in "${CODE_EXTENSIONS[@]}"; do
        $cmd --install-extension "$extension"
    done
}

configure_git() {
    if command_exists git; then
        echo "Configuring Git..."
        git config --global user.name "$GIT_USER_NAME"
        git config --global user.email "$GIT_USER_EMAIL"
        git config --global core.editor "$GIT_CORE_EDITOR"
        git config --global init.defaultBranch "$GIT_DEFAULT_BRANCH"
    fi
}

configure_zsh() {
    if [ "$SHELL" = "/bin/zsh" ]; then
        echo "Configuring Zsh..."
        # Install Oh My Zsh if not already installed
        if [ ! -d "$HOME/.oh-my-zsh" ]; then
            sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        fi
        # Set ZSH theme
        sed -i '' "s/ZSH_THEME=.*/ZSH_THEME=\"$ZSH_THEME\"/" ~/.zshrc
        # Add custom aliases
        for alias in "${ZSH_ALIASES[@]}"; do
            echo "$alias" >> ~/.zshrc
        done
        # Load changes
        source ~/.zshrc
    fi
}

install_python_packages() {
    if command_exists python3; then
        echo "Installing Python packages..."
        for package in "${PYTHON_PACKAGES[@]}"; do
            python3 -m pip install "$package"
        done
    fi
}

install_node_packages() {
    if command_exists npm; then
        echo "Installing Node.js packages..."
        for package in "${NODE_PACKAGES[@]}"; do
            npm install -g "$package"
        done
    fi
}

install_external_fonts() {
    local fonts_dir="$HOME/Library/Fonts"
    echo "Downloading and installing external fonts..."
    for url in "${EXTERNAL_FONTS[@]}"; do
        local filename=$(basename "$url")
        curl -L "$url" -o "/tmp/$filename"
        
        if [[ $filename == *.zip ]]; then
            unzip -o "/tmp/$filename" -d "/tmp/fonts"
            mv /tmp/fonts/*.ttf "$fonts_dir"
            rm -rf "/tmp/fonts"
        elif [[ $filename == *.ttf ]]; then
            mv "/tmp/$filename" "$fonts_dir"
        else
            echo "Unsupported font format: $filename"
        fi
    done
}

download_manual_installs() {
    local download_dir="$HOME/Downloads/SiliCLONE_Manual_Installs"
    echo "Downloading files for manual installation..."
    mkdir -p "$download_dir"
    for url in "${MANUAL_INSTALL_FILES[@]}"; do
        local filename=$(basename "$url")
        curl -L "$url" -o "$download_dir/$filename"
    done
    echo "Files for manual installation downloaded to $download_dir"
}
