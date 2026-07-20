# vi: ft=fish
#
# Completions for Yandex Cloud CLI (yc).
# yc ships only bash/zsh completions, so candidates are built dynamically:
# `yc <path> --help` output is parsed on demand and cached per command path
# for the lifetime of the shell session.
#
# Help format (not cobra): "Groups:"/"Commands:" sections list subcommands as
# "  name  description"; "Flags:"/"Global Flags:" sections are two-line —
# a flag line ("  --flag type") followed by an indented description line.

function __yc_cmd_path
    set -l tokens (commandline -opc)

    for token in $tokens[2..]
        string match -q -- '-*' $token
        or echo $token
    end
end

function __yc_candidates
    set -l key (string join _ __yc_cache $argv | string replace -ra '[^A-Za-z0-9_]' _)

    if not set -q $key
        set -l lines
        set -l section ''
        set -l flag ''

        for line in (yc $argv --help 2>/dev/null)
            if string match -qr '^\S' -- $line # section headers have no indent
                switch $line
                    case 'Groups:*' 'Commands:*'
                        set section commands
                    case 'Flags:*' 'Global Flags:*'
                        set section flags
                    case '*'
                        set section ''
                end
                continue
            end

            switch $section
                case commands
                    set -l m (string match -r '^\s+([A-Za-z0-9-]+)\s+(\S.*)$' -- $line)
                    test (count $m) -eq 3; and set -a lines $m[2]\t$m[3]
                case flags
                    if string match -qr '^\s+-' -- $line
                        test -n "$flag"; and set -a lines $flag # flag without description
                        set -l m (string match -r -- '(--[A-Za-z0-9-]+)' $line)
                        set flag $m[2]
                    else if test -n "$flag"
                        set -a lines $flag\t(string trim -- $line)
                        set flag ''
                    end
            end
        end

        test -n "$flag"; and set -a lines $flag
        set -g $key $lines
    end

    count $$key >/dev/null; and printf '%s\n' $$key
end

function __yc_complete
    set -l cmd (__yc_cmd_path)

    if string match -q -- '-*' (commandline -ct)
        __yc_candidates $cmd | string match -er '^--'

        # Leaf commands list only their own flags; global ones are on `yc --help`
        test -n "$cmd[1]"; and __yc_candidates | string match -er '^--'
    else
        __yc_candidates $cmd | string match -rv '^--'
    end
end

complete -c yc -f -a '(__yc_complete)'
