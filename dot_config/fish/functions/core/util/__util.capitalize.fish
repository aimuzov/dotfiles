function __util.capitalize
    set -l str $argv[1]

    if test -n "$str"
        echo (string sub -l 1 $str | string upper)(string sub -s 2 $str)
    end
end
