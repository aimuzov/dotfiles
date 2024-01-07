#!/bin/bash

battery=(
	label.drawing=on
	label.padding_left=6
	script="$PLUGIN_DIR/battery.sh"
	update_freq=120
	updates=on
)

sketchybar --add item battery right \
	--set battery "${battery[@]}" \
	--subscribe battery power_source_change system_woke
