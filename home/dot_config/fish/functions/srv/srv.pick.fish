function srv.pick
    set -l subdir $argv[1]

    # Configs are what I go there for, and it keeps pickers off the remote root
    test -n "$subdir"; or set subdir etc

    set -l hosts (string replace -rf '^\s*Host\s+' '' <$HOME/.ssh/config | string split ' ' | string match -v '*\**')

    if test (count $hosts) -eq 0
        echo "srv.pick: no hosts in ~/.ssh/config" >&2
        return 1
    end

    set -l host (printf '%s\n' $hosts | fzf --prompt="SSH Hosts > " --height=~50% --layout=reverse --border --exit-0)

    if test -z "$host"
        echo "No host selected"
        return
    end

    srv.mount $host; or return 1

    set -l target $HOME/mnt/$host/$subdir

    if not test -d $target
        echo "srv.pick: $subdir not found, opening the mount root" >&2
        set target $HOME/mnt/$host
    end

    nvim $target
end
