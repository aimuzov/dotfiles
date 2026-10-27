# CLAUDE.md

Этот файл содержит инструкции для Claude Code (claude.ai/code) при работе с кодом в этом репозитории.

## Краткий справочник

Это личный репозиторий dotfiles для macOS, управляемый с помощью [chezmoi](https://www.chezmoi.io/). Подробная документация доступна в [docs/OVERVIEW.md](docs/OVERVIEW.md).

### Структура репозитория

Репозиторий использует `.chezmoiroot` для указания `home/` как корня исходного состояния chezmoi. Это означает:
- Все файлы dotfiles находятся в директории `home/`
- Документация и ресурсы хранятся вне `home/` (в `docs/`, `assets/`)
- Chezmoi управляет только содержимым `home/`

### ⚠️ ВАЖНЫЕ ОГРАНИЧЕНИЯ ДЛЯ CLAUDE

**НИКОГДА не используй следующие команды:**

- `chezmoi apply` - требует пароль KeePassXC для обработки шаблонов
- `chezmoi status` - требует пароль KeePassXC для обработки шаблонов
- `chezmoi diff` - требует пароль KeePassXC для обработки шаблонов

**Рабочий процесс для Claude:**

1. Редактируй файлы напрямую в репозитории dotfiles (`/Users/aimuzov/Projects/aimuzov/dotfiles/home/`)
2. Файлы в `home/dot_config/` уже находятся в исходном репозитории
3. Попроси пользователя запустить `chezmoi apply`
4. После правки `kumiko.toml` ничего перезапускать не нужно: kumiko перечитывает конфиг сам

### Основная информация

**Тип репозитория:** Dotfiles, управляемые через chezmoi
**Целевая ОС:** macOS
**Основные технологии:** Fish shell, kumiko, Neovim, mise

### Соглашения об именовании в Chezmoi

- Префикс `dot_` → `.` (например, `dot_config` → `.config`)
- Префикс `private_` → убирает права доступа для группы и других пользователей (permissions 600/700)
- Суффикс `.tmpl` → файл обрабатывается как шаблон (с переменными, условиями, функциями)
- Префикс `executable_` → исполняемые файлы

### Основные команды для работы с репозиторием

```bash
# Посмотреть какие изменения будут применены
chezmoi diff

# Применить изменения в систему
chezmoi apply

# Проверить статус (что изменено)
chezmoi status

# Проверить kumiko после правок dot_config/kumiko/ (конфиг перечитывается сам)
kumiko status
```

### Соглашения о коммитах

Используются conventional commits со scope из `.commitlintrc.js`:

**Component scopes:** `asdf`, `bat`, `brew`, `claude`, `chezmoi`, `fish`, `ghostty`, `git`, `gitconfig`, `karabiner`, `kumiko`, `lazygit`, `mise`, `nvim`, `oh-my-posh`, `projects`, `raycast`, `ssh`, `termscp`, `them-switcher`, `time`, `vscode`, `warp`, `wezterm`, `yazi`, `zed`, `zrok`, `zsh`

**Generic scopes:** `other`, `shell`, `install-script`

Формат: `type(scope): description`

Пример: `feat(nvim): add new keybinding for LSP actions`

### Ключевые директории

Все пути ниже относительно корня репозитория:

- `home/.chezmoiscripts/` - Скрипты установки (Fish shell, запускаются после chezmoi apply)
- `home/.chezmoiexternals/` - Внешние зависимости (плагины для fish, yazi, nvim)
- `home/dot_config/` - Конфигурации приложений (становится `~/.config/`)
- `home/dot_bin/` - Пользовательские скрипты
- `home/dot_bin/raycast/` - Raycast script commands (становится `~/.bin/raycast/`)
- `home/dot_claude/` - Конфигурация Claude Code (становится `~/.claude/`)
- `home/dot_claude/mcp.json.tmpl` - Определения MCP серверов (единый источник правды)
- `home/dot_mcp.json.tmpl` - Тонкая обёртка `{"mcpServers": ...}`, подключает список выше через `includeTemplate`
- `docs/` - Документация (вне home/, не управляется chezmoi)
- `assets/` - Статические файлы для документации

### Основные компоненты

- **Neovim** - Конфигурация LazyVimx, стабильная и nightly версии
- **Fish Shell** - Пользовательские функции, соблюдение XDG, переключение тем
- **kumiko** - Собственный тайловый менеджер окон (`~/Projects/aimuzov/kumiko`): рабочие области, горячие клавиши, бар, рамки и vim-режимы в одном приложении, конфиг `dot_config/kumiko/kumiko.toml`. Заменил yabai, skhd, JankyBorders, SketchyBar и SketchyVim
- **Git** - Интеграция с KeePassXC для секретов, подпись GPG
- **mise** - Менеджер инструментов разработки (замена asdf)
- **Raycast Scripts** - Команды для Raycast (управление Tailscale, загрузка видео с YouTube)

### Рабочий процесс разработки

1. **Добавить новый инструмент:** Обновить `home/dot_config/mise/config.toml` → `mise install` → коммит со scope `mise`
2. **Добавить новую конфигурацию:** Добавить в `home/dot_config/` → проверить через `chezmoi diff` → `chezmoi apply` → коммит с соответствующим scope
3. **Изменить kumiko:** Отредактировать `home/dot_config/kumiko/kumiko.toml` → `chezmoi apply` → `kumiko status`. Описание: [docs/kumiko](docs/kumiko/README.ru.md)
4. **Добавить MCP сервер:** Правится в ДВУХ файлах — `home/dot_config/mise/config.toml` (`[tools]`, установка пакета) и `home/dot_claude/mcp.json.tmpl` (определение сервера)

### Структура документации

- [Обзор и Архитектура](docs/OVERVIEW.md) - Полная документация (на английском)
- [Скрипты Chezmoi](docs/chezmoiscripts/README.md) - Автоматизация установки
- Документация компонентов (русский и английский):
  - [Fish Shell](docs/fish/README.md) ([RU](docs/fish/README.ru.md))
  - [Git](docs/git/README.md) ([RU](docs/git/README.ru.md))
  - [kumiko](docs/kumiko/README.md) ([RU](docs/kumiko/README.ru.md))
  - [LazyGit](docs/lazygit/README.md) ([RU](docs/lazygit/README.ru.md))
  - [Mise](docs/mise/README.md) ([RU](docs/mise/README.ru.md))
  - [Neovim](docs/nvim/README.md)
  - [Oh My Posh](docs/oh-my-posh/README.md) ([RU](docs/oh-my-posh/README.ru.md))
  - [Raycast](docs/raycast/README.md) ([RU](docs/raycast/README.ru.md))
  - [Yazi](docs/yazi/README.md) ([RU](docs/yazi/README.ru.md))
