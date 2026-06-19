# Единый источник session-переменных окружения

Дата: 2026-06-19
Статус: согласовано, готово к плану реализации

## Проблема

Переменные окружения разбросаны по нескольким файлам и дублируются:

| Переменная | `config.fish.tmpl` | `dot_zshrc.tmpl` | `dot_zshenv` | plist |
|---|---|---|---|---|
| `GITHUB_TOKEN` | :230 | :7 | — | да |
| `GNUPGHOME` | :287 | — | — | да |
| `OPENAI_API_KEY`, `GITLAB_TOKEN` | да | да (zshrc) | — | — |
| XDG-база, `GOPATH`, `CARGO_HOME`, `RUSTUP_HOME` | да | — | — | — |

Следствия:

1. **Bash-инструмент Claude не видит части переменных.** Инструмент запускает
   **non-interactive zsh**, который сорсит **только `~/.zshenv`**. `.zshrc` (интерактивный)
   и `.zprofile` не сорсятся. `GNUPGHOME` нигде в `.zshenv` нет → подпись коммитов падает
   с «No secret key». `GITHUB_TOKEN` виден только потому, что случайно унаследован из
   launchd-сессии (ненадёжно).
2. **Тройное дублирование** `GITHUB_TOKEN` (fish + zshrc + plist) — правка в трёх местах.
3. **Секрет в файле с правами 644.** `config.fish.tmpl` рендерится в `~/.config/fish/config.fish`
   (644) с plaintext-токеном.

Проверено эмпирически в текущей сессии:

- Bash-инструмент = `/opt/homebrew/bin/zsh`, `ZSH_VERSION=5.9.1`, non-interactive.
- `~/.zshenv` гарантированно сорсится (видны `XDG_CONFIG_HOME`, `ZDOTDIR`, `SHELL_SESSIONS_DISABLE`).
- В окружении инструмента `GNUPGHOME` пуст; `launchctl getenv GNUPGHOME` тоже пуст.

## Цель и критерии успеха

- Один источник правды для session-переменных; добавление новой = правка одной строки.
- Bash-инструмент Claude (non-interactive zsh) **всегда** видит `GNUPGHOME` и остальной набор
  → подпись коммитов работает без fish-обёртки.
- Те же переменные доступны в fish и в GUI-приложениях (launchd).
- Секреты — только в файлах с правами 600.
- Дубли `GITHUB_TOKEN`/`GNUPGHOME` устранены.

## Архитектура

Единственный источник правды — партиал-шаблон `home/.chezmoitemplates/session-env.tmpl`.
Он описывает список переменных один раз и рендерит их в нужном синтаксисе по параметру `syntax`.

`includeTemplate` (механика chezmoi): относительный путь ищется сначала в `.chezmoitemplates/`,
затем относительно корня источника; файл **исполняется как шаблон**, поэтому `keepassxcAttribute`
внутри работает. Файлы из `.chezmoitemplates/` **не** рендерятся как самостоятельные таргеты.

Значения переменных — абсолютные пути через `{{ .homeDir }}` (chezmoi-резолв во время apply),
а не shell-ссылки `$XDG_DATA_HOME/...`. Причина: `launchctl setenv` не разворачивает `$VAR`,
плюс отсутствует зависимость от порядка установки внутри файла.

```text
                 home/.chezmoitemplates/session-env.tmpl   (единый список $vars)
                          /                |                 \
        syntax="posix"   /    syntax="fish"|     syntax="launchctl" \
                        v                  v                         v
   private_dot_zshenv.tmpl     conf.d/private_session-env    session-env.plist.tmpl
        (zsh, 600)               .fish.tmpl (fish, 600)            (launchd, 600)
              |                          |                              |
   Bash-инструмент Claude        интерактивный/скриптовый        GUI-приложения
   + любой zsh-процесс                  fish                    (Dock/Finder)
```

### Набор переменных

`XDG_CONFIG_HOME`, `XDG_DATA_HOME`, `XDG_STATE_HOME`, `XDG_CACHE_HOME`,
`GNUPGHOME`, `GOPATH`, `CARGO_HOME`, `RUSTUP_HOME`,
`GITHUB_TOKEN`, `GITLAB_TOKEN`, `OPENAI_API_KEY`.

Значения (соответствуют текущим):

| Переменная | Значение |
|---|---|
| `XDG_CONFIG_HOME` | `{{ .homeDir }}/.config` |
| `XDG_DATA_HOME` | `{{ .homeDir }}/.local/share` |
| `XDG_STATE_HOME` | `{{ .homeDir }}/.local/state` |
| `XDG_CACHE_HOME` | `{{ .homeDir }}/.cache` |
| `GNUPGHOME` | `{{ .homeDir }}/.local/share/gnupg` |
| `GOPATH` | `{{ .homeDir }}/Library/go` |
| `CARGO_HOME` | `{{ .homeDir }}/.local/share/cargo` |
| `RUSTUP_HOME` | `{{ .homeDir }}/.local/share/rustup` |
| `GITHUB_TOKEN` | `keepassxcAttribute "GITHUB" "TOKEN"` |
| `GITLAB_TOKEN` | `keepassxcAttribute "GITLAB" "TOKEN"` |
| `OPENAI_API_KEY` | `keepassxcAttribute "OPENAI" "API_KEY"` |

## Реализация партиала (референс)

`home/.chezmoitemplates/session-env.tmpl`:

```gotemplate
{{- /*
  Единый источник session-переменных окружения.
  Подключение:
    {{ includeTemplate "session-env.tmpl" (dict "syntax" "posix" "homeDir" .chezmoi.homeDir) }}
  syntax: "posix" (export) | "fish" (set -gx) | "launchctl" (launchctl setenv).
  Значения — абсолютные пути, чтобы launchctl их не разворачивал в шелле.
  Добавить переменную = одна строка в $vars (секреты — через keepassxcAttribute).
*/ -}}
{{- $home := .homeDir -}}
{{- $vars := list
    (dict "k" "XDG_CONFIG_HOME" "v" (printf "%s/.config" $home))
    (dict "k" "XDG_DATA_HOME"   "v" (printf "%s/.local/share" $home))
    (dict "k" "XDG_STATE_HOME"  "v" (printf "%s/.local/state" $home))
    (dict "k" "XDG_CACHE_HOME"  "v" (printf "%s/.cache" $home))
    (dict "k" "GNUPGHOME"       "v" (printf "%s/.local/share/gnupg" $home))
    (dict "k" "GOPATH"          "v" (printf "%s/Library/go" $home))
    (dict "k" "CARGO_HOME"      "v" (printf "%s/.local/share/cargo" $home))
    (dict "k" "RUSTUP_HOME"     "v" (printf "%s/.local/share/rustup" $home))
    (dict "k" "GITHUB_TOKEN"    "v" (keepassxcAttribute "GITHUB" "TOKEN"))
    (dict "k" "GITLAB_TOKEN"    "v" (keepassxcAttribute "GITLAB" "TOKEN"))
    (dict "k" "OPENAI_API_KEY"  "v" (keepassxcAttribute "OPENAI" "API_KEY"))
-}}
{{- range $v := $vars }}
{{- if eq $.syntax "fish" }}
set -gx {{ $v.k }} "{{ $v.v }}"
{{- else if eq $.syntax "launchctl" }}
launchctl setenv {{ $v.k }} "{{ $v.v }}"
{{- else }}
export {{ $v.k }}="{{ $v.v }}"
{{- end }}
{{- end }}
```

Примечание: секреты рендерятся безусловным присваиванием (не `set -q; or`), чтобы при ротации
токена значение обновлялось, а не залипало из ранее установленного.

## Изменения по файлам

### Новый: `home/.chezmoitemplates/session-env.tmpl`

См. референс выше.

### `home/dot_zshenv` → `home/private_dot_zshenv.tmpl`

Переименовать (получает права 600 и обработку шаблона). Партиал подключается **в начале**,
до установки `ZDOTDIR` (тот зависит от `XDG_CONFIG_HOME`, который теперь приходит из партиала):

```gotemplate
# vi: ft=zsh

SHELL_SESSIONS_DISABLE=1

{{ includeTemplate "session-env.tmpl" (dict "syntax" "posix" "homeDir" .chezmoi.homeDir) }}

ZSH="$XDG_CONFIG_HOME/zsh"
ZDOTDIR=$ZSH
```

(Строки `XDG_CONFIG_HOME="$HOME/.config"`, `ZSH=...` из старого `dot_zshenv` заменяются: первая
переезжает в партиал, остальные сохраняются.)

### Новый: `home/dot_config/fish/conf.d/private_session-env.fish.tmpl`

Права 600. fish сорсит `conf.d/*.fish` **до** `config.fish`:

```gotemplate
# vi: ft=fish
{{ includeTemplate "session-env.tmpl" (dict "syntax" "fish" "homeDir" .chezmoi.homeDir) }}
```

### `home/dot_config/fish/config.fish.tmpl`

Удалить (теперь приходит из партиала через conf.d):
- секреты — блок `# -- SECRETS --` со строками `OPENAI_API_KEY`, `GITLAB_TOKEN`, `GITHUB_TOKEN` (≈228-230);
- `set -gx CARGO_HOME ...`, `set -gx GNUPGHOME ...`, `set -gx RUSTUP_HOME ...`, `set -gx GOPATH ...` (≈286-290);
- четыре базовых XDG: `set -Ux XDG_CONFIG_HOME`, `XDG_DATA_HOME`, `XDG_STATE_HOME`, `XDG_CACHE_HOME` (30-33).

Оставить без изменений:
- `set -Ux XDG_RUNTIME_DIR ...` (34) и mkdir-цикл `for xdgdir in ...` (36) — fish-специфично;
- `fish_add_path $GOPATH` — `$GOPATH` уже выставлен conf.d-партиалом до config.fish;
- WEBOS-переменные (`LG_WEBOS_TV_SDK_HOME`, `WEBOS_CLI_TV`) — вне scope.

### `home/dot_config/zsh/dot_zshrc.tmpl`

Удалить блок `## -- SECRETS --` (строки 5-7: `OPENAI_API_KEY`, `GITLAB_TOKEN`, `GITHUB_TOKEN`).
Остальное (`EDITOR`, `GPG_TTY`, WEBOS/TIZEN, brew, mise, oh-my-posh) — без изменений.

### `home/private_Library/LaunchAgents/private_io.aimuzov.session-env.plist.tmpl`

Заменить хардкод `launchctl setenv` в `<string>` на партиал (`launchctl`). Каждая команда на своей
строке исполняется `/bin/sh -c` как отдельная (перевод строки = разделитель команд). Обновить
комментарий: источник переменных теперь `session-env.tmpl`, добавление новой — там.

```gotemplate
        <string>{{ includeTemplate "session-env.tmpl" (dict "syntax" "launchctl" "homeDir" .chezmoi.homeDir) }}</string>
```

## Верификация

После реализации пользователь выполняет `chezmoi apply` (требует разблокировки KeePassXC).
Затем:

1. В Bash-инструменте Claude (новый вызов): `echo $GNUPGHOME` → непустой путь;
   `echo ${GITHUB_TOKEN:+set}` → `set`. Bash-инструмент переинициализируется из профиля
   (`~/.zshenv`) при каждом вызове, поэтому обновлённое значение подхватывается **следующим**
   вызовом без рестарта Claude. Если по какой-то причине не появилось — перезапустить Claude Code
   (fallback на случай унаследованного/кэшированного окружения).
2. Тестовая подпись: `git commit` со включённой GPG-подписью проходит без «No secret key».
3. Новая fish-сессия: `echo $GNUPGHOME $GITHUB_TOKEN` — значения на месте.
4. GUI: `launchctl getenv GNUPGHOME` — непусто (после перелогина/перезагрузки агента).

## Риски и нюансы

- **Окружение Bash-инструмента.** Подхватывается из `~/.zshenv` при каждом вызове, поэтому
  обычно рестарт Claude не нужен. Рестарт — fallback, если значение всё же не появилось.
- **Universal XDG-переменные fish.** Старые `set -Ux` залипают в `~/.config/fish/fish_variables`.
  conf.d-партиал (грузится первым) выставит их через `set -gx`; `set -q ...; or set -Ux` в config.fish
  затем их пропустит. Значения идентичны → функционально безопасно. Полная очистка (опционально):
  `set -eU XDG_CONFIG_HOME XDG_DATA_HOME XDG_STATE_HOME XDG_CACHE_HOME` в новой fish-сессии.
- **KeePassXC unlock при apply** — как и сейчас; `keepassxcAttribute` кэшируется chezmoi в рамках запуска.
- **Спецсимволы в секретах** в `launchctl setenv "..."` — риск тот же, что в текущем plist (не регресс).

## Вне scope

- WEBOS/TIZEN-пути (`LG_WEBOS_TV_SDK_HOME`, `WEBOS_CLI_TV`, `SAMSUNG_TIZEN_SDK_HOME`, `TIZEN_CLI_TV`)
  — содержат shell-специфичную PATH-логику; кандидаты на будущую централизацию.
- `XDG_RUNTIME_DIR`, mkdir-цикл XDG — остаются fish-специфичными.
- PATH-сборка, FZF/NPM/HOMEBREW-флаги — остаются в соответствующих шеллах.
