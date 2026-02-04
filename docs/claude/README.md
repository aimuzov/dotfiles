# Claude Code Configuration

> 🇷🇺 [Русская версия](README.ru.md)

This directory contains configuration for [Claude Code](https://claude.ai/code) — Anthropic's AI coding assistant CLI.

## Overview

The configuration includes:

- **MCP Servers** - Model Context Protocol servers for extended capabilities
- **Centralized Configuration** - Single source of truth for MCP settings
- **KeePassXC Integration** - Secure PATH management via templates
- **Custom Settings** - Personalized behavior preferences

## Configuration Files

### Location

- `home/dot_claude/` - Claude Code configuration directory (becomes `~/.claude/`)
- `home/dot_mcp.json.tmpl` - Centralized MCP servers configuration (becomes `~/.mcp.json`)

### Files

| File | Description |
|------|-------------|
| `CLAUDE.md` | Personal instructions for Claude Code (language, style preferences) |
| `mcp.json.tmpl` | MCP servers configuration template |
| `settings.json` | Claude Code behavior settings |

## MCP Servers

The configuration includes the following MCP (Model Context Protocol) servers:

| Server | Command | Purpose |
|--------|---------|---------|
| `filesystem` | `mcp-server-filesystem` | File system access with home directory scope |
| `git` | `mcp-server-git` | Git repository operations |
| `fetch` | `mcp-server-fetch` | HTTP fetching capabilities |
| `memory` | `mcp-server-memory` | Persistent memory across sessions |
| `everything` | `mcp-server-everything` | Demo/testing server |
| `sequential-thinking` | `mcp-server-sequential-thinking` | Step-by-step reasoning capabilities |
| `eslint` | `mcp` | ESLint code analysis |
| `devtools` | `chrome-devtools-mcp` | Chrome DevTools integration |

### Centralized Configuration

MCP servers are configured in `home/dot_mcp.json.tmpl`, which uses chezmoi templates to include the server definitions from `home/dot_claude/mcp.json.tmpl`:

```json
{
  "mcpServers": {{- includeTemplate "dot_claude/mcp.json.tmpl" -}}
}
```

This allows:
- Single source of truth for all MCP configurations
- Reuse across different Claude Code installations
- Secure PATH injection via KeePassXC

### KeePassXC Integration

All MCP servers use PATH from KeePassXC for secure environment management:

```json
{
  "env": {
    "PATH": "{{ (keepassxcAttribute \"ENV\" \"PATH\") }}"
  }
}
```

This ensures:
- Consistent PATH across all servers
- Secure storage of environment configuration
- No hardcoded paths in configuration files

## Settings

The `settings.json` file configures Claude Code behavior:

```json
{
  "alwaysThinkingEnabled": true,
  "permissions": { "defaultMode": "plan" },
  "preferredNotifChannel": "ghostty"
}
```

| Setting | Value | Description |
|---------|-------|-------------|
| `alwaysThinkingEnabled` | `true` | Always show thinking process |
| `permissions.defaultMode` | `plan` | Default to plan mode for safety |
| `preferredNotifChannel` | `ghostty` | Send notifications to Ghostty terminal |

## Personal Instructions (CLAUDE.md)

The `CLAUDE.md` file contains personal preferences:

- **Language**: Always respond in Russian
- **Style**: Concise and specific
- **Code**: Prefer readability over performance
- **Git**: Use conventional commits, no Co-Authored-By metadata

## Installation

The configuration is automatically applied via chezmoi:

```bash
chezmoi apply
```

After applying:
- `~/.claude/` contains Claude Code settings
- `~/.mcp.json` contains MCP server configurations
- Restart Claude Code to apply changes

## Dependencies

- [Claude Code CLI](https://claude.ai/code) - The AI assistant
- [KeePassXC](https://keepassxc.org/) - For secure environment management
- [chezmoi](https://www.chezmoi.io/) - For dotfiles management
- Various MCP server packages (installed via mise/npm)

## Related Documentation

- [Ghostty Terminal](../ghostty/README.md) - Preferred notification channel
- [chezmoi Scripts](../chezmoiscripts/README.md) - Automated setup
