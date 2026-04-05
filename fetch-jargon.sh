#!/bin/bash
set -euo pipefail

_TMPDIR=$(mktemp -d)
OUT="documentation/jargon.md"
BASE_URL="https://agiacalone.github.io/jargonfile/html"
VERBOSE=0

usage() {
    printf 'Usage: fetch-jargon [-v] [-o FILE]\n'
    printf 'Fetch the Jargon File (Community Edition) and convert it to Markdown.\n'
    printf '\n'
    printf '  -o FILE    write output to FILE (default: documentation/jargon.md)\n'
    printf '  -v         verbose output\n'
    printf '  -h         display this help and exit\n'
    exit 0
}

while getopts 'o:vh' opt; do
    case "$opt" in
        o) OUT="$OPTARG" ;;
        v) VERBOSE=1 ;;
        h) usage ;;
        *) exit 2 ;;
    esac
done

log() { [[ "$VERBOSE" -eq 1 ]] && printf 'fetch-jargon: %s\n' "$*" >&2 || true; }

cleanup() { rm -rf "$_TMPDIR"; }
trap cleanup EXIT

LETTERS="0 A B C D E F G H I J K L M N O P Q R S T U V W X Y Z"

> "$OUT"
for letter in $LETTERS; do
    index_url="$BASE_URL/$letter.html"
    index_file="$_TMPDIR/${letter}_index.html"
    log "downloading index: $letter.html..."
    if ! wget -q -O "$index_file" "$index_url" 2>/dev/null; then
        printf 'fetch-jargon: warning: could not fetch %s\n' "$index_url" >&2
        continue
    fi

    # Extract relative entry URLs from the index page (only entries under $letter/)
    entry_urls=$(grep -oP 'href="\K[^"]+\.html' "$index_file" | grep "^$letter/" | awk '!seen[$0]++')

    if [[ -z "$entry_urls" ]]; then
        log "no entries found in $letter.html, skipping"
        continue
    fi

    printf '\n## %s\n\n' "$letter" >> "$OUT"
    while IFS= read -r entry_rel; do
        entry_url="$BASE_URL/$entry_rel"
        entry_file="$_TMPDIR/$(echo "$entry_rel" | tr '/' '_')"
        log "  fetching $entry_rel..."
        if wget -q -O "$entry_file" "$entry_url" 2>/dev/null; then
            perl -0777 -pe 's/<div class="nav(?:header|footer)">.*?<\/div>//gs' "$entry_file" \
                | pandoc -f html -t commonmark --wrap=none \
                | perl -0777 -pe 's/<[^>]+>//g; s/\n{3,}/\n\n/g' >> "$OUT"
            printf '\n---\n\n' >> "$OUT"
        else
            printf 'fetch-jargon: warning: could not fetch %s\n' "$entry_url" >&2
        fi
    done <<< "$entry_urls"
done
