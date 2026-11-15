# Дизайнерские skills

Пять наборов закреплены по commit SHA в `home/.chezmoiexternals/design-skills.toml`. Codex читает их из `~/.agents/skills`.

UX/UI содержит 26 skills. Их шаблоны заменяют пути Claude на `~/.local/share/design-skills/ux-ui-agent-skills`, где лежит полный комплект токенов, справочников и проверок.

После `chezmoi apply` открой новый чат. Вызовы: `$design-review`, `$a11y-audit`, `$canvas-design`, `$app-store-screenshots`, `$design-taste-frontend`, `$transitions-dev`.

After-скрипт устанавливает npm-зависимости UX/UI и Pillow/ReportLab. Python для Canvas: `~/.local/share/design-skills/canvas-python/bin/python`. Для headless-проверок нужен Chrome. Зависимости редактора App Store устанавливаются в проект при использовании.

Для обновления поменяй SHA архивов. У UX/UI также обнови шаблоны из `.claude/skills/*/SKILL.md` с заменой путей и SHA в after-скрипте. Лицензия UX/UI: [MIT](UX-UI-LICENSE).
