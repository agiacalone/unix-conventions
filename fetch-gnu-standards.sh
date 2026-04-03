#!/bin/bash
set -euo pipefail

OUT="documentation/gnu-coding-standards.txt"
URL="https://www.gnu.org/prep/standards/standards.txt"
VERBOSE=0

usage() {
    printf 'Usage: fetch-gnu-standards [-v] [-o FILE]\n'
    printf 'Fetch the GNU Coding Standards as plain text.\n'
    printf '\n'
    printf '  -o FILE    write output to FILE (default: %s)\n' "$OUT"
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

log() { [[ "$VERBOSE" -eq 1 ]] && echo "fetch-gnu-standards: $*" >&2 || true; }

log "downloading GNU Coding Standards..."
wget -q -O "$OUT" "$URL"
