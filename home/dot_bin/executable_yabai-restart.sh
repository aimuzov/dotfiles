#!/bin/sh
# Restarts the window manager stack in the order the pieces depend on each other.
#
# yabai goes first: it re-runs yabairc, which re-adds the signals and relaunches
# skhd. sketchybar comes last so that the items re-install their own window_focus
# signal on a yabai that is already up. Skipping that leaves the bar alive but
# deaf to focus changes.
#
# Nothing here goes through `brew services`: Homebrew 6 refuses to load formulae
# from an untrusted tap, and borders/sketchybar live in felixkratz/formulae. That
# turned a restart into a half-restart. launchd and sketchybar's own --reload do
# the same job without asking brew for permission.

PATH="/opt/homebrew/bin:$PATH"
export PATH

uid=$(id -u)

yabai --restart-service
launchctl kickstart -k "gui/$uid/homebrew.mxcl.borders"
launchctl kickstart -k "gui/$uid/sh.brew.svim"

# A stray `brew cleanup` once unlinked the keg. launchd points at the opt path,
# so it just kept failing with EX_CONFIG and the bar stayed dead until relinked.
# Cheap insurance: if the binary is gone, link it back and kick the agent.
if ! command -v sketchybar >/dev/null 2>&1; then
	brew link felixkratz/formulae/sketchybar
	launchctl kickstart -k "gui/$uid/sh.brew.sketchybar"
fi

sketchybar --reload

echo "vm is restarted"
