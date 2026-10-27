# Обзор Dotfiles

> [🇬🇧 English version](OVERVIEW.md)

Это личный репозиторий dotfiles для macOS, управляемый с помощью [chezmoi](https://www.chezmoi.io/). Конфигурация включает полное окружение рабочего стола с kumiko (тайлинг, горячие клавиши, панель состояния и рамки окон в одном приложении), Neovim, Fish shell и различные инструменты для разработки.

## Структура репозитория

### Корневая директория Chezmoi

Этот репозиторий использует `.chezmoiroot` для указания поддиректории как корня исходного состояния. Фактические dotfiles находятся в директории `home/`:

```text
dotfiles/
├── .chezmoiroot          # Содержит "home" - указывает корень исходников
├── home/                 # Корень исходного состояния (chezmoi управляет этим)
│   ├── .chezmoi.toml.tmpl
│   ├── .chezmoiscripts/
│   ├── .chezmoiexternals/
│   ├── dot_config/
│   ├── dot_bin/
│   └── ...
├── docs/                 # Документация (не управляется chezmoi)
├── assets/               # Изображения для документации
└── ...
```

Эта структура позволяет хранить документацию, ресурсы и конфигурационные файлы отдельно от фактических dotfiles, которыми управляет chezmoi.

### Соглашения об именовании файлов Chezmoi

Файлы и директории используют соглашения об именовании chezmoi:

- Префикс `dot_` → становится `.` (например, `dot_config` → `.config`)
- Префикс `private_` → файлы исключаются из git и имеют ограниченные права доступа
- Суффикс `.tmpl` → файлы обрабатываются как шаблоны с переменными chezmoi
- Префикс `executable_` → файлы делаются исполняемыми

### Ключевые директории

Все пути ниже указаны относительно `home/` (корня исходников chezmoi):

- `home/.chezmoiscripts/` - Автоматические скрипты установки, запускаемые после chezmoi apply
  - Скрипты упорядочены с префиксами типа `run_once_after_1_`, `run_once_after_2_` и т.д.
  - Скрипты `run_once_weekly_*` запускаются периодически
  - Все скрипты написаны на Fish shell с расширением `.fish.tmpl`
- `home/.chezmoiexternals/` - Внешние зависимости, управляемые chezmoi
  - `fish.toml` - Плагины Fish shell
  - `yazi.toml` - Плагины файлового менеджера Yazi
  - `nvim.toml` - Внешние конфигурации Neovim
- `home/dot_config/` - Конфигурации приложений (становится `~/.config/`)
- `home/dot_bin/` - Пользовательские скрипты и утилиты
- `home/dot_claude/` - Конфигурация Claude Code (становится `~/.claude/`)
- `home/dot_mcp.json.tmpl` - Централизованная конфигурация MCP серверов
- `docs/` - Документация (вне корня chezmoi)
- `assets/` - Изображения и другие статические файлы для документации

### Основные конфигурации

Все пути ниже указаны относительно `home/` (корня исходников chezmoi):

- **Neovim** (`dot_config/nvim/`) - Использует конфигурацию [LazyVimx](https://github.com/aimuzov/LazyVimx), поддерживает стабильную и nightly версии
- **Fish Shell** (`dot_config/fish/`) - Комплексная оболочка с пользовательскими функциями, соблюдением XDG, переключением тем
- **Zsh** (`dot_config/zsh/`) - Конфигурация оболочки Zsh
- **kumiko** (`dot_config/kumiko/`) - Собственный тайловый менеджер окон: рабочие пространства, горячие клавиши, панель состояния, рамки окон и vim-режимы в текстовых полях, настраивается одним `kumiko.toml`
- **Karabiner** (`dot_config/private_karabiner/`) - Настройка клавиатуры и сложные модификации
- **Git** (`dot_config/git/`) - Конфигурация Git с интеграцией KeePassXC для секретов
- **Yazi** (`dot_config/yazi/`) - Файловый менеджер с темой Catppuccin и пользовательскими плагинами
- **LazyGit** (`dot_config/lazygit/`) - Git TUI с поддержкой темной/светлой темы
- **WezTerm** (`dot_config/wezterm/`) - Конфигурация эмулятора терминала
- **Ghostty** (`dot_config/ghostty/`) - Быстрый эмулятор терминала с quick terminal, Display P3 colorspace, темой Catppuccin
- **Claude Code** (`dot_claude/`) - Конфигурация AI ассистента с MCP серверами
- **Matterhorn** (`dot_config/matterhorn/`) - Терминальный клиент Mattermost
- **Oh My Posh** (`dot_config/oh-my-posh/`) - Движок тем для prompt
- **Raycast** (`dot_bin/raycast/`) - Скриптовые команды для лаунчера продуктивности
  - Управление Tailscale VPN (выбор exit-node, отображение статуса)
  - Загрузка видео с YouTube
  - Подробнее в [документации Raycast](raycast/README.md)
- **Zed** (`dot_config/zed/`) - Конфигурация редактора кода
- **Bat** (`dot_config/bat/`) - Клон cat с подсветкой синтаксиса
- **Vim** (`dot_config/vim/`) - Конфигурация Vim
- **Mise** (`dot_config/mise/`) - Менеджер версий инструментов разработки (замена asdf)
- **Asdf** (`dot_config/asdf/`) - Конфигурация устаревшего менеджера версий
- **Homebrew** (`dot_config/homebrew/`) - Конфигурация пакетного менеджера macOS (Brewfile)
- **NPM** (`dot_config/npm/`) - Конфигурация менеджера пакетов Node
- **Stylus** (`dot_config/stylus/`) - Стили для браузерного расширения

## Основные команды

### Операции Chezmoi

```bash
# Применить изменения из репозитория dotfiles
chezmoi apply

# Отредактировать файл в репозитории dotfiles
chezmoi edit ~/.config/fish/config.fish

# Повторно запустить скрипты установки
chezmoi init --apply

# Посмотреть, что изменится без применения
chezmoi diff

# Добавить новый файл в chezmoi
chezmoi add ~/.config/newapp/config.toml
```

### Управление пакетами

```bash
# Установить все пакеты (Homebrew + инструменты mise)
brew bundle install --file $XDG_CONFIG_HOME/homebrew/Brewfile
mise install -y

# Обновить инструменты mise
mise upgrade

# Обновить пакеты Homebrew
brew update && brew upgrade

# Список установленных инструментов mise
mise ls

# Установить конкретный инструмент
mise use -g node@latest
```

### Инструменты разработки

Все инструменты разработки управляются через mise (настроены в `dot_config/mise/config.toml`):

**Языки программирования:**

- Node.js (latest), Python (3.12), Ruby (latest), Go (latest), Rust (latest), Bun (latest)
- Neovim (стабильная и nightly версии через пользовательский плагин asdf)

**Менеджеры пакетов:**

- pnpm (Node.js)
- pipx (Python)
- cargo (Rust)

**Бэкенды установки инструментов:**

- `asdf:` - Традиционные плагины asdf
- `cargo:` - Пакеты Rust (eza, yazi, bottom, tokei, vivid, genact)
- `npm:` - Пакеты Node (Claude Code, MCP-серверы)
- `pipx:` - CLI инструменты Python (httpie, neovim-remote)
- `ubi:` - Прямые релизы с GitHub (ripgrep, fd, bat, fzf, lazygit, chezmoi и т.д.)

### Управление окнами и окружение рабочего стола

kumiko одним приложением заменяет yabai, skhd, JankyBorders, SketchyBar и SketchyVim. Устройство конфига и горячие клавиши описаны в [kumiko](kumiko/README.ru.md).

```bash
kumiko status    # модули, разрешения, путь к конфигу и последняя ошибка в нём
kumiko reload    # перечитать kumiko.toml (происходит и само при изменении файла)
kumiko query workspaces
```

## Соглашения о коммитах

Этот репозиторий использует commitlint с conventional commits. Допустимые scope определены в `.commitlintrc.js`:

- Scope компонентов: `asdf`, `bat`, `brew`, `claude`, `chezmoi`, `fish`, `ghostty`, `git`, `gitconfig`, `karabiner`, `kumiko`, `lazygit`, `mise`, `nvim`, `oh-my-posh`, `projects`, `raycast`, `spicetify`, `ssh`, `termscp`, `them-switcher`, `time`, `vscode`, `warp`, `wezterm`, `yazi`, `zed`, `zrok`, `zsh`
- Общие scope: `other`, `shell`, `install-script`

Коммиты должны следовать формату: `type(scope): description`

Пример: `feat(nvim): add new keybinding for LSP actions`

Используйте `npm run commit` для интерактивного создания сообщения коммита.

## Заметки об архитектуре

### Система шаблонов Chezmoi

Файлы с расширением `.tmpl` обрабатываются как шаблоны Go. Общие паттерны:

**Переменные:**

- `{{ .chezmoi.os }}` - Операционная система (обычно "darwin")
- `{{ .chezmoi.homeDir }}` - Домашняя директория пользователя
- `{{ .chezmoi.username }}` - Текущий пользователь
- `{{ .chezmoi.hostname }}` - Имя хоста машины

**Условные блоки:**

```go
{{ if (eq .chezmoi.os "darwin") -}}
# Конфигурация специфичная для macOS
{{ end -}}
```

**Интеграция с KeePassXC для секретов:**

```go
{{ (keepassxcAttribute "entry-name" "attribute-name").Text }}
```

### Управление инструментами Mise

`dot_config/mise/config.toml` определяет все инструменты разработки в формате TOML:

**Псевдонимы инструментов** (короткие имена):

```toml
[alias]
neovim = "asdf:richin13/asdf-neovim"
```

**Версии инструментов:**

```toml
[tools]
node = "latest"
python = "3.12"
neovim = ["nightly", "stable"]  # Поддержка нескольких версий
```

**Инструменты для конкретных бэкендов:**

- `asdf:` - Традиционные плагины asdf с путем к репозиторию
- `cargo:` - Rust пакеты с crates.io
- `npm:` - Node пакеты с опциональным сопоставлением exe
- `pipx:` - CLI приложения Python
- `ubi:` - Релизы с GitHub с автоматическим определением бинарного файла

### Архитектура переключения тем

Всё окружение поддерживает автоматическое переключение темной/светлой темы на основе системного оформления macOS:

**Переменная окружения:**

- `MACOS_IS_DARK` - Устанавливается системой (true/false)

**Компоненты, которые автоматически переключаются:**

- Fish shell (Catppuccin Macchiato/Latte)
- Neovim (через LazyVimx)
- Файловый менеджер Yazi
- LazyGit
- FZF (инструмент поиска)
- Bat (просмотрщик файлов)
- Oh My Posh (prompt)

**Реализация:**

- Fish 4.3+ использует переменную `fish_terminal_color_theme`, которая автоматически обновляется когда современные терминалы (Ghostty, iTerm2, WezTerm) отправляют OSC последовательности
- Функция `reload_theme` в `conf.d/theme_setup.fish` автоматически срабатывает при изменении `fish_terminal_color_theme`
- Файлы кеша для каждой темы хранятся отдельно
- Переменные окружения `MACOS_IS_DARK` и `CATPPUCCIN_FLAVOR` устанавливаются функцией `reload_theme`
- Цветовые схемы для fzf, bat, eza и fish shell перезагружаются автоматически во всех открытых сессиях

### Архитектура Fish Shell

**Структура директорий:**

```text
home/dot_config/fish/
├── config.fish.tmpl          # Основная конфигурация (шаблон для секретов)
├── conf.d/                   # Автоматически загружаемые конфигурации
│   └── recursive_paths.fish  # Настройка путей функций/автодополнений
└── functions/                # Пользовательские функции
    └── core/                 # Основные функции
        ├── git/              # Функции связанные с Git
        ├── wrappers/         # Обертки команд
        └── *.fish            # Отдельные функции
```

**Порядок инициализации:**

1. Переменные окружения устанавливаются в `~/.zshenv` (загружаются первыми, даже для Fish)
2. Скрипты `conf.d/` автоматически загружаются
3. `config.fish.tmpl` основная конфигурация
4. Функции загружаются по требованию из `functions/`

**Ключевые особенности:**

- Соответствие XDG Base Directory
- Рекурсивное обнаружение путей функций/автодополнений
- Кешированная инициализация для производительности (Homebrew, mise, zoxide)
- Vi режим с пользовательскими привязками клавиш
- Автоматическое переключение тем

### Конфигурация Git

Находится в `dot_config/git/config.tmpl`:

- Секреты загружаются из KeePassXC через шаблоны chezmoi (имя пользователя, email, ключ подписи GPG)
- Подпись коммитов GPG включена по умолчанию
- Пользовательский pager: `diff-so-fancy` с настройкой цветов
- Пользовательский diff tool: `difftastic`
- Пользовательский merge tool: Neovim с DiffviewOpen
- Псевдонимы Git:
  - `lg` - Красивый граф лог с цветами
  - `dlog` - Лог с внешним diff через difftastic
  - `dft` - Сокращение для difftool

## Установка

Настройка при первой загрузке (документировано в README.md):

1. Установить Xcode Command Line Tools: `xcode-select --install`
2. Установить Homebrew
3. Установить mise и fish: `brew install mise fish`
4. Установить KeePassXC: `brew install --cask keepassxc`
5. Установить chezmoi через mise: `mise install ubi:twpayne/chezmoi`
6. Инициализировать dotfiles: `$(mise where ubi:twpayne/chezmoi)/bin/chezmoi init --apply aimuzov`

Скрипты chezmoi в `.chezmoiscripts/` автоматически обрабатывают:

1. `run_once_after_1_install-packages.fish.tmpl` - Установка пакетов Homebrew и инструментов mise
2. `run_once_after_2_configure-system.fish.tmpl` - Настройка системных параметров macOS
3. `run_onchange_after_3_setup-dark-signal.fish.tmpl` - Сборка и установка наблюдателя за темой
4. `run_once_after_5_install-workflows.fish.tmpl` - Установка пользовательских рабочих процессов
5. `run_once_after_7_download-cht.fish.tmpl` - Загрузка шпаргалок
6. `run_once_weekly_1_rebuild_cache.fish.tmpl` - Еженедельная перестройка кешей

## Устранение неполадок

### kumiko не работает

- Проверьте, что приложение запущено: `kumiko ping`
- `kumiko status` покажет недостающие разрешения (Accessibility, Input Monitoring) и последнюю ошибку конфига
- Сломанный `kumiko.toml` оставляет в силе прежний конфиг: исправьте ошибку и сохраните файл снова

### Fish Shell не загружает конфигурацию

- Проверьте, что `~/.zshenv` устанавливает `SHELL` и подключает mise
- Проверьте существование директорий XDG: `echo $XDG_CONFIG_HOME`
- Протестируйте конфигурацию: `fish --debug`

### Инструменты Mise не найдены

- Убедитесь, что mise активирован в shell: `mise doctor`
- Проверьте, что PATH включает shims mise: `echo $PATH | grep mise`
- Переустановите инструменты: `mise install -y`

### Тема не переключается

- Проверьте переменную окружения `MACOS_IS_DARK`: `echo $MACOS_IS_DARK`
- Проверьте тему терминала Fish: `echo $fish_terminal_color_theme`
- Убедитесь, что ваш терминал поддерживает OSC последовательности (Ghostty, iTerm2, WezTerm поддерживают)
- Перезагрузите тему вручную: `theme_reload` (или сокращение `tr`)
- Проверьте наличие функции `reload_theme`: `type reload_theme`
- Перезапустите Fish shell, если автоматическое определение не работает

## Рабочий процесс разработки

### Добавление новых инструментов

1. Добавить в `home/dot_config/mise/config.toml` под соответствующий бэкенд
2. Запустить `mise install` для установки
3. Закоммитить изменения со scope `mise`

### Добавление новой конфигурации

1. Добавить файл в соответствующую поддиректорию `home/dot_config/`
2. Использовать соглашения об именовании chezmoi (`dot_`, `private_`, `executable_`, `.tmpl`)
3. Протестировать с `chezmoi diff` перед `chezmoi apply`
4. Закоммитить с соответствующим scope из `.commitlintrc.js`

### Изменение конфига kumiko

1. Отредактировать `home/dot_config/kumiko/kumiko.toml`
2. Выполнить `chezmoi apply`: kumiko перечитает файл сам
3. Проверить результат: `kumiko status`

## Связанная документация

Документация для отдельных компонентов (доступны русская и английская версии):

- [Скрипты Chezmoi](chezmoiscripts/README.md)
- [Конфигурация Claude Code](claude/README.md)
- [Конфигурация Fish Shell](fish/README.md)
- [Терминал Ghostty](ghostty/README.md)
- [Конфигурация Git](git/README.md)
- [Конфигурация kumiko](kumiko/README.ru.md)
- [Конфигурация LazyGit](lazygit/README.md)
- [Конфигурация Mise](mise/README.md)
- [Конфигурация Oh My Posh](oh-my-posh/README.md)
- [Скрипты Raycast](raycast/README.md)
- [Конфигурация Yazi](yazi/README.md)
