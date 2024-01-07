#!/bin/zsh

# ----------------------------------------------------------------------------------------------------------------------

echo "Installing commandline tools..."

xcode-select --install

# ----------------------------------------------------------------------------------------------------------------------

echo "Installing Brew..."

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew analytics off
brew bundle install --global

# ----------------------------------------------------------------------------------------------------------------------

echo "Changing macOS defaults..."

defaults write com.apple.LaunchServices "LSQuarantine"		-bool "false"

defaults write com.apple.dock			"autohide"			-bool "true"
defaults write com.apple.dock			"mru-spaces"		-bool "false"
defaults write com.apple.spaces			"spans-displays"	-bool "false"

defaults write com.apple.screencapture	"location"			-string "$HOME/temp/screenshots"
defaults write com.apple.screencapture	"disable-shadow"	-bool true
defaults write com.apple.screencapture	"type"				-string "png"

defaults write com.apple.finder			"DisableAllAnimations"				-bool "true"
defaults write com.apple.finder			"ShowExternalHardDrivesOnDesktop"	-bool "false"
defaults write com.apple.finder			"ShowHardDrivesOnDesktop"			-bool "false"
defaults write com.apple.finder			"ShowMountedServersOnDesktop"		-bool "false"
defaults write com.apple.finder			"ShowRemovableMediaOnDesktop"		-bool "false"
defaults write com.apple.Finder			"AppleShowAllFiles"					-bool "true"

killall Dock
