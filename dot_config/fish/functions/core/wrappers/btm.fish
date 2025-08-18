function btm --description 'use bottom with specific theme file' --wraps btm
    command btm --config_location="$XDG_CONFIG_HOME/bottom/themes/$([ $MACOS_IS_DARK = yes ]; and echo macchiato; or echo latte).toml" $argv
end
