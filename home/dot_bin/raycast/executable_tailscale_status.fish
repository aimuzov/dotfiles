#!/usr/bin/env fish

set status_json (tailscale status --json 2>/dev/null)
set backend_state (echo "$status_json" | jq -r '.BackendState')

if test "$backend_state" = NeedsLogin
	echo "Needs login"
else if test "$backend_state" = Stopped
    echo "Off"
else
    set exit_node (echo "$status_json" | jq -r '.ExitNodeStatus.TailscaleIPs[0] // empty')
    if test -z "$exit_node"
        echo "Direct"
    else
        set exit_hostname (echo "$status_json" | jq -r '[.Peer[] | select(.ExitNode == true)][0].HostName // "Unknown"')
        echo "$exit_hostname"
    end
end
