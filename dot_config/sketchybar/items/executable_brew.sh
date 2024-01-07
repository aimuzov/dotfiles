#!/bin/bash

brew=(
	icon=􀐛
	script="$PLUGIN_DIR/brew.sh"
	click_script="wezterm start -- zsh -c 'brew upgrade'"
)

sketchybar --add event brew_update \
	--add item brew right \
	--set brew "${brew[@]}" \
	--subscribe brew brew_update
