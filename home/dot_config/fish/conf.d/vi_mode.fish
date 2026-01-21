function __rerender_on_bind_mode_change --on-variable fish_bind_mode
    if test "$fish_bind_mode" != "$FISH__BIND_MODE"
        set -gx FISH_BIND_MODE $fish_bind_mode
        omp_repaint_prompt
    end
end

function fish_default_mode_prompt --description "Display vi prompt mode"
    # This function is masked and does nothing
end

fish_vi_key_bindings
