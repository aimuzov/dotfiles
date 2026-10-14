function gp.on --description 'Start Palo Alto GlobalProtect'
    # Daemon first: the agents connect to it on launch
    for plist in /Library/LaunchDaemons/com.paloaltonetworks.gp.*.plist
        sudo launchctl bootstrap system $plist 2>/dev/null
    end

    for plist in /Library/LaunchAgents/com.paloaltonetworks.gp.*.plist
        launchctl bootstrap gui/(id -u) $plist 2>/dev/null
    end

    echo "gp.on: started"
end
