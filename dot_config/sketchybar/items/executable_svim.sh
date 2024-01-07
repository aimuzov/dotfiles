#!/bin/bash

svim=(
	drawing=off
	icon.font.size=26
	icon.padding_right=13
	icon=$INSERT_MODE
	script="$PLUGIN_DIR/svim.sh"
	updates=on
)

sketchybar --add event svim_update \
	--add item svim right \
	--set svim "${svim[@]}" \
	--subscribe svim svim_update
