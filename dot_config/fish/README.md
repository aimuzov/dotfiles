# Fish Shell Configuration Documentation

[🇷🇺 Русская версия](README.ru.md)

This document describes the configuration of the Fish shell environment.

## Table of Contents

- [XDG Base Directories](#xdg-base-directories)
- [Path Configuration](#path-configuration)
- [Theme and Appearance](#theme-and-appearance)
- [Cache Management](#cache-management)
- [Plugin Management](#plugin-management)
- [Shell Integration](#shell-integration)
- [Development Tools](#development-tools)
- [File Management](#file-management)
- [Key Bindings](#key-bindings)
- [Environment Variables](#environment-variables)
- [Abbreviations and Aliases](#abbreviations-and-aliases)

## XDG Base Directories

The configuration follows the XDG Base Directory Specification for organizing configuration files:

- `XDG_CONFIG_HOME`: `$HOME/.config`
- `XDG_DATA_HOME`: `$HOME/.local/share`
- `XDG_STATE_HOME`: `$HOME/.local/state`
- `XDG_CACHE_HOME`: `$HOME/.cache`

These directories are automatically created if they don't exist.

## Path Configuration

The configuration sets up various paths for functions and completions:

- Recursive function paths from `$__fish_config_dir/functions/*/`
- Recursive completion paths from `$__fish_config_dir/completions/*/`

## Theme and Appearance

The shell uses Catppuccin theme with automatic dark/light mode detection based on macOS system settings:

- Dark mode: [Catppuccin Macchiato](https://github.com/catppuccin/fish)
- Light mode: [Catppuccin Latte](https://github.com/catppuccin/fish)

## Cache Management

Cache files are managed in `$XDG_CACHE_HOME/fish`:

- Expired cache files (older than 1200 minutes) are automatically removed
- Cache initialization for various tools (brew, fzf, zoxide, etc.)

## Plugin Management

Uses Fisher as the plugin manager:

- Plugin directory: `$__fish_config_dir/.fisher`
- Custom plugins directory: `$__fish_config_dir/plugins`
- Automatic plugin initialization and updates

## Shell Integration

### Oh My Posh

- Custom prompt configuration
- Automatic theme switching based on system appearance

### FZF Integration

- Custom color schemes for dark/light modes
- Default commands and preview settings
- Integration with `fd` for file searching

### Zoxide

- Directory jumping functionality
- Automatic initialization

## Development Tools

### Version Managers

- ASDF configuration for multiple language versions
- MISE configuration for development environment management

### Homebrew

- Automatic shell environment setup
- Fish completions integration
- Analytics disabled by default

## File Management

### EZA (Modern ls)

- Custom color schemes using Vivid
- Various aliases for different listing options:
  - `l`: Basic listing
  - `ll`: Detailed listing
  - `llm`: Modified time sorting
  - `la`: All files with details
  - `lt`: Tree view

### Bat

- Used as a replacement for `cat`
- Theme matching system appearance

## Key Bindings

- Vi mode enabled with custom bindings
- Clipboard integration for copy/paste operations
- Visual mode support

## Environment Variables

### Editor Settings

- `EDITOR`: Neovim
- `VISUAL`: Same as EDITOR
- `GIT_EDITOR`: Same as EDITOR

### Development

- `GOPATH`: `$HOME/Library/go`
- `LG_WEBOS_TV_SDK_HOME`: WebOS TV SDK location
- `BAT_THEME`: Matches system theme

## Abbreviations and Aliases

### General

- `e`: Open Neovim
- `y`: Open Yazi file manager
- `c`: Clear screen and restart fish
- `q`: Exit shell

### Git

- `gb`: List branches
- `gco`: Checkout
- `gp`: Push
- `gl`: Pull
- And many more git flow related abbreviations

### Development

- `nr`: npm run
- `cat`: bat (with syntax highlighting)
- Various `ls` alternatives using eza

## Additional Features

- Automatic man page path configuration
- VS Code shell integration
- Custom Git pathspec configuration
- Secret management for API keys and tokens

## Custom Functions

The configuration includes several custom functions organized in the `functions` directory:

### Neovim Related Functions

- `nvim_config_pick`: Interactive function to select and switch between different Neovim configurations
  - Uses `fd` and `fzf` for configuration selection
  - Supports multiple Neovim configurations via `NVIM_APPNAME`
- `nvim_update`: Updates Neovim and its plugins
- `nvim_disable_builtin_colorschemes`: Disables built-in color schemes in Neovim

### Git Related Functions

Located in `functions/git/`:

- `__git.current_branch`: Helper function to get the current Git branch name
- `gbda`: Git branch deletion utility for managing remote branches

### System Management Functions

- `wezterm_update_icon`: Updates WezTerm terminal icon
- `yabai_sudoers`: Manages Yabai window manager sudoers configuration
- `restart_vm`: Utility for restarting virtual machines

### Command Wrappers

Located in `functions/wrappers/`:

- `lazygit`: Wrapper for the lazygit terminal UI for Git
- `btm`: Wrapper for the bottom system monitor
- `grep`: Enhanced grep wrapper

These functions enhance the shell's functionality and provide convenient shortcuts for common tasks. They are automatically loaded when the shell starts.
