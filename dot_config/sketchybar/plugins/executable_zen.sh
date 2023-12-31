#!/bin/bash

zen_on() {
	sketchybar --set '/cpu.*/' drawing=off \
		--set calendar icon.drawing=off \
		--set separator drawing=off \
		--set front_app drawing=off \
		--set brew drawing=off
}

zen_off() {
	sketchybar --set '/cpu.*/' drawing=on \
		--set calendar icon.drawing=on \
		--set separator drawing=on \
		--set front_app drawing=on \
		--set volume_icon drawing=on \
		--set brew drawing=on
}

if [ "$1" = "on" ]; then
	zen_on
elif [ "$1" = "off" ]; then
	zen_off
else
	if [ "$(sketchybar --query brew | jq -r ".geometry.drawing")" = "on" ]; then
		zen_on
	else
		zen_off
	fi
fi
