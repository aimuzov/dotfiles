# Конфигурация yabai

> 🇺🇸 [English version](README.md)

Этот каталог содержит кастомную конфигурацию для [yabai](https://github.com/koekeishiya/yabai) — динамического тайлинг-менеджера окон для macOS.

## Быстрый старт

1. **Установите yabai**
   Следуйте официальной инструкции: <https://github.com/koekeishiya/yabai/wiki/Installing-yabai-(latest-release)>

2. **Установите зависимости**

   - [Fish shell](https://fishshell.com/) — конфигурация написана на Fish
   - [jq](https://stedolan.github.io/jq/) — для парсинга JSON
   - [sketchybar](https://github.com/FelixKratz/SketchyBar) — для отображения статуса окон/spaces (опционально)

3. **Запустите сервис**

   ```sh
   yabai --start-service
   ```

## Основные возможности

- **Конфигурация написана на Fish shell** для чистого синтаксиса и интеграции с Fish функциями
- **Автоматическая загрузка scripting addition**
- **Сигналы для интеграции с SketchyBar** (window focus, создание/удаление окон, перезапуск дока)
- **Гибкая настройка внешнего вида и поведения окон** (layout, прозрачность, отступы, gap'ы, padding, mouse actions)
- **Автоматическое создание и именование рабочих столов (spaces)**
- **Автоматическое назначение приложений на рабочие столы**
- **Гибкое управление layout'ом и исключениями**

## Структура конфигурации

Файл конфигурации (`executable_yabairc`) — это Fish shell скрипт, который:

1. **Загружает scripting addition** - Включает продвинутые функции управления окнами
2. **Настраивает сигналы событий** - Интеграция со SketchyBar и вызов Fish функций
3. **Конфигурирует глобальные настройки** - Layout, отступы, промежутки, поведение мыши
4. **Создаёт и именует spaces** - 12 рабочих пространств на 2 дисплеях
5. **Назначает приложения на spaces** - Правила автоматического размещения окон
6. **Управляет исключениями layout'а** - Правила layout для отдельных приложений

## Вспомогательные функции

Расположены в `home/dot_config/fish/functions/core/yabai/`:

- **`yabai.rearrange.fish`** - Перераспределяет окна при создании новых. Вызывается через сигнал при событии `window_created`.
- **`yabai.restart.fish`** - Чистый перезапуск сервиса Yabai.
- **`yabai.sudoers.fish`** - Управление конфигурацией sudoers для scripting addition (позволяет выполнять `yabai --load-sa` без пароля).

## Раскладка рабочих пространств

| Space | Название | Дисплей | Приложения                          |
|-------|----------|---------|-------------------------------------|
| 1     | Code     | 1       | WezTerm, Ghostty, Code, Cursor, Zed |
| 2     | Serf     | 1       | Arc, Dia, Google Chrome             |
| 3     | Org      | 1       | Things, Calendar, Mail              |
| 4     | Graph    | 1       | Figma, Miro                         |
| 5     | Explr    | 1       | Finder, Cyberduck                   |
| 6     | Fun      | 1       | Steam Helper, Dota 2                |
| 7     | Sys      | 2       | System Settings, MacPass            |
| 8     | Ai       | 2       | ChatGPT, Claude, Perplexity         |
| 9     | Any      | 2       | По умолчанию для прочих приложений  |
| 10    | Social   | 2       | Time, Telegram, WhatsApp            |
| 11    | Calls    | 2       | Толк (встречи)                      |
| 12    | Media    | 2       | Yandex Music, Photos                |

## Точки интеграции

- **skhd** - Горячие клавиши для управления окнами (см. [документацию skhd](../skhd/README.ru.md))
- **SketchyBar** - Визуальная обратная связь через сигналы:
  - `window_focus` - Обновляет индикатор активного окна
  - `windows_on_spaces` - Обновляет иконки приложений в рабочих пространствах
- **Fish shell** - Вспомогательные функции и чистый синтаксис конфигурации
- **JankyBorders** - Визуальные границы окон (отдельный сервис)

## Примечания

- Для работы некоторых функций требуется разрешить yabai доступ к управлению системой (Accessibility).
- Для scripting addition требуется отключить SIP (System Integrity Protection) на macOS. См. [официальную документацию](https://github.com/koekeishiya/yabai/wiki/Disabling-System-Integrity-Protection).
- Конфигурация использует синтаксис Fish shell. Убедитесь, что Fish установлен перед запуском yabai.
