#!/bin/bash

calendar=(
	click_script="$PLUGIN_DIR/zen.sh"
	icon.font="$FONT:Regular:12.0"
	icon=cal
	script="$PLUGIN_DIR/calendar.sh"
	update_freq=30
)

sketchybar --add item calendar right \
	--set calendar "${calendar[@]}" \
	--subscribe calendar system_woke
