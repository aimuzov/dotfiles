#!/bin/bash

yabai=(
	script="$PLUGIN_DIR/yabai.sh"
	display=active
)

sketchybar --add event window_focus \
	--add item yabai left \
	--set yabai "${yabai[@]}" \
	--subscribe yabai window_focus \
	mouse.clicked
