function srv.mountpoint
    set -l host $argv[1]

    if test -z "$host"
        echo "srv.mountpoint: no host given" >&2
        return 1
    end

    # FUSE-T exports the mount point basename over NFS, and dots in it make
    # mount fail with exit status 66
    echo $HOME/mnt/(string replace -a . - -- $host)
end
