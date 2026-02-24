function lazygit --description 'use lazygit with specific theme file' --wraps lazygit
    set -gx LAZYGIT_NEW_DIR_FILE "$XDG_CONFIG_HOME/lazygit/newdir"
    command lazygit --use-config-file="$XDG_CONFIG_HOME/lazygit/config.yml,$XDG_CONFIG_HOME/lazygit/theme-catppuccin-$CATPPUCCIN_FLAVOR.yml" $argv

    if test -f $LAZYGIT_NEW_DIR_FILE
        cd "$(cat $LAZYGIT_NEW_DIR_FILE)"
        rm -f $LAZYGIT_NEW_DIR_FILE >/dev/null
    end
end
