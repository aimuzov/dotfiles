#!/usr/bin/env sh
# Sourced by husky's hook wrapper (.husky/_/h) before EVERY hook, in EVERY
# project. husky sets a repo-local `core.hooksPath`, which makes git ignore the
# global `~/.config/git/hooks` — so global hook logic for husky repos must live
# here instead. husky cannot bypass this: it sources the file itself.
#
# `$n` is husky's hook name (basename of the running hook); `$1` is the hook's
# first argument. For commit-msg, `$1` is the path to the commit message file.
if [ "$n" = "commit-msg" ]; then
	checks="${XDG_CONFIG_HOME:-$HOME/.config}/git/commit-msg-checks.sh"
	[ -x "$checks" ] && { "$checks" "$1" || exit $?; }
fi

if [ "$n" = "pre-commit" ]; then
	checks="${XDG_CONFIG_HOME:-$HOME/.config}/git/pre-commit-checks.sh"
	[ -x "$checks" ] && { "$checks" || exit $?; }
fi
