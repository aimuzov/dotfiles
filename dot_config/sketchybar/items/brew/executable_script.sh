source "$CONFIG_DIR/colors.sh"

COUNT="$(brew outdated | wc -l | tr -d ' ')"
COLOR=$WHITE

case "$COUNT" in
1[0-9]) COLOR=$ORANGE ;;
[1-9]) COLOR=$YELLOW ;;
0) COUNT="" ;;
*) COLOR=$RED ;;
esac

sketchybar --set $NAME label="$COUNT" icon.color="$COLOR"
