#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Restart WM
# @raycast.mode silent
# @raycast.packageName 􀩼

# kumiko has no fixed install path yet, so LaunchServices finds it by bundle id, and the CLI comes
# from inside the bundle. `kumiko quit` rather than kill: it puts hidden windows back on screen.

bundle="online.aimuzov.kumiko"
app=$(osascript -e "POSIX path of (path to application id \"$bundle\")") || exit 1

"${app%/}/Contents/MacOS/kumiko" quit

for _ in $(seq 50); do
	pgrep -xq KumikoApp || break
	sleep 0.1
done

open -b "$bundle"
echo "kumiko is restarted"
