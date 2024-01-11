NAME="svim"

config=(
	script="$CONFIG_DIR/items/svim/script.sh"
	drawing=off
	icon.font.size=26
	icon.padding_right=6
	updates=on
)

sketchybar --add item $NAME right \
	--add event svim_update \
	--set $NAME "${config[@]}" \
	--subscribe $NAME svim_update window_focus
