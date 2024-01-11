NAME="datetime"

config=(
	script="$CONFIG_DIR/items/$NAME/script.sh"
	click_script="$CONFIG_DIR/items/$NAME/script_toggle.sh"
	update_freq=30
	icon.font.size=12
	icon.font.style="Regular"
)

sketchybar --add item $NAME right \
	--set $NAME "${config[@]}" \
	--subscribe $NAME system_woke
