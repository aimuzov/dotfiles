function srv.mount
    set -l host $argv[1]
    set -l remote_path $argv[2]

    if test -z "$host"
        echo "srv.mount: no host given" >&2
        return 1
    end

    if not type -q sshfs
        echo "srv.mount: sshfs not found, see 'brew install --cask fuse-t' and 'brew install gromgit/fuse/sshfs-mac'" >&2
        return 1
    end

    test -n "$remote_path"; or set remote_path /

    set -l mount_point (srv.mountpoint $host)

    if mount | string match -q "* on $mount_point *"
        echo "srv.mount: already mounted → $mount_point"
        return 0
    end

    mkdir -p $mount_point

    # User and identity come from ~/.ssh/config, so nothing is duplicated here
    sshfs $host:$remote_path $mount_point \
        -o reconnect,ServerAliveInterval=15,ServerAliveCountMax=3,follow_symlinks

    if test $status -ne 0
        rmdir $mount_point 2>/dev/null
        echo "srv.mount: failed to mount $host" >&2
        return 1
    end

    echo "srv.mount: mounted → $mount_point"
end
