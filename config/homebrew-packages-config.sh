#!/bin/bash

# COMMON: Installs in all scenario's (Desktop and Laptop)
# DESKTOP: Installs in scenario 1 (Desktop)
# LAPTOP: Installs in scenario 2 (Laptop)
# See README for further details

##### COMMON #####

# Common Homebrew formulae for all scenarios
COMMON_HOMEBREW_FORMULAE=(
    "git"
    "mas"
    "wget"
    "tree"
    "htop"
    "python"
    "node"
)

# Common Homebrew casks for all scenarios
COMMON_HOMEBREW_CASKS=(
    "adobe-creative-cloud"
    "affinity-photo"
    "asana"
    "bitwarden"
    "brave-browser"
    "caffeine"
    "canon-eos-utility"
    "canva"
    "capcut"
    "chatgpt"
    "discord"
    "handbrake"
    "home-assistant"
    "keybase"
    "localsend"
    "logitech-presentation"
    "lulu"
    "maccy"
    "miro"
    "obsidian"
    "ollama"
    "orbstack"
    "plex"
    "raycast"
    "rectangle"
    "signal"
    "steam"
    "synology-drive"
    "tailscale"
    "telegram"
    "vlc"
    "vscodium"
    "whatsapp"
    "ytmdesktop-youtube-music"
    "zoom"
)

# Common Homebrew fonts for all scenarios
COMMON_HOMEBREW_FONTS=(
    "font-jetbrains-mono"
    "font-manrope"
    "font-hack-nerd-font"
    "font-fira-code"
    "font-iosevka"
)

##### DESKTOP ONLY #####

# Desktop-only Homebrew formulae
DESKTOP_HOMEBREW_FORMULAE=(
)

# Desktop-only Homebrew casks
DESKTOP_HOMEBREW_CASKS=(
    "MonitorControl"
    "elgato-camera-hub"
    "elgato-control-center"
    "elgato-stream-deck"
    "logitech-options"
)

# Desktop-only Homebrew fonts
DESKTOP_HOMEBREW_FONTS=(
    # Add any desktop-specific fonts here
)

##### LAPTOP ONLY #####

# Laptop-only Homebrew formulae
LAPTOP_HOMEBREW_FORMULAE=(
    "battery"
)

# Laptop-only Homebrew casks
LAPTOP_HOMEBREW_CASKS=(
    "caffeine"
)

# Laptop-only Homebrew fonts
LAPTOP_HOMEBREW_FONTS=(
    # Add any laptop-specific fonts here
)
