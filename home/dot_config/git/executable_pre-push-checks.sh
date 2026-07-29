#!/usr/bin/env sh
# Shared pre-push checks. Reads the pushed refs on stdin (git pre-push format):
#   <local ref> <local oid> <remote ref> <remote oid>
#
# Called from two places so the same rule applies with or without husky:
#   - ~/.config/git/hooks/pre-push   (repos that use the global hooksPath)
#   - <repo>/.husky/pre-push         (husky repos — a thin shim execs this)
#
# Blocks pushing a branch whose REMOTE name is refs/heads/claude/* — those are
# throwaway labels from the Claude app's git-worktree pool, not gitflow branches.
# Rebrand onto a gitflow branch (feature/*, bugfix/*, hotfix/*, ...) and push it.
# One-off bypass: PUSH_ALLOW_CLAUDE_BRANCH=1 git push ...
[ "${PUSH_ALLOW_CLAUDE_BRANCH:-0}" = "1" ] && exit 0

status=0
# No pipe into the loop — a subshell would swallow $status.
while read -r local_ref local_oid remote_ref remote_oid; do
	# Skip deletions: the local side is "(delete)" with an all-zero oid.
	case "$local_oid" in
		*[!0]*) : ;;    # real object → a create/update push
		*) continue ;;  # all zeros → branch deletion, allow
	esac
	case "$remote_ref" in
		refs/heads/claude/*)
			branch=${remote_ref#refs/heads/}
			echo "git - refusing to push '$branch'." >&2
			echo "      claude/* is the Claude app worktree-pool label, not a gitflow branch." >&2
			echo "      Rebrand onto gitflow and push that instead, e.g.:" >&2
			echo "        git branch -m feature/<slug>   # or bugfix/<slug>, hotfix/<slug>" >&2
			echo "        git push -u origin feature/<slug>" >&2
			echo "      One-off bypass: PUSH_ALLOW_CLAUDE_BRANCH=1 git push ..." >&2
			status=1
			;;
	esac
done

exit $status
