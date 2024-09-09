function wezterm_update_icon() {
	cd ~/.config/wezterm/icon
	command make install
}

function sketchybar_update_icons() {
	cd $XDG_CONFIG_HOME/sketchybar-app-font
	command npm install
	command npm run build:install
	command cp dist/sketchybar-app-font.ttf $HOME/Library/Fonts/
	command cp dist/icon_map.lua $XDG_CONFIG_HOME/sketchybar/items/left/spaces/
}
