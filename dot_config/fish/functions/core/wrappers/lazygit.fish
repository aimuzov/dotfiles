function lazygit --description 'use lazygit with specific theme file' --wraps lazygit
    command lazygit --use-config-file="$XDG_CONFIG_HOME/lazygit/config.yml,$XDG_CONFIG_HOME/lazygit/theme-$([ $MACOS_IS_DARK = yes ]; and echo dark; or echo light).yml" $argv
end
