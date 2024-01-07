#!/bin/bash

source "$CONFIG_DIR/icons.sh"
source "$CONFIG_DIR/colors.sh"

BATTERY_INFO="$(pmset -g batt)"
PERCENTAGE=$(echo "$BATTERY_INFO" | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(echo "$BATTERY_INFO" | grep 'AC Power')

if [ $PERCENTAGE = "" ]; then
	exit 0
fi

COLOR=$WHITE
LABEL="${PERCENTAGE}%"

case ${PERCENTAGE} in
9[0-9] | 100)
	ICON=$BATTERY_100
	COLOR=$GREEN
	LABEL=""
	;;
[6-8][0-9])
	ICON=$BATTERY_75
	COLOR=$YELLOW
	;;
[3-5][0-9])
	ICON=$BATTERY_50
	COLOR=$ORANGE
	;;
[1-2][0-9])
	ICON=$BATTERY_25
	COLOR=$RED
	;;
*)
	ICON=$BATTERY_0
	COLOR=$RED
	;;
esac

if [[ $CHARGING != "" ]]; then
	ICON=$BATTERY_CHARGING
fi

sketchybar --set $NAME drawing=on icon="$ICON" icon.color=$COLOR label=$LABEL
