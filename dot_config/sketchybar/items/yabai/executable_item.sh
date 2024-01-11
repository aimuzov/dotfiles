NAME="yabai"

config=(
	script="$CONFIG_DIR/items/yabai/script.sh"
	display=active
	icon.width=0
	label.width=0
)

sketchybar --add item $NAME left \
	--set $NAME "${config[@]}" \
	--add event window_focus \
	--subscribe $NAME window_focus mouse.clicked
