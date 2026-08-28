function srv.onmount
    set -l table (mount)
    set -l mounted

    for dir in $HOME/mnt/*
        if string match -q "* on $dir *" -- $table
            set -a mounted (path basename $dir)
        end
    end

    if test (count $mounted) -eq 0
        echo "srv.onmount: nothing mounted"
        return
    end

    set -l chosen (printf '%s\n' $mounted | fzf --multi --prompt="Unmount > " --height=~50% --layout=reverse --border --exit-0)

    if test -z "$chosen"
        echo "No host selected"
        return
    end

    # srv.mountpoint leaves an already normalized name alone, so the basename works as a host
    for host in $chosen
        srv.umount $host
    end
end
