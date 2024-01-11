ICON_NORMAL=􀂯
ICON_INSERT=􀂥
ICON_VISUAL=􀂿
ICON_CMD=􀂙
ICON_PENDING=􀈏

svim_update() {
	source "$CONFIG_DIR/colors.sh"

	DRAWING=on
	DRAW_CMD=off
	COLOR=$WHITE

	case "$MODE" in
	"I") ICON="$ICON_INSERT" COLOR=$GREEN ;;
	"N") ICON="$ICON_NORMAL" COLOR=$BLUE ;;
	"V") ICON="$ICON_VISUAL" COLOR=$MAGENTA ;;
	"C") ICON="$ICON_CMD" DRAW_CMD=on COLOR=$ORANGE ;;
	"_") ICON="$ICON_PENDING" ;;
	*) DRAWING=off ;;
	esac

	sketchybar --set $NAME drawing="$DRAWING" \
		label.drawing="$DRAW_CMD" \
		icon="$ICON" \
		icon.color="$COLOR" \
		label="$CMDLINE"
}

case "$SENDER" in
"svim_update") svim_update ;;
esac
