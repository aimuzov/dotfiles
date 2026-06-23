function yabai.sudoers
    # https://github.com/koekeishiya/yabai/wiki/Installing-yabai-(latest-release)#configure-scripting-addition

    set yabai_path (which yabai)

    if test -z "$yabai_path"
        echo "yabai.sudoers: yabai not found in PATH" >&2
        return 1
    end

    set yabai_hash (shasum -a 256 $yabai_path | cut -d " " -f 1)
    set sudoers_line (whoami)" ALL=(root) NOPASSWD: sha256:$yabai_hash $yabai_path --load-sa"

    echo $sudoers_line | sudo tee /private/etc/sudoers.d/yabai >/dev/null

    and sudo visudo -cf /private/etc/sudoers.d/yabai
    and echo "yabai.sudoers: written → /private/etc/sudoers.d/yabai"
end
