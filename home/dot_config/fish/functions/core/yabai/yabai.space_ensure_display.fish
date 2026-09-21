function yabai.space_ensure_display --argument-names display want
    # `yabai -m space --create` is asynchronous: the scripting addition hands the request
    # to the Dock and reports success right away, so the new space shows up in the query a
    # moment later. Creating them in a batch is therefore not an option either — yabai
    # hands out indices in order within a display, and a --label issued too early lands on
    # the wrong space. So: one at a time, and wait for each one.
    set -l have (yabai -m query --spaces --display $display | jq length)

    while test $have -lt $want
        yabai -m space --create $display

        set -l target (math $have + 1)
        set -l created 0

        for i in (seq 30)
            sleep 0.1
            set have (yabai -m query --spaces --display $display | jq length)

            if test $have -ge $target
                set created 1
                break
            end
        end

        if test $created -eq 0
            # Usually a scripting addition whose add_space pattern no longer matches the
            # Dock after a macOS update: --create exits 0 and does nothing at all.
            echo "yabai.space_ensure: display $display stuck at $have space(s), wanted $want" >&2
            return 1
        end
    end
end
