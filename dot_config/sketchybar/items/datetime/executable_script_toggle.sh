show() {
	sketchybar --set front_app drawing=off \
		--set separator drawing=off \
		--set '/cpu.*/' drawing=off \
		--set brew drawing=off \
		--set battery label.drawing=off \
		--set datetime icon.drawing=off \
		--set space_creator icon.drawing=off
}

hide() {
	sketchybar --set separator drawing=on \
		--set front_app drawing=on \
		--set '/cpu.*/' drawing=on \
		--set brew drawing=on \
		--set battery label.drawing=on \
		--set datetime icon.drawing=on \
		--set space_creator icon.drawing=on
}

if [ "$1" = "on" ]; then
	show
elif [ "$1" = "off" ]; then
	hide
else
	if [ "$(sketchybar --query brew | jq -r ".geometry.drawing")" = "on" ]; then
		show
	else
		hide
	fi
fi
