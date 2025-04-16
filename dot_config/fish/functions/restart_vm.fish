function restart_vm
    yabai --restart-service
    skhd --restart-service
    brew services restart borders
    brew services restart svim
    brew services restart sketchybar

    echo "vm is restarted"
end
