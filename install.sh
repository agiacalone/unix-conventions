#!/bin/bash
set -euo pipefail

SKILL_NAME="unix-conventions"
ROOT="$(cd "$(dirname "$0")" && pwd)"
INSTALL_DIR="$HOME/.claude/skills/$SKILL_NAME"
CONFIG_DIR="$HOME/.config/unix-conventions"

if [[ ! -f "$ROOT/SKILL.md" ]]; then
    printf '%s: SKILL.md not found in %s\n' "${0##*/}" "$ROOT" >&2
    exit 1
fi

mkdir -p "$INSTALL_DIR"
cp "$ROOT/SKILL.md" "$INSTALL_DIR/"
cp -r "$ROOT/references" "$INSTALL_DIR/"

mkdir -p "$CONFIG_DIR"
if [[ ! -f "$CONFIG_DIR/config" ]]; then
    cp "$ROOT/.unix-conventions.example" "$CONFIG_DIR/config.example"
fi
