ICON_STACK=􀏭
ICON_FULLSCREEN_ZOOM=􀏜
ICON_PARENT_ZOOM=􀥃
ICON_FLOAT=􀢌

window_state() {
	source "$CONFIG_DIR/colors.sh"

	WINDOW=$(yabai -m query --windows --window)
	STACK_INDEX=$(echo "$WINDOW" | jq '.["stack-index"]')

	COLOR=$BAR_BORDER_COLOR
	COLOR_BG=$BAR_COLOR
	ICON=""

	if [ "$(echo "$WINDOW" | jq '.["is-floating"]')" = "true" ]; then
		ICON+=$ICON_FLOAT
		COLOR=$RED
		COLOR_BG=$RED_BG
	elif [ "$(echo "$WINDOW" | jq '.["has-fullscreen-zoom"]')" = "true" ]; then
		ICON+=$ICON_FULLSCREEN_ZOOM
		COLOR=$GREEN
		COLOR_BG=$GREEN_BG
	elif [ "$(echo "$WINDOW" | jq '.["has-parent-zoom"]')" = "true" ]; then
		ICON+=$ICON_PARENT_ZOOM
		COLOR=$BLUE
		COLOR_BG=$BLUE_BG
	elif [[ $STACK_INDEX -gt 0 ]]; then
		LAST_STACK_INDEX=$(yabai -m query --windows --window stack.last | jq '.["stack-index"]')
		ICON+=$ICON_STACK
		LABEL="$(printf "[%s/%s]" "$STACK_INDEX" "$LAST_STACK_INDEX")"
		COLOR=$MAGENTA
		COLOR_BG=$MAGENTA_BG
	fi

	args=(--bar color=$COLOR_BG border_color=$COLOR --animate sin 10 --set $NAME icon.color=$COLOR)

	[ -z "$LABEL" ] && args+=(label.width=0) ||
		args+=(label="$LABEL" label.width=40)

	[ -z "$ICON" ] && args+=(icon.width=0) ||
		args+=(icon="$ICON" icon.width=30)

	sketchybar -m "${args[@]}"
}

mouse_clicked() {
	yabai -m window --toggle float
	window_state
}

case "$SENDER" in
"mouse.clicked") mouse_clicked ;;
"window_focus") window_state ;;
esac