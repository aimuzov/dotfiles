# SketchyVim Configuration

> 🇷🇺 [Русская версия](README.ru.md)

This directory contains configuration for [SketchyVim](https://github.com/FelixKratz/SketchyVim) — a system-wide vim-like navigation daemon for macOS.

## Overview

SketchyVim provides vim-style navigation keybindings across all macOS applications. It integrates with SketchyBar to show the current mode and uses blacklisting to exclude specific applications.

## Files

- `svimrc` - Main configuration file with language mapping
- `blacklist` - Applications excluded from SketchyVim control
- `executable_svim.sh` - Launch script for SketchyVim service

## Configuration

### Language Mapping (`svimrc`)

The configuration includes comprehensive Russian keyboard layout mapping, allowing vim navigation with Russian input method:

```vim
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
```

This means you can use:
- `ф` instead of `a`
- `и` instead of `b`
- `с` instead of `c`
- And so on for the entire Russian alphabet

**Key mappings for navigation:**
- `р` (h) - Left
- `о` (j) - Down
- `л` (k) - Up
- `д` (l) - Right
- `в` (d) - Delete
- `ц` (w) - Word forward
- `и` (b) - Word backward

### Application Blacklist

Applications listed in `blacklist` are excluded from SketchyVim control. Current entries:

```
Telegram
```

**Why blacklist apps?**
- Apps with their own vim bindings (terminals, editors)
- Apps where system-wide vim mode causes conflicts
- Games or full-screen applications

### Launch Script (`executable_svim.sh`)

Simple wrapper script to start SketchyVim with the configuration:

```bash
#!/bin/sh
svim
```

## SketchyVim Modes

SketchyVim supports standard vim modes:

- **Normal mode** - Default mode for navigation
- **Insert mode** - Regular text input
- **Visual mode** - Text selection
- **Command mode** - Execute commands
- **Pending mode** - Waiting for operation completion

The current mode is displayed in SketchyBar (see `dot_config/sketchybar/items/center/svim.lua`).

## Service Management

```bash
# Start SketchyVim
brew services start svim

# Stop SketchyVim
brew services stop svim

# Restart SketchyVim
brew services restart svim
```

Or use the launch script:
```bash
~/.config/svim/svim.sh
```

## Integration with SketchyBar

SketchyVim sends mode change events to SketchyBar, which displays a mode indicator in the center of the status bar.

**Mode indicators:**
- **N** - Normal mode (green)
- **I** - Insert mode (blue)
- **V** - Visual mode (purple)
- **C** - Command mode (yellow)
- **P** - Pending mode (orange)

See `dot_config/sketchybar/items/center/svim.lua` for indicator configuration.

## Common Usage

### Entering Modes

- `Esc` - Enter Normal mode from any mode
- `i` or `и` - Enter Insert mode (before cursor)
- `a` or `ф` - Enter Insert mode (after cursor)
- `v` or `м` - Enter Visual mode
- `:` - Enter Command mode

### Navigation (Normal Mode)

- `h/j/k/l` or `р/о/л/д` - Move left/down/up/right
- `w` or `ц` - Jump to next word
- `b` or `и` - Jump to previous word
- `0` - Jump to line start
- `$` - Jump to line end
- `gg` - Jump to document start
- `G` - Jump to document end

### Editing (Normal Mode)

- `d` or `в` - Delete (use with motion, e.g., `dw`, `dd`)
- `y` or `н` - Yank/copy (use with motion)
- `p` or `з` - Paste
- `u` or `г` - Undo
- `Ctrl+r` - Redo
- `x` - Delete character under cursor

### Visual Mode

- Select text with navigation keys
- `y` or `н` - Yank selection
- `d` or `в` - Delete selection
- `c` or `с` - Change selection (delete and enter insert mode)

## Customization

### Adding Applications to Blacklist

1. Open `blacklist` file
2. Add application name (one per line)
3. Restart SketchyVim: `brew services restart svim`

Example:
```
Telegram
Terminal
WezTerm
Neovim
```

### Modifying Language Mapping

Edit `svimrc` to add more language mappings or modify existing ones:

```vim
set langmap=<source>;<target>,<source>;<target>
```

## Troubleshooting

### SketchyVim Not Working in Some Apps

- Check if app is in `blacklist`
- Verify Accessibility permissions are granted
- Check if app has its own keyboard shortcuts conflicting

### Mode Not Showing in SketchyBar

- Ensure SketchyBar is running: `brew services list | grep sketchybar`
- Check SketchyBar svim item configuration
- Restart both services: `brew services restart svim sketchybar`

### Russian Layout Not Working

- Verify `svimrc` contains langmap configuration
- Check keyboard input source in macOS
- Restart SketchyVim after modifying `svimrc`

## Notes

- SketchyVim requires Accessibility permissions to function
- System-wide vim bindings work in most native macOS apps
- Web browsers and Electron apps have varying levels of support
- Some applications may require blacklisting due to conflicts
- Russian keyboard layout support allows seamless navigation without switching input methods

## Links

- [SketchyVim GitHub](https://github.com/FelixKratz/SketchyVim)
- [Vim Cheat Sheet](https://vim.rtorr.com/)
