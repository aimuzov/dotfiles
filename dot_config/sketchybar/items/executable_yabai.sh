#!/bin/bash

yabai=(
	display=active
	icon.width=0
	label.width=0
	script="$PLUGIN_DIR/yabai.sh"
)

sketchybar --add event window_focus \
	--add item yabai left \
	--set yabai "${yabai[@]}" \
	--subscribe yabai window_focus \
	mouse.clicked
