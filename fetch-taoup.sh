#!/bin/bash
set -euo pipefail

OUT="taoup.md"
BASE_URL="http://catb.org/esr/writings/taoup/html"
VERBOSE=0

usage() {
    printf 'Usage: fetch-taoup [-v] [-o FILE]\n'
    printf 'Fetch The Art of Unix Programming and convert it to Markdown.\n'
    printf '\n'
    printf '  -o FILE    write output to FILE (default: taoup.md)\n'
    printf '  -v         verbose output\n'
    printf '  -h         display this help and exit\n'
    printf '\n'
    printf 'Report bugs to: https://github.com/agiacalone/unix-conventions/issues\n'
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

_TMPDIR=$(mktemp -d)
cleanup() {
    rm -rf "$_TMPDIR"
}
trap cleanup EXIT

log() { [[ "$VERBOSE" -eq 1 ]] && printf 'fetch-taoup: %s\n' "$*" >&2 || true; }

log "downloading TAOUP HTML..."
wget -q -r -l1 -nd -A "*.html" "$BASE_URL/" -P "$_TMPDIR"

log "building chapter order from index..."
# Extract hrefs from index in document order, filter to local chapter files only
CHAPTERS=$(grep -oP 'href="\K[^"]+\.html' "$_TMPDIR/index.html" | grep -v '^http' | awk '!seen[$0]++')

if [[ -z "$CHAPTERS" ]]; then
    printf 'fetch-taoup: warning: could not parse chapter order from index.html, falling back to filename order\n' >&2
    CHAPTERS=$(for f in "$_TMPDIR"/*.html; do basename "$f"; done | grep -v '^index\.html')
fi

log "converting to Markdown..."
> "$OUT"
while IFS= read -r chapter; do
    f="$_TMPDIR/$chapter"
    if [[ -f "$f" ]]; then
        log "$chapter"
        iconv -f iso-8859-1 -t utf-8 "$f" | pandoc -f html -t commonmark --wrap=none \
            | perl -0777 -pe 's/<[^>]+>//g; s/\n{3,}/\n\n/g' >> "$OUT"
        printf '\n---\n\n' >> "$OUT"
    fi
done <<< "$CHAPTERS"
