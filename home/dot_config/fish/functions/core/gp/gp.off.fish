function gp.off --description 'Stop Palo Alto GlobalProtect'
    # launchd respawns plain-killed processes, so the jobs have to be booted out first
    for plist in /Library/LaunchAgents/com.paloaltonetworks.gp.*.plist
        launchctl bootout gui/(id -u) $plist 2>/dev/null
    end

    for plist in /Library/LaunchDaemons/com.paloaltonetworks.gp.*.plist
        sudo launchctl bootout system $plist 2>/dev/null
    end

    killall GlobalProtect PanGPA PanGPS 2>/dev/null
    sleep 1

    if gp.status >/dev/null
        echo "gp.off: still running:" >&2
        gp.status >&2
        return 1
    end

    echo "gp.off: stopped"
end
