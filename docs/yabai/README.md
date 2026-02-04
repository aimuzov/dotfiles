# yabai Configuration

> 🇷🇺 [Русская версия](README.ru.md)

This directory contains custom configuration for [yabai](https://github.com/koekeishiya/yabai) — a dynamic tiling window manager for macOS.

## Quick Start

1. **Install yabai**
   Follow the official guide: https://github.com/koekeishiya/yabai/wiki/Installing-yabai-(latest-release)

2. **Install dependencies**

   - [Fish shell](https://fishshell.com/) — configuration is written in Fish
   - [jq](https://stedolan.github.io/jq/) — for JSON parsing
   - [sketchybar](https://github.com/FelixKratz/SketchyBar) — for displaying window/spaces status (optional)

3. **Start the service**
   ```sh
   yabai --start-service
   ```

## Main Features

- **Configuration written in Fish shell** for clean syntax and integration with Fish functions
- **Automatic scripting addition loading**
- **Signals for SketchyBar integration** (window focus, window creation/deletion, dock restart)
- **Flexible window appearance and behavior configuration** (layout, transparency, margins, gaps, padding, mouse actions)
- **Automatic workspace (spaces) creation and naming**
- **Automatic application assignment to workspaces**
- **Flexible layout management and exceptions**

## Configuration Structure

The configuration file (`executable_yabairc`) is a Fish shell script that:

1. **Loads scripting addition** - Enables advanced window management features
2. **Sets up event signals** - Integrates with SketchyBar and triggers Fish functions
3. **Configures global settings** - Layout, padding, gaps, mouse behavior
4. **Creates and names spaces** - 12 workspaces across 2 displays
5. **Assigns applications to spaces** - Rules for automatic window placement
6. **Manages layout exceptions** - Per-app layout rules

## Helper Functions

Located in `home/dot_config/fish/functions/core/yabai/`:

- **`yabai.rearrange.fish`** - Rearranges windows when new ones are created. Triggered via signal on `window_created` event.
- **`yabai.restart.fish`** - Restarts Yabai service cleanly.
- **`yabai.sudoers.fish`** - Manages sudoers configuration for scripting addition (allows `yabai --load-sa` without password).

## Workspace Layout

| Space | Name   | Display | Applications                        |
|-------|--------|---------|-------------------------------------|
| 1     | Code   | 1       | WezTerm, Ghostty, Code, Cursor, Zed |
| 2     | Serf   | 1       | Arc, Dia, Google Chrome             |
| 3     | Org    | 1       | Things, Calendar, Mail              |
| 4     | Graph  | 1       | Figma, Miro                         |
| 5     | Explr  | 1       | Finder, Cyberduck                   |
| 6     | Fun    | 1       | Steam Helper, Dota 2                |
| 7     | Sys    | 2       | System Settings, MacPass            |
| 8     | Ai     | 2       | ChatGPT, Claude, Perplexity         |
| 9     | Any    | 2       | Default for unmatched apps          |
| 10    | Social | 2       | Time, Telegram, WhatsApp            |
| 11    | Calls  | 2       | Толк (meetings)                     |
| 12    | Media  | 2       | Yandex Music, Photos                |

## Integration Points

- **skhd** - Keybindings for window management (see [skhd documentation](../skhd/README.md))
- **SketchyBar** - Visual feedback via signals:
  - `window_focus` - Updates focused window indicator
  - `windows_on_spaces` - Updates workspace app icons
- **Fish shell** - Helper functions and clean configuration syntax
- **JankyBorders** - Visual window borders (separate service)

## Notes

- Some features require granting yabai access to system control (Accessibility).
- Scripting addition requires disabling SIP (System Integrity Protection) on macOS. See [official documentation](https://github.com/koekeishiya/yabai/wiki/Disabling-System-Integrity-Protection).
- The configuration uses Fish shell syntax. Make sure Fish is installed before starting yabai.
