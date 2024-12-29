function mise() {
	if [[ $* =~ "upgrade" ]] || [[ $* =~ "update" ]]; then
		rm $CARGO_HOME/.package-cache
	fi

	command mise "$@"

	if [[ $* =~ "upgrade" ]] || [[ $* =~ "update" ]] || [[ $* =~ "outdated" ]]; then
		command sketchybar --trigger deps_update
	fi
}
