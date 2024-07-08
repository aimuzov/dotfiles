function nvim_plugins_update() {
	echo "[nvim] updating lazy plugins..."
	command nvim --headless "+Lazy! update" +qa
	echo "[nvim] lazy plugins updated..."

	command chezmoi add "$HOME/.config/nvim/lazy-lock.json"
	echo "[chezmoi] lazy-lock applied..."
}

# https://github.com/neovim/neovim/issues/15083#issuecomment-1987041311
function nvim_disable_builtin_colorschemes() {
	local base_path="$HOME/.local/share/mise/installs/neovim/"

	for dir in $(ls $base_path); do
		if [ -d "$base_path/$dir/share/nvim/runtime/colors" ]; then
			local dir_prev="$(pwd)"
			cd "$base_path/$dir/share/nvim/runtime/colors"

			for file in *.vim; do
				if [ "$file" != "default.vim" ]; then
					mv "$file" "$file.disabled"
				fi
			done

			mv "vim.lua" "vim.lua.disabled"

			cd $dir_prev
		fi
	done
}

function nvim_update() {
	local tag="$1"
	local nvim_path="$(echo $(mise where neovim@$tag))"

	if [[ "$nvim_path" == "Version not installed" ]]; then
		echo "\n\033[0;93m[zsh]\033[0m nvim ($tag) not installed, fix it!"
		command mise install neovim@$tag
		nvim_update $tag
		return
	fi

	if [[ "$nvim_path" != *"neovim"* ]]; then
		echo "\n\033[0;91m[zsh]\033[0m Can't update nvim ($tag)"
		echo "\n\033[0;91m[zsh]\033[0m nvim path (or error): $nvim_path"
		return
	fi

	echo "\033[0;94m[mise]\033[0m updating nvim $tag..."
	local version_current="$nvim_path/bin/nvim --version"
	command mise uninstall neovim@$tag
	echo "\n\033[0;94m[mise]\033[0m current nvim version uninstalled:"
	echo $version_current

	echo "\n\033[0;94m[mise]\033[0m new version downloading..."
	command mise install neovim@$tag
	echo "\n\033[0;93m[mise]\033[0m nvim updated:"
	echo "$nvim_path/bin/nvim --version"

	nvim_disable_builtin_colorschemes
	echo "\n\033[0;32m[zsh]\033[0m default colorscheme disabled"

	command sketchybar --trigger nvim_update
}
