#!/bin/bash

source "$CONFIG_DIR/colors.sh"

COUNT="$(brew outdated | wc -l | tr -d ' ')"
COLOR=$RED

case "$COUNT" in
2[0-9])
	COLOR=$ORANGE
	;;
[1-9])
	COLOR=$YELLOW
	;;
0)
	COLOR=$GREEN
	COUNT=
	;;
esac

sketchybar --set $NAME label=$COUNT icon.color=$COLOR
