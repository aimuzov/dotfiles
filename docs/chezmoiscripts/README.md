# Chezmoi Scripts

> 🇷🇺 [Русская версия](README.ru.md)
>
> **Location:** `home/.chezmoiscripts/` directory in the dotfiles repository

This directory contains automated setup scripts that run when initializing or updating dotfiles with chezmoi.

## Repository Structure Note

This repository uses `.chezmoiroot` to specify `home/` as the source state root. This means:
- Scripts are located at `home/.chezmoiscripts/` in the repository
- Chezmoi treats `home/` as the root, so paths within chezmoi are relative to `home/`

## Overview

Chezmoi scripts automate the setup and maintenance of the dotfiles environment. Scripts run automatically based on their naming conventions and execute in a specific order.

## Script Naming Convention

Scripts follow chezmoi's naming pattern:

```
run_<frequency>_<order>_<description>.fish.tmpl
```

**Components:**

- `run_` - Prefix indicating a script to execute
- `<frequency>` - When to run: `once`, `onchange`, `always`
- `<order>` - Execution order: `before`, `after` (with optional number)
- `<description>` - Descriptive name
- `.fish.tmpl` - Fish shell script with template support

**Examples:**

- `run_once_after_1_install-packages.fish.tmpl` - Run once, after chezmoi apply, first in order
- `run_once_weekly_1_rebuild_cache.fish.tmpl` - Run once per week, first in order

## Script Execution Order

Scripts in this directory execute in the following order:

### 1. Package Installation

**`run_once_after_1_install-packages.fish.tmpl`**

Installs all system packages and development tools:

- Homebrew packages from Brewfile
- Mise-managed tools (languages, CLI utilities)

```fish
brew bundle install --file $XDG_CONFIG_HOME/homebrew/Brewfile
mise install -y
```

**Runs:** Once after chezmoi apply
**Purpose:** Ensure all required software is installed

### 2. System Configuration

**`run_once_after_2_configure-system.fish.tmpl`**

Configures macOS system settings:

- Finder preferences
- Dock settings
- Keyboard/trackpad configuration
- Security settings
- Performance optimizations

**Runs:** Once after chezmoi apply
**Purpose:** Customize macOS to personal preferences

### 3. Theme Switcher Setup

**`run_once_after_3_setup-theme-switcher.fish.tmpl`**

Sets up automatic dark/light theme switching:

- Installs theme switching scripts
- Configures LaunchAgents
- Sets up system appearance monitoring

**Runs:** Once after chezmoi apply
**Purpose:** Enable automatic theme changes based on macOS appearance

### 4. SketchyBar Setup

**`run_once_after_4_setup-sketchybar.fish.tmpl`**

Configures SketchyBar status bar:

- Installs SbarLua plugin system
- Sets up SketchyBar plugins
- Configures bar items
- Starts SketchyBar service

**Runs:** Once after chezmoi apply
**Purpose:** Initialize custom status bar

### 5. Workflow Installation

**`run_once_after_5_install-workflows.fish.tmpl`**

Installs custom workflows and automation:

- Raycast scripts
- Alfred workflows (if used)
- Custom shell scripts to `~/bin/`

**Runs:** Once after chezmoi apply
**Purpose:** Set up productivity workflows

### 6. WezTerm Icon Update

**`run_once_after_6_update_wezterm_icon.fish.tmpl`**

Updates WezTerm terminal emulator icon:

- Downloads custom icon
- Applies to WezTerm.app
- Refreshes icon cache

**Runs:** Once after chezmoi apply
**Purpose:** Customize terminal appearance

### 7. Cheatsheet Download

**`run_once_after_7_download-cht.fish.tmpl`**

Downloads command-line cheatsheets:

- Installs cht.sh scripts
- Downloads common cheatsheets
- Sets up quick reference system

**Runs:** Once after chezmoi apply
**Purpose:** Provide offline command reference

### 8. Cache Rebuild (Weekly)

**`run_once_weekly_1_rebuild_cache.fish.tmpl`**

Rebuilds various caches for performance:

- Fish shell completions
- Homebrew cache
- Mise tool cache
- Font cache

**Runs:** Once per week
**Purpose:** Maintain optimal performance

## Script Features

### Template Support

Scripts use chezmoi templating (`.tmpl` extension):

```fish
{{ if (eq .chezmoi.os "darwin") -}}
# macOS-specific commands
{{ end -}}
```

**Available variables:**

- `{{ .chezmoi.os }}` - Operating system
- `{{ .chezmoi.homeDir }}` - Home directory
- `{{ .chezmoi.username }}` - Current user
- Custom variables from `.chezmoi.toml.tmpl`

### Environment Variables

Scripts have access to:

- `XDG_CONFIG_HOME` - Config directory (`~/.config`)
- `XDG_DATA_HOME` - Data directory (`~/.local/share`)
- `XDG_CACHE_HOME` - Cache directory (`~/.cache`)
- All user environment variables

### Error Handling

Scripts should include error handling:

```fish
if not command -v brew &> /dev/null
    echo "Homebrew not found, installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
end
```

## Manual Execution

### Run All Scripts

```bash
# Apply dotfiles and run scripts
chezmoi apply

# Dry run (see what would execute)
chezmoi apply --dry-run --verbose
```

### Run Specific Script

```bash
# Force re-run a once script
chezmoi state delete-bucket --bucket=scriptState
chezmoi apply

# Run script manually
fish .chezmoiscripts/run_once_after_1_install-packages.fish.tmpl
```

### Skip Scripts

```bash
# Apply without running scripts
chezmoi apply --exclude scripts
```

## Script State

Chezmoi tracks script execution in state database:

```bash
# View script state
chezmoi state dump

# Reset script state (force re-run)
chezmoi state delete-bucket --bucket=scriptState

# Reset specific script
chezmoi state delete --key=run_once_after_1_install-packages.fish.tmpl
```

## Adding New Scripts

### Creating a Script

1. Create file with proper naming:

```bash
touch .chezmoiscripts/run_once_after_8_my-setup.fish.tmpl
chmod +x .chezmoiscripts/run_once_after_8_my-setup.fish.tmpl
```

2. Add script content:

```fish
#!/usr/bin/env fish
# vi: ft=fish

{{ if (eq .chezmoi.os "darwin") -}}

echo "Running my custom setup..."

# Your commands here

{{ end -}}
```

3. Test the script:

```bash
fish .chezmoiscripts/run_once_after_8_my-setup.fish.tmpl
```

4. Commit and apply:

```bash
git add .chezmoiscripts/run_once_after_8_my-setup.fish.tmpl
git commit -m "feat(chezmoi): add custom setup script"
chezmoi apply
```

### Script Types

**Run once:**

```
run_once_after_N_name.fish.tmpl
```

Executes once, tracked in state database.

**Run on change:**

```
run_onchange_after_N_name.fish.tmpl
```

Executes when script content changes.

**Run always:**

```
run_after_N_name.fish.tmpl
```

Executes every time `chezmoi apply` runs.

**Before apply:**

```
run_before_N_name.fish.tmpl
```

Executes before files are written.

## Best Practices

### Idempotency

Scripts should be idempotent (safe to run multiple times):

```fish
# Check before creating
if not test -d ~/some-directory
    mkdir -p ~/some-directory
end

# Check before installing
if not command -v some-tool &> /dev/null
    brew install some-tool
end
```

### Logging

Add informative output:

```fish
echo "→ Installing packages..."
brew bundle install --file $XDG_CONFIG_HOME/homebrew/Brewfile
echo "✓ Packages installed"
```

### Error Messages

Provide clear error messages:

```fish
if not test -f ~/.config/some/config
    echo "✗ Error: Configuration file not found"
    echo "  Please run: chezmoi apply"
    exit 1
end
```

### Performance

Minimize slow operations:

- Cache expensive checks
- Run long operations in background
- Skip unnecessary work

```fish
# Skip if already done
if test -f ~/.setup-complete
    exit 0
end

# Mark as complete
touch ~/.setup-complete
```

## Troubleshooting

### Script Not Running

- Check filename matches pattern: `run_*`
- Verify script is executable: `chmod +x script.fish.tmpl`
- Check script state: `chezmoi state dump`
- Force re-run: `chezmoi state delete-bucket --bucket=scriptState`

### Script Fails

- Run manually to see errors: `fish script.fish.tmpl`
- Check logs in verbose mode: `chezmoi apply --verbose`
- Verify environment variables are set
- Test template rendering: `chezmoi execute-template < script.fish.tmpl`

### Script Runs Too Often

- Ensure using `run_once_*` not `run_*`
- Check script hasn't been modified (triggers `onchange`)
- Verify state is being saved: `chezmoi state dump`

### Dependencies Missing

- Ensure order numbers are correct (1, 2, 3...)
- Install dependencies in earlier scripts
- Add dependency checks in script

## Security Considerations

- Scripts run with user permissions
- Avoid hardcoding secrets (use KeePassXC integration)
- Be careful with `sudo` commands
- Review scripts before running on new machine
- Keep scripts in version control

## Integration with Dotfiles

Scripts work together with dotfiles:

1. **Before Scripts** - Prepare environment
2. **Dotfiles Apply** - Files copied to home directory
3. **After Scripts** - Configure software, run setup

This ensures:

- Tools are installed before configs are applied
- Configs are in place before services start
- System is fully configured and ready to use

## Links

- [Chezmoi Scripts Documentation](https://www.chezmoi.io/user-guide/use-scripts-to-perform-actions/)
- [Script Order](https://www.chezmoi.io/reference/source-state-attributes/)
- [Template Syntax](https://www.chezmoi.io/user-guide/templating/)
