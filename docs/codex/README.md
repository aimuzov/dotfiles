# Codex configuration

[Русский](README.ru.md)

The private `home/dot_codex` submodule supplies native configuration in `~/.codex`:
a concise AGENTS.md, seven skills, four agent roles, MCP settings and local hooks.
Model selection, reasoning, application settings, unrelated MCP servers and hook
trust state survive updates.

`config.base.toml.tmpl` is the native configuration source; chezmoi does not deploy
it as a separate profile. The modifier merges it into the private config.toml.
Codex no longer imports Claude configuration, installs Claude plugins or repairs
imported skills. OpenAI application plugins and system skills remain enabled.

The shared `home/.chezmoitemplates/session-env.tmpl` supplies
`shell_environment_policy.set`, including OPENROUTER_API_KEY. KeePassXC resolves
secrets during apply. The generated config is private and never committed.
Commands retain their chosen shell. Use `mise exec -- <command>` for project tool versions.

Hooks retain deterministic checks for exact npm/pnpm dependencies, broad process
termination, AI attribution footers and Kaiten tags. They no longer rewrite shell
commands, require thinks scoring, silently run oxlint or inject edit reminders.
`Bash` is Codex's documented canonical shell hook event name.

Serena and thinks are disabled by default. Context7, Things, Nanobanana, Veo and
Peeshet remain available. Claude marketplace plugins, imported synced skills and
30 third-party design skills are disabled without deleting their files.
Enable selected capabilities in a trusted project's `.codex/config.toml`, using
`mcp_servers.<name>.enabled = true` or a `[[skills.config]]` entry with the absolute
SKILL.md path and `enabled = true`.

Run `python3 -m unittest discover -s home/dot_codex/tests -v` from dotfiles.
Template tests use an isolated source and fake secrets, never the live config.
The user runs `chezmoi apply`, opens a new chat and reviews changed hook trust.
Old installer files or skill symlinks may remain at the destination, but the new
configuration no longer invokes the installers.

See the [audit](audit-2026-11-15.md) for findings and measurement limits.
