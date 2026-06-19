#!/usr/bin/env sh
# Shared commit-msg checks. $1 = path to the commit message file.
#
# Called from two places so the same rules apply with or without husky:
#   - ~/.config/git/hooks/commit-msg      (repos that use the global hooksPath)
#   - ~/.config/husky/init.sh             (repos where husky hijacks hooksPath)
msg="$1"
[ -n "$msg" ] && [ -f "$msg" ] || exit 0

# Drop attribution lines.
sed -i '' '/^[Cc]o-[Aa]uthored-[Bb]y:/d' "$msg"
# Collapse trailing blank lines to a single newline.
perl -i -0pe 's/\n+$/\n/' "$msg"

# Enforce English: reject any Cyrillic character.
if ! perl -CSD -ne 'exit 1 if /\p{Cyrillic}/' "$msg"; then
	echo "git - commit message must be in English (Cyrillic detected)" >&2
	exit 1
fi
