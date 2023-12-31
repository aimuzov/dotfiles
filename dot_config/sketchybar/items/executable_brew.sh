#!/bin/bash

# Trigger the brew_udpate event when brew update or upgrade is run from cmdline
# e.g. via function in .zshrc

brew=(
	icon=􀐛
	script="$PLUGIN_DIR/brew.sh"
	click_script="wezterm start -- zsh -c 'brew upgrade; read -r -d '' _ </dev/tty'"
)

sketchybar --add event brew_update \
	--add item brew right \
	--set brew "${brew[@]}" \
	--subscribe brew brew_update
