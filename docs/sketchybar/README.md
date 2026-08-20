# SketchyBar Configuration

> 🇷🇺 [Русская версия](README.ru.md)

This folder contains a modular configuration for [SketchyBar](https://github.com/FelixKratz/SketchyBar) using Lua scripts. The config is easy to extend and maintain thanks to its separation into individual modules.

---

## Structure

- **init.lua** — Main entry point. Loads base modules: `bar`, `default`, `items`.
- **bar.lua** — Describes panel parameters (color, height, position, etc.).
- **config.lua** — Main settings: fonts, padding, color scheme.
- **default.lua** — Default values for all panel items.
- **executable_sketchybarrc** — Script to launch SketchyBar with Lua config. Checks and installs SbarLua, puts `vendor/` in front of `package.path`, starts the event loop.
- **items/init.lua** — The list of items to load, in bar order.
- **items/right/** — The items that live here: `datetime.lua` and `battery.lua`.
- **vendor/** — [sketchybar-items](https://github.com/aimuzov/sketchybar-items), pulled by chezmoi from [`.chezmoiexternals/sketchybar-items.toml`](../../home/.chezmoiexternals/sketchybar-items.toml). Not part of this repository.

---

## Module Description

### From vendor/

Every item there checks its own tools first and returns `false` when one is missing, so a machine without yabai gets a shorter bar rather than an error.

| Item | Shows | Needs |
| --- | --- | --- |
| `items/yabai_spaces` | one entry per space with the apps on it, clickable | `yabai`, `jq` |
| `items/yabai_window` | floating, zoomed, or "2 / 4" for a window in a stack | `yabai`, `jq` |
| `items/skhd_mode` | which modal skhd mode is active, as a coloured badge | `skhd` |
| `items/input` | keyboard layout and the SketchyVim mode in one badge | `im-select` and/or `svim` |
| `items/tailscale` | whether [Tailscale](https://tailscale.com/) is up, down or waiting for a login | `tailscale`, `jq` |
| `items/caffeinate` | whether the display is being kept awake; click to toggle | `caffeinate` |

### items/right/

- **battery.lua** — Battery level and charging status via pmset.
- **datetime.lua** — Current date and time, updates every 30 seconds, click toggles additional elements.

## Customization

- Colors, fonts, padding — in `config.lua`. It is merged over the defaults of `vendor/theme.lua`, so anything it leaves out keeps the vendor value.
- Add/remove items — by editing `items/init.lua`; the require order is the bar order.
- For new items, create a Lua module in `items/right/` and require it in `items/init.lua`. An item useful outside this config belongs in [sketchybar-items](https://github.com/aimuzov/sketchybar-items) instead.

---

## Dependencies

- [SketchyBar](https://github.com/FelixKratz/SketchyBar)
- [SbarLua](https://github.com/FelixKratz/SbarLua)
- [yabai](https://github.com/koekeishiya/yabai)
- [skhd](https://github.com/koekeishiya/skhd)
- [SketchyVim](https://github.com/FelixKratz/SketchyVim)
- [im-select](https://github.com/daipeihust/im-select)
- [Tailscale](https://tailscale.com/)
- [jq](https://stedolan.github.io/jq/)
- `pmset`, `caffeinate` (standard macOS utilities)

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
- [sketchybar-items](https://github.com/aimuzov/sketchybar-items)
