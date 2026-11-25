# Codex configuration

[Русский](README.ru.md)

The user configuration lives in `home/dot_codex/modify_private_config.toml`. Chezmoi renders it directly into `~/.codex/config.toml`, preserving application settings, trusted projects, additional MCP servers and skill preferences. The private configuration gets environment variables from the shared `session-env.tmpl` and secrets from KeePassXC.

Chezmoi installs and enables Superpowers from the active OpenAI marketplace. Codex uses `openai-api-curated` before login or with an API key, and `openai-curated` with a ChatGPT account. Subsequent applies skip the plugin if it is already installed and enabled. Check its status with `codex plugin list --json`.

The submodule also provides personal instructions, seven skills, four agent roles and shell hooks. Serena and thinks are disabled globally. The webapp-next project config supplies Kaiten in that project. The user template controls the disabled design skills.

Run `mise exec -- python3 -m unittest discover -s home/dot_codex/tests -v` from dotfiles. Template tests render isolated fixtures with dummy secrets. The user runs `chezmoi apply` and opens a new chat.
