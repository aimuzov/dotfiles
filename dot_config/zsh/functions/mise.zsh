function mise() {
	command mise "$@"

	if [[ $* =~ "upgrade" ]] || [[ $* =~ "update" ]] || [[ $* =~ "outdated" ]]; then
		command sketchybar --trigger deps_update
	fi
}
