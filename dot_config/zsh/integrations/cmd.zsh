## -- ALIAS HELPER -----------------------------------------------------------------------------------------------------

zsh-defer source "$ZSH/plugins/you-should-use/you-should-use.plugin.zsh"

## -- AUTOCOMPLETE -----------------------------------------------------------------------------------------------------

zsh-defer source "$ZSH/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh"

## -- SYNTAX HIGHLIGHTING ----------------------------------------------------------------------------------------------

zsh-defer source "$ZSH/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh"
zsh-defer source "$ZSH/plugins/zsh-syntax-highlighting/themes/$CATPPUCCIN_FLAVOR.zsh"

## -- VI MODE ----------------------------------------------------------------------------------------------------------

zsh-defer source "$ZSH/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh"

ZVM_VI_HIGHLIGHT_FOREGROUND=black
ZVM_VI_HIGHLIGHT_BACKGROUND=magenta

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
