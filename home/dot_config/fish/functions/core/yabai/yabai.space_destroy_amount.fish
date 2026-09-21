function yabai.space_destroy_amount
    for idx in (yabai -m query --spaces | jq ".[].index | select(. > $argv[1])" | sort -nr)
        yabai -m space --destroy "$idx"
    end

    # `space --destroy` can exit 0 and do nothing when the scripting addition no longer
    # matches the Dock, the same way `space --create` does. Say so rather than leaving the
    # extra spaces to be explained later.
    set -l left (yabai -m query --spaces | jq "[.[].index | select(. > $argv[1])] | length")

    if test "$left" -gt 0
        echo "yabai.space_destroy_amount: $left space(s) above $argv[1] survived --destroy" >&2
    end
end
