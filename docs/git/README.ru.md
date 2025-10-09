# Конфигурация Git

> 🇬🇧 [English version](README.md)

Эта директория содержит конфигурацию Git для репозитория dotfiles.

## Обзор

Конфигурация Git с интегрированным управлением секретами через KeePassXC и улучшенными инструментами diff/merge.

## Файлы

- `config.tmpl` - Основная конфигурация Git (шаблон chezmoi)
- `ignore` - Глобальные паттерны gitignore

## Возможности

### Интеграция с KeePassXC

Секреты управляются безопасно через KeePassXC и внедряются через шаблоны chezmoi:

```toml
# .chezmoi.toml.tmpl
[keepassxc]
  database = "~/Library/Mobile Documents/com~apple~CloudDocs/Secrets/vaults/secrets.kdbx"
```

Файл `config.tmpl` использует интеграцию chezmoi с KeePassXC для получения секретов:

```git
[user]
  name = {{ (keepassxcAttribute "Git" "username").Text }}
  email = {{ (keepassxcAttribute "Git" "email").Text }}
```

**Хранимые секреты:**

- Имя пользователя и email для Git
- Имя пользователя и токен GitHub
- Имя пользователя и токен GitLab
- Ключ подписи GPG

### Улучшенный инструмент Diff

Использует [diff-so-fancy](https://github.com/so-fancy/diff-so-fancy) для красивых, читаемых diff:

```git
[core]
  pager = diff-so-fancy | less --tabs=4 -RFX
```

**Возможности:**

- Подсветка синтаксиса
- Улучшенное форматирование
- Повышенная читаемость
- Заголовки файлов с четким разделением

### Пользовательский инструмент Merge

Настроен для использования Neovim с трехсторонним diff:

```git
[merge]
  tool = nvim

[mergetool "nvim"]
  cmd = nvim +"DiffviewOpen $branches" +tabonly
```

**Преимущества:**

- Визуальное трехстороннее слияние
- Знакомые vim-привязки клавиш
- Эффективное разрешение конфликтов
- Показывает базовую, локальную и удаленную версии

### Глобальный Gitignore

Файл `ignore` содержит паттерны для файлов, специфичных для проекта, которые должны быть исключены глобально:

```gitignore
.mise.toml                        # Версии инструментов mise для конкретного проекта
**/.claude/settings.local.json    # Локальные настройки Claude Code
```

Эти паттерны исключают:
- **`.mise.toml`** - Переопределения версий инструментов для проекта (личная настройка разработки)
- **`.claude/settings.local.json`** - Локальная конфигурация Claude Code (специфична для машины)

**Настроено в git:**

```git
[core]
  excludesfile = ~/.config/git/ignore
```

## Основные моменты конфигурации

### Настройки пользователя

```git
[user]
  name = Your Name (из KeePassXC)
  email = your.email@example.com (из KeePassXC)
  signingkey = GPG_KEY_ID (из KeePassXC)

[commit]
  gpgsign = true  # Подписывать все коммиты с помощью GPG
```

### Основные настройки

```git
[core]
  editor = nvim
  autocrlf = input  # Нормализация окончаний строк
  whitespace = trailing-space,space-before-tab
  pager = diff-so-fancy | less --tabs=4 -RFX
```

### Алиасы

Общие алиасы Git для продуктивности:

```git
[alias]
  st = status -sb
  co = checkout
  br = branch
  ci = commit
  unstage = reset HEAD --
  last = log -1 HEAD
  visual = log --graph --oneline --all
```

### Поведение Push/Pull

```git
[push]
  default = current        # Push текущей ветки с тем же именем
  followTags = true        # Push тегов вместе с коммитами

[pull]
  rebase = true           # Rebase вместо merge при pull
  ff = only               # Только fast-forward
```

### Настройки Rebase

```git
[rebase]
  autoStash = true        # Автоматически stash изменений
  autoSquash = true       # Авто-squash fixup коммитов
```

### Настройки Diff

```git
[diff]
  tool = nvimdiff
  algorithm = patience    # Лучший алгоритм diff
  colorMoved = zebra      # Подсветка перемещенных строк

[diff "bin"]
  textconv = hexdump -v -C  # Показать бинарные diff в hex
```

## Использование

### Просмотр конфигурации

```bash
# Показать всю конфигурацию git
git config --list

# Показать конфигурацию из конкретного файла
git config --file ~/.config/git/config --list

# Показать конкретное значение
git config user.name
```

### Использование diff-so-fancy

```bash
# Просмотр diff с diff-so-fancy
git diff

# Сравнение веток
git diff main..feature

# Показать изменения коммита
git show HEAD
```

### Использование инструмента Merge в Neovim

```bash
# При возникновении конфликтов
git merge feature-branch

# Открыть инструмент слияния
git mergetool

# В Neovim:
# - Левое окно: LOCAL (ваши изменения)
# - Центральное окно: BASE (общий предок)
# - Правое окно: REMOTE (входящие изменения)
# - Нижнее окно: MERGED (результат)
```

**Команды слияния в Neovim:**

- `:diffget LOCAL` - Получить изменения из локальной версии
- `:diffget REMOTE` - Получить изменения из удаленной версии
- `:diffget BASE` - Получить изменения из базовой версии
- `:wqa` - Сохранить и выйти из всех окон

### Управление секретами

Секреты автоматически загружаются из KeePassXC при выполнении:

```bash
chezmoi apply
```

**Для обновления секретов:**

1. Обновите запись в KeePassXC
2. Выполните `chezmoi apply` для регенерации `~/.config/git/config`
3. Проверьте с помощью `git config user.email`

### Добавление глобальных игнорируемых файлов

Отредактируйте `~/.config/git/ignore`:

```bash
chezmoi edit ~/.config/git/ignore
```

Или напрямую:

```bash
echo "*.log" >> ~/.config/git/ignore
```

## Интеграция

### С Fish Shell

Fish shell включает аббревиатуры и функции Git:

- `gb` - Список веток
- `gco` - Checkout
- `gp` - Push
- `gl` - Pull
- Полный список см. в `dot_config/fish/config.fish.tmpl`

### С LazyGit

LazyGit учитывает конфигурацию git:

- Использует diff-so-fancy для diff
- Учитывает настройки подписи GPG
- Использует настроенный редактор

### С Chezmoi

Конфигурация Git управляется chezmoi:

- Шаблон обрабатывается при `chezmoi apply`
- Секреты внедряются из KeePassXC
- Изменения отслеживаются в репозитории dotfiles

## Устранение неполадок

### Секреты не загружаются

- Убедитесь, что база данных KeePassXC разблокирована
- Проверьте путь к базе данных в `.chezmoi.toml.tmpl`
- Проверьте, что имена записей совпадают в KeePassXC
- Запустите `chezmoi apply -v` для подробного вывода

### diff-so-fancy не работает

- Проверьте установку: `which diff-so-fancy`
- Проверьте установку mise: `mise ls | grep diff-so-fancy`
- Переустановите: `mise install ubi:so-fancy/diff-so-fancy`

### Инструмент Merge не открывается

- Проверьте, что Neovim установлен: `which nvim`
- Проверьте конфигурацию git: `git config merge.tool`
- Попробуйте ручное слияние: `git mergetool --tool=nvim`

### Ошибка подписи GPG

- Проверьте ключ GPG: `gpg --list-secret-keys`
- Проверьте ключ подписи: `git config user.signingkey`
- Проверьте подпись: `echo "test" | gpg --sign`

## Замечания по безопасности

- Никогда не коммитьте сгенерированный файл `~/.config/git/config` (содержит секреты)
- Коммитьте только файл шаблона `config.tmpl`
- Храните базу данных KeePassXC в безопасности и делайте резервные копии
- Периодически обновляйте токены в KeePassXC
- При необходимости используйте разные токены для разных машин

## Расширенная конфигурация

### Переопределения для конкретного репозитория

Конфигурация Git имеет три уровня:

1. Системный: `/etc/gitconfig`
2. Глобальный: `~/.config/git/config` (эта конфигурация)
3. Локальный: `.git/config` (для конкретного репозитория)

Локальная конфигурация переопределяет глобальную:

```bash
cd /path/to/repo
git config user.email "work@example.com"  # Только для этого репозитория
```

### Условные включения

Добавьте в `config.tmpl` для разделения рабочих/личных настроек:

```git
[includeIf "gitdir:~/work/"]
  path = ~/.config/git/config-work

[includeIf "gitdir:~/personal/"]
  path = ~/.config/git/config-personal
```

### Пользовательские драйверы Diff

Для конкретных типов файлов:

```git
[diff "json"]
  textconv = jq .

[diff "image"]
  textconv = exiftool
```

## Ссылки

- [Документация Git](https://git-scm.com/doc)
- [diff-so-fancy](https://github.com/so-fancy/diff-so-fancy)
- [KeePassXC](https://keepassxc.org/)
- [Шаблон Chezmoi для Git](https://www.chezmoi.io/user-guide/password-managers/keepassxc/)
