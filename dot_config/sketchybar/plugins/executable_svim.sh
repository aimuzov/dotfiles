#!/bin/bash

source "$CONFIG_DIR/icons.sh"
source "$CONFIG_DIR/colors.sh"

if [ "$SENDER" = "svim_update" ]; then
	DRAWING=on
	DRAW_CMD=off
	COLOR=$WHITE
	case "$MODE" in
	"I")
		ICON="$SVIM_MODE_INSERT" COLOR=$GREEN
		;;
	"N")
		ICON="$SVIM_MODE_NORMAL" COLOR=$BLUE
		;;
	"V")
		ICON="$SVIM_MODE_VISUAL" COLOR=$MAGENTA
		;;
	"C")
		ICON="$SVIM_MODE_CMD" DRAW_CMD=on COLOR=$ORANGE
		;;
	"_")
		ICON="$SVIM_MODE_PENDING"
		;;
	*)
		DRAWING=off
		;;
	esac

	sketchybar --set $NAME drawing="$DRAWING" \
		label.drawing="$DRAW_CMD" \
		icon="$ICON" \
		icon.color="$COLOR" \
		label="$CMDLINE"
fi
