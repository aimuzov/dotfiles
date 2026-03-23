function claude --description 'claude with hourly auto-update check' --wraps claude
    argparse --ignore-unknown no-update -- $argv
    or return 1

    if not set -q _flag_no_update
        __claude_maybe_update
    end

    # Load custom plugins from ~/.claude/custom-plugins/
    set -l plugin_args
    for dir in ~/.claude/custom-plugins/*/
        if test -d "$dir.claude-plugin"
            set -a plugin_args --plugin-dir $dir
        end
    end

    command claude $plugin_args $argv
end

function __claude_maybe_update
    set -l state_dir "$XDG_STATE_HOME/claude"
    set -l stamp_file "$state_dir/last_update_check"
    set -l check_interval 3600

    test -d $state_dir; or mkdir -p $state_dir

    if test -f $stamp_file
        set -l last_check (cat $stamp_file)
        set -l now (date +%s)
        if test (math "$now - $last_check") -lt $check_interval
            return 0
        end
    end

    # Detached fish process — immune to Ctrl+C, no terminal output
    command fish -c '
        echo "STARTED "(date) >>"$XDG_STATE_HOME/claude/update.log"
        set tool "aqua:anthropics/claude-code"
        set state_dir "$XDG_STATE_HOME/claude"
        set stamp_file "$state_dir/last_update_check"
        set title "Claude Code"

        set outdated (mise outdated $tool 2>/dev/null)
        if test -z "$outdated"
            date +%s >$stamp_file
            return 0
        end

        osascript -e "display notification \"Update available, upgrading...\" with title \"$title\"" &>/dev/null

        if mise upgrade $tool &>/dev/null
            osascript -e "display notification \"Upgrade complete\" with title \"$title\"" &>/dev/null
            date +%s >$stamp_file
        else
            osascript -e "display notification \"Upgrade failed\" with title \"$title\"" &>/dev/null
        end
    ' &>/dev/null &
    disown
end
