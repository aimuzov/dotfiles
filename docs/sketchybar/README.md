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
- **exact_items/init.lua** — The list of items to load, in bar order. The only file left here: every item itself comes from `vendor/`. The `exact_` prefix makes chezmoi delete anything else that turns up in the deployed directory, which is how the files of the older layout were cleared out.
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
| `items/battery` | charge, and whether it is on the charger | `pmset` |
| `items/datetime` | the date and the time | — |

The `window_focus` event three of these listen for is a yabai signal, and they install it themselves — see [Events](https://github.com/aimuzov/sketchybar-items#events). That is why `yabairc` no longer adds it.

## Customization

- Colors, fonts, padding — in `config.lua`. It is merged over the defaults of `vendor/theme.lua`, so anything it leaves out keeps the vendor value.
- Add/remove items — by editing `exact_items/init.lua`; the require order is the bar order.
- A new item belongs in [sketchybar-items](https://github.com/aimuzov/sketchybar-items) unless it only makes sense in this bar. If it does stay here, put it next to `init.lua` and remember that `exact_` deletes whatever chezmoi does not know about.

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

1. Create the file `exact_items/mywidget.lua`:

```lua
local sbar = require("sketchybar")
local mywidget = sbar.add("item", {
  position = "right",
  icon = { string = "★" },
  label = "Hello!",
})
return mywidget
```

2. Require it in `exact_items/init.lua`, at the position it should take in the bar:

```lua
require("items.mywidget")
```

`vendor/` comes first in `package.path`, so a file here must not take the name of an item in [sketchybar-items](https://github.com/aimuzov/sketchybar-items) — the vendor one would answer the require instead.

---

## Links

- [SketchyBar](https://github.com/FelixKratz/SketchyBar)
- [SbarLua](https://github.com/FelixKratz/SbarLua)
- [sketchybar-items](https://github.com/aimuzov/sketchybar-items)
