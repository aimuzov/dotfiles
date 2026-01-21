function nvim_update --description="Update Neovim to a specific tag"
    set tag $argv[1]
    set echo_preset "$(set_color blue) [mise] $(set_color black)"

    set nvim_path (echo (mise where neovim@$tag))

    if test $status -eq 1
        echo "$echo_preset nvim ($tag) not installed, fix it!"
        mise install neovim@$tag
        return
    end

    if not echo $nvim_path | grep -q neovim
        echo "$echo_preset Can't update nvim ($tag)"
        echo "$echo_preset nvim path (or error): $nvim_path"
        return
    end

    echo "$echo_preset updating nvim $tag..."
    set version_current (echo "$nvim_path/bin/nvim --version")
    mise uninstall neovim@$tag
    echo "$echo_preset current nvim version uninstalled:"
    echo $version_current

    echo "$echo_preset new version downloading..."
    command mise install neovim@$tag
    echo "$echo_preset nvim updated:"
    echo "$nvim_path/bin/nvim --version"

    nvim_disable_builtin_colorschemes
    echo "$echo_preset default colorscheme disabled"
end
