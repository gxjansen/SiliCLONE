# SiliCLONE: macOS Setup Automation Script

SiliCLONE is a powerful script that automates the process of setting up a new macOS system or updating an existing one. It installs software, configures system settings, and sets up development environments with minimal user intervention.

## Features

- Single command installation
- Support for different installation scenarios (Desktop/Laptop)
- Software installation from multiple sources (Homebrew, Mac App Store, manual downloads)
- SSH and GPG key setup for GitHub
- macOS configuration settings
- Application settings and extensions installation
- Cleanup and Homebrew auto-update setup
- Error handling and logging
- Ability to resume interrupted installations
- Verbose mode for detailed output
- Easy script and configuration updates

## Prerequisites

- macOS Sonoma 14.5 or higher
- Apple Silicon hardware
- Internet connection
- Apple ID (for Mac App Store installations)

## Usage

### Basic Installation

To run SiliCLONE with default settings:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/yourusername/your-repo/main/bootstrap.sh)"
```

### Additional Options

You can pass additional options to the SiliCLONE script:

- Verbose mode: Add `-- --verbose` at the end of the command
- Update script and configurations: Add `-- --update` at the end of the command
- Resume a previous installation: Add `-- --resume` at the end of the command

Example:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/yourusername/your-repo/main/bootstrap.sh)" -- --verbose
```

The bootstrap script will download all necessary files to a temporary directory, run the main SiliCLONE script, and then clean up after itself.

## Customization

### User Settings

Edit the `config/user_settings.sh` file to customize user-specific settings:

```bash
USER_EMAIL="your_email@example.com"
GITHUB_USERNAME="your_github_username"
```

### Software Selection

Modify the following files to customize software installation:

- `config/homebrew_packages.sh`: Homebrew formulae, casks, and fonts
- `config/mas_packages.sh`: Mac App Store applications

### macOS Settings

Edit `config/macos_settings.sh` to change macOS system preferences.

### Application Settings

Modify `config/app_settings.sh` to customize application-specific settings and extensions.

## Directory Structure

```
.
├── siliclone.sh
├── utils.sh
├── homebrew_install.sh
├── mas_install.sh
├── key_setup.sh
├── system_setup.sh
├── README.md
└── config
    ├── user_settings.sh
    ├── homebrew_packages.sh
    ├── mas_packages.sh
    ├── macos_settings.sh
    └── app_settings.sh
```

## How It Works

1. The main script (`siliclone.sh`) orchestrates the entire process.
2. Utility functions are stored in `utils.sh`.
3. Homebrew installation and package management are handled by `homebrew_install.sh`.
4. Mac App Store installations are managed by `mas_install.sh`.
5. SSH and GPG key setup is performed by `key_setup.sh`.
6. System and application settings are applied by `system_setup.sh`.
7. Configuration files in the `config` directory determine which software to install and what settings to apply.

The script uses a progress tracking mechanism to allow for resuming interrupted installations.

## Logging

SiliCLONE generates a log file (`siliclone_log.txt`) in the same directory. Use the `--verbose` flag for more detailed console output.

## Updating

Run SiliCLONE with the `--update` flag to download the latest version of the script and configuration files.

## Contributing

Contributions are welcome! Please fork the repository and submit a pull request with your improvements.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Disclaimer

SiliCLONE modifies system settings and installs software. While it's designed to be safe, please review the script and configurations before running it on your system. Always ensure you have backups of important data.
