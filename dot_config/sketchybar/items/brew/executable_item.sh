NAME="brew"

config=(
	script="$CONFIG_DIR/items/$NAME/script.sh"
	click_script='wezterm start -- zsh -c "brew upgrade"'
	icon=􀐛
)

sketchybar --add item $NAME right \
	--set $NAME "${config[@]}" \
	--add event brew_update \
	--subscribe $NAME brew_update
