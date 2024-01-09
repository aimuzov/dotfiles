#!/bin/bash

SPACE_ICONS=("1" "2" "3" "4" "5" "6" "7" "8" "9" "10" "11" "12")

sid=0
spaces=()
for i in "${!SPACE_ICONS[@]}"; do
	sid=$(($i + 1))

	space=(
		background.color=$BACKGROUND_1
		icon.color=$GREY
		icon.highlight_color=$WHITE
		icon.padding_left=6
		icon.padding_right=0
		icon.width=16
		icon="${SPACE_ICONS[i]}"
		label.color=$GREY
		label.font="sketchybar-app-font:Regular:16.0"
		label.highlight_color=$WHITE
		label.padding_right=16
		label.y_offset=-1
		padding_left=2
		padding_right=2
		script="$PLUGIN_DIR/space.sh"
		space=$sid
	)

	sketchybar --add space space.$sid left \
		--set space.$sid "${space[@]}" \
		--subscribe space.$sid mouse.clicked
done

space_creator=(
	click_script='yabai -m space --create'
	display=active
	icon.color=$WHITE
	icon.font="$FONT:Heavy:12.0"
	icon=􀆊
	label.drawing=off
	padding_left=8
	padding_right=8
	script="$PLUGIN_DIR/space_windows.sh"
)

sketchybar --add item space_creator left \
	--set space_creator "${space_creator[@]}" \
	--subscribe space_creator space_windows_change
