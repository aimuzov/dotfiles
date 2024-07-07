# https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins
plugins=(
	brew
	git
	git-flow
	git-flow-avh
	you-should-use
	zsh-autosuggestions
	zsh-interactive-cd
	zsh-syntax-highlighting
)

## ---------------------------------------------------------------------------------------------------------------------

THEME_NAME=$([[ $MACOS_IS_DARK == "yes" ]] && echo "macchiato" || echo "latte")
source "$ZSH/custom/plugins/zsh-syntax-highlighting/themes/$THEME_NAME.zsh"
