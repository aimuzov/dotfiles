function __vsc_integration_lazy_init --on-event fish_prompt
    if string match -q "$TERM_PROGRAM" vscode
        if not set -q $VSCODE_FISH_PATH
            set -U VSCODE_FISH_PATH (code --locate-shell-integration-path fish ^/dev/null)
        end

        if test -n "$VSCODE_FISH_PATH"; and test -f "$VSCODE_FISH_PATH"
            source $VSCODE_FISH_PATH
        end
    end

    if string match -q "$TERM_PROGRAM" cursor
        if not set -q CURSOR_FISH_PATH
            set -U CURSOR_FISH_PATH (cursor --locate-shell-integration-path fish ^/dev/null)
        end

        if test -n "$CURSOR_FISH_PATH"; and test -f "$CURSOR_FISH_PATH"
            source $CURSOR_FISH_PATH
        end
    end

    functions -e __vsc_integration_lazy_init
end
