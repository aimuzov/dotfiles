#!/bin/sh
# Restarts the window manager stack in the order the pieces depend on each other.
#
# yabai goes first: it re-runs yabairc, which re-adds the signals and relaunches
# skhd. sketchybar comes last so that the items re-install their own window_focus
# signal on a yabai that is already up.

PATH="/opt/homebrew/bin:$PATH"
export PATH

yabai --restart-service
brew services restart borders
brew services restart svim
brew services restart sketchybar

echo "vm is restarted"
