function yabai.space_create
    set -l display ($HOME/.bin/yabai-display-index.sh $argv[1])
    set -l idx $argv[2]
    set -l name $argv[3]
    # $argv[4] is "--" separator
    set -l apps $argv[5..-1]
    set -l spaces_json (yabai -m query --spaces)
    set -l space (echo $spaces_json | jq "first(.[] | select(.index == $idx) | .index)")
    set -l current_display (echo $spaces_json | jq "first(.[] | select(.index == $idx) | .display)")

    # Spaces themselves are made by yabai.space_ensure, which waits for each one. A missing
    # index here means creation failed; bail out instead of firing three commands at a
    # space that is not there and leaving "could not locate the space to act on!" in the log.
    if test -z "$space"
        echo "yabai.space_create: no space with index $idx, skipping $name" >&2
        return 1
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
