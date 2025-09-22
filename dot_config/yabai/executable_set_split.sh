#!/usr/bin/env zsh
# vi: ft=sh

space_index=$(yabai -m query --spaces --space | jq -r '.index')

if [ "$space_index" -e 10 ]; then
	windows=$(yabai -m query --windows --space $space_index)

	time_id=$(echo "$windows" | jq '.[] | select(.app=="Telegram") | .id')
	tg_id=$(echo "$windows" | jq '.[] | select(.app=="TiMe") | .id')

	if [ -n "$time_id" ] && [ -n "$tg_id" ]; then
		yabai -m window "$time_id" --focus

		window_count=$(echo "$windows" | jq 'length')

		if [ "$window_count" -eq 2 ]; then
			yabai -m window --ratio abs:0.7
		fi

		yabai -m window "$tg_id" --warp "$time_id"
	fi
fi
