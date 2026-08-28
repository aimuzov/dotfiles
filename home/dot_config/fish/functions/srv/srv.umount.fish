function srv.umount
    set -l host $argv[1]

    if test -z "$host"
        echo "srv.umount: no host given" >&2
        return 1
    end

    set -l mount_point (srv.mountpoint $host)

    if not mount | string match -q "* on $mount_point *"
        echo "srv.umount: not mounted → $mount_point"
        rmdir $mount_point 2>/dev/null
        return 0
    end

    # A dropped connection leaves the mount hanging, and plain umount will not take it
    umount $mount_point 2>/dev/null; or diskutil unmount force $mount_point >/dev/null

    if test $status -ne 0
        echo "srv.umount: failed to unmount $mount_point" >&2
        return 1
    end

    rmdir $mount_point 2>/dev/null

    echo "srv.umount: unmounted → $mount_point"
end
