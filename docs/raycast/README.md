# Raycast Scripts Configuration

> 🇷🇺 [Русская версия](README.ru.md)

## Table of Contents

- [Overview](#overview)
- [Script Metadata Format](#script-metadata-format)
- [Available Scripts](#available-scripts)
  - [Tailscale Exit Node Selection](#tailscale-exit-node-selection)
  - [Tailscale Status](#tailscale-status)
  - [YouTube Video Download](#youtube-video-download)
  - [VM Services Restart](#vm-services-restart)
  - [Dota 2 Launcher](#dota-2-launcher)
- [Adding New Scripts](#adding-new-scripts)
- [Integration with Fish Functions](#integration-with-fish-functions)
- [Troubleshooting](#troubleshooting)

## Overview

Raycast Script Commands are bash scripts that integrate with Raycast for quick task execution through the command palette. Scripts use special metadata in comments to configure display and behavior.

### Location

- Source files: `dot_bin/raycast/executable_*.sh`
- After applying chezmoi: `~/.bin/raycast/*.sh`
- Raycast automatically discovers scripts in the `~/.bin/raycast/` directory

### Management via chezmoi

All scripts are managed through chezmoi:
- The `executable_` prefix makes scripts executable
- Changes are applied via `chezmoi apply`
- Edit scripts with `chezmoi edit ~/.bin/raycast/<script>.sh`

## Script Metadata Format

Raycast uses comments at the beginning of the script to configure behavior.

### Required Parameters

```bash
# @raycast.schemaVersion 1
# @raycast.title <Command Name>
# @raycast.mode <silent|compact|fullOutput|inline>
```

- **schemaVersion**: Metadata schema version (always `1`)
- **title**: Name displayed in Raycast
- **mode**: Output mode
  - `silent` — no output, execution only
  - `compact` — compact window with result
  - `fullOutput` — full output
  - `inline` — result in search bar

### Optional Parameters

#### Icon

```bash
# @raycast.icon <path or URL>
```

Examples:
- Local path: `/Applications/Tailscale.app/Contents/Resources/AppIcon.icns`
- URL: `https://cdn.example.com/icon.png`
- Emoji: `🚀`

#### Arguments (up to 3 arguments)

##### Dropdown Argument

```bash
# @raycast.argument1 { "type": "dropdown", "placeholder": "Select", "data": [{"title": "Option 1", "value": "value1"}, {"title": "Option 2", "value": "value2"}] }
```

- `type`: Argument type (`dropdown`, `text`, `password`)
- `placeholder`: Hint text
- `data`: Array of options with `title` (display) and `value` (actual value)

##### Text Argument

```bash
# @raycast.argument1 { "type": "text", "placeholder": "Enter text" }
```

### Accessing Arguments in Script

Arguments are available as positional parameters: `$1`, `$2`, `$3`

## Available Scripts

### Tailscale Exit Node Selection

**File:** [`home/dot_bin/raycast/executable_tailscale_pick_node.sh`](../../home/dot_bin/raycast/executable_tailscale_pick_node.sh)

**Purpose:** Interactive selection of Tailscale exit-node from available peers.

**How it works:**
1. Gets list of available peers via `tailscale status --json`
2. Presents interactive picker for node selection
3. Sets selected node as exit-node via `tailscale set --exit-node=<peer>`

**Usage:**
1. Invoke Raycast (⌘Space)
2. Type "tailscale pick"
3. Select desired exit node from the list

**Requirements:**
- Installed Tailscale
- `jq` for JSON processing
- Fish shell at `/opt/homebrew/bin/fish`

**Related Files:**
- Fish implementation: [`executable_tailscale_pick_node.fish`](../../home/dot_bin/raycast/executable_tailscale_pick_node.fish)
- SketchyBar integration: [`tailscale.lua`](../../home/dot_config/sketchybar/items/right/tailscale.lua)

---

### Tailscale Status

**File:** [`home/dot_bin/raycast/executable_tailscale_status.sh`](../../home/dot_bin/raycast/executable_tailscale_status.sh)

**Purpose:** Display current Tailscale connection status and exit-node information.

**How it works:**
1. Queries Tailscale status
2. Shows current connection state
3. Displays active exit-node if configured

**Usage:**
1. Invoke Raycast (⌘Space)
2. Type "tailscale status"
3. View current VPN status

**Related Files:**
- Fish implementation: [`executable_tailscale_status.fish`](../../home/dot_bin/raycast/executable_tailscale_status.fish)

---

### YouTube Video Download

**File:** [`home/dot_bin/raycast/executable_youtube-download.sh`](../../home/dot_bin/raycast/executable_youtube-download.sh)

**Purpose:** Download YouTube videos using yt-dlp.

**How it works:**
1. Takes YouTube URL as input
2. Downloads video using yt-dlp
3. Saves to configured download directory

**Usage:**
1. Copy YouTube URL to clipboard
2. Invoke Raycast (⌘Space)
3. Type "youtube download"

**Requirements:**
- `yt-dlp` installed (via mise/homebrew)
- Fish shell at `/opt/homebrew/bin/fish`

**Related Files:**
- Fish implementation: [`executable_youtube-download.fish`](../../home/dot_bin/raycast/executable_youtube-download.fish)

### VM Services Restart

**File:** [`home/dot_bin/raycast/executable_restart-vm.sh`](../../home/dot_bin/raycast/executable_restart-vm.sh)

**Purpose:** Restarts all window manager services and related components (Yabai, skhd, Borders, SketchyVim, SketchyBar).

**Functionality:**

Calls the Fish function `restart_vm`, which sequentially restarts:
1. Yabai (tiling window manager)
2. skhd (hotkey daemon)
3. Borders (visual window borders)
4. SketchyVim (system-wide Vim-like navigation)
5. SketchyBar (status bar)

**Usage:**
1. Invoke Raycast (⌘Space)
2. Type "restart vm"
3. Press Enter

**When to Use:**
- After changing Yabai/skhd configuration
- When window manager hangs
- After updating components

**Related Files:**
- Fish function: [`home/dot_config/fish/functions/core/restart_vm.fish`](../../home/dot_config/fish/functions/core/restart_vm.fish)
- Configurations:
  - [Yabai](../../home/dot_config/yabai/executable_yabairc)
  - [skhd](../../home/dot_config/skhd/skhdrc)
  - [SketchyBar](../../home/dot_config/sketchybar/)
  - [SketchyVim](../../home/dot_config/svim/)

**See Also:**
- [Yabai documentation](../yabai/README.md)
- [skhd documentation](../skhd/README.md)
- [SketchyBar documentation](../sketchybar/README.md)

### Dota 2 Launcher

**File:** [`home/dot_bin/raycast/executable_dota2.sh`](../../home/dot_bin/raycast/executable_dota2.sh)

**Purpose:** Quick launch of Dota 2 through Steam.

**Functionality:**
- Launches Dota 2 directly via Steam's shell script
- Bypasses the need to open Steam UI

**Usage:**
1. Invoke Raycast (⌘Space)
2. Type "Dota 2"
3. Press Enter

**Requirements:**
- Installed Steam
- Installed Dota 2
- Path: `~/Library/Application Support/Steam/steamapps/common/dota 2 beta/game/dota.sh`

**Note:** The path is hardcoded for a specific user. Using on another system will require updating the path.

## Adding New Scripts

### Step 1: Create File

Create a file in the `dot_bin/raycast/` directory with the `executable_` prefix:

```bash
# In the dotfiles repository
touch dot_bin/raycast/executable_my_script.sh
```

### Step 2: Add Metadata

Add Raycast metadata at the beginning of the file:

```bash
#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title My Script
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🚀

# Your code here
```

### Step 3: Implement Logic

Three main patterns:

#### Simple Command

```bash
#!/bin/bash
# ... metadata ...

# Direct command execution
osascript -e 'tell application "Music" to playpause'
```

#### Script with Arguments

```bash
#!/bin/bash
# ... metadata ...
# @raycast.argument1 { "type": "text", "placeholder": "Name" }

echo "Hello, $1!"
```

#### Integration with Fish Function

```bash
#!/bin/bash
# ... metadata ...

# Call existing Fish function
/opt/homebrew/bin/fish -c "my_fish_function"
```

### Step 4: Apply via chezmoi

```bash
# Apply changes
chezmoi apply

# Verify script is executable
ls -la ~/.bin/raycast/my_script.sh
```

### Step 5: Test in Raycast

1. Open Raycast (⌘Space)
2. Type your script name
3. Raycast will automatically discover the new script

### Universal Script Template

```bash
#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Template Script
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🛠️
# @raycast.argument1 { "type": "dropdown", "placeholder": "Action", "data": [{"title": "Action 1", "value": "action1"}, {"title": "Action 2", "value": "action2"}] }

# Check argument
if [ -z "$1" ]; then
    echo "❌ No argument provided"
    exit 1
fi

# Process argument
case "$1" in
    "action1")
        echo "✅ Executing action 1"
        # Your code
        ;;
    "action2")
        echo "✅ Executing action 2"
        # Your code
        ;;
    *)
        echo "❌ Unknown action: $1"
        exit 1
        ;;
esac
```

### Best Practices

1. **Use absolute paths** for executables:
   ```bash
   /opt/homebrew/bin/fish  # ✅ Good
   fish                     # ❌ Bad (may not be found)
   ```

2. **Handle errors**:
   ```bash
   if ! command -v tailscale &> /dev/null; then
       echo "❌ Tailscale not found"
       exit 1
   fi
   ```

3. **Use informative messages** for `compact` and `fullOutput` modes

4. **Document dependencies** in comments

5. **Test from command line** before adding to Raycast

## Integration with Fish Functions

### Why Use Fish Functions

Raycast scripts are written in bash, but you can call Fish functions to:
- Use existing logic from Fish configuration
- Access Fish environment variables
- Reuse code between Fish and Raycast

### Basic Pattern

```bash
#!/bin/bash
# Raycast metadata...

/opt/homebrew/bin/fish -c "fish_function_name"
```

### Passing Arguments

```bash
#!/bin/bash
# @raycast.argument1 { "type": "text", "placeholder": "Value" }

/opt/homebrew/bin/fish -c "fish_function_name \"$1\""
```

### Example: restart_vm

**Raycast script** ([`executable_restart-vm.sh`](../../dot_bin/raycast/executable_restart-vm.sh)):
```bash
#!/bin/bash
# ... metadata ...
/opt/homebrew/bin/fish -c "restart_vm"
```

**Fish function** ([`restart_vm.fish`](../../dot_config/fish/functions/core/restart_vm.fish)):
```fish
function restart_vm
    yabai --restart-service
    skhd --restart-service
    brew services restart borders
    brew services restart svim
    brew services restart sketchybar
    echo "vm is restarted"
end
```

### Creating Fish Function for Raycast

1. Create function in `dot_config/fish/functions/`:
   ```fish
   # dot_config/fish/functions/core/my_raycast_function.fish
   function my_raycast_function
       # Your logic
   end
   ```

2. Create Raycast script:
   ```bash
   # dot_bin/raycast/executable_my_script.sh
   #!/bin/bash
   # ... metadata ...
   /opt/homebrew/bin/fish -c "my_raycast_function"
   ```

3. Apply changes:
   ```bash
   chezmoi apply
   ```

### Advantages

- ✅ Single codebase for Fish and Raycast
- ✅ Access to Fish environment and configuration
- ✅ Easier to test (can call function directly in Fish)
- ✅ Reuse existing functions

### See Also

- [Fish Shell documentation](../fish/README.md)
- [Fish functions for system management](../fish/README.md#custom-functions)

## Troubleshooting

### Script Not Appearing in Raycast

**Problem:** New script doesn't appear in Raycast after creation.

**Solutions:**
1. Verify script is in `~/.bin/raycast/` (not in source `dot_bin/`)
2. Check execute permissions: `ls -la ~/.bin/raycast/`
3. Verify metadata format (especially `schemaVersion`, `title`, `mode`)
4. Restart Raycast: `killall Raycast && open -a Raycast`

### Permission Denied Error

**Problem:** Script fails with "Permission denied" error.

**Solutions:**
1. Check script has execute permissions:
   ```bash
   ls -la ~/.bin/raycast/script.sh
   ```
2. If not executable:
   ```bash
   chmod +x ~/.bin/raycast/script.sh
   ```
3. Verify chezmoi uses `executable_` prefix in source file

### Command Not Found

**Problem:** Script fails with "command not found" for tools like `tailscale`, `jq`, etc.

**Solutions:**
1. Use absolute paths:
   ```bash
   /opt/homebrew/bin/tailscale  # Instead of just 'tailscale'
   ```
2. Find command location:
   ```bash
   which tailscale
   ```
3. Verify tool is installed:
   ```bash
   brew list | grep tailscale
   ```

### Fish Function Not Working

**Problem:** Fish function call fails from Raycast script.

**Solutions:**
1. Verify Fish path: `/opt/homebrew/bin/fish` (not `/usr/local/bin/fish`)
2. Test function directly in Fish:
   ```fish
   fish -c "function_name"
   ```
3. Check function is defined:
   ```fish
   type function_name
   ```
4. Verify function file exists: `ls ~/.config/fish/functions/`

### Metadata Not Recognized

**Problem:** Raycast doesn't recognize metadata parameters.

**Solutions:**
1. Verify metadata is in comments at the top of file (before any code)
2. Check exact format: `# @raycast.parameterName value`
3. Validate JSON for arguments (use online JSON validator)
4. Ensure no typos in parameter names

### Script Execution Hangs

**Problem:** Script runs but never completes.

**Solutions:**
1. Test script from terminal:
   ```bash
   ~/.bin/raycast/script.sh argument
   ```
2. Add timeout to commands:
   ```bash
   timeout 10s command_that_might_hang
   ```
3. Check for missing input (script waiting for stdin)
4. Add debug output:
   ```bash
   echo "Step 1 completed"
   ```

### Wrong Argument Values

**Problem:** Script receives incorrect argument values.

**Solutions:**
1. Verify dropdown `value` field (not `title` which is displayed)
2. Check argument order: `$1`, `$2`, `$3` match declaration order
3. Test with debug output:
   ```bash
   echo "Received argument: $1"
   ```
4. Verify quotes in JSON: use `\"` for nested quotes
