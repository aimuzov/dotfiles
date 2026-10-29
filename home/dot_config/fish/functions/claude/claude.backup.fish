function claude.backup
    set -l manifest $argv[1]
    set -l dest_root $argv[2]

    if test -z "$manifest"
        echo "claude.backup: usage: claude.backup <manifest.json> [dest_root]" >&2
        return 1
    end

    if not test -f "$manifest"
        echo "claude.backup: manifest not found: $manifest" >&2
        return 1
    end

    for cmd in jq curl unzip
        if not type -q $cmd
            echo "claude.backup: $cmd not found" >&2
            return 1
        end
    end

    set -l manifest_version (jq -r '.version // empty' $manifest)
    if test "$manifest_version" != "1.0"
        echo "claude.backup: unexpected manifest version '$manifest_version', continuing anyway" >&2
    end

    test -n "$dest_root"; or set dest_root $HOME/temp/claude-backup

    # 2026-10-29T06:16:42.951205+00:00 → 2026-10-29T06-16-42
    set -l stamp (jq -r '.created_at // empty' $manifest | string sub -l 19 | string replace -a : -)
    test -n "$stamp"; or set stamp (date -u +%Y-%m-%dT%H-%M-%S)

    set -l dest $dest_root/$stamp

    if test -d $dest; and count $dest/* >/dev/null
        echo "claude.backup: $dest is not empty, refusing to overwrite" >&2
        return 1
    end

    mkdir -p $dest/zips
    cp $manifest $dest/manifest.json

    set -l ok 0
    set -l failed

    # Links may die once opened, so a failed file must not stop the rest
    for row in (jq -r '.data_files[] | [.category, .filename, .export_url] | @tsv' $manifest)
        set -l fields (string split \t -- $row)
        set -l category $fields[1]
        set -l filename $fields[2]
        set -l url $fields[3]
        set -l zip $dest/zips/$filename

        echo "claude.backup: $filename"

        if not curl -fL --retry 3 --progress-bar -o $zip.part $url
            rm -f $zip.part
            echo "claude.backup: download failed: $filename" >&2
            set -a failed $filename
            continue
        end

        if not unzip -tq $zip.part >/dev/null 2>&1
            echo "claude.backup: $filename is not a zip, the link has expired or needs a login, request a new export" >&2
            mv $zip.part $zip.invalid
            set -a failed $filename
            continue
        end

        mv $zip.part $zip

        if not unzip -oq $zip -d $dest/$category
            echo "claude.backup: unzip failed: $filename" >&2
            set -a failed $filename
            continue
        end

        set ok (math $ok + 1)
    end

    echo "claude.backup: $ok ok, "(count $failed)" failed → $dest"

    if test (count $failed) -gt 0
        printf '  failed: %s\n' $failed >&2
        return 1
    end
end
