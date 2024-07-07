export EDITOR="nvim"
export XDG_CONFIG_HOME="$HOME/.config"

## ---------------------------------------------------------------------------------------------------------------------

# https://github.com/ohmyzsh/ohmyzsh/wiki/Settings#zsh
export ZSH="$HOME/.oh-my-zsh"
export ZSH_COMPDUMP="$ZSH/cache/.zcompdump-$HOST"

## ---------------------------------------------------------------------------------------------------------------------

export ZSH_CONFIG_PATH="$XDG_CONFIG_HOME/zsh"
export DOTFILES_SRC_PATH="$HOME/projects/github/aimuzov/dotfiles"

## ---------------------------------------------------------------------------------------------------------------------

export BIN_PATH="$HOME/.bin"
export PATH="$BIN_PATH:$PATH"

## ---------------------------------------------------------------------------------------------------------------------

export MACOS_IS_DARK=$([[ $(defaults read -g AppleInterfaceStyle 2>&1) == "Dark" ]] && echo "yes" || echo "no")
