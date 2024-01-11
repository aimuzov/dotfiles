media_update() {
	STATE="$(echo "$INFO" | jq -r '.state')"

	if [ "$STATE" = "playing" ]; then
		MEDIA="$(echo "$INFO" | jq -r '.title + " / " + .artist')"
		sketchybar --set $NAME label="$MEDIA" drawing=on icon.background.drawing=on
	else
		sketchybar --set $NAME drawing=off icon.background.drawing=off
	fi
}

case "$SENDER" in
"media_change") media_update ;;
esac
