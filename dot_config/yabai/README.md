# yabai Configuration

> 🇷🇺 [Русская версия](README.ru.md)

This directory contains custom configuration for [yabai](https://github.com/koekeishiya/yabai) — a dynamic tiling window manager for macOS.

## Quick Start

1. **Install yabai**
   Follow the official guide: https://github.com/koekeishiya/yabai/wiki/Installing-yabai-(latest-release)

2. **Install dependencies**

   - [jq](https://stedolan.github.io/jq/) — for JSON parsing
   - [sketchybar](https://github.com/FelixKratz/SketchyBar) — for displaying window/spaces status (optional)

3. **Start the service**
   ```sh
   yabai --start-service
   ```

## Main Features

- **Automatic scripting addition loading**
- **Signals for SketchyBar integration** (window focus, window creation/deletion, dock restart)
- **Flexible window appearance and behavior configuration** (layout, transparency, margins, gaps, padding, mouse actions)
- **Automatic workspace (spaces) creation and naming**
- **Automatic application assignment to workspaces**
- **Flexible layout management and exceptions**

## Script Structure

- Scripting addition loading
- Event handling (signals)
- Main yabai configuration
- Functions for spaces management
- Spaces creation and naming
- Window assignment to spaces
- Layout and exceptions management

## Notes

- Some features require granting yabai access to system control (Accessibility).
- Scripting addition requires disabling SIP (System Integrity Protection) on macOS. See [official documentation](https://github.com/koekeishiya/yabai/wiki/Disabling-System-Integrity-Protection).
