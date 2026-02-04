function yabai.layout_add
    set -l app $argv[1]

    yabai -m rule --add manage=on app="^$app\$"

    if test (count $argv) -gt 1
        set -l titles $argv[3..-1]
        set -l pattern "("(string join "|" $titles)")"
        yabai -m rule --add manage=off app="^$app\$" title="$pattern"
    end
end
