function kumiko.sudoers
    # The line is pinned to the binary's hash: run this again after every kumiko rebuild.

    set kumiko_path (command -v kumiko)

    # The cask links kumiko onto the PATH, a build from the repository does not: ask LaunchServices for the bundle.
    if test -z "$kumiko_path"
        set app_path (osascript -e 'POSIX path of (path to application id "online.aimuzov.kumiko")' 2>/dev/null)
        and set kumiko_path (string trim -r -c / $app_path)/Contents/MacOS/kumiko
    end

    if not test -x "$kumiko_path"
        echo "kumiko.sudoers: kumiko not found" >&2
        return 1
    end

    set sudoers_line ($kumiko_path sa sudoers)
    or return 1

    # A broken file in sudoers.d breaks sudo itself, so check it before it gets there.
    set tmp (mktemp)
    echo $sudoers_line >$tmp

    visudo -cf $tmp >/dev/null
    and sudo install -m 0440 -o root -g wheel $tmp /private/etc/sudoers.d/kumiko
    and echo "kumiko.sudoers: written → /private/etc/sudoers.d/kumiko"

    set result $status
    rm -f $tmp
    return $result
end
