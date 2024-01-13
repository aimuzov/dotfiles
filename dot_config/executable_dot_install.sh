#!/bin/zsh

# Close any open System Preferences panes,
# to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do
	sudo -n true
	sleep 60
	kill -0 "$$" || exit
done 2>/dev/null &

# ----------------------------------------------------------------------------------------------------------------------

echo "Installing commandline tools..."

xcode-select --install

# ----------------------------------------------------------------------------------------------------------------------

echo "Installing Brew..."

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew analytics off
brew bundle install --global

# ----------------------------------------------------------------------------------------------------------------------

echo "Changing macOS defaults..." # https://macos-defaults.com/

sudo nvram SystemAudioVolume=" "
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

defaults write NSGlobalDomain "AppleKeyboardUIMode" -int "3"
defaults write NSGlobalDomain "AppleLanguages" -array "en" "ru"
defaults write NSGlobalDomain "ApplePressAndHoldEnabled" -bool "false"
defaults write NSGlobalDomain "InitialKeyRepeat" -int "10"
defaults write NSGlobalDomain "KeyRepeat" -int "1"
defaults write NSGlobalDomain "NSAutomaticCapitalizationEnabled" -bool "false"
defaults write NSGlobalDomain "NSAutomaticDashSubstitutionEnabled" -bool "false"
defaults write NSGlobalDomain "NSAutomaticPeriodSubstitutionEnabled" -bool "false"
defaults write NSGlobalDomain "NSAutomaticQuoteSubstitutionEnabled" -bool "false"
defaults write NSGlobalDomain "NSAutomaticSpellingCorrectionEnabled" -bool "false"
defaults write NSGlobalDomain "NSDocumentSaveNewDocumentsToCloud" -bool "false"

defaults write com.apple.dock "autohide" -bool "true"
defaults write com.apple.dock "mineffect" -string "suck"
defaults write com.apple.dock "mru-spaces" -bool "false"
defaults write com.apple.dock "orientation" -string "right"
defaults write com.apple.dock "scroll-to-open" -bool "true"
defaults write com.apple.dock "show-recents" -bool "false"
defaults write com.apple.dock "tilesize" -int "42"
killall "Dock"

defaults write com.apple.Finder "AppleShowAllFiles" -bool "true"
defaults write com.apple.finder "DisableAllAnimations" -bool "true"
defaults write com.apple.finder "QuitMenuItem" -bool "true"
defaults write com.apple.finder "FXDefaultSearchScope" -string "SCcf"
defaults write com.apple.finder "FXEnableExtensionChangeWarning" -bool "false"
defaults write com.apple.finder "FXPreferredViewStyle" -string "Nlsv"
defaults write com.apple.finder "FXRemoveOldTrashItems" -bool "true"
defaults write com.apple.finder "ShowExternalHardDrivesOnDesktop" -bool "false"
defaults write com.apple.finder "ShowHardDrivesOnDesktop" -bool "false"
defaults write com.apple.finder "ShowMountedServersOnDesktop" -bool "false"
defaults write com.apple.finder "ShowPathbar" -bool "true"
defaults write com.apple.finder "ShowRemovableMediaOnDesktop" -bool "false"
defaults write com.apple.finder "_FXSortFoldersFirst" -bool "true"
defaults write com.apple.finder "_FXSortFoldersFirstOnDesktop" -bool "true"
defaults write com.apple.universalaccess "showWindowTitlebarIcons" -bool "true"
killall "Finder"

defaults write com.apple.ActivityMonitor "UpdatePeriod" -int "2"
defaults write com.apple.ActivityMonitor "IconType" -int "2"
killall "Activity Monitor"

defaults write com.apple.screencapture "disable-shadow" -bool "true"
defaults write com.apple.screencapture "location" -string "$HOME/temp/screenshots"
defaults write com.apple.screencapture "type" -string "png"

defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int "40"
defaults write com.apple.menuextra.clock "IsAnalog" -bool "true" && killall SystemUIServer
defaults write com.apple.LaunchServices "LSQuarantine" -bool "false"
defaults write com.apple.spaces "spans-displays" -bool "false"

defaults write com.apple.frameworks.diskimages "skip-verify" -bool "true"
defaults write com.apple.frameworks.diskimages "skip-verify-locked" -bool "true"
defaults write com.apple.frameworks.diskimages "skip-verify-remote" -bool "true"

defaults write com.apple.mail "AddressesIncludeNameOnPasteboard" -bool "false"
defaults write com.apple.mail "NSUserKeyEquivalents" -dict-add "Send" "@\U21a9"
