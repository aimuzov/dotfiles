# Конфигурация yabai

> 🇺🇸 [English version](README.md)

Этот каталог содержит кастомную конфигурацию для [yabai](https://github.com/koekeishiya/yabai) — динамического тайлинг-менеджера окон для macOS.

## Быстрый старт

1. **Установите yabai**
   Следуйте официальной инструкции: https://github.com/koekeishiya/yabai/wiki/Installing-yabai-(latest-release)

2. **Установите зависимости**

   - [jq](https://stedolan.github.io/jq/) — для парсинга JSON
   - [sketchybar](https://github.com/FelixKratz/SketchyBar) — для отображения статуса окон/spaces (опционально)

3. **Запустите сервис**
   ```sh
   yabai --start-service
   ```

## Основные возможности

- **Автоматическая загрузка scripting addition**
- **Сигналы для интеграции с SketchyBar** (window focus, создание/удаление окон, перезапуск дока)
- **Гибкая настройка внешнего вида и поведения окон** (layout, прозрачность, отступы, gap'ы, padding, mouse actions)
- **Автоматическое создание и именование рабочих столов (spaces)**
- **Автоматическое назначение приложений на рабочие столы**
- **Гибкое управление layout'ом и исключениями**

## Структура скрипта

- Загрузка scripting addition
- Обработка событий (signals)
- Основная конфигурация yabai
- Функции для управления spaces
- Создание и именование spaces
- Назначение окон на spaces
- Управление layout'ом и исключениями

## Примечания

- Для работы некоторых функций требуется разрешить yabai доступ к управлению системой (Accessibility).
- Для scripting addition требуется отключить SIP (System Integrity Protection) на macOS. См. [официальную документацию](https://github.com/koekeishiya/yabai/wiki/Disabling-System-Integrity-Protection).
