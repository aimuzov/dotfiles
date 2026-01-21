function nvim_config_pick
    set config (fd --max-depth 1 --glob '{nvim,nvim-*}' $XDG_CONFIG_HOME | fzf --prompt="Neovim Configs > " --height=~50% --layout=reverse --border --exit-0)

    if test -z "$config"
        echo "No config selected"
        return
    end

    echo "$config (mise which nvim) $argv"

    # Установить переменную NVIM_APPNAME и запустить Neovim
    env NVIM_APPNAME=(basename $config) (mise which nvim) $argv
end
