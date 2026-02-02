#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Download YouTube video
# @raycast.mode compact
# @raycast.packageName 􀩼

# Optional parameters:
# @raycast.icon 􀁸
# @raycast.argument1 { "type": "text", "placeholder": "  url " }

/opt/homebrew/bin/mise exec aqua:fish-shell/fish-shell -- fish -c "./youtube-download.fish $1"
