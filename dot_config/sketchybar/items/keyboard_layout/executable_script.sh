ICON_EN=􀂕
ICON_RU=􀂷
ICON_UNKNOWN=􀃭

LAYOUT="$(im-select)"

case "$LAYOUT" in
"com.apple.keylayout.US") ICON=$ICON_EN ;;
"com.apple.keylayout.Russian") ICON=$ICON_RU ;;
*) ICON=$ICON_UNKNOWN ;;
esac

sketchybar --set $NAME drawing=on icon="$ICON"
