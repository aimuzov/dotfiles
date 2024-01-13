NAME="media"

config=(
	script="$CONFIG_DIR/items/$NAME/script.sh"
	icon.background.drawing=on
	icon.background.image=media.artwork
	icon.background.image.corner_radius=14
	icon.background.image.scale=0.9
	label.max_chars=30
	label.padding_left=9
	scroll_texts=on
	update_freq=30
	updates=on
)

sketchybar --add item $NAME right \
	--set $NAME "${config[@]}" \
	--add event media_click \
	--subscribe $NAME media_change media_click
