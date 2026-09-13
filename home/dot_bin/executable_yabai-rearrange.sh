#!/bin/sh
# Fixes up the layout of a space after a window appears on it.
#
# Runs from the yabai window_created signal, so it is on the hot path of every
# new window: keep it to plain POSIX sh and a handful of processes. Booting an
# interactive shell here costs ~400ms per window.
#
# Usage: yabai-rearrange.sh [space_index]
# Without an argument it works on the currently focused space.

PATH="/opt/homebrew/bin:$HOME/.local/share/mise/installs/aqua-jqlang-jq/latest:$PATH"
export PATH

# Stacks the managed windows of the listed apps on a space into one shared stack.
# Usage: stack_apps <space_index> <app>...
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
stack_apps() {
    stack_space=$1
    shift

    [ "$#" -gt 0 ] || return 0

    ids=$(yabai -m query --windows --space "$stack_space" \
        | jq -r '.[] | select(.["is-floating"]==false) | select(.app as $a | $ARGS.positional | index($a)) | .id' --args "$@")

    # Window ids are integers, so word splitting them is safe.
    # shellcheck disable=SC2086
    set -- $ids
    [ "$#" -gt 1 ] || return 0

    if [ -n "$YABAI_WINDOW_ID" ] && printf '%s\n' "$ids" | grep -qx "$YABAI_WINDOW_ID"; then
        # Event mode: add the new window into a stack with any other window.
        for id in "$@"; do
            [ "$id" = "$YABAI_WINDOW_ID" ] && continue

            yabai -m window "$id" --insert stack
            yabai -m window "$YABAI_WINDOW_ID" --warp "$id"

            return 0
        done
    else
        # Manual/startup mode: gather all windows into the first one.
        anchor=$1
        shift

        for id in "$@"; do
            yabai -m window "$anchor" --insert stack
            yabai -m window "$id" --warp "$anchor"
        done
    fi
}

space_index=$1

if [ -z "$space_index" ]; then
    space_index=$(yabai -m query --spaces --space | jq -r '.index')
fi

# A failed query leaves a non-numeric value; bail out rather than feed it to `test -eq`.
case $space_index in
    '' | *[!0-9]*) exit 0 ;;
esac

# Social: keep Time wide and Telegram pinned to the far side.
if [ "$space_index" -eq 10 ]; then
    windows=$(yabai -m query --windows --space "$space_index")

    time_id=$(printf '%s' "$windows" | jq -r '.[] | select(.app=="Time") | .id')
    tg_id=$(printf '%s' "$windows" | jq -r '.[] | select(.app=="Telegram") | .id')

    if [ -n "$time_id" ] && [ -n "$tg_id" ]; then
        window_count=$(printf '%s' "$windows" | jq 'length')

        if [ "$window_count" -eq 2 ]; then
            yabai -m window "$time_id" --ratio abs:0.7
        fi

        yabai -m window "$tg_id" --warp last
    fi
fi

# Org: Things, Calendar and Mail live as tabs of one stack.
if [ "$space_index" -eq 8 ]; then
    stack_apps "$space_index" Things Calendar Mail
fi

sketchybar --trigger window_focus
