Create a git commit.

1. `git status` + `git diff --staged` — check what's staged; if nothing, ask the user.
2. `git log -5 --oneline` — match the commit style.
3. Propose a message, wait for confirmation.
4. `git commit -m "..."` — use a multiline string in quotes if body is needed.
