# https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins
plugins=(
	brew
	git
	git-flow
	git-flow-avh
	you-should-use
	zsh-autosuggestions
	zsh-bat
	zsh-interactive-cd
	zsh-mise
	zsh-npm
	zsh-syntax-highlighting
	zsh-vi-mode
	# какой-то особенный, должен идти после mise
	# чтобы не руинить шелл.
	zsh-eza
)

## ---------------------------------------------------------------------------------------------------------------------

source "$ZSH/custom/plugins/zsh-syntax-highlighting/themes/$CATPPUCCIN_FLAVOR.zsh"

## ---------------------------------------------------------------------------------------------------------------------

ZVM_VI_HIGHLIGHT_FOREGROUND=black
ZVM_VI_HIGHLIGHT_BACKGROUND=magenta
