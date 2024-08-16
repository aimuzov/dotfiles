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
	zsh-syntax-highlighting
	zsh-vi-mode
)

## ---------------------------------------------------------------------------------------------------------------------

THEME_NAME=$([[ $MACOS_IS_DARK == "yes" ]] && echo "macchiato" || echo "latte")
source "$ZSH/custom/plugins/zsh-syntax-highlighting/themes/$THEME_NAME.zsh"

## ---------------------------------------------------------------------------------------------------------------------

ZVM_VI_HIGHLIGHT_FOREGROUND=black
ZVM_VI_HIGHLIGHT_BACKGROUND=magenta
