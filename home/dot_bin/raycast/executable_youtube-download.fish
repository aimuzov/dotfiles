#!/usr/bin/env fish

if test -z "$argv[1]"
    echo "􀻃  no url provided"
    exit 1
end

set OUTPUT_DIR "$HOME/temp/yt"
mkdir -p "$OUTPUT_DIR"

set FORMAT "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best"
set OUTPUT_TEMPLATE "$OUTPUT_DIR/%(title)s.%(ext)s"

echo "􀁸  downloading..."

set OUTPUT (yt-dlp --js-runtimes bun --format "$FORMAT" --output "$OUTPUT_TEMPLATE" --merge-output-format mp4 --windows-filenames --newline --print after_move:filepath "$argv[1]" 2>&1)
set EXIT_CODE $status

echo "$OUTPUT"

if test $EXIT_CODE -eq 0
    echo "􀁹  downloaded"

    set DOWNLOADED_FILE $OUTPUT[-1]
    echo "$DOWNLOADED_FILE"

    osascript -e 'on run argv
		set the clipboard to (POSIX file (item 1 of argv))
    end run' "$DOWNLOADED_FILE" 2>/dev/null

    if test $status -eq 0
        echo "􀒕  copied to clipboard"
    end
else
    echo "􃇚  download failed"
    exit 1
end
