# Конфигурация SketchyBar

> 🇬🇧 [English version](README.md)

Данная папка содержит модульную конфигурацию для [SketchyBar](https://github.com/FelixKratz/SketchyBar) с использованием Lua-скриптов. Конфиг легко расширять и поддерживать благодаря разделению на отдельные модули.

---

## Структура

- **init.lua** — Главная точка входа. Подключает базовые модули: `bar`, `default`, `items`.
- **bar.lua** — Описывает параметры панели (цвет, высота, позиция и др.).
- **config.lua** — Основные настройки: шрифты, отступы, цветовая схема.
- **default.lua** — Значения по умолчанию для всех элементов панели.
- **executable_sketchybarrc** — Скрипт для запуска SketchyBar с Lua-конфигом. Проверяет и устанавливает SbarLua, ставит `vendor/` в начало `package.path`, запускает event loop.
- **exact_items/init.lua** — Список подключаемых элементов, в порядке их следования в панели. Единственный оставшийся здесь файл: сами элементы приезжают из `vendor/`. Префикс `exact_` заставляет chezmoi удалять из развёрнутой директории всё, чего он не знает — так вычистились файлы прежней структуры.
- **vendor/** — [sketchybar-items](https://github.com/aimuzov/sketchybar-items), приезжает через chezmoi из [`.chezmoiexternals/sketchybar-items.toml`](../../home/.chezmoiexternals/sketchybar-items.toml). В этом репозитории не хранится.

---

## Описание модулей

### Из vendor/

Каждый элемент оттуда сначала проверяет свои инструменты и возвращает `false`, если чего-то нет: на машине без yabai панель просто короче, а не сломана.

| Элемент | Показывает | Нужен |
| --- | --- | --- |
| `items/yabai_spaces` | по элементу на каждый space с приложениями на нём, кликабельно | `yabai`, `jq` |
| `items/yabai_window` | float, zoom или «2 / 4» для окна в стеке | `yabai`, `jq` |
| `items/skhd_mode` | активный модальный режим skhd — цветным бейджем | `skhd` |
| `items/input` | раскладку клавиатуры и режим SketchyVim в одном бейдже | `im-select` и/или `svim` |
| `items/tailscale` | поднят ли [Tailscale](https://tailscale.com/), выключен или ждёт логина | `tailscale`, `jq` |
| `items/caffeinate` | не даёт ли что-то уснуть дисплею; по клику переключается | `caffeinate` |
| `items/battery` | заряд и подключено ли питание | `pmset` |
| `items/datetime` | дату и время | — |

Событие `window_focus`, которое слушают трое из них, — это сигнал yabai, и они ставят его себе сами, см. [Events](https://github.com/aimuzov/sketchybar-items#events). Поэтому `yabairc` его больше не добавляет.

## Кастомизация

- Цвета, шрифты, отступы — в `config.lua`. Он мержится поверх дефолтов `vendor/theme.lua`, поэтому всё, что в нём не названо, остаётся вендорным.
- Добавление/удаление элементов — через редактирование `exact_items/init.lua`; порядок require и есть порядок в панели.
- Новому элементу место в [sketchybar-items](https://github.com/aimuzov/sketchybar-items), если он не имеет смысла только в этой панели. Если всё же остаётся здесь — кладите рядом с `init.lua` и помните, что `exact_` удаляет всё, чего chezmoi не знает.

---

## Зависимости

- [SketchyBar](https://github.com/FelixKratz/SketchyBar)
- [SbarLua](https://github.com/FelixKratz/SbarLua)
- [yabai](https://github.com/koekeishiya/yabai)
- [skhd](https://github.com/koekeishiya/skhd)
- [SketchyVim](https://github.com/FelixKratz/SketchyVim)
- [im-select](https://github.com/daipeihust/im-select)
- [Tailscale](https://tailscale.com/)
- [jq](https://stedolan.github.io/jq/)
- `pmset`, `caffeinate` (стандартные утилиты macOS)

---

## Пример расширения

Добавим новый элемент справа:

1. Создайте файл `exact_items/mywidget.lua`:

```lua
local sbar = require("sketchybar")
local mywidget = sbar.add("item", {
  position = "right",
  icon = { string = "★" },
  label = "Hello!",
})
return mywidget
```

2. Подключите его в `exact_items/init.lua` — на том месте, которое он должен занять в панели:

```lua
require("items.mywidget")
```

`vendor/` стоит первым в `package.path`, поэтому файл отсюда не должен называться так же, как элемент из [sketchybar-items](https://github.com/aimuzov/sketchybar-items): на require ответит вендорный.

---

## Ссылки

- [SketchyBar](https://github.com/FelixKratz/SketchyBar)
- [SbarLua](https://github.com/FelixKratz/SbarLua)
- [sketchybar-items](https://github.com/aimuzov/sketchybar-items)
