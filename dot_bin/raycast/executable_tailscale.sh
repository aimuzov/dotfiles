#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title tailscale
# @raycast.mode silent

# Optional parameters:
# @raycast.icon /Applications/Tailscale.app/Contents/Resources/AppIcon.icns
# @raycast.argument1 { "type": "dropdown", "data": [{"title": "off", "value": "off"}, {"title": "eu", "value": "eu"}, {"title": "us", "value": "us"}, {"title": "ru", "value": "ru"}, {"title": "no", "value": "no"}], "placeholder": "eu" }

status_json=$(tailscale status --json)

if [ "$1" = "off" ]; then
	/opt/homebrew/bin/fish -c "tailscale down && sketchybar --trigger tailscale_status_update"
	echo "off"
else
	if [ "$1" = "no" ]; then
		dnsname=""
	else
		dnsname=$(echo "$status_json" | jq -r --arg prefix "$1" '.Peer[] | select(.ExitNodeOption == true) | select(.HostName | startswith($prefix)) | .DNSName' | head -n1)
	fi

	/opt/homebrew/bin/fish -c "tailscale set --exit-node=$dnsname"
	echo $dnsname

	backend_state=$(echo "$status_json" | jq -r '.BackendState')

	if [ "$backend_state" = "Stopped" ]; then
		/opt/homebrew/bin/fish -c "tailscale up && sketchybar --trigger tailscale_status_update"
	fi
fi
