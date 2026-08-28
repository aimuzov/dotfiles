function srv.onmount
    set -l table (mount)
    set -l mounted
    set -l swept 0

    for dir in $HOME/mnt/*
        if string match -q "* on $dir *" -- $table
            set -a mounted (path basename $dir)
        else if rmdir $dir 2>/dev/null
            # A mount that failed halfway leaves its point behind; rmdir spares the ones holding files
            set swept (math $swept + 1)
        end
    end

    test $swept -gt 0; and echo "srv.onmount: swept $swept stale mount point(s)"

    if test (count $mounted) -eq 0
        echo "srv.onmount: nothing mounted"
        return
    end

    set -l chosen (printf '%s\n' $mounted | fzf --multi --prompt="Unmount > " --height=~50% --layout=reverse --border --exit-0)

    if test -z "$chosen"
        echo "No host selected"
        return
    end

    # srv.mountpoint leaves a normalized name alone, so the basename works as a host
    for host in $chosen
        srv.umount $host
    end
end
