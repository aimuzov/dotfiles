function yabai.stack_apps
    # Stacks the managed windows of the listed apps on a space into one shared stack.
    # Usage: yabai.stack_apps <space_index> <app>...
    #
    # Works with windows of DIFFERENT apps too (a stack is about position in the layout,
    # not about the app), so, for example, Things/Calendar/Mail on one space can be kept
    # as tabs of a single stack. With a single-app list it merges that app's own extra
    # windows into a stack (a message in Mail, a tab in Dia).
    #
    # Important: `--stack` is NOT suitable here — it makes a stack of exactly two windows,
    # pulling the target out of its current stack, so a third window breaks the stack. The
    # only reliable way to add a window to an existing stack is the pair `--insert stack`
    # (mark the insertion point) + `--warp` (move the window into that area).
    #
    # From the window_created signal (yabai sets $YABAI_WINDOW_ID) only the new window is
    # added — one per event. On a manual call (yabai start) — all windows into the first.
    # Floating windows (event popovers, settings windows) are filtered out and left alone.

    set -l space_index $argv[1]
    set -l apps $argv[2..-1]

    if test -z "$space_index"
        set space_index (yabai -m query --spaces --space | jq -r '.index')
    end

    test (count $apps) -gt 0; or return

    set -l ids (yabai -m query --windows --space $space_index \
        | jq -r '.[] | select(.["is-floating"]==false) | select(.app as $a | $ARGS.positional | index($a)) | .id' --args $apps)

    test (count $ids) -gt 1; or return

    if set -q YABAI_WINDOW_ID; and contains -- $YABAI_WINDOW_ID $ids
        # Event mode: add the new window into a stack with any other window.
        for id in $ids
            test "$id" = "$YABAI_WINDOW_ID"; and continue
            yabai -m window $id --insert stack
            yabai -m window $YABAI_WINDOW_ID --warp $id
            return
        end
    else
        # Manual/startup mode: gather all windows into the first one.
        for id in $ids[2..-1]
            yabai -m window $ids[1] --insert stack
            yabai -m window $id --warp $ids[1]
        end
    end
end
