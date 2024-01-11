battery=(
	script="$CONFIG_DIR/items/battery/script.sh"
	label.drawing=on
	update_freq=120
	updates=on
)
#
sketchybar --add item battery right \
	--set battery "${battery[@]}" \
	--subscribe battery power_source_change system_woke
