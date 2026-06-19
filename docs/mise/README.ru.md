# Конфигурация Mise

> 🇬🇧 [English version](README.md)

Эта директория содержит конфигурацию для [mise](https://mise.jdx.dev/) — полиглот менеджера версий инструментов и менеджера окружения разработки.

## Обзор

Mise управляет всеми инструментами разработки и языковыми средами выполнения в этой установке dotfiles. Он заменяет множество менеджеров версий (nvm, rbenv, pyenv и т.д.) единым унифицированным инструментом.

## Файлы

- `config.toml` - Основная конфигурация mise, определяющая все инструменты и версии

## Бэкенды инструментов

Mise поддерживает несколько бэкендов для установки инструментов:

### Бэкенд asdf

Традиционные плагины asdf с пользовательскими репозиториями:

```toml
[alias]
neovim = "asdf:richin13/asdf-neovim"
node = "asdf:asdf-vm/asdf-nodejs"
pipx = "asdf:yozachar/asdf-pipx"
python = "asdf:asdf-community/asdf-python"
ruby = "asdf:asdf-vm/asdf-ruby"
```

### Бэкенд cargo

Rust пакеты из crates.io:

```toml
"cargo:bottom" = "latest"      # Системный монитор
"cargo:eza" = "latest"         # Современная замена ls
"cargo:genact" = "latest"      # Генератор активности
"cargo:tokei" = "latest"       # Статистика кода
"cargo:vivid" = "latest"       # Генератор LS_COLORS
"cargo:yazi-cli" = "latest"    # CLI файлового менеджера
"cargo:yazi-fm" = "latest"     # Файловый менеджер
```

### Бэкенд npm

Node.js пакеты с опциональным отображением exe:

```toml
"npm:@aimuzov/sketchybar-app-font" = { version = "latest", exe = "sketchybar-app-font" }
"npm:@anthropic-ai/claude-code" = { version = "latest" }
```

### Бэкенд pipx

Python CLI приложения в изолированных окружениях:

```toml
"pipx:httpie" = "latest"          # HTTP клиент
"pipx:neovim-remote" = "latest"   # Удаленное управление Neovim
```

### Бэкенд ubi

Прямые релизы с GitHub с автоматическим определением бинарников:

```toml
"ubi:ajeetdsouza/zoxide" = "latest"                              # Прыжки по директориям
"ubi:BurntSushi/ripgrep" = { version = "latest", exe = "rg" }    # Быстрый grep
"ubi:cli/cli" = { version = "latest", exe = "gh" }               # GitHub CLI
"ubi:jesseduffield/lazygit" = "latest"                           # Git TUI
"ubi:junegunn/fzf" = "latest"                                    # Fuzzy finder
"ubi:sharkdp/bat" = "latest"                                     # Cat с крыльями
"ubi:sharkdp/fd" = "latest"                                      # Альтернатива find
"ubi:twpayne/chezmoi" = "latest"                                 # Менеджер dotfiles
```

## Установленные инструменты

### Языки и среды выполнения

```toml
[tools]
bun = "latest"                    # JavaScript среда выполнения
go = "latest"                     # Язык Go
neovim = ["nightly", "stable"]    # Текстовый редактор (несколько версий)
node = "latest"                   # Node.js
pipx = "latest"                   # Установщик Python приложений
pnpm = "latest"                   # Менеджер пакетов Node.js
python = "3.12"                   # Python (конкретная версия)
ruby = "latest"                   # Язык Ruby
rust = "latest"                   # Язык Rust
```

### CLI инструменты

**Управление файлами:**
- `bat` - Cat с подсветкой синтаксиса
- `eza` - Современная замена ls
- `fd` - Дружественный find
- `yazi` - Терминальный файловый менеджер
- `zoxide` - Умная команда cd

**Разработка:**
- `gh` - GitHub CLI
- `glab` - GitLab CLI
- `lazygit` - Терминальный UI для Git
- `difftastic` - Структурный diff инструмент
- `diff-so-fancy` - Читаемые diff

**Поиск и навигация:**
- `fzf` - Fuzzy finder
- `ripgrep` - Быстрая альтернатива grep
- `ast-grep` - Инструмент поиска по коду

**Утилиты:**
- `bottom` - Системный монитор
- `chezmoi` - Менеджер dotfiles
- `glow` - Рендерер Markdown
- `httpie` - HTTP клиент
- `jq` - Процессор JSON
- `ouch` - Утилита для архивов
- `tokei` - Статистика кода

**Специализированные:**
- `nowplaying-cli` - Информация о воспроизводимом в macOS
- `oh-my-posh` - Движок тем приглашения
- `sketchybar-app-font` - Генератор шрифта иконок для SketchyBar

## Использование

### Установка инструментов

```bash
# Установить все инструменты из конфигурации
mise install

# Установить конкретный инструмент
mise install node@latest

# Установить конкретную версию
mise install python@3.11

# Установить из .tool-versions текущей директории
mise install
```

### Список инструментов

```bash
# Список всех установленных инструментов
mise ls

# Список доступных версий для инструмента
mise ls-remote node

# Показать путь установки инструмента
mise where node

# Показать путь к бинарнику инструмента
mise which node
```

### Использование инструментов

```bash
# Использовать инструмент глобально
mise use -g node@latest

# Использовать инструмент для текущей директории
mise use node@20

# Использовать конкретную версию временно
mise exec node@18 -- node script.js
```

### Управление инструментами

```bash
# Обновить все инструменты
mise upgrade

# Обновить конкретный инструмент
mise upgrade node

# Удалить версию инструмента
mise uninstall node@18

# Удалить неиспользуемые инструменты
mise prune
```

### Окружение

```bash
# Показать окружение mise
mise env

# Активировать mise в текущей оболочке
eval "$(mise activate fish)"

# Показать doctor mise (диагностика)
mise doctor

# Показать конфигурацию mise
mise config
```

## Выбор версии

Mise использует несколько источников для определения используемой версии (по порядку):

1. Файл `.tool-versions` в текущей директории
2. Файл `.mise.toml` в текущей директории
3. Глобальная конфигурация (`~/.config/mise/config.toml`)
4. Переменные окружения (`MISE_NODE_VERSION`)

### Версии для конкретного проекта

Создайте `.tool-versions` в директории проекта:

```text
node 20.0.0
python 3.11.0
ruby 3.2.0
```

Или используйте `.mise.toml`:

```toml
[tools]
node = "20"
python = "3.11"
```

## Параметры конфигурации

### Настройки

```toml
[settings]
experimental = true                           # Включить экспериментальные функции
idiomatic_version_file_enable_tools = []     # Инструменты, поддерживающие .nvmrc и т.д.
```

### Специфичные для инструмента параметры

Некоторые инструменты поддерживают дополнительную конфигурацию:

```toml
# Node.js с конкретными параметрами
"npm:package" = {
  version = "latest",
  exe = "binary-name",          # Имя исполняемого файла, если отличается от пакета
  install = "npm install -g"    # Пользовательская команда установки
}

# UBI с указанием провайдера
"ubi:gitlab-org/cli" = {
  version = "latest",
  provider = "gitlab",          # Использовать GitLab вместо GitHub
  exe = "glab"
}
```

## Интеграция

### Fish Shell

Mise активируется в Fish shell через `config.fish.tmpl`:

```fish
# Активировать mise
mise activate fish | source

# Автодополнение
mise completion fish | source
```

### Переменные окружения

Mise автоматически настраивает окружение:
- Добавляет бинарники инструментов в PATH
- Устанавливает специфичные для языка переменные
- Управляет shims

## Производительность

### Кэширование

Mise кэширует информацию об инструментах для производительности:
- Определение версии
- Расположение бинарников
- Настройка окружения

Расположение кэша: `~/.cache/mise/`

### Ленивая загрузка

Инструменты загружаются лениво при необходимости:
- Минимальное время запуска оболочки
- Быстрое переключение директорий
- Эффективное переключение версий

## Расширенное использование

### Пользовательские определения инструментов

Добавьте пользовательские инструменты в конфигурацию:

```toml
[tools]
"ubi:user/repo" = { version = "latest", exe = "binary" }
```

### Конфигурация для конкретного окружения

```toml
[env]
NODE_ENV = "development"
RUST_BACKTRACE = "1"
```

### Исполнитель задач

Mise может выполнять задачи, определенные в `.mise.toml`:

```toml
[tasks.dev]
run = "npm run dev"

[tasks.build]
run = "npm run build"
```

Запуск: `mise run dev`

## Миграция

### Из asdf

Mise совместим с asdf:
- Читает файлы `.tool-versions`
- Использует ту же экосистему плагинов
- Может сосуществовать с asdf

### Из nvm/rbenv/pyenv

Конвертируйте файлы версий:

```bash
# .nvmrc → .tool-versions
echo "node $(cat .nvmrc)" > .tool-versions

# .ruby-version → .tool-versions
echo "ruby $(cat .ruby-version)" >> .tool-versions
```

## Устранение неполадок

### Инструмент не найден после установки

- Убедитесь, что mise активирован: `mise doctor`
- Проверьте PATH: `echo $PATH | grep mise`
- Перезагрузите оболочку: `exec fish`

### Версия не переключается

- Проверьте `.tool-versions` в директории
- Проверьте глобальную конфигурацию: `mise config`
- Принудительно перезагрузите: `mise reshim`

### Ошибки сборки

- Проверьте зависимости: `mise doctor`
- Установите инструменты сборки: `xcode-select --install`
- Проверьте логи: `~/.cache/mise/logs/`

### Низкая производительность

- Отключите неиспользуемые бэкенды
- Уменьшите количество плагинов
- Очистите кэш: `rm -rf ~/.cache/mise/`

## Лучшие практики

### Закрепление версий

Закрепите версии в проектах:

```toml
# .mise.toml в корне проекта
[tools]
node = "20.0.0"  # Конкретная версия
python = "3.12"  # Версия major.minor
```

### Глобальное vs локальное

- **Глобальное**: Инструменты разработки (gh, lazygit, fzf)
- **Локальное**: Среды выполнения проектов (node, python, ruby)

### Организация инструментов

Группируйте связанные инструменты:

```toml
# CLI утилиты через cargo
"cargo:eza" = "latest"
"cargo:bat" = "latest"

# Инструменты разработки через ubi
"ubi:cli/cli" = "latest"
"ubi:jesseduffield/lazygit" = "latest"
```

## Ссылки

- [Документация Mise](https://mise.jdx.dev/)
- [Mise на GitHub](https://github.com/jdx/mise)
- [Справочник по бэкендам](https://mise.jdx.dev/dev-tools/backends/)
- [Справочник по конфигурации](https://mise.jdx.dev/configuration.html)
