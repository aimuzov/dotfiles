function yabai.sudoers
    # https://github.com/koekeishiya/yabai/wiki/Installing-yabai-(latest-release)#configure-scripting-addition

    set yabai_path (which yabai)
    set yabai_hash (shasum -a 256 $yabai_path | cut -d " " -f 1)
    set sudoers_line (whoami)" ALL=(root) NOPASSWD: sha256:$yabai_hash $yabai_path --load-sa"

    echo $sudoers_line | sudo tee /private/etc/sudoers.d/yabai >/dev/null
end
