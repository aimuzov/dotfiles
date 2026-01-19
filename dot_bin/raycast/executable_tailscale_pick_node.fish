#!/usr/bin/env fish

set status_json (tailscale status --json)

if test "$argv[1]" = off
    tailscale down
    echo off
else
    if test "$argv[1]" = no
        set dnsname ""
    else
        set dnsname (echo "$status_json" | jq -r --arg prefix "$argv[1]" '.Peer[] | select(.ExitNodeOption == true) | select(.HostName | startswith($prefix)) | .DNSName' | head -n1)
    end

    tailscale set --exit-node=$dnsname
    echo $dnsname
    set backend_state (echo "$status_json" | jq -r '.BackendState')

    if test "$backend_state" = Stopped
        tailscale up
    end
end

sketchybar --trigger tailscale_status_update
