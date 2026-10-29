function claude.backup.pick
    set -l since $argv[1]
    set -l filename $argv[2]
    set -l sources $argv[3..]

    # A browser renames a repeated download to "name (1).zip"
    set -l base (path change-extension '' $filename)
    set -l candidates $sources/$filename $sources/"$base ("*").zip"
    set candidates (path filter -f $candidates)

    # Every export names its zips the same, so one left from an older export
    # would pass for this one
    set -l fresh
    for file in $candidates
        if test -z "$since"; or test (path mtime $file) -ge $since
            set -a fresh $file
        end
    end

    test -n "$fresh"; or return 1

    # Plain ls, the interactive one is an eza wrapper with its own -t
    command ls -t $fresh | head -1
end
