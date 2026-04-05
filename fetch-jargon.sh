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
    url="$BASE_URL/$letter.html"
    f="$_TMPDIR/$letter.html"
    log "downloading $letter.html..."
    if wget -q -O "$f" "$url" 2>/dev/null; then
        log "converting $letter.html..."
        pandoc -f html -t commonmark --wrap=none "$f" \
            | perl -0777 -pe 's/<[^>]+>//g; s/\n{3,}/\n\n/g' >> "$OUT"
        printf '\n---\n\n' >> "$OUT"
    else
        printf 'fetch-jargon: warning: could not fetch %s\n' "$url" >&2
    fi
done
