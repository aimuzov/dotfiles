# Конфигурация Raycast скриптов

> 🇬🇧 [English version](README.md)

## Содержание

- [Обзор](#обзор)
- [Формат метаданных скрипта](#формат-метаданных-скрипта)
- [Доступные скрипты](#доступные-скрипты)
  - [Выбор Tailscale Exit Node](#выбор-tailscale-exit-node)
  - [Статус Tailscale](#статус-tailscale)
  - [Загрузка видео с YouTube](#загрузка-видео-с-youtube)
  - [Перезапуск сервисов VM](#перезапуск-сервисов-vm)
  - [Запуск Dota 2](#запуск-dota-2)
- [Добавление новых скриптов](#добавление-новых-скриптов)
- [Интеграция с функциями Fish](#интеграция-с-функциями-fish)
- [Решение проблем](#решение-проблем)

## Обзор

Raycast Script Commands — это bash-скрипты, которые интегрируются с Raycast для быстрого выполнения задач через командную палитру. Скрипты используют специальные метаданные в комментариях для настройки отображения и поведения.

### Расположение

- Исходные файлы: `dot_bin/raycast/executable_*.sh`
- После применения chezmoi: `~/.bin/raycast/*.sh`
- Raycast автоматически обнаруживает скрипты в директории `~/.bin/raycast/`

### Управление через chezmoi

Все скрипты управляются через chezmoi:
- Префикс `executable_` делает скрипт исполняемым
- Изменения применяются через `chezmoi apply`
- Редактирование скриптов: `chezmoi edit ~/.bin/raycast/<script>.sh`

## Формат метаданных скрипта

Raycast использует комментарии в начале скрипта для настройки поведения.

### Обязательные параметры

```bash
# @raycast.schemaVersion 1
# @raycast.title <Название команды>
# @raycast.mode <silent|compact|fullOutput|inline>
```

- **schemaVersion**: Версия схемы метаданных (всегда `1`)
- **title**: Название, отображаемое в Raycast
- **mode**: Режим вывода результата
  - `silent` — без вывода, только выполнение
  - `compact` — компактное окно с результатом
  - `fullOutput` — полный вывод
  - `inline` — результат в строке поиска

### Опциональные параметры

#### Иконка

```bash
# @raycast.icon <путь или URL>
```

Примеры:
- Локальный путь: `/Applications/Tailscale.app/Contents/Resources/AppIcon.icns`
- URL: `https://cdn.example.com/icon.png`
- Эмодзи: `🚀`

#### Аргументы (до 3 аргументов)

##### Dropdown аргумент

```bash
# @raycast.argument1 { "type": "dropdown", "placeholder": "Выберите", "data": [{"title": "Опция 1", "value": "value1"}, {"title": "Опция 2", "value": "value2"}] }
```

- `type`: Тип аргумента (`dropdown`, `text`, `password`)
- `placeholder`: Текст-подсказка
- `data`: Массив опций с `title` (отображение) и `value` (значение)

##### Text аргумент

```bash
# @raycast.argument1 { "type": "text", "placeholder": "Введите текст" }
```

### Доступ к аргументам в скрипте

Аргументы доступны как позиционные параметры: `$1`, `$2`, `$3`

## Доступные скрипты

### Выбор Tailscale Exit Node

**Файл:** [`home/dot_bin/raycast/executable_tailscale_pick_node.sh`](../../home/dot_bin/raycast/executable_tailscale_pick_node.sh)

**Назначение:** Интерактивный выбор exit-node Tailscale из доступных peers.

**Как работает:**
1. Получает список доступных peers через `tailscale status --json`
2. Показывает интерактивный выбор узла
3. Устанавливает выбранный узел как exit-node через `tailscale set --exit-node=<peer>`

**Использование:**
1. Вызовите Raycast (⌘Space)
2. Введите "tailscale pick"
3. Выберите нужный exit node из списка

**Требования:**
- Установленный Tailscale
- `jq` для обработки JSON
- Fish shell в `/opt/homebrew/bin/fish`

**Связанные файлы:**
- Fish реализация: [`executable_tailscale_pick_node.fish`](../../home/dot_bin/raycast/executable_tailscale_pick_node.fish)
- Интеграция со SketchyBar: [`tailscale.lua`](../../home/dot_config/sketchybar/items/right/tailscale.lua)

---

### Статус Tailscale

**Файл:** [`home/dot_bin/raycast/executable_tailscale_status.sh`](../../home/dot_bin/raycast/executable_tailscale_status.sh)

**Назначение:** Отображение текущего статуса подключения Tailscale и информации о exit-node.

**Как работает:**
1. Запрашивает статус Tailscale
2. Показывает текущее состояние подключения
3. Отображает активный exit-node, если настроен

**Использование:**
1. Вызовите Raycast (⌘Space)
2. Введите "tailscale status"
3. Посмотрите текущий статус VPN

**Связанные файлы:**
- Fish реализация: [`executable_tailscale_status.fish`](../../home/dot_bin/raycast/executable_tailscale_status.fish)

---

### Загрузка видео с YouTube

**Файл:** [`home/dot_bin/raycast/executable_youtube-download.sh`](../../home/dot_bin/raycast/executable_youtube-download.sh)

**Назначение:** Загрузка видео с YouTube с помощью yt-dlp.

**Как работает:**
1. Принимает URL YouTube как входные данные
2. Загружает видео с помощью yt-dlp
3. Сохраняет в настроенную директорию загрузок

**Использование:**
1. Скопируйте URL YouTube в буфер обмена
2. Вызовите Raycast (⌘Space)
3. Введите "youtube download"

**Требования:**
- `yt-dlp` установлен (через mise/homebrew)
- Fish shell в `/opt/homebrew/bin/fish`

**Связанные файлы:**
- Fish реализация: [`executable_youtube-download.fish`](../../home/dot_bin/raycast/executable_youtube-download.fish)

### Перезапуск сервисов VM

**Файл:** [`home/dot_bin/raycast/executable_restart-vm.sh`](../../home/dot_bin/raycast/executable_restart-vm.sh)

**Назначение:** Перезапускает все сервисы оконного менеджера и связанных компонентов (Yabai, skhd, Borders, SketchyVim, SketchyBar).

**Функциональность:**

Вызывает Fish функцию `restart_vm`, которая последовательно перезапускает:
1. Yabai (тайловый оконный менеджер)
2. skhd (демон горячих клавиш)
3. Borders (визуальные границы окон)
4. SketchyVim (системная навигация в стиле Vim)
5. SketchyBar (статус-бар)

**Использование:**
1. Вызовите Raycast (⌘Space)
2. Введите "restart vm"
3. Нажмите Enter

**Когда использовать:**
- После изменения конфигурации Yabai/skhd
- При зависании оконного менеджера
- После обновления компонентов

**Связанные файлы:**
- Fish функция: [`home/dot_config/fish/functions/core/restart_vm.fish`](../../home/dot_config/fish/functions/core/restart_vm.fish)
- Конфигурации:
  - [Yabai](../../home/dot_config/yabai/executable_yabairc)
  - [skhd](../../home/dot_config/skhd/skhdrc)
  - [SketchyBar](../../home/dot_config/sketchybar/)
  - [SketchyVim](../../home/dot_config/svim/)

**См. также:**
- [Документация Yabai](../yabai/README.ru.md)
- [Документация skhd](../skhd/README.ru.md)
- [Документация SketchyBar](../sketchybar/README.ru.md)

### Запуск Dota 2

**Файл:** [`home/dot_bin/raycast/executable_dota2.sh`](../../home/dot_bin/raycast/executable_dota2.sh)

**Назначение:** Быстрый запуск Dota 2 через Steam.

**Функциональность:**
- Запускает Dota 2 напрямую через shell-скрипт Steam
- Обходит необходимость открывать Steam UI

**Использование:**
1. Вызовите Raycast (⌘Space)
2. Введите "Dota 2"
3. Нажмите Enter

**Требования:**
- Установленный Steam
- Установленная Dota 2
- Путь: `~/Library/Application Support/Steam/steamapps/common/dota 2 beta/game/dota.sh`

**Примечание:** Путь жестко закодирован для конкретного пользователя. При использовании на другой системе потребуется обновить путь.

## Добавление новых скриптов

### Шаг 1: Создание файла

Создайте файл в директории `dot_bin/raycast/` с префиксом `executable_`:

```bash
# В репозитории dotfiles
touch dot_bin/raycast/executable_my_script.sh
```

### Шаг 2: Добавление метаданных

Добавьте метаданные Raycast в начало файла:

```bash
#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title My Script
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🚀

# Ваш код здесь
```

### Шаг 3: Реализация логики

Три основных паттерна:

#### Простая команда

```bash
#!/bin/bash
# ... метаданные ...

# Прямое выполнение команды
osascript -e 'tell application "Music" to playpause'
```

#### Скрипт с аргументами

```bash
#!/bin/bash
# ... метаданные ...
# @raycast.argument1 { "type": "text", "placeholder": "Имя" }

echo "Привет, $1!"
```

#### Интеграция с Fish функцией

```bash
#!/bin/bash
# ... метаданные ...

# Вызов существующей Fish функции
/opt/homebrew/bin/fish -c "my_fish_function"
```

### Шаг 4: Применение через chezmoi

```bash
# Применить изменения
chezmoi apply

# Проверить что скрипт исполняемый
ls -la ~/.bin/raycast/my_script.sh
```

### Шаг 5: Тестирование в Raycast

1. Откройте Raycast (⌘Space)
2. Введите название вашего скрипта
3. Raycast автоматически обнаружит новый скрипт

### Шаблон универсального скрипта

```bash
#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Template Script
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🛠️
# @raycast.argument1 { "type": "dropdown", "placeholder": "Action", "data": [{"title": "Action 1", "value": "action1"}, {"title": "Action 2", "value": "action2"}] }

# Проверка аргумента
if [ -z "$1" ]; then
    echo "❌ Аргумент не предоставлен"
    exit 1
fi

# Обработка аргумента
case "$1" in
    "action1")
        echo "✅ Выполняется действие 1"
        # Ваш код
        ;;
    "action2")
        echo "✅ Выполняется действие 2"
        # Ваш код
        ;;
    *)
        echo "❌ Неизвестное действие: $1"
        exit 1
        ;;
esac
```

### Best Practices

1. **Используйте абсолютные пути** для исполняемых файлов:

   ```bash
   /opt/homebrew/bin/fish  # ✅ Хорошо
   fish                     # ❌ Плохо (может не найтись)
   ```

2. **Обрабатывайте ошибки**:

   ```bash
   if ! command -v tailscale &> /dev/null; then
       echo "❌ Tailscale не найден"
       exit 1
   fi
   ```

3. **Используйте информативные сообщения** для режимов `compact` и `fullOutput`

4. **Документируйте зависимости** в комментариях

5. **Тестируйте из командной строки** перед добавлением в Raycast

## Интеграция с функциями Fish

### Зачем использовать Fish функции

Raycast скрипты пишутся на bash, но можно вызывать Fish функции для:
- Использования существующей логики из Fish конфигурации
- Доступа к Fish переменным окружения
- Повторного использования кода между Fish и Raycast

### Базовый паттерн

```bash
#!/bin/bash
# Raycast метаданные...

/opt/homebrew/bin/fish -c "fish_function_name"
```

### Передача аргументов

```bash
#!/bin/bash
# @raycast.argument1 { "type": "text", "placeholder": "Value" }

/opt/homebrew/bin/fish -c "fish_function_name \"$1\""
```

### Пример: restart_vm

**Raycast скрипт** ([`executable_restart-vm.sh`](../../dot_bin/raycast/executable_restart-vm.sh)):

```bash
#!/bin/bash
# ... метаданные ...
/opt/homebrew/bin/fish -c "restart_vm"
```

**Fish функция** ([`restart_vm.fish`](../../dot_config/fish/functions/core/restart_vm.fish)):

```fish
function restart_vm
    yabai --restart-service
    skhd --restart-service
    brew services restart borders
    brew services restart svim
    brew services restart sketchybar
    echo "vm is restarted"
end
```

### Создание Fish функции для Raycast

1. Создайте функцию в `dot_config/fish/functions/`:

   ```fish
   # dot_config/fish/functions/core/my_raycast_function.fish
   function my_raycast_function
       # Ваша логика
   end
   ```

2. Создайте Raycast скрипт:

   ```bash
   # dot_bin/raycast/executable_my_script.sh
   #!/bin/bash
   # ... метаданные ...
   /opt/homebrew/bin/fish -c "my_raycast_function"
   ```

3. Применить изменения:

   ```bash
   chezmoi apply
   ```

### Преимущества

- ✅ Единая кодовая база для Fish и Raycast
- ✅ Доступ к Fish окружению и конфигурации
- ✅ Легче тестировать (можно вызвать функцию напрямую в Fish)
- ✅ Переиспользование существующих функций

### См. также

- [Документация Fish Shell](../fish/README.ru.md)
- [Fish функции для системного управления](../fish/README.ru.md#пользовательские-функции)

## Решение проблем

### Скрипт не появляется в Raycast

**Проблема:** Новый скрипт не появляется в Raycast после создания.

**Решения:**
1. Проверьте что скрипт находится в `~/.bin/raycast/` (а не в исходном `dot_bin/`)
2. Проверьте права на выполнение: `ls -la ~/.bin/raycast/`
3. Проверьте формат метаданных (особенно `schemaVersion`, `title`, `mode`)
4. Перезапустите Raycast: `killall Raycast && open -a Raycast`

### Ошибка Permission Denied

**Проблема:** Скрипт не выполняется с ошибкой "Permission denied".

**Решения:**
1. Проверьте что скрипт имеет права на выполнение:

   ```bash
   ls -la ~/.bin/raycast/script.sh
   ```

2. Если не исполняемый:

   ```bash
   chmod +x ~/.bin/raycast/script.sh
   ```

3. Проверьте что chezmoi использует префикс `executable_` в исходном файле

### Command Not Found

**Проблема:** Скрипт не выполняется с ошибкой "command not found" для инструментов типа `tailscale`, `jq` и т.д.

**Решения:**
1. Используйте абсолютные пути:

   ```bash
   /opt/homebrew/bin/tailscale  # Вместо просто 'tailscale'
   ```

2. Найдите расположение команды:

   ```bash
   which tailscale
   ```

3. Проверьте что инструмент установлен:

   ```bash
   brew list | grep tailscale
   ```

### Fish функция не работает

**Проблема:** Вызов Fish функции не работает из Raycast скрипта.

**Решения:**
1. Проверьте путь к Fish: `/opt/homebrew/bin/fish` (не `/usr/local/bin/fish`)
2. Протестируйте функцию напрямую в Fish:

   ```fish
   fish -c "function_name"
   ```

3. Проверьте что функция определена:

   ```fish
   type function_name
   ```

4. Проверьте что файл функции существует: `ls ~/.config/fish/functions/`

### Метаданные не распознаются

**Проблема:** Raycast не распознает параметры метаданных.

**Решения:**
1. Проверьте что метаданные находятся в комментариях в начале файла (перед любым кодом)
2. Проверьте точный формат: `# @raycast.parameterName value`
3. Валидируйте JSON для аргументов (используйте онлайн JSON валидатор)
4. Убедитесь в отсутствии опечаток в именах параметров

### Зависание выполнения скрипта

**Проблема:** Скрипт запускается но никогда не завершается.

**Решения:**
1. Протестируйте скрипт из терминала:

   ```bash
   ~/.bin/raycast/script.sh argument
   ```

2. Добавьте таймаут к командам:

   ```bash
   timeout 10s command_that_might_hang
   ```

3. Проверьте что нет ожидания ввода (скрипт ждет stdin)
4. Добавьте отладочный вывод:

   ```bash
   echo "Шаг 1 выполнен"
   ```

### Неправильные значения аргументов

**Проблема:** Скрипт получает некорректные значения аргументов.

**Решения:**
1. Проверьте поле `value` в dropdown (а не `title` который отображается)
2. Проверьте порядок аргументов: `$1`, `$2`, `$3` соответствуют порядку объявления
3. Тестируйте с отладочным выводом:

   ```bash
   echo "Получен аргумент: $1"
   ```

4. Проверьте кавычки в JSON: используйте `\"` для вложенных кавычек
