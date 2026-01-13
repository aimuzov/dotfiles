function lazygit --description 'use lazygit with specific theme file' --wraps lazygit
    command lazygit --use-config-file="$XDG_CONFIG_HOME/lazygit/config.yml,$XDG_CONFIG_HOME/lazygit/theme-catppuccin-$CATPPUCCIN_FLAVOR.yml" $argv
end
