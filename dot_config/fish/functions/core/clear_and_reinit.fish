function clear_and_reinit
    command clear
    source "$XDG_CONFIG_HOME/fish/config.fish"

    if functions -q fish_prompt
        fish_prompt
    end

    commandline -f repaint
end
