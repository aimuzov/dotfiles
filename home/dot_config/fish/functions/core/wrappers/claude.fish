function claude --description 'claude with daily auto-update check' --wraps claude
    argparse no-update -- $argv
    or return 1

    if not set -q _flag_no_update
        __claude_check_update
    end

    command claude $argv
end

function __claude_check_update
    set -l tool "aqua:anthropics/claude-code"
    set -l state_dir "$XDG_STATE_HOME/claude"
    set -l stamp_file "$state_dir/last_update_check"
    set -l check_interval 86400
    set -l prefix (set_color blue)"[claude]"(set_color normal)

    test -d $state_dir; or mkdir -p $state_dir

    # Skip if checked recently
    if test -f $stamp_file
        set -l last_check (cat $stamp_file)
        set -l now (date +%s)
        set -l elapsed (math "$now - $last_check")

        if test $elapsed -lt $check_interval
            return 0
        end
    end

    # Record check time before the check (avoid retries on failure)
    date +%s >$stamp_file

    echo "$prefix Checking for updates..."

    set -l outdated (mise outdated $tool 2>/dev/null)

    if test -z "$outdated"
        echo "$prefix Up to date."
        return 0
    end

    echo "$prefix Update available:"
    echo "$outdated"
    echo "$prefix Upgrading..."

    if mise upgrade $tool 2>&1
        echo "$prefix" (set_color green)"Upgrade complete."(set_color normal)
    else
        echo "$prefix" (set_color yellow)"Upgrade failed, launching current version."(set_color normal)
    end
end
