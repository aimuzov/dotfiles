#!/bin/zsh

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title tailscale
# @raycast.mode silent

# Optional parameters:
# @raycast.icon /Applications/Tailscale.app/Contents/Resources/AppIcon.icns
# @raycast.argument1 { "type": "dropdown", "data": [{"title": "up", "value": "up"}, {"title": "down", "value": "down"}], "placeholder": "up" }

tailscale $1
