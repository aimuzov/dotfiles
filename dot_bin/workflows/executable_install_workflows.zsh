#!/bin/zsh

rm -rf ./temp
mkdir temp

for filename in ./*.workflow; do
	cp -R "$filename" ./temp/"$filename"
done

for filename in ./temp/*.workflow; do
	open $filename
	sleep 1
	osascript -e 'tell application "System Events" to click button "Install" of window "Quick Action Installer" of process "Automator Installer"'
	sleep 1
	osascript -e 'tell application "System Events" to click button "Done" of window "Quick Action Installer" of process "Automator Installer"'
done

rm -rf ./temp
