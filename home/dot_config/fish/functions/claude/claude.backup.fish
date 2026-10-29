function claude.backup
    argparse 'f/from=+' -- $argv; or return 1

    set -l manifest $argv[1]
    set -l dest_root $argv[2]

    if test -z "$manifest"
        echo "claude.backup: usage: claude.backup [-f dir]... <manifest.json> [dest_root]" >&2
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

    # Where the browser saved the zips, the manifest usually lands next to them
    set -l sources $_flag_from
    test -n "$sources"; or set sources (path dirname $manifest) $HOME/Downloads

    # 2026-10-29T06:16:42.951205+00:00 → 2026-10-29T06-16-42
    set -l stamp (jq -r '.created_at // empty' $manifest | string sub -l 19 | string replace -a : -)
    test -n "$stamp"; or set stamp (date -u +%Y-%m-%dT%H-%M-%S)

    set -l dest $dest_root/$stamp

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

        if test -f $zip
            echo "claude.backup: $filename already in backup"
        else
            # A browser renames a repeated download to "name (1).zip", take the newest
            set -l base (path change-extension '' $filename)
            set -l local $sources/$filename $sources/"$base ("*").zip"
            set local (path filter -f $local)

            if test -n "$local"
                set local (ls -t $local)[1]
                echo "claude.backup: $filename ← $local"
                cp $local $zip.part
            else
                echo "claude.backup: $filename ← $url"
                set -l code (curl -sSL --retry 3 -D $zip.headers -o $zip.part -w '%{http_code}' $url)

                if string match -qir '^cf-mitigated: *challenge' <$zip.headers
                    echo "claude.backup: Cloudflare blocks curl, open the link in a browser and rerun: $url" >&2
                    rm -f $zip.part $zip.headers
                    set -a failed $filename
                    continue
                end

                rm -f $zip.headers

                if test "$code" != 200
                    echo "claude.backup: download failed with HTTP $code: $filename" >&2
                    rm -f $zip.part
                    set -a failed $filename
                    continue
                end
            end

            if not unzip -tq $zip.part >/dev/null 2>&1
                echo "claude.backup: $filename is not a zip, the link has expired or needs a login, request a new export" >&2
                rm -f $zip.part
                set -a failed $filename
                continue
            end

            mv $zip.part $zip
        end

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
