#!/bin/sh
# vi: ft=sh
# PostToolUse(Edit|Write): on MCP definition edits, reminds about the second file.
# A new MCP server also requires an entry in home/dot_config/mise/config.toml ([tools]).

INPUT=$(cat)
FILE=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

case "$FILE" in
  *dot_claude/mcp.json.tmpl)
    jq -n '{
      hookSpecificOutput: {
        hookEventName: "PostToolUse",
        additionalContext: "Напоминание: новый MCP-сервер требует записи также в home/dot_config/mise/config.toml ([tools])."
      }
    }'
    ;;
  *)
    exit 0
    ;;
esac
