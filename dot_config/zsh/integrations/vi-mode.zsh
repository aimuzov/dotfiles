source "$ZSH/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh"

ZVM_VI_HIGHLIGHT_FOREGROUND=black
ZVM_VI_HIGHLIGHT_BACKGROUND=magenta

export POSH_VI_MODE="I"
export POSH_VI_ICON="󰰄"

function my_zvm_vi_yank() {
	zvm_vi_yank
	echo -en "${CUTBUFFER}" | pbcopy
}

function my_zvm_vi_delete() {
	zvm_vi_delete
	echo -en "${CUTBUFFER}" | pbcopy
}

function my_zvm_vi_change() {
	zvm_vi_change
	echo -en "${CUTBUFFER}" | pbcopy
}

function my_zvm_vi_change_eol() {
	zvm_vi_change_eol
	echo -en "${CUTBUFFER}" | pbcopy
}

function my_zvm_vi_put_after() {
	CUTBUFFER=$(pbpaste)
	zvm_vi_put_after
	zvm_highlight clear
}

function my_zvm_vi_put_before() {
	CUTBUFFER=$(pbpaste)
	zvm_vi_put_before
	zvm_highlight clear
}

function zvm_after_lazy_keybindings() {
	zvm_define_widget my_zvm_vi_yank
	zvm_define_widget my_zvm_vi_delete
	zvm_define_widget my_zvm_vi_change
	zvm_define_widget my_zvm_vi_change_eol
	zvm_define_widget my_zvm_vi_put_after
	zvm_define_widget my_zvm_vi_put_before

	zvm_bindkey visual 'y' my_zvm_vi_yank
	zvm_bindkey visual 'd' my_zvm_vi_delete
	zvm_bindkey visual 'x' my_zvm_vi_delete
	zvm_bindkey vicmd 'C' my_zvm_vi_change_eol
	zvm_bindkey visual 'c' my_zvm_vi_change
	zvm_bindkey vicmd 'p' my_zvm_vi_put_after
	zvm_bindkey vicmd 'P' my_zvm_vi_put_before
}

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
