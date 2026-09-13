#!/bin/sh
# Resolves the yabai display index for a logical screen slot.
#
# Displays are addressed by UUID rather than by index, because yabai renumbers
# indices when a monitor is plugged in or the arrangement changes.
#
# Usage: yabai-display-index.sh <slot>
#   slot 1 - the display that is NOT the retina one (external, when attached)
#   slot 2 - the retina one
#
# Falls back to display 1 when the query finds nothing, so that a caller in a
# hotkey chain still gets a usable selector on a single-display setup.

PATH="/opt/homebrew/bin:$HOME/.local/share/mise/installs/aqua-jqlang-jq/latest:$PATH"
export PATH

retina_uuid=37D8832A-2D66-02CA-B9F7-8F30A301B230

if [ "$1" = 1 ]; then
    cond="!="
else
    cond="=="
fi

index=$(yabai -m query --displays | jq -r "first(.[] | select(.uuid $cond \"$retina_uuid\") | .index)")

if [ -n "$index" ] && [ "$index" != null ]; then
    echo "$index"
else
    echo 1
fi
