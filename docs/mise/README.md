# Mise Configuration

> 🇷🇺 [Русская версия](README.ru.md)

This directory contains configuration for [mise](https://mise.jdx.dev/) — a polyglot tool version manager and dev environment manager.

## Overview

Mise manages all development tools and language runtimes in this dotfiles setup. It replaces multiple version managers (nvm, rbenv, pyenv, etc.) with a single unified tool.

## Files

- `config.toml` - Main mise configuration defining all tools and versions

## Tool Backends

Mise supports multiple backends for installing tools:

### asdf Backend

Traditional asdf plugins with custom repositories:

```toml
[alias]
neovim = "asdf:richin13/asdf-neovim"
node = "asdf:asdf-vm/asdf-nodejs"
pipx = "asdf:yozachar/asdf-pipx"
python = "asdf:asdf-community/asdf-python"
ruby = "asdf:asdf-vm/asdf-ruby"
```

### cargo Backend

Rust packages from crates.io:

```toml
"cargo:bottom" = "latest"      # System monitor
"cargo:eza" = "latest"         # Modern ls replacement
"cargo:genact" = "latest"      # Activity generator
"cargo:tokei" = "latest"       # Code statistics
"cargo:vivid" = "latest"       # LS_COLORS generator
"cargo:yazi-cli" = "latest"    # File manager CLI
"cargo:yazi-fm" = "latest"     # File manager
```

### npm Backend

Node.js packages with optional exe mapping:

```toml
"npm:@aimuzov/sketchybar-app-font" = { version = "latest", exe = "sketchybar-app-font" }
"npm:@anthropic-ai/claude-code" = { version = "latest" }
"npm:@georgesg/arc-cli" = { version = "latest", exe = "arc-cli" }
```

### pipx Backend

Python CLI applications in isolated environments:

```toml
"pipx:httpie" = "latest"          # HTTP client
"pipx:neovim-remote" = "latest"   # Neovim remote control
```

### ubi Backend

Direct GitHub releases with automatic binary detection:

```toml
"ubi:ajeetdsouza/zoxide" = "latest"                              # Directory jumper
"ubi:BurntSushi/ripgrep" = { version = "latest", exe = "rg" }    # Fast grep
"ubi:cli/cli" = { version = "latest", exe = "gh" }               # GitHub CLI
"ubi:jesseduffield/lazygit" = "latest"                           # Git TUI
"ubi:junegunn/fzf" = "latest"                                    # Fuzzy finder
"ubi:sharkdp/bat" = "latest"                                     # Cat with wings
"ubi:sharkdp/fd" = "latest"                                      # Find alternative
"ubi:twpayne/chezmoi" = "latest"                                 # Dotfiles manager
```

## Installed Tools

### Languages & Runtimes

```toml
[tools]
bun = "latest"                    # JavaScript runtime
go = "latest"                     # Go language
neovim = ["nightly", "stable"]    # Text editor (multiple versions)
node = "latest"                   # Node.js
pipx = "latest"                   # Python app installer
pnpm = "latest"                   # Node.js package manager
python = "3.12"                   # Python (specific version)
ruby = "latest"                   # Ruby language
rust = "latest"                   # Rust language
```

### CLI Tools

**File Management:**
- `bat` - Cat with syntax highlighting
- `eza` - Modern ls replacement
- `fd` - User-friendly find
- `yazi` - Terminal file manager
- `zoxide` - Smarter cd command

**Development:**
- `gh` - GitHub CLI
- `glab` - GitLab CLI
- `lazygit` - Git terminal UI
- `difftastic` - Structural diff tool
- `diff-so-fancy` - Readable diffs

**Search & Navigation:**
- `fzf` - Fuzzy finder
- `ripgrep` - Fast grep alternative
- `ast-grep` - Code search tool

**Utilities:**
- `bottom` - System monitor
- `chezmoi` - Dotfiles manager
- `glow` - Markdown renderer
- `httpie` - HTTP client
- `jq` - JSON processor
- `ouch` - Archive utility
- `tokei` - Code statistics

**Specialized:**
- `nowplaying-cli` - macOS now playing info
- `oh-my-posh` - Prompt theme engine
- `sketchybar-app-font` - SketchyBar icon font generator

## Usage

### Installing Tools

```bash
# Install all tools from config
mise install

# Install specific tool
mise install node@latest

# Install specific version
mise install python@3.11

# Install from current directory's .tool-versions
mise install
```

### Listing Tools

```bash
# List all installed tools
mise ls

# List available versions for a tool
mise ls-remote node

# Show tool installation path
mise where node

# Show tool binary path
mise which node
```

### Using Tools

```bash
# Use tool globally
mise use -g node@latest

# Use tool for current directory
mise use node@20

# Use specific version temporarily
mise exec node@18 -- node script.js
```

### Managing Tools

```bash
# Update all tools
mise upgrade

# Update specific tool
mise upgrade node

# Uninstall tool version
mise uninstall node@18

# Remove unused tools
mise prune
```

### Environment

```bash
# Show mise environment
mise env

# Activate mise in current shell
eval "$(mise activate fish)"

# Show mise doctor (diagnostics)
mise doctor

# Show mise configuration
mise config
```

## Version Selection

Mise uses multiple sources to determine which version to use (in order):

1. `.tool-versions` file in current directory
2. `.mise.toml` file in current directory
3. Global config (`~/.config/mise/config.toml`)
4. Environment variables (`MISE_NODE_VERSION`)

### Per-Project Versions

Create `.tool-versions` in project directory:

```
node 20.0.0
python 3.11.0
ruby 3.2.0
```

Or use `.mise.toml`:

```toml
[tools]
node = "20"
python = "3.11"
```

## Configuration Options

### Settings

```toml
[settings]
experimental = true                           # Enable experimental features
idiomatic_version_file_enable_tools = []     # Tools that support .nvmrc, etc.
```

### Tool-Specific Options

Some tools support additional configuration:

```toml
# Node.js with specific options
"npm:package" = {
  version = "latest",
  exe = "binary-name",          # Executable name if different from package
  install = "npm install -g"    # Custom install command
}

# UBI with provider specification
"ubi:gitlab-org/cli" = {
  version = "latest",
  provider = "gitlab",          # Use GitLab instead of GitHub
  exe = "glab"
}
```

## Integration

### Fish Shell

Mise is activated in Fish shell via `config.fish.tmpl`:

```fish
# Activate mise
mise activate fish | source

# Completion
mise completion fish | source
```

### Environment Variables

Mise sets up environment automatically:
- Adds tool bins to PATH
- Sets language-specific variables
- Manages shims

## Performance

### Caching

Mise caches tool information for performance:
- Version detection
- Binary locations
- Environment setup

Cache location: `~/.cache/mise/`

### Lazy Loading

Tools are loaded lazily when needed:
- Minimal shell startup time
- Fast directory switching
- Efficient version switching

## Advanced Usage

### Custom Tool Definitions

Add custom tools to config:

```toml
[tools]
"ubi:user/repo" = { version = "latest", exe = "binary" }
```

### Environment-Specific Configuration

```toml
[env]
NODE_ENV = "development"
RUST_BACKTRACE = "1"
```

### Task Runner

Mise can run tasks defined in `.mise.toml`:

```toml
[tasks.dev]
run = "npm run dev"

[tasks.build]
run = "npm run build"
```

Run with: `mise run dev`

## Migration

### From asdf

Mise is compatible with asdf:
- Reads `.tool-versions` files
- Uses same plugin ecosystem
- Can coexist with asdf

### From nvm/rbenv/pyenv

Convert version files:

```bash
# .nvmrc → .tool-versions
echo "node $(cat .nvmrc)" > .tool-versions

# .ruby-version → .tool-versions
echo "ruby $(cat .ruby-version)" >> .tool-versions
```

## Troubleshooting

### Tool Not Found After Install

- Ensure mise is activated: `mise doctor`
- Check PATH: `echo $PATH | grep mise`
- Reload shell: `exec fish`

### Version Not Switching

- Check `.tool-versions` in directory
- Verify global config: `mise config`
- Force reload: `mise reshim`

### Build Failures

- Check dependencies: `mise doctor`
- Install build tools: `xcode-select --install`
- Check logs: `~/.cache/mise/logs/`

### Slow Performance

- Disable unused backends
- Reduce plugin count
- Clear cache: `rm -rf ~/.cache/mise/`

## Best Practices

### Version Pinning

Pin versions in projects:
```toml
# .mise.toml in project root
[tools]
node = "20.0.0"  # Specific version
python = "3.12"  # Major.minor version
```

### Global vs Local

- **Global**: Development tools (gh, lazygit, fzf)
- **Local**: Project runtimes (node, python, ruby)

### Tool Organization

Group related tools:
```toml
# CLI utilities via cargo
"cargo:eza" = "latest"
"cargo:bat" = "latest"

# Development tools via ubi
"ubi:cli/cli" = "latest"
"ubi:jesseduffield/lazygit" = "latest"
```

## Links

- [Mise Documentation](https://mise.jdx.dev/)
- [Mise GitHub](https://github.com/jdx/mise)
- [Backend Reference](https://mise.jdx.dev/dev-tools/backends/)
- [Configuration Reference](https://mise.jdx.dev/configuration.html)
