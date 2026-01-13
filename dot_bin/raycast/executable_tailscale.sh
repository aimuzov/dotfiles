#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title tailscale
# @raycast.mode silent

# Optional parameters:
# @raycast.icon /Applications/Tailscale.app/Contents/Resources/AppIcon.icns
# @raycast.argument1 { "type": "dropdown", "data": [{"title": "no", "value": "no"}, {"title": "eu", "value": "eu"}, {"title": "us", "value": "us"}, {"title": "ru", "value": "ru"}], "placeholder": "eu" }

# Обрабатываем выбор
if [ "$1" = "no" ]; then
	/opt/homebrew/bin/fish -c "tailscale set --exit-node="
	echo "disable"
else
	dnsname=$(tailscale status --json | jq -r --arg prefix "$1" '.Peer[] | select(.ExitNodeOption == true) | select(.HostName | startswith($prefix)) | .DNSName' | head -n1)

	if [ -z "$dnsname" ]; then
		echo "Could not find exit node"
		exit 1
	fi

	/opt/homebrew/bin/fish -c "tailscale set --exit-node=$dnsname"
	echo $dnsname
fi
