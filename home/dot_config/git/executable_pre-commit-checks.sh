#!/usr/bin/env sh
# Shared pre-commit checks. Runs in both worlds (mirrors commit-msg-checks.sh):
#   - ~/.config/git/hooks/pre-commit   (global hooksPath repos)
#   - ~/.config/husky/init.sh          (husky repos)
#
# Rejects staged package.json files whose deps use floating ranges
# (^, ~, >, <, *, x, ||, dist-tags). Only exact pinned versions pass.
command -v jq >/dev/null 2>&1 || exit 0

# Staged package.json files (added/copied/modified). No pipe into the loop —
# a subshell would swallow the exit status.
files=$(git diff --cached --name-only --diff-filter=ACM | grep -E '(^|/)package\.json$')
[ -n "$files" ] || exit 0

status=0
IFS='
'
for file in $files; do
	# Inspect the STAGED blob, not the working tree. Allow non-semver specifiers
	# (workspace:/file:/git/url/npm: alias). Flag anything that isn't exact x.y.z.
	floating=$(git show ":$file" | jq -r '
		[.dependencies, .devDependencies]
		| map(select(. != null) | to_entries[]) | .[]
		| select(.value | test("^(workspace:|file:|link:|git|github:|https?://|npm:|catalog:)") | not)
		| select(.value | test("^[0-9]+\\.[0-9]+\\.[0-9]+([-+].*)?$") | not)
		| "  \(.key): \(.value)"
	' 2>/dev/null)

	if [ -n "$floating" ]; then
		echo "git - $file has non-pinned dependencies:" >&2
		echo "$floating" >&2
		status=1
	fi
done

exit $status
