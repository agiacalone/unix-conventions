#!/bin/bash
set -e

SKILL_NAME="unix-conventions"
SKILL_SRC="$(cd "$(dirname "$0")" && pwd)/$SKILL_NAME"
INSTALL_DIR="$HOME/.claude/skills"

if [ ! -d "$SKILL_SRC" ]; then
    echo "${0##*/}: $SKILL_SRC: skill directory not found" >&2
    exit 1
fi

mkdir -p "$INSTALL_DIR"
cp -r "$SKILL_SRC" "$INSTALL_DIR/"
echo "Installed $SKILL_NAME to $INSTALL_DIR/$SKILL_NAME"
