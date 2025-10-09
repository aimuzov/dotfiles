# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Quick Reference

This is a personal macOS dotfiles repository managed with [chezmoi](https://www.chezmoi.io/). For detailed documentation, see [docs/OVERVIEW.md](docs/OVERVIEW.md).

### Essential Information

**Repository type:** Dotfiles managed with chezmoi
**Target OS:** macOS
**Main technologies:** Fish shell, Yabai, SketchyBar, Neovim, mise

### Chezmoi Naming Conventions

- `dot_` prefix → `.` (e.g., `dot_config` → `.config`)
- `private_` prefix → files excluded from git
- `.tmpl` suffix → Go template files
- `executable_` prefix → executable files

### Quick Commands

```bash
# Apply dotfiles changes
chezmoi apply

# Edit config file
chezmoi edit ~/.config/fish/config.fish

# Install packages
brew bundle install --file $XDG_CONFIG_HOME/homebrew/Brewfile
mise install -y

# Window management
yabai --restart-service
sketchybar --reload
```

### Commit Conventions

Uses conventional commits with scopes from `.commitlintrc.js`:

**Component scopes:** `asdf`, `bat`, `borders`, `brew`, `chezmoi`, `fish`, `ghostty`, `git`, `karabiner`, `lazygit`, `mise`, `nvim`, `oh-my-posh`, `raycast`, `sketchybar`, `skhd`, `ssh`, `svim`, `wezterm`, `yabai`, `yazi`, `zed`, `zsh`

**Generic scopes:** `other`, `shell`, `install-script`

Format: `type(scope): description`

Example: `feat(nvim): add new keybinding for LSP actions`

### Key Directories

- `.chezmoiscripts/` - Setup scripts (Fish shell, run after chezmoi apply)
- `.chezmoiexternals/` - External dependencies (plugins for fish, yazi, nvim)
- `dot_config/` - Application configs (becomes `~/.config/`)
- `dot_bin/` - User scripts
- `docs/` - Documentation
- `assets/` - Static files for documentation

### Major Components

- **Neovim** - LazyVimx configuration, stable + nightly versions
- **Fish Shell** - Custom functions, XDG compliance, theme switching
- **Yabai** - Tiling window manager with auto space creation
- **SketchyBar** - Lua-based status bar with modular items
- **skhd** - Hotkey daemon for window management
- **SketchyVim** - System-wide Vim navigation with Russian layout support
- **Git** - KeePassXC integration for secrets, GPG signing
- **mise** - Development tools manager (replaces asdf)

### Development Workflow

1. **Add new tool:** Update `dot_config/mise/config.toml` → `mise install` → commit with scope `mise`
2. **Add new config:** Add to `dot_config/` → test with `chezmoi diff` → `chezmoi apply` → commit with appropriate scope
3. **Modify SketchyBar:** Edit `dot_config/sketchybar/items/` → `sketchybar --reload`
4. **Test Yabai:** Edit `dot_config/yabai/executable_yabairc` → `yabai --restart-service`

### Documentation Structure

- [Overview & Architecture](docs/OVERVIEW.md) - Complete documentation
- [Chezmoi Scripts](docs/chezmoiscripts/README.md) - Setup automation
- Component docs in `dot_config/*/README.md` (Russian & English):
  - [Fish Shell](dot_config/fish/README.md)
  - [Git](dot_config/git/README.md)
  - [LazyGit](dot_config/lazygit/README.md)
  - [Mise](dot_config/mise/README.md)
  - [SketchyBar](dot_config/sketchybar/README.md)
  - [skhd](dot_config/skhd/README.md)
  - [SketchyVim](dot_config/svim/README.md)
  - [Yabai](dot_config/yabai/README.md)
  - [Yazi](dot_config/yazi/README.md)
