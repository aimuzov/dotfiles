SPACESHIP_SYMLINK_PATH="$ZSH/custom/themes/spaceship.zsh-theme"

if [ ! \( -e "${SPACESHIP_SYMLINK_PATH}" \) ]; then
	ln -s "$ZSH/custom/themes/spaceship-prompt/spaceship.zsh-theme" $SPACESHIP_SYMLINK_PATH
fi

ZSH_THEME="spaceship"
