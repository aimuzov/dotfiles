function wezterm_update_icon
    cd $XDG_CONFIG_HOME/wezterm/icon
    make install
    return 0
end
