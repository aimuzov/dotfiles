function yabai.display_index_get
    set -l cond "=="

    if test "$argv[1]" = 1
        set cond "!="
    end

    set -l retina_uuid 37D8832A-2D66-02CA-B9F7-8F30A301B230
    set -l index (yabai -m query --displays | jq "first(.[] | select(.uuid $cond \"$retina_uuid\") | .index)")

    if test -z "$index"
        echo 1
    else
        echo $index
    end
end
