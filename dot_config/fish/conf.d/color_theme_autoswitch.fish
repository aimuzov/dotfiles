function color_theme_autoswitch --description 'Automatically reload colors for utils when terminal theme changes' --on-variable fish_terminal_color_theme
    if test "$fish_terminal_color_theme" = dark
        set -gx MACOS_IS_DARK yes
        set -gx CATPPUCCIN_FLAVOR macchiato
    else
        set -gx MACOS_IS_DARK no
        set -gx CATPPUCCIN_FLAVOR latte
    end

    if type -q fzf
        # https://github.com/catppuccin/fzf?tab=readme-ov-file#usage
        source "$__fish_config_dir/themes/catppuccin-fzf-$CATPPUCCIN_FLAVOR.fish"

        # Save theme colors
        set -l theme_colors $FZF_DEFAULT_OPTS

        # Combine theme colors with additional options
        set -Ux FZF_DEFAULT_OPTS "$theme_colors $additional_opts"
    end

    if type -q bat
        set -l CATPPUCCIN_FLAVOR_CAPITALIZED (string sub -l 1 $CATPPUCCIN_FLAVOR | string upper)(string sub -s 2 $CATPPUCCIN_FLAVOR)
        set -gx BAT_THEME "Catppuccin $CATPPUCCIN_FLAVOR_CAPITALIZED"
    end

    if type -q vivid # eza 
        set -l COLORS (vivid generate "catppuccin-$CATPPUCCIN_FLAVOR")

        set -gx LS_COLORS $COLORS
        set -gx EZA_COLORS $COLORS
    end
end
