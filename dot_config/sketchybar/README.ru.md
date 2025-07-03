# Конфигурация SketchyBar

> 🇬🇧 [English version](README.md)

Данная папка содержит модульную конфигурацию для [SketchyBar](https://github.com/FelixKratz/SketchyBar) с использованием Lua-скриптов. Конфиг легко расширять и поддерживать благодаря разделению на отдельные модули.

---

## Структура

- **init.lua** — Главная точка входа. Подключает базовые модули: `bar`, `default`, `items`.
- **bar.lua** — Описывает параметры панели (цвет, высота, позиция и др.).
- **config.lua** — Основные настройки: шрифты, отступы, цветовая схема.
- **default.lua** — Значения по умолчанию для всех элементов панели.
- **executable_sketchybarrc** — Скрипт для запуска SketchyBar с Lua-конфигом. Проверяет и устанавливает SbarLua, запускает event loop.
- **items/** — Модули для элементов панели, сгруппированные по расположению:
  - **left/** — элементы слева (рабочие столы, yabai-статус)
  - **center/** — элементы по центру (раскладка клавиатуры, режимы svim)
  - **right/** — элементы справа (дата/время, батарея, медиа)

---

## Описание модулей

### items/left/

- **spaces.lua** — Отображение рабочих столов (spaces) через [yabai](https://github.com/koekeishiya/yabai). Поддержка выделения, отображения приложений, взаимодействие мышью.
- **yabai.lua** — Статус активного окна (tile/float/fullscreen/stack) через [yabai](https://github.com/koekeishiya/yabai).

### items/center/

- **keyboard_layout.lua** — Текущая раскладка клавиатуры (en/ru/unknown) через [im-select](https://github.com/daipeihust/im-select).
- **svim.lua** — Режимы работы [svim](https://github.com/FelixKratz/SketchyVim) (normal/insert/visual/cmd/pending).

### items/right/

- **battery.lua** — Уровень заряда батареи и статус зарядки через pmset.
- **datetime.lua** — Текущие дата и время, обновление каждые 30 секунд, по клику — переключение отображения дополнительных элементов.
- **media.lua** — Информация о текущем треке (исполнитель, название, play/pause) через [nowplaying-cli](https://github.com/nowplaying/nowplaying-cli).

## Кастомизация

- Цвета, шрифты, отступы — в `config.lua`.
- Добавление/удаление элементов — через редактирование `items/init.lua` и соответствующих подпапок.
- Для новых элементов создайте Lua-модуль в нужной подпапке и подключите его в `items/init.lua`.

---

## Зависимости

- [SketchyBar](https://github.com/FelixKratz/SketchyBar)
- [SbarLua](https://github.com/FelixKratz/SbarLua)
- [yabai](https://github.com/koekeishiya/yabai)
- [im-select](https://github.com/daipeihust/im-select)
- [nowplaying-cli](https://github.com/nowplaying/nowplaying-cli)
- [jq](https://stedolan.github.io/jq/)
- `pmset` (стандартная утилита macOS)

---

## Пример расширения

Добавим новый элемент справа:

1. Создайте файл `items/right/mywidget.lua`:

```lua
local sbar = require("sketchybar")
local mywidget = sbar.add("item", {
  position = "right",
  icon = { string = "★" },
  label = "Hello!",
})
return mywidget
```

2. Подключите его в `items/init.lua`:

```lua
require("items.right.mywidget")
```

---

## Ссылки

- [SketchyBar](https://github.com/FelixKratz/SketchyBar)
- [SbarLua](https://github.com/FelixKratz/SbarLua)
