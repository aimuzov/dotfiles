function display_index_get() {
	local cond=$([[ "$1" == "1" ]] && echo "!=" || echo "==")
	local retina_uuid="37D8832A-2D66-02CA-B9F7-8F30A301B230"
	local index=$(yabai -m query --displays | jq "first(.[] | select(.uuid $cond \"$retina_uuid\") | .index)")

	if [ -z "$index" ]; then
		echo "1"
	else
		echo $index
	fi
}

function yabai_sudoers() {
	# https://github.com/koekeishiya/yabai/wiki/Installing-yabai-(latest-release)#configure-scripting-addition
	echo "aimuzov ALL=(root) NOPASSWD: sha256:$(shasum -a 256 $(which yabai)) --load-sa" | pbcopy
	command sudo visudo -f /private/etc/sudoers.d/yabai
}

function restart_vm() {
	command yabai --restart-service
	command skhd --restart-service
	command brew services restart borders
	command brew services restart svim
	command brew services restart sketchybar

	echo "vm is restarted"
}
