function yabai.space_create
    set -l display (yabai_display_index_get $argv[1])
    set -l idx $argv[2]
    set -l name $argv[3]
    # $argv[4] is "--" separator
    set -l apps $argv[5..-1]
    set -l spaces_json (yabai -m query --spaces)
    set -l space (echo $spaces_json | jq "first(.[] | select(.index == $idx) | .index)")
    set -l current_display (echo $spaces_json | jq "first(.[] | select(.index == $idx) | .display)")

    if test -z "$space"
        yabai -m space --create
    end

    yabai -m space "$idx" --label "$name"

    if test "$current_display" != "$display"
        yabai -m space "$idx" --display "$display"
    end

    if test (count $apps) -gt 0
        set -l pattern "^("(string join "|" $apps)")\$"
        yabai -m rule --add space="$name" app="$pattern"
    end
end
