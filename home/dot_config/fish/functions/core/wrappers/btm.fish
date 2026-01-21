function btm --description 'use bottom with specific theme file' --wraps btm
    command btm --config_location="$XDG_CONFIG_HOME/bottom/themes/$CATPPUCCIN_FLAVOR.toml" $argv
end
