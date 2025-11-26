#!/usr/bin/env fish

# Скрипт для statusLine Claude Code на основе fish/oh-my-posh конфигурации

# Левая часть: иконка + имя текущей директории
set LEFT "󰉋 $(basename $PWD)"

# Правая часть: Node.js версия + Git информация
set RIGHT ""

# Показываем версию Node.js только если есть package.json
if test -f package.json
    set node_version (node --version 2>/dev/null | string replace 'v' '')
    if test -n "$node_version"
        set RIGHT "󰋙 $node_version  "
    end
end

# Git информация
if git rev-parse --git-dir >/dev/null 2>&1
    # Получаем название ветки
    set branch (git --no-optional-locks rev-parse --abbrev-ref HEAD 2>/dev/null)

    # Маппинг веток (как в oh-my-posh конфигурации)
    set branch (string replace -r '^release/' 'r/' $branch)
    set branch (string replace -r '^feature/' 'f/' $branch)
    set branch (string replace -r '^bugfix/' 'b/' $branch)

    # Определяем upstream статус
    set upstream_icon ""
    set upstream (git --no-optional-locks rev-parse --abbrev-ref @{u} 2>/dev/null)

    if test -n "$upstream"
        set local (git --no-optional-locks rev-parse @ 2>/dev/null)
        set remote (git --no-optional-locks rev-parse @{u} 2>/dev/null)
        set base (git --no-optional-locks merge-base @ @{u} 2>/dev/null)

        if test "$local" = "$remote"
            set upstream_icon "󰸞" # синхронизировано
        else if test "$local" = "$base"
            set upstream_icon "󰶡" # отстает (behind)
        else if test "$remote" = "$base"
            set upstream_icon "󰶣" # впереди (ahead)
        else
            set upstream_icon "󰹺" # разошлись (diverged)
        end
    end

    set RIGHT "$RIGHT $upstream_icon $branch"
end

# Выводим результат: левая часть, разделитель, правая часть
echo "$LEFT|||$RIGHT"
