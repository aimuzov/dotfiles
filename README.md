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

- [kumiko](docs/kumiko/README.md) - own tiling window manager: workspaces, hotkeys, status bar, window borders and vim modes in one app
- [Karabiner](https://karabiner-elements.pqrs.org) - keyboard customization and complex rules

### Terminal and Editors

- [WezTerm](https://wezfurlong.org/wezterm) - modern terminal emulator
- [Ghostty](https://github.com/mitchellh/ghostty) - minimal terminal emulator
- [neovim](https://github.com/neovim/neovim) - enhanced Vim
- [LazyGit](https://github.com/jesseduffield/lazygit) - Git TUI
- [Visual Studio Code](https://code.visualstudio.com/) - popular code editor
- [Cursor](https://cursor.sh/) - modern code editor with AI assistant

## Repository Structure

```text
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
│   ├── asdf/               # Version manager (legacy)
│   ├── bat/                # Enhanced cat
│   ├── fish/               # Fish shell configuration
│   ├── git/                # Git settings
│   ├── ghostty/            # Terminal emulator
│   ├── homebrew/           # Package manager (Brewfile)
│   ├── karabiner/          # Key remapping
│   ├── kumiko/             # Window manager
│   ├── lazygit/            # Git TUI
│   ├── matterhorn/         # Mattermost client
│   ├── mise/               # Version manager
│   ├── npm/                # Node package manager
│   ├── nvim/               # Neovim editor
│   ├── oh-my-posh/         # Prompt customization
│   ├── raycast/            # Launcher
│   ├── stylus/             # Browser styles
│   ├── vim/                # Vim editor
│   ├── wezterm/            # Terminal emulator
│   ├── yazi/               # File manager
│   ├── zed/                # Code editor
│   └── zsh/                # Zsh shell configuration
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

Detailed documentation is available in the [docs/](docs/) directory with both English and Russian versions:

- [Overview & Architecture](docs/OVERVIEW.md) - Complete system documentation
- [Chezmoi Scripts](docs/chezmoiscripts/README.md) - Setup automation
- [Fish Shell](docs/fish/README.md) ([RU](docs/fish/README.ru.md)) - Shell configuration
- [Git](docs/git/README.md) ([RU](docs/git/README.ru.md)) - Git settings and KeePassXC integration
- [kumiko](docs/kumiko/README.md) ([RU](docs/kumiko/README.ru.md)) - Window manager, hotkeys, bar and borders
- [LazyGit](docs/lazygit/README.md) ([RU](docs/lazygit/README.ru.md)) - Git TUI configuration
- [Mise](docs/mise/README.md) ([RU](docs/mise/README.ru.md)) - Tool version manager
- [Neovim](docs/nvim/README.md) - Editor configuration
- [Oh My Posh](docs/oh-my-posh/README.md) ([RU](docs/oh-my-posh/README.ru.md)) - Prompt customization
- [Yazi](docs/yazi/README.md) ([RU](docs/yazi/README.ru.md)) - File manager

## Useful Links

- [macos-defaults.com](https://macos-defaults.com/) - macOS settings reference
- [chezmoi.io](https://www.chezmoi.io/) - chezmoi documentation

## Repository Activity

![Repo Activity](https://repobeats.axiom.co/api/embed/5f836ec617e98ecfa2c81e02c79aaa806f7bc42e.svg "Repobeats analytics image")
