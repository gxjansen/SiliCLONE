#!/bin/bash

# Function to download and install external fonts
install_external_fonts() {
    local font_urls=(
        "https://github.com/source-foundry/Hack/releases/download/v3.003/Hack-v3.003-ttf.zip"
        # Add more font URLs here
    )
    local fonts_dir="$HOME/Library/Fonts"

    echo "Downloading and installing external fonts..."
    for url in "${font_urls[@]}"; do
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
    echo "External fonts installed successfully."
}

# Function to download files for manual installation
download_manual_installs() {
    local manual_installs=(
        "https://example.com/software1.dmg"
        "https://example.com/software2.pkg"
        # Add more URLs here
    )
    local download_dir="$HOME/Downloads/SiliCLONE_Manual_Installs"

    echo "Downloading files for manual installation..."
    mkdir -p "$download_dir"
    for url in "${manual_installs[@]}"; do
        local filename=$(basename "$url")
        curl -L "$url" -o "$download_dir/$filename"
    done
    echo "Files for manual installation downloaded to $download_dir"
}

apply_app_settings_impl() {
    # Function to install VS Code / VSCodium extensions
    install_code_extensions() {
        local cmd=$1
        echo "Installing extensions for $cmd..."
        $cmd --install-extension aaron-bond.better-comments
        $cmd --install-extension astro-build.astro-vs$cmd
        $cmd --install-extension astro-build.houston
        $cmd --install-extension bmewburn.vs$cmd-intelephense-client
        $cmd --install-extension bradlc.vs$cmd-tailwindcss
        $cmd --install-extension dracula-theme.theme-dracula
        $cmd --install-extension eamodio.gitlens
        $cmd --install-extension ecmel.vs$cmd-html-css
        $cmd --install-extension esbenp.prettier-vs$cmd
        $cmd --install-extension github.copilot
        $cmd --install-extension github.copilot-chat
        $cmd --install-extension github.remotehub
        $cmd --install-extension github.vs$cmd-github-actions
        $cmd --install-extension github.vs$cmd-pull-request-github
        $cmd --install-extension ibm.output-colorizer
        $cmd --install-extension kamikillerto.vs$cmd-colorize
        $cmd --install-extension lovebird.better-comments-enhanced
        $cmd --install-extension ms-azuretools.vs$cmd-docker
        $cmd --install-extension ms-python.debugpy
        $cmd --install-extension ms-python.python
        $cmd --install-extension ms-python.vs$cmd-pylance
        $cmd --install-extension ms-vs$cmd-remote.remote-containers
        $cmd --install-extension ms-vs$cmd.azure-repos
        $cmd --install-extension ms-vs$cmd.live-server
        $cmd --install-extension ms-vs$cmd.remote-repositories
        $cmd --install-extension oderwat.indent-rainbow
        $cmd --install-extension pranaygp.vs$cmd-css-peek
        $cmd --install-extension rajeshrenato.workspace-colors
        $cmd --install-extension streetsidesoftware.$cmd-spell-checker
        $cmd --install-extension unifiedjs.vs$cmd-mdx
        $cmd --install-extension vs$cmd-icons-team.vs$cmd-icons
        $cmd --install-extension yoavbls.pretty-ts-errors
        $cmd --install-extension yzhang.markdown-all-in-one
        # Add more extensions here as needed
    }

    # Check for VS Code or VSCodium
    if command_exists code; then
        install_code_extensions code
    elif command_exists codium; then
        install_code_extensions codium
    else
        echo "Neither VS Code nor VSCodium is installed."
    fi

    # Git configuration
    if command_exists git; then
        echo "Configuring Git..."
        git config --global user.name "$GITHUB_USERNAME"
        git config --global user.email "$USER_EMAIL"
        git config --global core.editor "nano"
        git config --global init.defaultBranch main
        git config --global pull.rebase false
        git config --global core.autocrlf input
    fi

    # Zsh configuration (if using Oh My Zsh)
    if [ "$SHELL" = "/bin/zsh" ]; then
        echo "Configuring Zsh..."
        # Install Oh My Zsh if not already installed
        if [ ! -d "$HOME/.oh-my-zsh" ]; then
            sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        fi
        # Set ZSH theme
        sed -i '' 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/' ~/.zshrc
        # Add custom aliases
        echo "alias ll='ls -la'" >> ~/.zshrc
        echo "alias update='brew update && brew upgrade'" >> ~/.zshrc
        echo "alias gs='git status'" >> ~/.zshrc
        echo "alias gc='git commit'" >> ~/.zshrc
        echo "alias gp='git push'" >> ~/.zshrc
        # Load changes
        source ~/.zshrc
    fi

    # Python configuration
    if command_exists python3; then
        echo "Configuring Python..."
        python3 -m pip install --upgrade pip
        python3 -m pip install virtualenv
        python3 -m pip install pylint
        python3 -m pip install black
        python3 -m pip install mypy
    fi

    # Node.js configuration
    if command_exists npm; then
        echo "Configuring Node.js..."
        npm install -g yarn
        npm install -g typescript
        npm install -g eslint
        npm install -g prettier
        npm install -g nodemon
    fi

    # Docker configuration (if installed)
    if command_exists docker; then
        echo "Configuring Docker..."
        # Create a Docker group and add the user to it (may require password)
        sudo groupadd docker
        sudo usermod -aG docker $USER
        # Enable and start Docker service
        sudo systemctl enable docker
        sudo systemctl start docker
    fi

    # Configure iTerm2 (if installed)
    if [ -d "/Applications/iTerm.app" ]; then
        echo "Configuring iTerm2..."
        # Set iTerm2 to use the Solarized Dark theme
        defaults write com.googlecode.iterm2 "Default Bookmark Guid" -string "Solarized Dark"
        # Set iTerm2 to use the Meslo LG M for Powerline font
        /usr/libexec/PlistBuddy -c "Set 'New Bookmarks':0:'Normal Font' 'MesloLGM-RegularForPowerline 12'" ~/Library/Preferences/com.googlecode.iterm2.plist
    fi

    echo "Application settings applied successfully."
}
