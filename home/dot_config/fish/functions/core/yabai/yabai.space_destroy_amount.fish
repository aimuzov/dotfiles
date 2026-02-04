function yabai.space_destroy_amount
    for idx in (yabai -m query --spaces | jq ".[].index | select(. > $argv[1])" | sort -nr)
        yabai -m space --destroy "$idx"
    end
end
