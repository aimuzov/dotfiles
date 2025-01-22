eval "$($(mise which oh-my-posh) init zsh --config $XDG_CONFIG_HOME/oh-my-posh/config.json)"

function _omp_redraw-prompt() {
	local precmd
	for precmd in "${precmd_functions[@]}"; do
		"$precmd"
	done

	zle .reset-prompt
}
