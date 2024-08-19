#!/bin/bash

apply_app_settings_impl() {
    # VSCode extensions
    if command_exists code; then
        echo "Installing VSCode extensions..."
        code --install-extension ms-python.python
        code --install-extension dbaeumer.vscode-eslint
        code --install-extension esbenp.prettier-vscode
        # Add more extensions here
    fi

    # Git configuration
    if command_exists git; then
        echo "Configuring Git..."
        git config --global user.name "$GITHUB_USERNAME"
        git config --global user.email "$USER_EMAIL"
        git config --global core.editor "nano"
        git config --global init.defaultBranch main
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
    fi

    # Python configuration
    if command_exists python3; then
        echo "Configuring Python..."
        python3 -m pip install --upgrade pip
        python3 -m pip install virtualenv
    fi

    # Node.js configuration
    if command_exists npm; then
        echo "Configuring Node.js..."
        npm install -g yarn
        npm install -g typescript
    fi

    echo "Application settings applied successfully."
}
