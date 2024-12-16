eval "$($(mise which oh-my-posh) init zsh --config $XDG_CONFIG_HOME/oh-my-posh/config.json)"

function _omp_redraw-prompt() {
	local precmd
	for precmd in "${precmd_functions[@]}"; do
		"$precmd"
	done

	zle .reset-prompt
}

export POSH_VI_MODE="I"
export POSH_VI_ICON="󰰄"

function zvm_after_select_vi_mode() {
	case $ZVM_MODE in
	$ZVM_MODE_NORMAL)
		POSH_VI_MODE="N"
		POSH_VI_ICON="󰰓"
		;;
	$ZVM_MODE_INSERT)
		POSH_VI_MODE="I"
		POSH_VI_ICON="󰰄"
		;;
	$ZVM_MODE_VISUAL)
		POSH_VI_MODE="V"
		POSH_VI_ICON="󰰫"
		;;
	$ZVM_MODE_VISUAL_LINE)
		POSH_VI_MODE="V-L"
		POSH_VI_ICON="󰰬"
		;;
	$ZVM_MODE_REPLACE)
		POSH_VI_MODE="R"
		POSH_VI_ICON="󰰟"
		;;
	esac
	_omp_redraw-prompt
}
