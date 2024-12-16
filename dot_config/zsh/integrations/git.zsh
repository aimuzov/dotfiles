## -- GIT / GIT FLOW ---------------------------------------------------------------------------------------------------

zsh-defer -t 0.1 source "$ZSH/plugins/git/git.plugin.zsh"
zsh-defer source "$ZSH/plugins/git-flow/git-flow.plugin.zsh"
zsh-defer source "$ZSH/plugins/git-flow-avh/git-flow-avh.plugin.zsh"

## -- FORGIT -----------------------------------------------------------------------------------------------------------

zsh-defer source "$ZSH/plugins/forgit/forgit.plugin.zsh"

export FORGIT_FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS"
PATH="$FORGIT_INSTALL_DIR/bin:$PATH"
