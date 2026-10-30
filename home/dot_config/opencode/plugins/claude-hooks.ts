import type { Plugin } from "@opencode-ai/plugin"
import { homedir } from "node:os"
import { join } from "node:path"

// Гоняет хуки Claude Code из ~/.claude/hooks на вызовах инструментов opencode: вход
// переводится в формат Claude (tool_name, tool_input), ответ -- обратно в deny или правку
// аргументов. Состав и порядок повторяют hooks в dot_claude/modify_settings.json.tmpl.

type Hook = { match: RegExp; script: string }

const HOOKS_DIR = join(homedir(), ".claude", "hooks")

// fish-shell-wrapper переписывает команду, поэтому идёт последним: гарды должны видеть
// команду такой, какой её написала модель.
const PRE: Hook[] = [
  { match: /^Bash$/, script: "npm-exact-version.sh" },
  { match: /^Bash$/, script: "claude-footer-guard.sh" },
  { match: /^Bash$/, script: "broad-pkill-guard.sh" },
  { match: /^(Bash|mcp__gitlab__.*|mcp__kaiten__.*)$/, script: "thinks-text-guard.sh" },
  { match: /^mcp__kaiten__kaiten_add_card_tag$/, script: "kaiten-tag-guard.sh" },
  { match: /^Bash$/, script: "fish-shell-wrapper.sh" },
]

const POST: Hook[] = [
  { match: /^(Edit|Write)$/, script: "mcp-two-files-reminder.sh" },
  { match: /^(Edit|Write)$/, script: "thinks-comment-reminder.sh" },
  { match: /^(Edit|Write)$/, script: "oxlint-fix.sh" },
]

const CHECK_AS_ME = "mcp__thinks__check_as_me"

type HookResult = {
  deny?: string
  command?: string
  context?: string
}

export const ClaudeHooks: Plugin = async ({ directory }) => {
  // Имена серверов приходят хуком config: client.config.get() при инициализации плагина
  // ждёт сервер, который сам ждёт плагины, и opencode зависает на старте.
  let servers: string[] = []

  // thinks-text-guard в Claude ищет check_as_me в транскрипте, которого у opencode нет.
  // Тот же признак держим сами: был ли check_as_me после последнего сообщения пользователя.
  const checked = new Set<string>()

  const claudeName = (tool: string) => {
    if (tool === "bash" || tool === "shell") return "Bash"
    if (tool === "edit") return "Edit"
    if (tool === "write") return "Write"
    const server = servers.find((name) => tool.startsWith(sanitize(name) + "_"))
    if (server) return `mcp__${server}__${tool.slice(sanitize(server).length + 1)}`
    return tool
  }

  const claudeInput = (name: string, args: any) => {
    if (name === "Bash") return { command: args.command }
    if (name === "Edit") return { file_path: args.filePath, old_string: args.oldString, new_string: args.newString }
    if (name === "Write") return { file_path: args.filePath, content: args.content }
    return args
  }

  const run = async (script: string, payload: object): Promise<HookResult> => {
    const proc = Bun.spawn(["bash", join(HOOKS_DIR, script)], {
      cwd: directory,
      stdin: new Blob([JSON.stringify(payload)]),
      stdout: "pipe",
      stderr: "pipe",
    })
    const [stdout, stderr, code] = await Promise.all([
      new Response(proc.stdout).text(),
      new Response(proc.stderr).text(),
      proc.exited,
    ])
    // Код 2 у Claude Code -- блокировка с причиной в stderr
    if (code === 2) return { deny: stderr.trim() || script }
    if (!stdout.trim()) return {}
    let output: any
    try {
      output = JSON.parse(stdout)
    } catch {
      return {}
    }
    const specific = output.hookSpecificOutput ?? {}
    return {
      deny: specific.permissionDecision === "deny" ? specific.permissionDecisionReason || script : undefined,
      command: specific.updatedInput?.command,
      context: specific.additionalContext,
    }
  }

  return {
    config: async (config) => {
      // Длинные имена первыми, чтобы сервер foo_bar не съел foo
      servers = Object.keys(config.mcp ?? {}).sort((a, b) => b.length - a.length)
    },

    "chat.message": async ({ sessionID }) => {
      checked.delete(sessionID)
    },

    "tool.execute.before": async ({ tool, sessionID }, output) => {
      const name = claudeName(tool)
      for (const hook of PRE) {
        if (!hook.match.test(name)) continue
        if (hook.script === "thinks-text-guard.sh" && checked.has(sessionID)) continue
        const result = await run(hook.script, {
          hook_event_name: "PreToolUse",
          session_id: sessionID,
          cwd: directory,
          tool_name: name,
          tool_input: claudeInput(name, output.args),
        })
        if (result.deny) throw new Error(result.deny)
        if (result.command && name === "Bash") output.args.command = result.command
      }
    },

    "tool.execute.after": async ({ tool, sessionID, args }, output) => {
      const name = claudeName(tool)
      if (name === CHECK_AS_ME) checked.add(sessionID)
      for (const hook of POST) {
        if (!hook.match.test(name)) continue
        const result = await run(hook.script, {
          hook_event_name: "PostToolUse",
          session_id: sessionID,
          cwd: directory,
          tool_name: name,
          tool_input: claudeInput(name, args),
        })
        if (result.context) output.output += `\n\n${result.context}`
      }
    },
  }
}

// Так opencode собирает имя MCP-инструмента из имени сервера
function sanitize(name: string) {
  return name.replace(/[^a-zA-Z0-9_-]/g, "_")
}
