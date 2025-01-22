## -- ALIAS HELPER -----------------------------------------------------------------------------------------------------

zsh-defer source "$ZSH/plugins/you-should-use/you-should-use.plugin.zsh"

## -- AUTOCOMPLETE -----------------------------------------------------------------------------------------------------

source "$ZSH/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh"

zstyle ':autocomplete:*' min-input 2
zstyle ':autocomplete:*' delay 0.1

zsh-defer source "$ZSH/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh"

## -- SYNTAX HIGHLIGHTING ----------------------------------------------------------------------------------------------

zsh-defer source "$ZSH/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh"
zsh-defer source "$ZSH/plugins/zsh-syntax-highlighting/themes/$CATPPUCCIN_FLAVOR.zsh"
