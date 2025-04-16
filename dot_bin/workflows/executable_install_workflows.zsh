#!/bin/zsh

local dir_prev="$(pwd)"

cd "$HOME/.bin/workflows"

rm -rf ./workflows_temp
mkdir ./workflows_temp

for filename in ./*.workflow; do
	cp -R $filename ./workflows_temp/$filename
done

for filename in ./workflows_temp/*.workflow; do
	open $filename
	sleep 1
	osascript -e 'tell application "System Events" to click button "Install" of window "Quick Action Installer" of process "Automator Installer"'
	{
		sleep 1
		osascript -e 'tell application "System Events" to click button "Done" of window "Quick Action Installer" of process "Automator Installer"'
	} || {
		sleep 1
		osascript -e 'tell application "System Events" to click button "Replace" of window "Quick Action Installer" of process "Automator Installer"'
	}
done

rm -rf ./workflows_temp

cd $dir_prev
