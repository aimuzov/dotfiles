# skhd Configuration

> 🇷🇺 [Русская версия](README.ru.md)

This directory contains configuration for [skhd](https://github.com/koekeishiya/skhd) — a simple hotkey daemon for macOS.

## Overview

skhd provides keyboard shortcuts for controlling [Yabai](https://github.com/koekeishiya/yabai) window manager and other system operations. The configuration uses vim-like keybindings for intuitive window navigation.

## Keybindings

### Space (Workspace) Navigation

Switch between workspaces using Alt + number:

- `Alt + 1-9` - Switch to workspaces 1-9
- `Alt + 0` - Switch to workspace 10
- `Alt + -` - Switch to workspace 11
- `Alt + =` - Switch to workspace 12

> Uses custom helper function `yabai_space_focus` for reliable space switching.

### Space Layout Manipulation

- `Alt + Shift + r` - Rotate space layout 270 degrees
- `Alt + Shift + y` - Mirror space on y-axis (horizontal flip)
- `Alt + Shift + x` - Mirror space on x-axis (vertical flip)

### Window Navigation

Vim-like navigation with h/j/k/l:

- `Alt + h` - Focus window to the west (left) or previous display
- `Alt + l` - Focus window to the east (right) or next display
- `Alt + j` - Focus window to the south (down)
- `Alt + k` - Focus window to the north (up)

> East/west navigation includes automatic display wrapping and fallback logic.

### Window Resizing

Use Control modifier with Alt for resizing:

- `Alt + Ctrl + Left` - Shrink window from right/left edge
- `Alt + Ctrl + Down` - Grow window from bottom/top edge
- `Alt + Ctrl + Up` - Shrink window from bottom/top edge
- `Alt + Ctrl + Right` - Grow window from right/left edge

> Resize amount: 20 pixels per press.

### Window Movement (Warping)

Move windows between positions with Shift modifier:

- `Alt + Shift + h` - Warp window west (or move to previous space)
- `Alt + Shift + l` - Warp window east (or move to next space)
- `Alt + Shift + j` - Warp window south
- `Alt + Shift + k` - Warp window north
- `Alt + Shift + d` - Move window to recent display

> Horizontal warping includes automatic space switching when at edge.

### Window Stacking

Stack windows on top of each other:

- `Alt + Shift + Left` - Stack window from the west
- `Alt + Shift + Down` - Stack window from the south
- `Alt + Shift + Up` - Stack window from the north
- `Alt + Shift + Right` - Stack window from the east
- `Alt + Shift + [` - Focus previous window in stack
- `Alt + Shift + ]` - Focus next window in stack

> Triggers SketchyBar update after stacking operation.

### Window Toggling

- `Alt + Shift + f` - Toggle float mode with centered 8x8 grid positioning
- `Alt + Shift + m` - Toggle fullscreen (zoom-fullscreen)
- `Alt + Shift + p` - Toggle parent zoom
- `Alt + Shift + e` - Balance all windows in space

> Triggers SketchyBar update after toggling.

### Application Blacklist

The `.blacklist` section excludes specific applications from skhd control. Currently configured:
- `"Dota 2"` - Gaming application

## Helper Scripts

The configuration relies on these custom helper scripts (located in PATH):

- `yabai_space_focus <number>` - Reliable space switching with focus handling
- `yabai_display_index_get <number>` - Get display index for multi-monitor setups

## Service Management

```bash
# Start skhd service
skhd --start-service

# Stop skhd service
skhd --stop-service

# Restart skhd service
skhd --restart-service

# Reload configuration without restart
skhd --reload
```

## Integration

skhd works in tandem with:
- **Yabai** - Executes window management commands
- **SketchyBar** - Updates UI indicators after operations
- **jq** - JSON parsing for Yabai queries

## Notes

- All keybindings use `Alt` (Option) as the primary modifier
- `Shift` modifier is used for destructive operations (move, warp, toggle)
- `Ctrl` modifier is used for resizing
- Keycodes are referenced from: https://github.com/koekeishiya/skhd/issues/1

## Customization

To add custom keybindings:

1. Edit `skhdrc` file
2. Use format: `modifier - key : command`
3. Reload skhd: `skhd --reload`

Example:
```bash
# Open terminal with Alt + T
alt - t : open -a WezTerm
```
