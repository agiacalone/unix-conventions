---
name: unix-conventions
description: Use when reviewing or writing CLI tools, shell scripts, C programs, man pages, --help output, error messages, or any artifact where Unix/POSIX/GNU conventions apply. Also use when the user asks if something "follows Unix conventions" or "Unix philosophy".
---

# Unix Conventions

## Overview

Enforce code and documentation against three canonical sources: *The Art of Unix Programming* (ESR), POSIX, and the GNU Coding Standards.

## Task Dispatch

| Task | References to load |
|------|--------------------|
| Review CLI tool (options, exit codes, streams) | `cli-conventions.md`, `taoup-principles.md` |
| Review shell script | `cli-conventions.md`, `gnu-coding-standards.md` |
| Review C program | `gnu-coding-standards.md`, `cli-conventions.md` |
| Write or review man page | `man-page-format.md` |
| Review `--help` / `--version` output | `cli-conventions.md`, `gnu-coding-standards.md` |
| Unix philosophy / design review | `taoup-principles.md` |

Load only the references needed for the task. All references are in the `references/` subdirectory of this skill.

## Checklists

### CLI Tool

1. Option syntax: POSIX short (`-x`), GNU long (`--foo`), clustering, `--` terminator
2. Exit codes: 0=success, 1=error, 2=misuse
3. Streams: errors → stderr, data → stdout, never reversed
4. Error format: `progname: description` (lowercase, no period)
5. `--help`: correct format, exits 0
6. `--version`: correct format, exits 0
7. Reserved options: `-h/--help`, `-V/--version`, `-v/--verbose`, `-q/--quiet`, `-n/--dry-run`
8. Rule of Silence: silent on success by default; no chatty progress output unless `-v`
9. Unix philosophy: does one thing, composes via stdin/stdout

### Shell Script

1. Shebang: `#!/bin/sh` for portable, `#!/bin/bash` only when bash features are used
2. `set -euo pipefail` present
3. All variable expansions quoted: `"$var"`, `"$@"`, `"${var}"`
4. Command substitution uses `$()` not backticks
5. Error messages go to stderr, include script name
6. Temp files via `mktemp`, cleaned up with `trap ... EXIT`
7. No parsing of `ls` output; use globs
8. Exit codes correct

### C Program

1. All system call return values checked
2. Error messages: `progname: description` format
3. `progname` set from `argv[0]` (path stripped)
4. No resource leaks: file descriptors, memory, temp files
5. Signal handling: SIGINT, SIGTERM handled gracefully
6. Option parsing handles `--` terminator

### Man Page

1. Sections present in canonical order: NAME, SYNOPSIS, DESCRIPTION, OPTIONS, EXIT STATUS, FILES, ENVIRONMENT, EXAMPLES, SEE ALSO
2. NAME: one line, `\-` separator, lowercase description, no period
3. SYNOPSIS: program bold, meta-variables italic, brackets for optional, ellipsis for repeatable
4. OPTIONS: each in its own `.TP` block
5. EXIT STATUS: all non-zero codes documented
6. SEE ALSO: section numbers in parens, alphabetical, comma-separated
7. Style: third person, present tense, terse

### `--help` / `--version`

1. `Usage:` line with uppercase meta-variables (`FILE`, `DIR`, `NUM`)
2. Two-column option list, `-h`/`-V` listed last
3. Bug report contact at end
4. Exits 0

## Reporting Format

```
VIOLATION: [rule or convention name]
LOCATION:  [file:line or section]
FOUND:     [current state]
EXPECTED:  [correct state]
FIX:       [exact correction]
```

Group by severity: **errors** (must fix) → **warnings** (should fix) → **suggestions** (consider).

## Tone

Direct and technical. Show the corrected form; minimize explanation of why it is wrong.
