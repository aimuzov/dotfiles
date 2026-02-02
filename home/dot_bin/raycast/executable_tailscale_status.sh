#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Tailscale Status
# @raycast.mode inline
# @raycast.packageName 􀩼
# @raycast.refreshTime 30s

# Optional parameters:
# @raycast.icon /Applications/Tailscale.app/Contents/Resources/AppIcon.icns

/opt/homebrew/bin/mise exec aqua:fish-shell/fish-shell -- fish -c "./tailscale_status.fish $1"
