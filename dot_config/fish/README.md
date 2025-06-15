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

- Dark mode: Catppuccin Macchiato
- Light mode: Catppuccin Latte

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

- Custom color schemes using Vis

> ⚠️ **Внимание**: Эта документация находится в режиме разработки и может быть неполной или содержать неточности. Структура и содержимое могут меняться.

Мои персональные настройки для macOS, собранные с помощью [chezmoi](https://www.chezmoi.io/).

## Содержание

- [Установка](#установка)
- [Используемые инструменты](#используемые-инструменты)
- [Структура репозитория](#структура-репозитория)
- [Полезные ссылки](#полезные-ссылки)

## Установка

### Первый запуск

Для первоначальной настройки выполните следующие команды:

```sh
# Установка Xcode Command Line Tools
xcode-select --install

# Установка Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Установка основных инструментов
brew install mise fish
brew install --cask keepassxc

# Установка и инициализация chezmoi
mise install ubi:twpayne/chezmoi
$(mise where ubi:twpayne/chezmoi)/bin/chezmoi init --apply aimuzov
```

## Используемые инструменты

### Системные инструменты

- [Yabai](https://github.com/koekeishiya/yabai) - тайловый оконный менеджер для macOS
- [skhd](https://github.com/koekeishiya/skhd) - горячие клавиши для Yabai
- [Karabiner](https://karabiner-elements.pqrs.org) - переназначение клавиш и создание сложных правил
- [SketchyBar](https://github.com/FelixKratz/SketchyBar) - кастомизируемый статус-бар
- [JankyBorders](https://github.com/FelixKratz/JankyBorders) - визуальные границы окон

### Терминал и редакторы

- [WezTerm](https://wezfurlong.org/wezterm) - современный терминальный эмулятор
- [Ghostty](https://github.com/mitchellh/ghostty) - минималистичный терминальный эмулятор
- [neovim](https://github.com/neovim/neovim) - улучшенная версия Vim
- [SketchyVim](https://github.com/FelixKratz/SketchyVim) - vim-подобные горячие клавиши для macOS
- [LazyGit](https://github.com/jesseduffield/lazygit) - TUI для работы с Git
- [Visual Studio Code](https://code.visualstudio.com/) - популярный редактор кода
- [Cursor](https://cursor.sh/) - современный редактор кода с AI-ассистентом

## Структура репозитория

```
.
├── README.md                # Основная документация
├── .chezmoi.toml.tmpl      # Шаблон конфигурации chezmoi
├── .chezmoiignore          # Игнорируемые файлы chezmoi
├── .chezmoiscripts/        # Скрипты для автоматизации chezmoi
├── .chezmoiexternals/      # Внешние зависимости chezmoi
├── .commitlintrc.js        # Правила для коммитов
├── .gitignore              # Игнорируемые файлы git
├── .repro/                 # Конфигурация repro
├── dot_bin/                # Пользовательские скрипты
├── dot_config/             # Конфигурационные файлы
│   ├── asdf/               # Менеджер версий
│   ├── bat/                # Улучшенный cat
│   ├── borders/            # Границы окон
│   ├── fish/               # Конфигурация shell
│   ├── git/                # Настройки git
│   ├── ghostty/            # Терминальный эмулятор
│   ├── homebrew/           # Менеджер пакетов
│   ├── karabiner/          # Переназначение клавиш
│   ├── lazygit/            # tui для git
│   ├── matterhorn/         # Терминальный эмулятор
│   ├── mise/               # Менеджер версий
│   ├── nvim/               # Редактор
│   ├── nvim-lazyvimx/      # Конфигурация neovim
│   ├── oh-my-posh/         # Кастомизация промпта
│   ├── raycast/            # Лаунчер
│   ├── sketchybar/         # Статус бар
│   ├── skhd/               # Горячие клавиши
│   ├── stylus/             # Стилизация
│   ├── svim/               # Vim-подобные клавиши
│   ├── wezterm/            # Терминальный эмулятор
│   ├── yabai/              # Оконный менеджер
│   ├── yazi/               # Файловый менеджер
│   └── zed/                # Еще один редактор
├── dot_default-gems        # Ruby gems
├── dot_gitconfig           # Глобальные настройки git
├── dot_hushlogin           # Отключение приветствия
├── dot_mise.toml           # Конфигурация mise
├── dot_ssh/                # SSH конфигурация
├── dot_zshenv              # Переменные окружения
├── dot_zshrc.tmpl          # Шаблон конфигурации zsh
├── package.json            # Зависимости node.js
├── private_dot_gnupg/      # Приватные ключи
├── private_dot_npmrc.tmpl  # Шаблон npm конфигурации
├── private_dot_zrok/       # Приватные настройки zrok
└── private_Library/        # Приватные настройки macOS
```

## Полезные ссылки

- [macos-defaults.com](https://macos-defaults.com/) - справочник по настройкам macOS
- [chezmoi.io](https://www.chezmoi.io/) - документация по chezmoi
- [Yabai Wiki](https://github.com/koekeishiya/yabai/wiki) - документация по Yabai
- [SketchyBar Wiki](https://github.com/FelixKratz/SketchyBar/wiki) - документация по SketchyBar

## Активность репозитория

![Repo Activity](https://repobeats.axiom.co/api/embed/vid

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
