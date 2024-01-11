NAME="keyboard_layout"

config=(
	script="$CONFIG_DIR/items/keyboard_layout/script.sh"
	icon.font.size=16
)

sketchybar --add item $NAME right \
	--set $NAME "${config[@]}" \
	--add event keyboard_layout_change "AppleSelectedInputSourcesChangedNotification" \
	--subscribe $NAME keyboard_layout_change
