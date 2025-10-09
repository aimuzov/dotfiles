# LazyGit Configuration

> 🇷🇺 [Русская версия](README.ru.md)

This directory contains configuration for [LazyGit](https://github.com/jesseduffield/lazygit) — a simple terminal UI for git commands.

## Overview

LazyGit provides an intuitive terminal-based interface for managing Git repositories. This configuration includes theme customization with automatic dark/light mode switching.

## Files

- `config.yml` - Main LazyGit configuration
- `theme-dark.yml` - Dark theme colors (Catppuccin Macchiato)
- `theme-light.yml` - Light theme colors (Catppuccin Latte)

## Features

### Automatic Theme Switching

LazyGit automatically switches between dark and light themes based on macOS system appearance:

- **Dark mode** → Uses `theme-dark.yml` (Catppuccin Macchiato)
- **Light mode** → Uses `theme-light.yml` (Catppuccin Latte)

The theme is detected via the `MACOS_IS_DARK` environment variable, which is set by Fish shell configuration.

### Configuration Structure

The `config.yml` includes:

```yaml
gui:
  theme:
    selectedLineBgColor:
      - {{ if eq (env "MACOS_IS_DARK") "true" }}
        - "#theme-dark-color"
        {{ else }}
        - "#theme-light-color"
        {{ end }}
```

### Catppuccin Theme

Both themes use the Catppuccin color scheme:

**Catppuccin Macchiato** (Dark):
- Rosewater, Flamingo, Pink, Mauve
- Red, Maroon, Peach, Yellow
- Green, Teal, Sky, Sapphire, Blue, Lavender

**Catppuccin Latte** (Light):
- Same color names with lighter variants
- Optimized for light backgrounds
- Better contrast for daylight viewing

## Usage

### Starting LazyGit

```bash
# From any git repository
lazygit

# From Fish shell (uses wrapper function)
lg
```

### Basic Navigation

**Panel Navigation:**
- `1-5` - Switch between panels (Status, Files, Branches, Commits, Stash)
- `Tab` - Next panel
- `Shift+Tab` - Previous panel
- `[` / `]` - Previous/next tab within panel

**List Navigation:**
- `j/k` or `↓/↑` - Move down/up
- `g/G` - Jump to top/bottom
- `/` - Search
- `n/N` - Next/previous search result

### Common Operations

**File Operations:**
- `Space` - Stage/unstage file
- `a` - Stage all files
- `d` - Show file diff
- `e` - Edit file
- `o` - Open file
- `c` - Commit changes
- `Shift+c` - Commit using git-flow

**Branch Operations:**
- `n` - Create new branch
- `Space` - Checkout branch
- `d` - Delete branch
- `r` - Rebase onto branch
- `m` - Merge into current branch
- `f` - Fast-forward branch

**Commit Operations:**
- `s` - Squash commits
- `r` - Reword commit
- `d` - Delete commit
- `e` - Edit commit
- `p` - Pick commit (rebase)
- `f` - Fixup commit

**Remote Operations:**
- `p` - Pull
- `Shift+p` - Push
- `Shift+f` - Force push
- `f` - Fetch

### Git Flow Integration

LazyGit supports git-flow workflow:
- Create feature/bugfix/hotfix branches
- Finish flows with automated merging
- Track flow branches

## Integration

### Fish Shell Wrapper

The Fish shell includes a wrapper function (`functions/wrappers/lazygit.fish`) that:
- Sets appropriate environment variables
- Ensures theme detection works correctly
- Provides better integration with Fish

### Terminal Integration

LazyGit works best in terminals with true color support:
- WezTerm ✅
- Ghostty ✅
- iTerm2 ✅
- Terminal.app ⚠️ (limited color support)

## Customization

### Modifying Themes

Edit `theme-dark.yml` or `theme-light.yml`:

```yaml
activeBorderColor:
  - "#89b4fa"  # Blue accent color
  inactiveBorderColor:
  - "#45475a"  # Subtle gray
```

After editing, restart LazyGit to see changes.

### Adding Custom Commands

Edit `config.yml` to add custom commands:

```yaml
customCommands:
  - key: 'C'
    command: 'git commit --amend --no-edit'
    description: 'Amend commit without editing'
    context: 'files'
```

### Changing Keybindings

Modify keybindings in `config.yml`:

```yaml
keybinding:
  universal:
    quit: 'q'
    return: 'Esc'
```

## Tips & Tricks

### Quick Actions

- `x` - Open menu for current context
- `?` - Open help menu
- `Ctrl+r` - Recent repositories
- `Ctrl+s` - View filtering options
- `:` - Execute custom command

### Viewing Changes

- `d` - View full diff
- `Enter` - View file/commit details
- `w` - Toggle whitespace in diff

### Stash Operations

- `s` - Stash changes
- `g` - Pop stash
- `d` - Drop stash
- `Space` - Apply stash

### Filtering

- `Ctrl+s` - Open filter menu
- Filter by author, date, path, etc.
- Clear filters with `Esc`

## Troubleshooting

### Theme Not Switching

- Verify `MACOS_IS_DARK` is set: `echo $MACOS_IS_DARK`
- Restart Fish shell: `exec fish`
- Check macOS appearance: `defaults read -g AppleInterfaceStyle`

### Colors Look Wrong

- Ensure terminal supports true color
- Check `$TERM` variable: should be `xterm-256color` or better
- Update terminal emulator

### LazyGit Not Found

- Verify installation: `which lazygit`
- Check mise installation: `mise ls | grep lazygit`
- Reinstall: `mise install ubi:jesseduffield/lazygit`

### Git Operations Fail

- Check git configuration: `git config --list`
- Verify SSH keys are set up
- Check repository status: `git status`

## Configuration Reference

### Main Configuration Options

```yaml
gui:
  showFileTree: true          # Show files in tree view
  showListFooter: true        # Show footer with shortcuts
  showRandomTip: true         # Show tips on startup
  showCommandLog: true        # Show git commands executed
  mouseEvents: true           # Enable mouse support
  skipUnstageLineWarning: false
  skipStashWarning: false

git:
  paging:
    colorArg: always          # Always use colors
    pager: diff-so-fancy      # Use diff-so-fancy for diffs

  commit:
    signOff: false            # Don't sign-off commits by default

  merging:
    manualCommit: false       # Auto-commit after merge

refresher:
  refreshInterval: 10         # Refresh every 10 seconds
  fetchInterval: 60           # Fetch from remote every 60 seconds
```

## Links

- [LazyGit Documentation](https://github.com/jesseduffield/lazygit)
- [Catppuccin Theme](https://github.com/catppuccin/catppuccin)
- [Git Flow Cheatsheet](https://danielkummer.github.io/git-flow-cheatsheet/)
