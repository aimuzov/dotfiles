#!/bin/bash

source "$CONFIG_DIR/icons.sh"
source "$CONFIG_DIR/colors.sh"

LAYOUT="$(im-select)"

case "$LAYOUT" in
"com.apple.keylayout.US")
	ICON=$KEYBOARD_LAYOUT_EN
	LABEL="us"
	;;
"com.apple.keylayout.Russian")
	ICON=$KEYBOARD_LAYOUT_RU
	LABEL="ru"
	;;
*)
	ICON=$KEYBOARD_LAYOUT_UNKNOWN
	LABEL='unknown'
	;;
esac

sketchybar --set $NAME drawing=on icon="$ICON" label="$LABEL"
