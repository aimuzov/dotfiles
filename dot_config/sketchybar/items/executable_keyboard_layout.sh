#!/bin/bash

keyboard=(
	icon.font.size=18
	label.drawing=off
	label.width=18
	padding_right=12
	script="$PLUGIN_DIR/keyboard_layout.sh"
)

sketchybar --add item keyboard right \
	--set keyboard "${keyboard[@]}" \
	--add event keyboard_change "AppleSelectedInputSourcesChangedNotification" \
	--subscribe keyboard keyboard_change
