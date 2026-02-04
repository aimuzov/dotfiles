function yabai.layout_add
    set -l app $argv[1]

    if test (count $argv) -eq 1
        # Without "--": enable manage for app
        yabai -m rule --add app="^$app\$" manage=on
    else
        # With "--": disable manage for specific titles
        # $argv[2] is "--" separator
        set -l titles $argv[3..-1]
        set -l pattern "("(string join "|" $titles)")"
        yabai -m rule --add app="^$app\$" title="$pattern" manage=off
    end

    yabai -m rule --apply
end
