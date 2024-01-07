media=(
	icon.background.drawing=on
	icon.background.image=media.artwork
	icon.background.image.corner_radius=14
	icon.background.image.scale=0.9
	script="$PLUGIN_DIR/media.sh"
	click_script="open -a 'Яндекс Музыка'"
	label.max_chars=30
	label.padding_left=12
	label.padding_right=12
	scroll_texts=on
	updates=on
)

sketchybar --add item media right \
	--set media "${media[@]}" \
	--subscribe media media_change
