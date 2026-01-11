# CLAUDE.md

Этот файл содержит инструкции для Claude Code (claude.ai/code) при работе с кодом в этом репозитории.

## Краткий справочник

Это личный репозиторий dotfiles для macOS, управляемый с помощью [chezmoi](https://www.chezmoi.io/). Подробная документация доступна в [docs/OVERVIEW.md](docs/OVERVIEW.md).

### Основная информация

**Тип репозитория:** Dotfiles, управляемые через chezmoi
**Целевая ОС:** macOS
**Основные технологии:** Fish shell, Yabai, SketchyBar, Neovim, mise

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

# Перезапустить сервисы после изменения конфигов
yabai --restart-service    # после правок dot_config/yabai/
sketchybar --reload        # после правок dot_config/sketchybar/
skhd --restart-service     # после правок dot_config/skhd/
```

### Соглашения о коммитах

Используются conventional commits со scope из `.commitlintrc.js`:

**Component scopes:** `asdf`, `bat`, `borders`, `brew`, `claude`, `chezmoi`, `fish`, `ghostty`, `git`, `gitconfig`, `karabiner`, `lazygit`, `mise`, `nvim`, `oh-my-posh`, `raycast`, `sketchybar`, `skhd`, `ssh`, `svim`, `termscp`, `them-switcher`, `time`, `vscode`, `wezterm`, `yabai`, `yazi`, `zed`, `zrok`, `zsh`

**Generic scopes:** `other`, `shell`, `install-script`

Формат: `type(scope): description`

Пример: `feat(nvim): add new keybinding for LSP actions`

### Ключевые директории

- `.chezmoiscripts/` - Скрипты установки (Fish shell, запускаются после chezmoi apply)
- `.chezmoiexternals/` - Внешние зависимости (плагины для fish, yazi, nvim)
- `dot_config/` - Конфигурации приложений (становится `~/.config/`)
- `dot_bin/` - Пользовательские скрипты
- `dot_bin/raycast/` - Raycast script commands (становится `~/.bin/raycast/`)
- `docs/` - Документация
- `assets/` - Статические файлы для документации

### Основные компоненты

- **Neovim** - Конфигурация LazyVimx, стабильная и nightly версии
- **Fish Shell** - Пользовательские функции, соблюдение XDG, переключение тем
- **Yabai** - Тайловый менеджер окон с автоматическим созданием рабочих областей
- **SketchyBar** - Статус-бар на основе Lua с модульными элементами
- **skhd** - Демон горячих клавиш для управления окнами
- **SketchyVim** - Системная навигация в стиле Vim с поддержкой русской раскладки
- **Git** - Интеграция с KeePassXC для секретов, подпись GPG
- **mise** - Менеджер инструментов разработки (замена asdf)
- **Raycast Scripts** - Команды для Raycast (управление Tailscale, перезапуск сервисов, лаунчеры)

### Рабочий процесс разработки

1. **Добавить новый инструмент:** Обновить `dot_config/mise/config.toml` → `mise install` → коммит со scope `mise`
2. **Добавить новую конфигурацию:** Добавить в `dot_config/` → проверить через `chezmoi diff` → `chezmoi apply` → коммит с соответствующим scope
3. **Изменить SketchyBar:** Отредактировать `dot_config/sketchybar/items/` → `sketchybar --reload`
4. **Протестировать Yabai:** Отредактировать `dot_config/yabai/executable_yabairc` → `yabai --restart-service`

### Структура документации

- [Обзор и Архитектура](docs/OVERVIEW.md) - Полная документация (на английском)
- [Скрипты Chezmoi](docs/chezmoiscripts/README.md) - Автоматизация установки
- Документация компонентов (русский и английский):
  - [Fish Shell](docs/fish/README.md) ([RU](docs/fish/README.ru.md))
  - [Git](docs/git/README.md) ([RU](docs/git/README.ru.md))
  - [LazyGit](docs/lazygit/README.md) ([RU](docs/lazygit/README.ru.md))
  - [Mise](docs/mise/README.md) ([RU](docs/mise/README.ru.md))
  - [Neovim](docs/nvim/README.md)
  - [Oh My Posh](docs/oh-my-posh/README.md) ([RU](docs/oh-my-posh/README.ru.md))
  - [Raycast](docs/raycast/README.md) ([RU](docs/raycast/README.ru.md))
  - [SketchyBar](docs/sketchybar/README.md) ([RU](docs/sketchybar/README.ru.md))
  - [skhd](docs/skhd/README.md) ([RU](docs/skhd/README.ru.md))
  - [SketchyVim](docs/svim/README.md) ([RU](docs/svim/README.ru.md))
  - [Yabai](docs/yabai/README.md) ([RU](docs/yabai/README.ru.md))
  - [Yazi](docs/yazi/README.md) ([RU](docs/yazi/README.ru.md))
