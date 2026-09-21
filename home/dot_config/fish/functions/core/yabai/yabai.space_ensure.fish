function yabai.space_ensure
    # Brings every display up to the number of spaces the layout expects.
    # Usage: yabai.space_ensure <slot_1_count> [<slot_2_count> ...]
    #
    # Slots are logical screen positions, resolved through yabai-display-index.sh. With a
    # single screen attached both slots resolve to the same yabai display, so the counts
    # are summed per display rather than per slot.
    set -l displays
    set -l wanted

    for slot in (seq (count $argv))
        set -l display ($HOME/.bin/yabai-display-index.sh $slot)
        set -l pos (contains -i -- $display $displays)

        if test -n "$pos"
            set wanted[$pos] (math $wanted[$pos] + $argv[$slot])
        else
            set -a displays $display
            set -a wanted $argv[$slot]
        end
    end

    for i in (seq (count $displays))
        yabai.space_ensure_display $displays[$i] $wanted[$i]
    end
end
