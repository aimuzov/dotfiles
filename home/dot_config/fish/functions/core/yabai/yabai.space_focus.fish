function yabai.space_focus
    yabai -m query --spaces --space $argv[1] | jq -r '.windows[0]' | xargs yabai -m window --focus
    yabai -m space --focus $argv[1]
end
