NAME="front_app"

config=(
	script="$CONFIG_DIR/items/$NAME/script.sh"
	click_script="open -a 'Mission Control'"
	display=active
	icon.width=0
)

sketchybar --add item $NAME left \
	--set $NAME "${config[@]}" \
	--subscribe $NAME front_app_switched
