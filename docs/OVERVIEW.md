# Dotfiles Overview

> [🇷🇺 Русская версия](OVERVIEW.ru.md)

This is a personal macOS dotfiles repository managed with [chezmoi](https://www.chezmoi.io/). The configuration includes a complete desktop environment with Yabai (tiling window manager), SketchyBar (status bar), Neovim, Fish shell, and various development tools.

## Repository Structure

### Chezmoi File Naming Convention

Files and directories use chezmoi's naming conventions:

- `dot_` prefix → becomes `.` (e.g., `dot_config` → `.config`)
- `private_` prefix → files excluded from git and restricted permissions
- `.tmpl` suffix → files processed as templates with chezmoi variables
- `executable_` prefix → files made executable

### Key Directories

- `.chezmoiscripts/` - Automated setup scripts that run after chezmoi apply
  - Scripts are ordered with prefixes like `run_once_after_1_`, `run_once_after_2_`, etc.
  - `run_once_weekly_*` scripts run periodically
  - All scripts are Fish shell scripts with `.fish.tmpl` extension
- `.chezmoiexternals/` - External dependencies managed by chezmoi
  - `fish.toml` - Fish shell plugins
  - `yazi.toml` - Yazi file manager plugins
  - `nvim.toml` - Neovim external configurations
- `dot_config/` - Application configurations (becomes `~/.config/`)
- `dot_bin/` - User scripts and utilities
- `assets/` - Images and other static files for documentation

### Major Configurations

- **Neovim** (`dot_config/nvim/`, `dot_config/nvim-lazyvimx/`) - Uses [LazyVimx](https://github.com/aimuzov/LazyVimx) configuration, supports stable and nightly versions
- **Fish Shell** (`dot_config/fish/`) - Comprehensive shell with custom functions, XDG compliance, theme switching
- **Zsh** (`dot_config/zsh/`) - Zsh shell configuration
- **Yabai** (`dot_config/yabai/`) - Tiling window manager with automatic space creation and application assignment
- **SketchyBar** (`dot_config/sketchybar/`) - Status bar written in Lua with modular item system
- **skhd** (`dot_config/skhd/`) - Hotkey daemon for window management keybindings
- **SketchyVim** (`dot_config/svim/`) - System-wide Vim-like navigation with Russian keyboard layout support
- **Karabiner** (`dot_config/private_karabiner/`) - Keyboard customization and complex modifications
- **JankyBorders** (`dot_config/borders/`) - Visual window borders for Yabai
- **Git** (`dot_config/git/`) - Git configuration with KeePassXC integration for secrets
- **Yazi** (`dot_config/yazi/`) - File manager with Catppuccin theme and custom plugins
- **LazyGit** (`dot_config/lazygit/`) - Git TUI with dark/light theme support
- **WezTerm** (`dot_config/wezterm/`) - Terminal emulator configuration
- **Ghostty** (`dot_config/ghostty/`) - Minimal terminal emulator configuration
- **Matterhorn** (`dot_config/matterhorn/`) - Terminal-based Mattermost client
- **Oh My Posh** (`dot_config/oh-my-posh/`) - Prompt theme engine
- **Raycast** (`dot_bin/raycast/`) - Script commands for productivity launcher
  - Tailscale VPN exit-node management
  - VM services restart (Yabai, skhd, SketchyBar, etc.)
  - Application launchers
  - See [Raycast documentation](raycast/README.md) for details
- **Zed** (`dot_config/zed/`) - Code editor configuration
- **Bat** (`dot_config/bat/`) - Cat clone with syntax highlighting
- **Vim** (`dot_config/vim/`) - Vim configuration
- **Mise** (`dot_config/mise/`) - Development tool version manager (replaces asdf)
- **Asdf** (`dot_config/asdf/`) - Legacy version manager configuration
- **Homebrew** (`dot_config/homebrew/`) - macOS package manager configuration (Brewfile)
- **NPM** (`dot_config/npm/`) - Node package manager configuration
- **Stylus** (`dot_config/stylus/`) - Browser extension styles

## Common Commands

### Chezmoi Operations

```bash
# Apply changes from dotfiles repository
chezmoi apply

# Edit a file in the dotfiles repository
chezmoi edit ~/.config/fish/config.fish

# Re-run install scripts
chezmoi init --apply

# View what would change without applying
chezmoi diff

# Add a new file to chezmoi
chezmoi add ~/.config/newapp/config.toml
```

### Package Management

```bash
# Install all packages (Homebrew + mise tools)
brew bundle install --file $XDG_CONFIG_HOME/homebrew/Brewfile
mise install -y

# Update mise tools
mise upgrade

# Update Homebrew packages
brew update && brew upgrade

# List installed mise tools
mise ls

# Install specific tool
mise use -g node@latest
```

### Raycast Script Commands

```bash
# Test script from command line
~/.bin/raycast/tailscale.sh enable

# Edit script in dotfiles
chezmoi edit ~/.bin/raycast/tailscale.sh

# Add new script to chezmoi
chezmoi add ~/.bin/raycast/new_script.sh
```

### Development Tools

All development tools are managed via mise (configured in `dot_config/mise/config.toml`):

**Languages:**

- Node.js (latest), Python (3.12), Ruby (latest), Go (latest), Rust (latest), Bun (latest)
- Neovim (both stable and nightly versions via custom asdf plugin)

**Package Managers:**

- pnpm (Node.js)
- pipx (Python)
- cargo (Rust)

**Tool Installation Backends:**

- `asdf:` - Traditional asdf plugins
- `cargo:` - Rust packages (eza, yazi, bottom, tokei, vivid, genact)
- `npm:` - Node packages (Claude Code, Arc CLI, SketchyBar App Font)
- `pipx:` - Python CLI tools (httpie, neovim-remote)
- `ubi:` - Direct GitHub releases (ripgrep, fd, bat, fzf, lazygit, chezmoi, etc.)

### Window Management & Desktop Environment

**Yabai & skhd keybindings:**

- `Alt + 1-9,0,-,=` - Switch to workspace 1-12
- `Alt + h/j/k/l` - Focus window (vim-like)
- `Alt + Shift + h/j/k/l` - Move window
- `Alt + Ctrl + arrows` - Resize window
- `Alt + Shift + f` - Toggle float
- `Alt + Shift + m` - Toggle fullscreen
- `Alt + Shift + e` - Balance windows

**SketchyBar:**

```bash
# Reload SketchyBar
sketchybar --reload

# Trigger specific event
sketchybar --trigger window_focus
```

**Services:**

```bash
# Start/stop Yabai
yabai --start-service
yabai --stop-service

# Start/stop skhd
skhd --start-service
skhd --stop-service

# Start/stop SketchyBar
brew services start sketchybar
brew services stop sketchybar
```

## Commit Conventions

This repository uses commitlint with conventional commits. Valid scopes are defined in `.commitlintrc.js`:

- Component scopes: `asdf`, `bat`, `borders`, `brew`, `claude`, `chezmoi`, `fish`, `ghostty`, `git`, `gitconfig`, `karabiner`, `lazygit`, `mise`, `nvim`, `oh-my-posh`, `raycast`, `sketchybar`, `skhd`, `ssh`, `svim`, `termscp`, `them-switcher`, `time`, `vscode`, `wezterm`, `yabai`, `yazi`, `zed`, `zrok`, `zsh`
- Generic scopes: `other`, `shell`, `install-script`

Commits must follow the format: `type(scope): description`

Example: `feat(nvim): add new keybinding for LSP actions`

Use `npm run commit` for interactive commit message creation.

## Architecture Notes

### Chezmoi Template System

Files with `.tmpl` extension are processed as Go templates. Common patterns:

**Variables:**

- `{{ .chezmoi.os }}` - Operating system (typically "darwin")
- `{{ .chezmoi.homeDir }}` - User's home directory
- `{{ .chezmoi.username }}` - Current user
- `{{ .chezmoi.hostname }}` - Machine hostname

**Conditional blocks:**

```go
{{ if (eq .chezmoi.os "darwin") -}}
# macOS-specific configuration
{{ end -}}
```

**KeePassXC integration for secrets:**

```go
{{ (keepassxcAttribute "entry-name" "attribute-name").Text }}
```

### Mise Tool Management

The `dot_config/mise/config.toml` defines all development tools using TOML format:

**Tool aliases** (shorthand names):

```toml
[alias]
neovim = "asdf:richin13/asdf-neovim"
```

**Tool versions:**

```toml
[tools]
node = "latest"
python = "3.12"
neovim = ["nightly", "stable"]  # Multiple versions supported
```

**Backend-specific tools:**

- `asdf:` - Traditional asdf plugins with repository path
- `cargo:` - Rust crates from crates.io
- `npm:` - Node packages with optional exe mapping
- `pipx:` - Python CLI applications
- `ubi:` - GitHub releases with automatic binary detection

### Theme Switching Architecture

The entire environment supports automatic dark/light theme switching based on macOS system appearance:

**Environment variable:**

- `MACOS_IS_DARK` - Set by system (true/false)

**Components that auto-switch:**

- Fish shell (Catppuccin Macchiato/Latte)
- Neovim (via LazyVimx)
- Yazi file manager
- LazyGit
- FZF (search tool)
- Bat (file viewer)
- Oh My Posh (prompt)

**Implementation:**

- Fish 4.3+ uses `fish_terminal_color_theme` variable that automatically updates when modern terminals (Ghostty, iTerm2, WezTerm) send OSC sequences
- The `reload_theme` function in `conf.d/theme_setup.fish` automatically triggers on `fish_terminal_color_theme` changes
- Theme-specific cache files stored separately
- Environment variables `MACOS_IS_DARK` and `CATPPUCCIN_FLAVOR` are set by `reload_theme` function
- Color schemes for fzf, bat, eza, and fish shell are reloaded automatically across all open sessions

### SketchyBar Architecture

SketchyBar is configured entirely in Lua with a modular structure:

**Core files:**

- `init.lua` - Entry point, requires all modules
- `bar.lua` - Bar appearance (position, height, colors)
- `config.lua` - Shared configuration (fonts, padding, colors)
- `default.lua` - Default item properties
- `executable_sketchybarrc` - Shell script that installs SbarLua and starts event loop

**Item structure:**

```
items/
├── init.lua           # Requires all items
├── left/              # Left-aligned items
│   ├── spaces.lua     # Yabai workspace indicators
│   └── yabai.lua      # Window layout status
└── right/             # Right-aligned items
    ├── keyboard_layout.lua  # Current input method
    ├── svim.lua       # SketchyVim mode indicator
    ├── battery.lua    # Battery status
    └── datetime.lua   # Date and time
```

**Event system:**

- Items subscribe to system events (window_focus, space_change, etc.)
- External triggers via `sketchybar --trigger event_name`
- Integration with Yabai signals for window management updates

### Fish Shell Architecture

**Directory structure:**

```
dot_config/fish/
├── config.fish.tmpl          # Main config (template for secrets)
├── conf.d/                   # Auto-loaded configs
│   └── recursive_paths.fish  # Function/completion path setup
└── functions/                # Custom functions
    ├── git/                  # Git-related functions
    ├── wrappers/             # Command wrappers
    └── *.fish                # Individual functions
```

**Initialization order:**

1. Environment variables set in `~/.zshenv` (loaded first, even for Fish)
2. `conf.d/` scripts auto-loaded
3. `config.fish.tmpl` main configuration
4. Functions loaded on-demand from `functions/`

**Key features:**

- XDG Base Directory compliance
- Recursive function/completion path discovery
- Cached initializations for performance (Homebrew, mise, zoxide)
- Vi mode with custom keybindings
- Automatic theme switching

### Yabai Window Management

**Configuration flow:**

1. Load scripting addition (requires SIP disabled)
2. Set up SketchyBar signals
3. Configure global settings (layout, padding, gaps, mouse)
4. Create/rename spaces dynamically
5. Assign applications to specific spaces
6. Set per-app layout exceptions

**Space management:**

- Spaces created automatically on startup
- Custom names for workspaces
- Application-to-space assignments
- Per-space layout rules

**Integration points:**

- skhd for keybindings
- SketchyBar for visual feedback
- Custom helper scripts in PATH (`yabai_space_focus`, `yabai_display_index_get`)

### Git Configuration

Located in `dot_config/git/config.tmpl`:

- Secrets loaded from KeePassXC via chezmoi templates (user name, email, GPG signing key)
- GPG commit signing enabled by default
- Custom pager: `diff-so-fancy` with color configuration
- Custom diff tool: `difftastic`
- Custom merge tool: Neovim with DiffviewOpen
- Git aliases:
  - `lg` - Pretty graph log with colors
  - `dlog` - Log with difftastic external diff
  - `dft` - Shortcut for difftool

## Installation

First boot setup (documented in README.md):

1. Install Xcode Command Line Tools: `xcode-select --install`
2. Install Homebrew
3. Install mise and fish: `brew install mise fish`
4. Install KeePassXC: `brew install --cask keepassxc`
5. Install chezmoi via mise: `mise install ubi:twpayne/chezmoi`
6. Initialize dotfiles: `$(mise where ubi:twpayne/chezmoi)/bin/chezmoi init --apply aimuzov`

The chezmoi scripts in `.chezmoiscripts/` automatically handle:

1. `run_once_after_1_install-packages.fish.tmpl` - Install Homebrew packages and mise tools
2. `run_once_after_2_configure-system.fish.tmpl` - Configure macOS system settings
3. `run_once_after_3_setup-theme-switcher.fish.tmpl` - Set up automatic theme switching
4. `run_once_after_4_setup-sketchybar.fish.tmpl` - Configure SketchyBar
5. `run_once_after_5_install-workflows.fish.tmpl` - Install custom workflows
6. `run_once_after_6_update_wezterm_icon.fish.tmpl` - Update WezTerm icon
7. `run_once_after_7_download-cht.fish.tmpl` - Download cheatsheets
8. `run_once_weekly_1_rebuild_cache.fish.tmpl` - Rebuild caches weekly

## Troubleshooting

### Yabai Not Working

- Check if Accessibility permissions are granted
- Verify scripting addition is loaded: `yabai -m query --windows`
- If using scripting addition, ensure SIP is disabled (see [Yabai wiki](https://github.com/koekeishiya/yabai/wiki/Disabling-System-Integrity-Protection))

### SketchyBar Not Showing

- Ensure SbarLua is installed: `brew install FelixKratz/formulae/sbarlua`
- Check service status: `brew services list | grep sketchybar`
- Reload manually: `sketchybar --reload`

### Fish Shell Not Loading Config

- Verify `~/.zshenv` sets `SHELL` and sources mise
- Check XDG directories exist: `echo $XDG_CONFIG_HOME`
- Test config: `fish --debug`

### Mise Tools Not Found

- Ensure mise is activated in shell: `mise doctor`
- Check PATH includes mise shims: `echo $PATH | grep mise`
- Reinstall tools: `mise install -y`

### Theme Not Switching

- Verify `MACOS_IS_DARK` environment variable: `echo $MACOS_IS_DARK`
- Check Fish terminal color theme: `echo $fish_terminal_color_theme`
- Verify your terminal supports OSC sequences (Ghostty, iTerm2, WezTerm do)
- Manually reload theme: `theme_reload` (or `tr` shortcut)
- Check if `reload_theme` function exists: `type reload_theme`
- Restart Fish shell if automatic detection fails

## Development Workflow

### Adding New Tools

1. Add to `dot_config/mise/config.toml` under appropriate backend
2. Run `mise install` to install
3. Commit changes with scope `mise`

### Adding New Config

1. Add file to appropriate `dot_config/` subdirectory
2. Use chezmoi naming conventions (`dot_`, `private_`, `executable_`, `.tmpl`)
3. Test with `chezmoi diff` before `chezmoi apply`
4. Commit with appropriate scope from `.commitlintrc.js`

### Modifying SketchyBar Items

1. Edit item file in `dot_config/sketchybar/items/`
2. Reload SketchyBar: `sketchybar --reload`
3. Check logs if not working: `log show --predicate 'process == "sketchybar"' --last 5m`

### Testing Yabai Changes

1. Edit `dot_config/yabai/executable_yabairc`
2. Reload config: `yabai --restart-service`
3. Check current layout: `yabai -m query --spaces --space`

## Related Documentation

Component-specific documentation (Russian and English versions available):

- [Chezmoi Scripts](chezmoiscripts/README.md)
- [Fish Shell Configuration](../dot_config/fish/README.md)
- [Git Configuration](../dot_config/git/README.md)
- [LazyGit Configuration](../dot_config/lazygit/README.md)
- [Mise Configuration](../dot_config/mise/README.md)
- [SketchyBar Configuration](../dot_config/sketchybar/README.md)
- [skhd Configuration](../dot_config/skhd/README.md)
- [SketchyVim Configuration](../dot_config/svim/README.md)
- [Yabai Configuration](../dot_config/yabai/README.md)
- [Yazi Configuration](../dot_config/yazi/README.md)
