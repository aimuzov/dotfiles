function yabai.rearrange
    set space_index $argv[1]

    if test -z "$space_index"
        set space_index (yabai -m query --spaces --space | jq -r '.index')
    end

    if test "$space_index" -eq 10
        set windows (yabai -m query --windows --space $space_index)

        set time_id (echo "$windows" | jq '.[] | select(.app=="Time") | .id')
        set tg_id (echo "$windows" | jq '.[] | select(.app=="Telegram") | .id')

        if test -n "$time_id"; and test -n "$tg_id"
            set window_count (echo "$windows" | jq 'length')

            if test "$window_count" -eq 2
                yabai -m window "$time_id" --ratio abs:0.7
            end

            yabai -m window "$tg_id" --warp last
        end
    end

    if test "$space_index" -eq 2
        yabai.stack_apps $space_index Dia
    end

    if test "$space_index" -eq 3
        yabai.stack_apps $space_index Things Calendar Mail
    end

    sketchybar --trigger window_focus
end
