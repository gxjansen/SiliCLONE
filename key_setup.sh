#!/bin/bash

# Function to set up SSH key
setup_ssh_key() {
    if ! step_completed "setup_ssh_key"; then
        if [ ! -f ~/.ssh/id_ed25519 ]; then
            log "Setting up SSH key..."
            ssh-keygen -t ed25519 -C "$USER_EMAIL" -f ~/.ssh/id_ed25519 -N "" || handle_error "Failed to generate SSH key"
            eval "$(ssh-agent -s)"
            ssh-add ~/.ssh/id_ed25519
            log "SSH key created. Please add the following public key to your GitHub account:"
            cat ~/.ssh/id_ed25519.pub
        else
            log "SSH key already exists."
        fi
        mark_step_completed "setup_ssh_key"
    else
        log "Skipping SSH key setup (already completed)"
    fi
}

# Function to set up GPG key
setup_gpg_key() {
    if ! step_completed "setup_gpg_key"; then
        if ! gpg --list-secret-keys --keyid-format LONG | grep sec > /dev/null; then
            log "Setting up GPG key..."
            gpg --batch --gen-key <<EOF
Key-Type: RSA
Key-Length: 4096
Name-Real: $GITHUB_USERNAME
Name-Email: $USER_EMAIL
Expire-Date: 0
%no-protection
EOF
            log "GPG key created. Please add the following public key to your GitHub account:"
            gpg --armor --export $(gpg --list-secret-keys --keyid-format LONG | grep sec | awk '{print $2}' | cut -d'/' -f2)
        else
            log "GPG key already exists."
        fi
        mark_step_completed "setup_gpg_key"
    else
        log "Skipping GPG key setup (already completed)"
    fi
}
