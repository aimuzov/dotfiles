#!/bin/bash

battery=(
	script="$PLUGIN_DIR/battery.sh"
	label.drawing=on
	update_freq=120
	updates=on
	label.padding_left=6
)

sketchybar --add item battery right \
	--set battery "${battery[@]}" \
	--subscribe battery power_source_change system_woke
