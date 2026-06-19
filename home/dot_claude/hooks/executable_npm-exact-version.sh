#!/bin/sh
# vi: ft=sh
# PreToolUse(Bash): блокирует `npm/pnpm install <pkg>` без точного пиннинга версий.
# Цель — не допустить плавающих зависимостей; всегда требуется -E / --save-exact.

INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')
[ -z "$COMMAND" ] && exit 0

# Интересуют только установки npm/pnpm с явным пакетом (токен после install/add/i, не флаг).
# Голая установка из манифеста (`npm install` без аргумента) под паттерн не попадает.
echo "$COMMAND" | grep -Eq '(npm|pnpm)[[:space:]]+(i|install|add)[[:space:]]+[^-[:space:]]' || exit 0

# Точные версии уже закреплены — пропускаем.
echo "$COMMAND" | grep -Eq '(-E|--save-exact)' && exit 0

jq -n '{
  hookSpecificOutput: {
    hookEventName: "PreToolUse",
    permissionDecision: "deny",
    permissionDecisionReason: "Закрепляй точные версии: добавь -E (--save-exact) к npm/pnpm install <pkg>."
  }
}'
