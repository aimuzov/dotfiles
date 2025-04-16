function yabai_sudoers
    # https://github.com/koekeishiya/yabai/wiki/Installing-yabai-(latest-release)#configure-scripting-addition
    echo "aimuzov ALL=(root) NOPASSWD: sha256:$(shasum -a 256 $(which yabai)) --load-sa" | pbcopy
    sudo visudo -f /private/etc/sudoers.d/yabai
end
