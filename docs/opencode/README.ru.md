# Конфигурация opencode

> 🇺🇸 [English version](README.md)

[opencode](https://opencode.ai) работает рядом с Claude Code и получает то же окружение: MCP-серверы,
правила, сабагентов, команды и хуки. Своих копий у него нет, всё берётся из `home/dot_claude/`.

## Файлы

| Исходник | Куда попадает |
| --- | --- |
| `home/dot_config/opencode/opencode.jsonc.tmpl` | `~/.config/opencode/opencode.jsonc` |
| `home/dot_config/opencode/plugins/claude-hooks.ts` | `~/.config/opencode/plugins/claude-hooks.ts` |

`package.json` и `node_modules` в `~/.config/opencode` opencode ведёт сам, chezmoi их не трогает.

## Что откуда

- **MCP**: шаблон переводит `dot_claude/mcp.json.tmpl` в формат opencode (`type: local`,
  `command` одним массивом, `env` => `environment`, `MCP_TIMEOUT` => `timeout`). serena стартует с
  контекстом `ide` вместо `claude-code`. Новый сервер по-прежнему правится в двух местах:
  `mcp.json.tmpl` и `mise/config.toml`.
- **Правила**: `CLAUDE.md` в корне проекта и `~/.claude/CLAUDE.md` opencode читает сам, а
  `.claude/CLAUDE.md` подключён через `instructions`.
- **Skills**: `~/.claude/skills/` opencode тоже находит сам.
- **Агенты и команды**: промпты подключены через `{file:~/.claude/...}`, описание берётся из их
  frontmatter. `nested` не перенесена: она про сессии десктопного приложения Claude.
- **Хуки**: плагин `claude-hooks.ts` отдаёт вызовы инструментов скриптам из `~/.claude/hooks` в
  формате Claude Code и превращает ответ в отказ, правку команды или добавку к выводу.
  `thinks-text-guard` ищет `check_as_me` в транскрипте Claude, поэтому плагин сам помнит, был ли
  этот вызов после последнего сообщения.
- **Не перенесены**: `serena-worktree-link` (нет аналога `EnterWorktree`), `mcp-readonly-allow`
  (MCP в opencode и так разрешены) и statusline.

## Модель

По умолчанию `anthropic/claude-opus-5-5`, агент при старте `plan`. Ключа в репозитории нет:
провайдер подключается один раз через `/connect` в opencode или `opencode auth login`. Подписка
Claude Pro/Max для сторонних клиентов не годится, поэтому Opus идёт по API-ключу Anthropic с
оплатой за токены.

## Проверка

```bash
opencode debug config
```

```bash
opencode mcp list
```
