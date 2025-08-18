# https://github.com/neovim/neovim/issues/15083#issuecomment-1987041311

function nvim_disable_builtin_colorschemes
    set -l base_path "$HOME/.local/share/mise/installs/neovim"

    for dir in (ls $base_path)
        set -l colors_path "$base_path/$dir/nvim-macos-arm64/share/nvim/runtime/colors"

        if test -d $colors_path
            set -l files $colors_path/*.vim

            for file in $files
                if test "$file" != "default.vim"
                    mv "$file" "$file.disabled"
                end
            end

            if test -e "$colors_path/vim.lua"
                mv "$colors_path/vim.lua" "$colors_path/vim.lua.disabled"
            end
        end
    end
end
