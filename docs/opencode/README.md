# opencode Configuration

> 🇷🇺 [Русская версия](README.ru.md)

[opencode](https://opencode.ai) runs alongside Claude Code and gets the same environment: MCP servers,
rules, subagents, commands and hooks. It keeps no copies of its own; everything comes from
`home/dot_claude/`.

## Files

| Source | Target |
| --- | --- |
| `home/dot_config/opencode/opencode.jsonc.tmpl` | `~/.config/opencode/opencode.jsonc` |
| `home/dot_config/opencode/plugins/claude-hooks.ts` | `~/.config/opencode/plugins/claude-hooks.ts` |

opencode manages `package.json` and `node_modules` in `~/.config/opencode` itself; chezmoi leaves them alone.

## Where things come from

- **MCP**: the template converts `dot_claude/mcp.json.tmpl` to the opencode format (`type: local`,
  `command` as one array, `env` => `environment`, `MCP_TIMEOUT` => `timeout`). serena starts with the
  `ide` context instead of `claude-code`. A new server still goes into two files:
  `mcp.json.tmpl` and `mise/config.toml`.
- **Rules**: opencode reads the project-root `CLAUDE.md` and `~/.claude/CLAUDE.md` on its own;
  `.claude/CLAUDE.md` is added through `instructions`.
- **Skills**: opencode finds `~/.claude/skills/` on its own too.
- **Agents and commands**: prompts are linked with `{file:~/.claude/...}`, descriptions come from
  their frontmatter. `nested` is not ported: it is about Claude desktop app sessions.
- **Hooks**: the `claude-hooks.ts` plugin feeds tool calls to the scripts in `~/.claude/hooks` in the
  Claude Code format and turns their answer into a denial, a rewritten command or extra tool
  output. Not ported: `serena-worktree-link` (no `EnterWorktree` counterpart), `mcp-readonly-allow`
  (MCP tools are allowed in opencode anyway) and the statusline. `thinks-text-guard` looks for
  `check_as_me` in the Claude transcript, so the plugin itself tracks whether that call happened
  after the last user message.

## Model

Defaults to `anthropic/claude-opus-5-5`, starting in the `plan` agent. No key is stored in the
repository: connect the provider once with `/connect` in opencode or `opencode auth login`. A Claude
Pro/Max subscription can't be used by third-party clients, so Opus runs on a pay-per-token
Anthropic API key.

## Checks

```bash
opencode debug config
```

```bash
opencode mcp list
```
