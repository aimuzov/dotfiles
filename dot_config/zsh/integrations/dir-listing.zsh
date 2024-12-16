## -- ZOXIDE -----------------------------------------------------------------------------------------------------------

eval "$($(mise which zoxide) init zsh)"

## -- BETTER CD --------------------------------------------------------------------------------------------------------

zsh-defer source "$ZSH/plugins/zsh-interactive-cd/zsh-interactive-cd.plugin.zsh"
