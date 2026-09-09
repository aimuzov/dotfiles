# Claude Code Configuration

> 🇷🇺 [Русская версия](README.ru.md)

This directory contains configuration for [Claude Code](https://claude.ai/code) — Anthropic's AI coding assistant CLI.

## Overview

The configuration includes:

- **MCP Servers** - Model Context Protocol servers for extended capabilities
- **Centralized Configuration** - Single source of truth for MCP settings
- **KeePassXC Integration** - Secure secret injection via templates
- **Custom Settings** - Personalized behavior preferences

## Configuration Files

### Location

- `home/dot_claude/` - Claude Code configuration directory (becomes `~/.claude/`)
- `home/dot_mcp.json.tmpl` - Centralized MCP servers configuration (becomes `~/.mcp.json`)

`home/dot_claude/` is a git submodule ([dotfiles-claude](https://github.com/aimuzov/dotfiles-claude)),
so its contents are versioned separately from the main repository.

### Files

| File | Description |
|------|-------------|
| `CLAUDE.md` | Personal instructions for Claude Code (language, style preferences) |
| `mcp.json.tmpl` | MCP servers configuration template |
| `modify_settings.json.tmpl` | chezmoi modify script: merges its settings block into the existing `~/.claude/settings.json` via `jq` |

## MCP Servers

The configuration includes the following MCP (Model Context Protocol) servers:

| Server | Command | Purpose |
|--------|---------|---------|
| `context7` | `context7-mcp` | Up-to-date documentation for libraries and frameworks |
| `serena` | `serena start-mcp-server` | Symbol-level code navigation and edits |
| `things` | `things-mcp` | Tasks and notes in Things |
| `thinks` | `thinks-mcp` | Text in the author's own voice (style profile from a Telegram export) |

Every server is launched through `mise exec` / `mise x`, so no global installation is required.
The packages are declared in `home/dot_config/mise/config.toml`
(`npm:@upstash/context7-mcp`, `pipx:serena-agent`, `pipx:things-mcp`,
`npm:@aimuzov/thinks-mcp`). The last one is also listed in `minimum_release_age_excludes`:
mise holds back npm releases younger than 24 hours, and that quarantine only gets in the way
for the author's own package.

Extra launch parameters:

- `context7` receives its API key from KeePassXC (see below);
- `serena` starts with `--context claude-code --project-from-cwd` and `MCP_TIMEOUT=60000`.

### Centralized Configuration

MCP servers are configured in `home/dot_mcp.json.tmpl`, which uses chezmoi templates to include the server definitions from `home/dot_claude/mcp.json.tmpl`:

```json
{
  "mcpServers": {{- includeTemplate "dot_claude/mcp.json.tmpl" . -}}
}
```

The trailing dot passes the chezmoi data context to the template — without it, variables such as
`.miseBinPath` inside the included file resolve to empty strings.

This allows:
- Single source of truth for all MCP configurations
- Reuse across different Claude Code installations
- Secure secret injection via KeePassXC

### mise Binary Path

No server sets `PATH`; instead, each one's `command` points at the mise binary, whose path lives in
`home/.chezmoidata.toml`:

```json
{
  "command": "{{ .miseBinPath }}",
  "args": ["exec", "pipx:things-mcp", "--", "things-mcp"]
}
```

This ensures:
- A single place where the mise path is defined
- No hardcoded paths in configuration files
- Tool versions consistent with the rest of the mise environment

### KeePassXC Integration

KeePassXC stores the secrets that are injected into the configuration on `chezmoi apply`. The only
consumer right now is the context7 API key:

```json
{
  "args": ["--api-key", "{{ keepassxcAttribute \"CTX7\" \"TOKEN\" }}"]
}
```

This ensures:
- No plaintext secrets in the repository
- A single vault for all credentials

## Settings

`~/.claude/settings.json` is never overwritten wholesale: `modify_settings.json.tmpl` takes the
existing file and merges its own settings block into it (`jq '. + $ours'`), so edits made by Claude
Code itself survive.

Key behavior settings:

| Setting | Value | Description |
|---------|-------|-------------|
| `alwaysThinkingEnabled` | `true` | Always show thinking process |
| `autoUpdates` | `false` | Never self-update Claude Code (mise owns the version) |
| `permissions.defaultMode` | `plan` | Default to plan mode for safety |
| `preferredNotifChannel` | `ghostty` | Send notifications to Ghostty terminal |

The template also defines environment variables (`env`), the allowed-command list
(`permissions.allow`), hooks, and the set of enabled plugins.

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
- [KeePassXC](https://keepassxc.org/) - For secure secret storage
- [chezmoi](https://www.chezmoi.io/) - For dotfiles management
- [mise](https://mise.jdx.dev/) - Runs the MCP servers and provides `jq` for the modify script
- MCP server packages: `@upstash/context7-mcp`, `serena-agent`, `things-mcp`,
  `@aimuzov/thinks-mcp`

## Related Documentation

- [Ghostty Terminal](../ghostty/README.md) - Preferred notification channel
- [chezmoi Scripts](../chezmoiscripts/README.md) - Automated setup
