#!/bin/bash

apply_app_settings_impl() {
    # Function to install VS Code / VSCodium extensions
    install_code_extensions() {
        local cmd=$1
        echo "Installing extensions for $cmd..."
        $cmd --install-extension ms-python.python
        $cmd --install-extension dbaeumer.vscode-eslint
        $cmd --install-extension esbenp.prettier-vscode
        $cmd --install-extension ms-azuretools.vscode-docker
        $cmd --install-extension eamodio.gitlens
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
