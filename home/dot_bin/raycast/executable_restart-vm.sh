#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Restart WM
# @raycast.mode silent
# @raycast.packageName 􀩼

# Optional parameters:
# @raycast.icon https://github.com/koekeishiya/yabai/blob/master/assets/icon/2x/icon-32px@2x.png?raw=true

/opt/homebrew/bin/mise exec aqua:fish-shell/fish-shell -- fish -c "restart_vm"
