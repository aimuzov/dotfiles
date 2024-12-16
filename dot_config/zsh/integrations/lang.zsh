## -- GO ---------------------------------------------------------------------------------------------------------------

export GOPATH="$HOME/Library/go"
PATH="$GOPATH:$PATH"

## -- NODE -------------------------------------------------------------------------------------------------------------

zsh-defer source "$ZSH/plugins/zsh-better-npm-completion/zsh-better-npm-completion.plugin.zsh"

export NODE_MODULES_PATH="node_modules/.bin"
PATH="$NODE_MODULES_PATH:$PATH"

## -- RUST -------------------------------------------------------------------------------------------------------------

export CARGO_BIN_PATH="$HOME/.cargo/bin"
PATH="$CARGO_BIN_PATH:$PATH"
