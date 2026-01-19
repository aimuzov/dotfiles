#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Tailscale Pick Node
# @raycast.mode compact
# @raycast.packageName 􀩼

# Optional parameters:
# @raycast.icon /Applications/Tailscale.app/Contents/Resources/AppIcon.icns
# @raycast.argument1 { "type": "dropdown", "data": [{"title": "  off", "value": "off"}, {"title": "  eu", "value": "eu"}, {"title": "  us", "value": "us"}, {"title": "  ru", "value": "ru"}, {"title": "  no", "value": "no"}], "placeholder": "  eu" }

/opt/homebrew/bin/fish -c "./tailscale_pick_node.fish $1"
