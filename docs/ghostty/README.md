# Ghostty Terminal Configuration

> 🇷🇺 [Русская версия](README.ru.md)

This directory contains configuration for [Ghostty](https://ghostty.org/) — a fast, feature-rich, and cross-platform terminal emulator.

## Overview

Ghostty is configured as the primary terminal emulator with the following key features:

- **Quick Terminal** - Full-screen bottom terminal triggered by `Alt+Escape`
- **Display P3 Colorspace** - Wide color gamut support for accurate colors
- **Catppuccin Theme** - Automatic dark/light theme switching
- **Fish Shell Integration** - Launches Fish via mise for consistent environment

## Configuration

Location: `home/dot_config/ghostty/config`

### Key Settings

| Setting                   | Value                                             | Description                                |
| ------------------------- | ------------------------------------------------- | ------------------------------------------ |
| `font-family`             | JetBrainsMono NFM                                 | Nerd Font for icons and ligatures          |
| `font-size`               | 16                                                | Base font size                             |
| `theme`                   | dark:Catppuccin Macchiato, light:Catppuccin Latte | Automatic theme based on system appearance |
| `window-colorspace`       | display-p3                                        | Wide color gamut support                   |
| `quick-terminal-position` | bottom                                            | Quick terminal appears at bottom           |
| `quick-terminal-size`     | 100%                                              | Full-screen quick terminal                 |
| `macos-icon`              | retro                                             | Retro-style macOS dock icon                |
| `auto-update`             | off                                               | Manual updates only                        |

### Shell Command

```conf
command = fish --login --interactive
```

This ensures Fish shell is launched through mise, providing:

- Consistent environment variables
- Access to mise-managed tools
- Proper PATH configuration

### Visual Adjustments

- `adjust-cell-height = 21` - Custom line height
- `adjust-cursor-height = 47%` - Adjusted cursor size
- `cursor-invert-fg-bg = true` - Inverted cursor colors for visibility
- `macos-titlebar-style = hidden` - Clean window appearance

### Keybindings

| Binding             | Action                                      |
| ------------------- | ------------------------------------------- |
| `global:alt+escape` | Toggle quick terminal                       |
| `ctrl+m`            | Send return character                       |
| `shift+up`          | Scroll up 25 lines                          |
| `shift+down`        | Scroll down 26 lines                        |
| `shift+enter`       | Send escape + return (useful for some apps) |

## Quick Terminal

The quick terminal is a key feature, providing instant access to a terminal from anywhere:

1. Press `Alt+Escape` to toggle
2. Full-screen terminal appears at the bottom
3. Press `Alt+Escape` again to hide

This is particularly useful for:

- Quick command execution
- Checking logs
- Running one-off scripts

## Theme Integration

Ghostty automatically switches themes based on macOS system appearance:

- **Dark mode**: Catppuccin Macchiato
- **Light mode**: Catppuccin Latte

The theme change is instant and doesn't require terminal restart.

## Dependencies

- [Ghostty](https://ghostty.org/) - The terminal emulator
- [mise](https://mise.jdx.dev/) - For launching Fish with proper environment
- [Fish shell](https://fishshell.com/) - Primary shell
- [JetBrainsMono Nerd Font](https://www.nerdfonts.com/) - Terminal font

## Related Documentation

- [Fish Shell Configuration](../fish/README.md)
- [Theme Switching Architecture](../OVERVIEW.md#theme-switching-architecture)
