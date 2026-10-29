function claude.backup
    argparse 'f/from=+' 't/timeout=!_validate_int --min 1' -- $argv; or return 1

    set -l manifest $argv[1]
    set -l dest_root $argv[2]

    if test -z "$manifest"
        echo "claude.backup: usage: claude.backup [-f dir]... [-t seconds] <manifest.json> [dest_root]" >&2
        return 1
    end

    if not test -f "$manifest"
        echo "claude.backup: manifest not found: $manifest" >&2
        return 1
    end

    for cmd in jq unzip
        if not type -q $cmd
            echo "claude.backup: $cmd not found" >&2
            return 1
        end
    end

    if not jq -e '.data_files | type == "array" and length > 0' $manifest >/dev/null 2>&1
        echo "claude.backup: $manifest is not valid JSON or lists no data_files" >&2
        return 1
    end

    set -l manifest_version (jq -r '.version // empty' $manifest)
    if test "$manifest_version" != "1.0"
        echo "claude.backup: unexpected manifest version '$manifest_version', continuing anyway" >&2
    end

    test -n "$dest_root"; or set dest_root $HOME/temp/claude-backup

    set -l timeout $_flag_timeout
    test -n "$timeout"; or set timeout 300

    # Where the browser saved the zips, the manifest usually lands next to them
    set -l sources $_flag_from
    test -n "$sources"; or set sources (path dirname $manifest) $HOME/Downloads

    # 2026-10-29T06:16:42.951205+00:00 → 2026-10-29T06-16-42
    set -l created (jq -r '.created_at // empty' $manifest | string sub -l 19)
    set -l since
    set -l stamp

    if test -n "$created"
        # jq, not date: the interactive PATH has GNU date without BSD -j
        set since (jq -nr --arg t $created '$t + "Z" | fromdateiso8601' 2>/dev/null)
        set stamp (string replace -a : - $created)
    end

    if test -z "$since"
        echo "claude.backup: no created_at in manifest, any zip with a matching name will do" >&2
        set stamp (date -u +%Y-%m-%dT%H-%M-%S)
    end

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
            set -l local (claude.backup.pick "$since" $filename $sources)

            # claude.ai hides the links behind a Cloudflare challenge that curl
            # can't pass, so the browser downloads them. It gives the file its
            # final name only once the download completes
            if test -z "$local"
                echo "claude.backup: $filename ← browser, waiting up to $timeout"s
                set -l marker $dest/.opened
                touch $marker
                open $url

                # A used link opens an error page instead of a download, so no
                # partial file shows up: .crdownload (Chromium), .download
                # (Safari), .part (Firefox)
                set -l started
                for i in (seq $timeout)
                    sleep 1
                    set local (claude.backup.pick "$since" $filename $sources)
                    test -n "$local"; and break

                    if test -z "$started"
                        set started (find $sources -maxdepth 1 -newer $marker \
                            \( -name '*.crdownload' -o -name '*.download' -o -name '*.part' \) 2>/dev/null)
                        test -z "$started" -a $i -ge 30; and break
                    end
                end

                rm -f $marker

                if test -z "$local"
                    if test -z "$started"
                        echo "claude.backup: $filename download did not start, the link was used or has expired, request a new export" >&2
                    else
                        echo "claude.backup: $filename did not finish in $timeout"s", download it and rerun" >&2
                    end
                    set -a failed $filename
                    continue
                end
            end

            echo "claude.backup: $filename ← $local"

            if not unzip -tq $local >/dev/null 2>&1
                echo "claude.backup: $local is not a valid zip" >&2
                set -a failed $filename
                continue
            end

            cp $local $zip
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
