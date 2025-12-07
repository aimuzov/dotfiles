# SketchyBar Configuration

> 🇷🇺 [Русская версия](README.ru.md)

This folder contains a modular configuration for [SketchyBar](https://github.com/FelixKratz/SketchyBar) using Lua scripts. The config is easy to extend and maintain thanks to its separation into individual modules.

---

## Structure

- **init.lua** — Main entry point. Loads base modules: `bar`, `default`, `items`.
- **bar.lua** — Describes panel parameters (color, height, position, etc.).
- **config.lua** — Main settings: fonts, padding, color scheme.
- **default.lua** — Default values for all panel items.
- **executable_sketchybarrc** — Script to launch SketchyBar with Lua config. Checks and installs SbarLua, starts the event loop.
- **items/** — Modules for panel items, grouped by position:
  - **left/** — items on the left (workspaces, yabai status)
  - **right/** — items on the right (keyboard layout, svim modes, date/time, battery)

---

## Module Description

### items/left/

- **spaces.lua** — Displays workspaces (spaces) via [yabai](https://github.com/koekeishiya/yabai). Supports highlighting, app display, mouse interaction.
- **yabai.lua** — Active window status (tile/float/fullscreen/stack) via [yabai](https://github.com/koekeishiya/yabai).

### items/right/

- **keyboard_layout.lua** — Current keyboard layout (en/ru/unknown) via [im-select](https://github.com/daipeihust/im-select).
- **svim.lua** — [svim](https://github.com/FelixKratz/SketchyVim) modes (normal/insert/visual/cmd/pending).
- **battery.lua** — Battery level and charging status via pmset.
- **datetime.lua** — Current date and time, updates every 30 seconds, click toggles additional elements.

## Customization

- Colors, fonts, padding — in `config.lua`.
- Add/remove items — by editing `items/init.lua` and corresponding subfolders.
- For new items, create a Lua module in the desired subfolder and require it in `items/init.lua`.

---

## Dependencies

- [SketchyBar](https://github.com/FelixKratz/SketchyBar)
- [SbarLua](https://github.com/FelixKratz/SbarLua)
- [yabai](https://github.com/koekeishiya/yabai)
- [im-select](https://github.com/daipeihust/im-select)
- [jq](https://stedolan.github.io/jq/)
- `pmset` (standard macOS utility)

---

## Example: Adding a New Item

Let's add a new item to the right side of the bar:

1. Create the file `items/right/mywidget.lua`:

```lua
local sbar = require("sketchybar")
local mywidget = sbar.add("item", {
  position = "right",
  icon = { string = "★" },
  label = "Hello!",
})
return mywidget
```

2. Require it in `items/init.lua`:

```lua
require("items.right.mywidget")
```

---

## Links

- [SketchyBar](https://github.com/FelixKratz/SketchyBar)
- [SbarLua](https://github.com/FelixKratz/SbarLua)
