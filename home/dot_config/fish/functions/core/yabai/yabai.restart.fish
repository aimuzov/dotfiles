function yabai.restart
    # Thin wrapper: the implementation lives in ~/.bin/yabai-restart.sh so that skhd
    # can call it without booting fish. Kept as a function because Raycast (restart-vm)
    # and muscle memory both reach for `yabai.restart`.
    $HOME/.bin/yabai-restart.sh $argv
end
