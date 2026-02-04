function yabai.space_create
    set -l display (yabai_display_index_get $argv[1])
    set -l idx $argv[2]
    set -l name $argv[3]
    # $argv[4] is "--" separator
    set -l apps $argv[5..-1]
    set -l space (yabai -m query --spaces | jq "first(.[] | select(.index == $idx) | .index)")

    if test -z "$space"
        yabai -m space --create
    end

    yabai -m space "$idx" --label "$name" --display "$display"

    if test (count $apps) -gt 0
        set -l pattern "^("(string join "|" $apps)")\$"
        yabai -m rule --add space="$name" app="$pattern"
    end
end
