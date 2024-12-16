## -- BREW -------------------------------------------------------------------------------------------------------------

source "$ZSH/plugins/brew/brew.plugin.zsh"
eval "$(/opt/homebrew/bin/brew shellenv)"

# https://docs.brew.sh/Shell-Completion#configuring-completions-in-bash
if type brew &>/dev/null; then
	FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

	autoload -Uz compinit
	compinit
fi

HOMEBREW_NO_ENV_HINTS=1
HOMEBREW_NO_ANALYTICS=1

# https://github.com/git-quick-stats/git-quick-stats#macos-homebrew
PATH="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH"

## -- ASDF -------------------------------------------------------------------------------------------------------------

export ASDF_CONFIG_FILE="$HOME/.config/asdf/asdfrc"

# https://asdf-vm.com/guide/getting-started.html#_3-install-asdf
. $(brew --prefix)/opt/asdf/libexec/asdf.sh

## -- MISE -------------------------------------------------------------------------------------------------------------

if [[ ! -e "$ZSH_CACHE_DIR/completions/_mise" ]]; then
	eval "mise completion zsh > $ZSH_CACHE_DIR/completions/_mise"
fi

zsh-defer -t 0.1 eval "$(mise activate zsh)"
zsh-defer source "$ZSH/plugins/mise/mise.plugin.zsh"

MISE_INSTALL_PATH="/opt/homebrew/bin/mise"
