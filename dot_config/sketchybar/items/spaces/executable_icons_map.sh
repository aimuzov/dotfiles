case "$1" in
"WhatsApp") icon_result=":whats_app:" ;;
"Notion") icon_result=":notion:" ;;
"Terminal" | "WezTerm") icon_result=":terminal:" ;;
"Podcasts") icon_result=":podcasts:" ;;
"Figma") icon_result=":figma:" ;;
"Numbers") icon_result=":numbers:" ;;
"Preview") icon_result=":pdf:" ;;
"zoom.us") icon_result=":zoom:" ;;
"Яндекс Музыка") icon_result=":music:" ;;
"Safari") icon_result=":safari:" ;;
"Finder") icon_result=":finder:" ;;
"Calendar") icon_result=":calendar:" ;;
"App Store") icon_result=":app_store:" ;;
"Things") icon_result=":things:" ;;
"Messages") icon_result=":messages:" ;;
"Notes") icon_result=":notes:" ;;
"System Preferences") icon_result=":gear:" ;;
"VLC") icon_result=":vlc:" ;;
"Chromium" | "Google Chrome") icon_result=":google_chrome:" ;;
"VSCodium") icon_result=":vscodium:" ;;
"Mail") icon_result=":mail:" ;;
"Digital Colour Meter") icon_result=":color_picker:" ;;
"WebStorm") icon_result=":web_storm:" ;;
"FaceTime") icon_result=":face_time:" ;;
"MacPass") icon_result=":one_password:" ;;
"Slack") icon_result=":slack:" ;;
"OBS") icon_result=":obsstudio:" ;;
"Default") icon_result=":default:" ;;
"Telegram") icon_result=":telegram:" ;;
"Discord") icon_result=":discord:" ;;
"Pages") icon_result=":pages:" ;;
*) icon_result=":default:" ;;
esac

echo $icon_result
