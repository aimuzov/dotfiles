#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title tailscale
# @raycast.mode silent

# Optional parameters:
# @raycast.icon /Applications/Tailscale.app/Contents/Resources/AppIcon.icns
# @raycast.argument1 { "type": "dropdown", "data": [{"title": "enable", "value": "enable"}, {"title": "disable", "value": "disable"}], "placeholder": "enable" }

if [ "$1" = "enable" ]; then
	/opt/homebrew/bin/fish -c "tailscale set --exit-node=$(tailscale status --json | jq -r '.Peer | to_entries[0].value.DNSName')"
else
	/opt/homebrew/bin/fish -c "tailscale set --exit-node="
fi
