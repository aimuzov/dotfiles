function yabai.restart
    yabai --restart-service
    brew services restart borders
    brew services restart svim
    brew services restart sketchybar

    echo "vm is restarted"
end
