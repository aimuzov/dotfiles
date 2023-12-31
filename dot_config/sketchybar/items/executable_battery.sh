#!/bin/bash

battery=(
	script="$PLUGIN_DIR/battery.sh"
	icon.font="$FONT:Regular:16.0"
	label.drawing=on
	update_freq=120
	updates=on
)

sketchybar --add item battery right \
	--set battery "${battery[@]}" \
	--subscribe battery power_source_change system_woke
