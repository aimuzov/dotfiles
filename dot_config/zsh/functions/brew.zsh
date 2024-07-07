function brew() {
	command brew "$@"

	if [[ $* =~ "upgrade" ]] || [[ $* =~ "update" ]] || [[ $* =~ "outdated" ]]; then
		command sketchybar --trigger brew_update
	fi
}

function brew_last_updated() {
	# https://stackoverflow.com/a/67845884
	local CELLAR="$(brew --prefix)/Cellar"
	local QUERY='[inputs | {time, file: (input_filename|sub($cellar;"") | sub("/INSTALL_RECEIPT.json";""))}] | sort_by(.time)[-10:][] | .file'
	command jq -cnr --arg cellar "$CELLAR" $QUERY $CELLAR/*/*/INSTALL_RECEIPT.json

}
