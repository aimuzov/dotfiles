# Dotfiles

<p>
<img src="https://img.shields.io/badge/platform-macos-lightgrey?logo=apple" alt="Platform" />
<a href="https://www.chezmoi.io/"><img src="https://img.shields.io/badge/managed%20by-chezmoi-yellow?logo=chezmoi" alt="Chezmoi" /></a>
<a href="https://github.com/aimuzov/dotfiles/commits"><img src="https://img.shields.io/github/last-commit/aimuzov/dotfiles?color=orange" alt="Last commit" /></a>
<a href="https://github.com/aimuzov/dotfiles/blob/main/LICENSE"><img src="https://img.shields.io/github/license/aimuzov/dotfiles?color=blue" alt="License" /></a>
<a href="https://github.com/aimuzov/dotfiles/stargazers"><img src="https://img.shields.io/github/stars/aimuzov/dotfiles?color=gray" alt="GitHub stars" /></a>
</p>

> ⚠️ **Внимание**: Эта документация находится в режиме разработки и может быть неполной или содержать неточности. Структура и содержимое могут меняться.
>
> [🇬🇧 English version](README.md)

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

```text
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

### Документация по конфигурации

- [Fish Shell](dot_config/fish/README.md) - Настройка и кастомизация shell
- [SketchyBar](dot_config/sketchybar/README.ru.md) - Конфигурация и модули статус-бара
- [Yabai](dot_config/yabai/README.ru.md) - Конфигурация оконного менеджера и тайлинг
- [Yazi](dot_config/yazi/README.ru.md) — Настройки и плагины файлового менеджера

## Полезные ссылки

- [macos-defaults.com](https://macos-defaults.com/) - справочник по настройкам macOS
- [chezmoi.io](https://www.chezmoi.io/) - документация по chezmoi
- [Yabai Wiki](https://github.com/koekeishiya/yabai/wiki) - документация по Yabai
- [SketchyBar Wiki](https://github.com/FelixKratz/SketchyBar/wiki) - документация по SketchyBar

## Активность репозитория

![Repo Activity](https://repobeats.axiom.co/api/embed/5f836ec617e98ecfa2c81e02c79aaa806f7bc42e.svg "Repobeats analytics image")
