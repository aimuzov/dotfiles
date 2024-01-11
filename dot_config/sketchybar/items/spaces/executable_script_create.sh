update() {
	args=(--animate sin 10)

	space="$(echo "$INFO" | jq -r '.space')"
	apps="$(echo "$INFO" | jq -r '.apps | keys[]')"

	icon_strip=" "
	if [ "${apps}" != "" ]; then
		while read -r app; do
			icon_strip+=" $($CONFIG_DIR/items/spaces/icons_map.sh "$app")"
		done <<<"${apps}"
	else
		icon_strip=""
	fi
	args+=(--set space.$space label="$icon_strip")

	sketchybar -m "${args[@]}"
}

case "$SENDER" in
"space_windows_change") update ;;
esac
