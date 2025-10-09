# Конфигурация LazyGit

> 🇬🇧 [English version](README.md)

Эта директория содержит конфигурацию для [LazyGit](https://github.com/jesseduffield/lazygit) — простого терминального UI для команд git.

## Обзор

LazyGit предоставляет интуитивный терминальный интерфейс для управления Git-репозиториями. Эта конфигурация включает настройку тем с автоматическим переключением между темным/светлым режимом.

## Файлы

- `config.yml` - Основная конфигурация LazyGit
- `theme-dark.yml` - Цвета темной темы (Catppuccin Macchiato)
- `theme-light.yml` - Цвета светлой темы (Catppuccin Latte)

## Возможности

### Автоматическое переключение тем

LazyGit автоматически переключается между темной и светлой темами на основе внешнего вида системы macOS:

- **Темный режим** → Использует `theme-dark.yml` (Catppuccin Macchiato)
- **Светлый режим** → Использует `theme-light.yml` (Catppuccin Latte)

Тема определяется через переменную окружения `MACOS_IS_DARK`, которая устанавливается конфигурацией Fish shell.

### Структура конфигурации

Файл `config.yml` включает:

```yaml
gui:
  theme:
    selectedLineBgColor:
      - {{ if eq (env "MACOS_IS_DARK") "true" }}
        - "#theme-dark-color"
        {{ else }}
        - "#theme-light-color"
        {{ end }}
```

### Тема Catppuccin

Обе темы используют цветовую схему Catppuccin:

**Catppuccin Macchiato** (темная):
- Rosewater, Flamingo, Pink, Mauve
- Red, Maroon, Peach, Yellow
- Green, Teal, Sky, Sapphire, Blue, Lavender

**Catppuccin Latte** (светлая):
- Те же названия цветов со светлыми вариантами
- Оптимизирована для светлого фона
- Лучший контраст для просмотра при дневном свете

## Использование

### Запуск LazyGit

```bash
# Из любого git-репозитория
lazygit

# Из Fish shell (использует функцию-обертку)
lg
```

### Базовая навигация

**Навигация по панелям:**
- `1-5` - Переключение между панелями (Status, Files, Branches, Commits, Stash)
- `Tab` - Следующая панель
- `Shift+Tab` - Предыдущая панель
- `[` / `]` - Предыдущая/следующая вкладка внутри панели

**Навигация по списку:**
- `j/k` или `↓/↑` - Движение вниз/вверх
- `g/G` - Переход в начало/конец
- `/` - Поиск
- `n/N` - Следующий/предыдущий результат поиска

### Общие операции

**Операции с файлами:**
- `Space` - Stage/unstage файл
- `a` - Stage все файлы
- `d` - Показать diff файла
- `e` - Редактировать файл
- `o` - Открыть файл
- `c` - Закоммитить изменения
- `Shift+c` - Коммит с использованием git-flow

**Операции с ветками:**
- `n` - Создать новую ветку
- `Space` - Переключиться на ветку
- `d` - Удалить ветку
- `r` - Rebase на ветку
- `m` - Слить в текущую ветку
- `f` - Fast-forward ветку

**Операции с коммитами:**
- `s` - Squash коммитов
- `r` - Переименовать коммит
- `d` - Удалить коммит
- `e` - Редактировать коммит
- `p` - Pick коммит (rebase)
- `f` - Fixup коммит

**Операции с удаленным репозиторием:**
- `p` - Pull
- `Shift+p` - Push
- `Shift+f` - Force push
- `f` - Fetch

### Интеграция с Git Flow

LazyGit поддерживает workflow git-flow:
- Создание веток feature/bugfix/hotfix
- Завершение flows с автоматическим слиянием
- Отслеживание flow веток

## Интеграция

### Обертка для Fish Shell

Fish shell включает функцию-обертку (`functions/wrappers/lazygit.fish`), которая:
- Устанавливает соответствующие переменные окружения
- Гарантирует корректную работу определения темы
- Обеспечивает лучшую интеграцию с Fish

### Интеграция с терминалом

LazyGit лучше всего работает в терминалах с поддержкой true color:
- WezTerm ✅
- Ghostty ✅
- iTerm2 ✅
- Terminal.app ⚠️ (ограниченная поддержка цветов)

## Настройка

### Изменение тем

Отредактируйте `theme-dark.yml` или `theme-light.yml`:

```yaml
activeBorderColor:
  - "#89b4fa"  # Синий акцентный цвет
  inactiveBorderColor:
  - "#45475a"  # Тонкий серый
```

После редактирования перезапустите LazyGit для применения изменений.

### Добавление пользовательских команд

Отредактируйте `config.yml` для добавления пользовательских команд:

```yaml
customCommands:
  - key: 'C'
    command: 'git commit --amend --no-edit'
    description: 'Исправить коммит без редактирования'
    context: 'files'
```

### Изменение привязок клавиш

Измените привязки клавиш в `config.yml`:

```yaml
keybinding:
  universal:
    quit: 'q'
    return: 'Esc'
```

## Советы и хитрости

### Быстрые действия

- `x` - Открыть меню для текущего контекста
- `?` - Открыть меню помощи
- `Ctrl+r` - Недавние репозитории
- `Ctrl+s` - Параметры фильтрации
- `:` - Выполнить пользовательскую команду

### Просмотр изменений

- `d` - Просмотр полного diff
- `Enter` - Просмотр деталей файла/коммита
- `w` - Переключить отображение пробелов в diff

### Операции со Stash

- `s` - Stash изменений
- `g` - Pop stash
- `d` - Drop stash
- `Space` - Apply stash

### Фильтрация

- `Ctrl+s` - Открыть меню фильтрации
- Фильтрация по автору, дате, пути и т.д.
- Очистить фильтры с помощью `Esc`

## Устранение неполадок

### Тема не переключается

- Проверьте, что `MACOS_IS_DARK` установлена: `echo $MACOS_IS_DARK`
- Перезапустите Fish shell: `exec fish`
- Проверьте внешний вид macOS: `defaults read -g AppleInterfaceStyle`

### Цвета выглядят неправильно

- Убедитесь, что терминал поддерживает true color
- Проверьте переменную `$TERM`: должна быть `xterm-256color` или лучше
- Обновите эмулятор терминала

### LazyGit не найден

- Проверьте установку: `which lazygit`
- Проверьте установку mise: `mise ls | grep lazygit`
- Переустановите: `mise install ubi:jesseduffield/lazygit`

### Операции Git не работают

- Проверьте конфигурацию git: `git config --list`
- Проверьте настройку SSH ключей
- Проверьте статус репозитория: `git status`

## Справочник по конфигурации

### Основные параметры конфигурации

```yaml
gui:
  showFileTree: true          # Показывать файлы в древовидном виде
  showListFooter: true        # Показывать нижний колонтитул с ярлыками
  showRandomTip: true         # Показывать советы при запуске
  showCommandLog: true        # Показывать выполненные git команды
  mouseEvents: true           # Включить поддержку мыши
  skipUnstageLineWarning: false
  skipStashWarning: false

git:
  paging:
    colorArg: always          # Всегда использовать цвета
    pager: diff-so-fancy      # Использовать diff-so-fancy для diff

  commit:
    signOff: false            # Не подписывать коммиты по умолчанию

  merging:
    manualCommit: false       # Авто-коммит после слияния

refresher:
  refreshInterval: 10         # Обновлять каждые 10 секунд
  fetchInterval: 60           # Получать из удаленного репозитория каждые 60 секунд
```

## Ссылки

- [Документация LazyGit](https://github.com/jesseduffield/lazygit)
- [Тема Catppuccin](https://github.com/catppuccin/catppuccin)
- [Шпаргалка Git Flow](https://danielkummer.github.io/git-flow-cheatsheet/)
