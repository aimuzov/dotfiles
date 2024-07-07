export HOMEBREW_NO_ENV_HINTS=1
export HOMEBREW_NO_ANALYTICS=1

## ---------------------------------------------------------------------------------------------------------------------

eval "$(/opt/homebrew/bin/brew shellenv)"

## ---------------------------------------------------------------------------------------------------------------------

# https://docs.brew.sh/Shell-Completion#configuring-completions-in-bash
if type brew &>/dev/null; then
	FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

	autoload -Uz compinit
	compinit
fi
