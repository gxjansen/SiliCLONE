#!/bin/bash

# Function to log messages
log() {
    local message="$1"
    local level="${2:-INFO}"
    local timestamp=$(date "+%Y-%m-%d %H:%M:%S")
    echo "[$timestamp] [$level] $message" | tee -a "$LOG_FILE"
    if [ "$VERBOSE" = true ] || [ "$level" != "DEBUG" ]; then
        echo "[$level] $message"
    fi
}

# Function to handle errors
handle_error() {
    local error_message="$1"
    log "Error: $error_message" "ERROR"
    exit 1
}

# Function to check if a step has been completed
step_completed() {
    local step="$1"
    grep -q "^$step$" "$STEP_FILE" 2>/dev/null
}

# Function to mark a step as completed
mark_step_completed() {
    local step="$1"
    echo "$step" >> "$STEP_FILE"
}

# Function to source configuration files
source_config() {
    local config_file="$1"
    if [ -f "$config_file" ]; then
        source "$config_file"
    else
        handle_error "Configuration file $config_file not found."
    fi
}

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}
