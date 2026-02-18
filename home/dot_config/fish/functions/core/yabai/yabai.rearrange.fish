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
        set dia_windows (yabai -m query --windows --space $space_index | jq '[.[] | select(.app=="Dia")]')
        set dia_count (echo "$dia_windows" | jq 'length')

        if test "$dia_count" -gt 1
            set first_dia_id (echo "$dia_windows" | jq '.[0].id')
            set last_dia_id (echo "$dia_windows" | jq '.[-1].id')
            yabai -m window "$last_dia_id" --stack "$first_dia_id"
        end
    end

    sketchybar --trigger window_focus
end
