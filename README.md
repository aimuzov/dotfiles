# Dotfiles

<p>
<img src="https://img.shields.io/badge/platform-macos-lightgrey?logo=apple" alt="Platform" />
<a href="https://www.chezmoi.io/"><img src="https://img.shields.io/badge/managed%20by-chezmoi-yellow?logo=chezmoi" alt="Chezmoi" /></a>
<a href="https://github.com/aimuzov/dotfiles/commits"><img src="https://img.shields.io/github/last-commit/aimuzov/dotfiles?color=orange" alt="Last commit" /></a>
<a href="https://github.com/aimuzov/dotfiles/blob/main/LICENSE"><img src="https://img.shields.io/github/license/aimuzov/dotfiles?color=blue" alt="License" /></a>
<a href="https://github.com/aimuzov/dotfiles/stargazers"><img src="https://img.shields.io/github/stars/aimuzov/dotfiles?color=gray" alt="GitHub stars" /></a>
</p>

> ⚠️ **Note**: This documentation is under development and may be incomplete or contain inaccuracies. Structure and content are subject to change.
>
> [🇷🇺 Русская версия](README.ru.md)

My personal macOS configuration managed with [chezmoi](https://www.chezmoi.io/).

## Table of Contents

- [Installation](#installation)
- [Tools Used](#tools-used)
- [Repository Structure](#repository-structure)
- [Useful Links](#useful-links)

## Installation

### First Boot

To set up the environment, run the following commands:

```sh
# Install Xcode Command Line Tools
xcode-select --install

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Install essential tools
brew install mise fish
brew install --cask keepassxc

# Install and initialize chezmoi
mise install ubi:twpayne/chezmoi
$(mise where ubi:twpayne/chezmoi)/bin/chezmoi init --apply aimuzov
```

## Tools Used

### System Tools

- [Yabai](https://github.com/koekeishiya/yabai) - tiling window manager for macOS
- [skhd](https://github.com/koekeishiya/skhd) - hotkey daemon for Yabai
- [Karabiner](https://karabiner-elements.pqrs.org) - keyboard customization and complex rules
- [SketchyBar](https://github.com/FelixKratz/SketchyBar) - customizable status bar
- [JankyBorders](https://github.com/FelixKratz/JankyBorders) - visual window borders

### Terminal and Editors

- [WezTerm](https://wezfurlong.org/wezterm) - modern terminal emulator
- [Ghostty](https://github.com/mitchellh/ghostty) - minimal terminal emulator
- [neovim](https://github.com/neovim/neovim) - enhanced Vim
- [SketchyVim](https://github.com/FelixKratz/SketchyVim) - vim-like hotkeys for macOS
- [LazyGit](https://github.com/jesseduffield/lazygit) - Git TUI
- [Visual Studio Code](https://code.visualstudio.com/) - popular code editor
- [Cursor](https://cursor.sh/) - modern code editor with AI assistant

## Repository Structure

```
.
├── README.md                # Main documentation
├── .chezmoi.toml.tmpl      # Chezmoi configuration template
├── .chezmoiignore          # Ignored files for chezmoi
├── .chezmoiscripts/        # Chezmoi automation scripts
├── .chezmoiexternals/      # Chezmoi external dependencies
├── .commitlintrc.js        # Commit rules
├── .gitignore              # Git ignored files
├── .repro/                 # Repro configuration
├── dot_bin/                # User scripts
├── dot_config/             # Configuration files
│   ├── asdf/               # Version manager
│   ├── bat/                # Enhanced cat
│   ├── borders/            # Window borders
│   ├── fish/               # Shell configuration
│   ├── git/                # Git settings
│   ├── ghostty/            # Terminal emulator
│   ├── homebrew/           # Package manager
│   ├── karabiner/          # Key remapping
│   ├── lazygit/            # Git TUI
│   ├── matterhorn/         # Terminal emulator
│   ├── mise/               # Version manager
│   ├── nvim/               # Editor
│   ├── nvim-lazyvimx/      # Neovim configuration
│   ├── oh-my-posh/         # Prompt customization
│   ├── raycast/            # Launcher
│   ├── sketchybar/         # Status bar
│   ├── skhd/               # Hotkeys
│   ├── stylus/             # Styling
│   ├── svim/               # Vim-like keys
│   ├── wezterm/            # Terminal emulator
│   ├── yabai/              # Window manager
│   ├── yazi/               # File manager
│   └── zed/                # Another editor
├── dot_default-gems        # Ruby gems
├── dot_gitconfig           # Global git settings
├── dot_hushlogin           # Disable login message
├── dot_mise.toml           # Mise configuration
├── dot_ssh/                # SSH configuration
├── dot_zshenv              # Environment variables
├── dot_zshrc.tmpl          # Zsh configuration template
├── package.json            # Node.js dependencies
├── private_dot_gnupg/      # Private keys
├── private_dot_npmrc.tmpl  # NPM configuration template
├── private_dot_zrok/       # Private zrok settings
└── private_Library/        # Private macOS settings
```

### Configuration Documentation

- [Fish Shell](dot_config/fish/README.md) - Shell configuration and customization
- [SketchyBar](dot_config/sketchybar/README.md) - Status bar configuration and modules
- [Yabai](dot_config/yabai/README.md) - Window manager configuration and tiling
- [Yazi](dot_config/yazi/README.md) - File manager configuration and plugins

## Useful Links

- [macos-defaults.com](https://macos-defaults.com/) - macOS settings reference
- [chezmoi.io](https://www.chezmoi.io/) - chezmoi documentation
- [Yabai Wiki](https://github.com/koekeishiya/yabai/wiki) - Yabai documentation
- [SketchyBar Wiki](https://github.com/FelixKratz/SketchyBar/wiki) - SketchyBar documentation

## Repository Activity

![Repo Activity](https://repobeats.axiom.co/api/embed/5f836ec617e98ecfa2c81e02c79aaa806f7bc42e.svg "Repobeats analytics image")
