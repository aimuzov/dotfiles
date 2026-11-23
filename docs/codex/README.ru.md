# Конфигурация Codex

[English](README.md)

Пользовательские настройки хранятся в `home/dot_codex/modify_private_config.toml`. Chezmoi напрямую формирует приватный `~/.codex/config.toml`, сохраняя параметры приложения, доверенные проекты, дополнительные MCP и настройки skills. Переменные окружения берутся из общего шаблона `session-env.tmpl`, секреты — из KeePassXC.

Superpowers включён секцией `[plugins."superpowers@openai-curated"]`. На новой машине плагин устанавливается один раз командой `codex plugin add superpowers@openai-curated`. Проверка установки — `codex plugin list --json`.

В submodule также находятся личные инструкции, семь skills, четыре роли агентов и хуки команд. Serena и thinks отключены глобально. Kaiten подключается в проектном конфиге webapp-next. Отключения дизайн-skills задаются в пользовательском шаблоне.

Проверка из dotfiles — `mise exec -- python3 -m unittest discover -s home/dot_codex/tests -v`. Тесты рендерят изолированные шаблоны с фиктивными секретами. Пользователь запускает `chezmoi apply` и открывает новый чат.
