---
name: unix-conventions
description: This skill should be used when reviewing or formatting code and documentation for proper Unix conventions. Triggers on requests like "review my CLI tool", "check my man page", "does this follow Unix conventions", "format my --help output", "check my error messages", "review this shell script for POSIX compliance", or "does this tool follow Unix philosophy". Covers CLI interface design, error messages, exit codes, man pages, --help/--version output, shell scripts, C code style, and Unix philosophy from TAOUP, POSIX, and GNU coding standards.
---

# Unix Conventions

## Overview

Enforce and format code and documentation to meet Unix conventions from three canonical sources: *The Art of Unix Programming* (ESR), the POSIX standard, and the GNU Coding Standards. Apply this skill to CLI tools, shell scripts, C programs, man pages, README files, `--help` output, and any other artifact where Unix tradition is relevant.

## Reference Documents

Load these as needed based on the task:

- `references/taoup-principles.md` — The 17 Rules from *The Art of Unix Programming*; use when reviewing program design, philosophy, or overall architecture
- `references/cli-conventions.md` — POSIX option syntax, exit codes, stream usage, error message format, `--help`/`--version` format, filter pattern; use for any CLI review
- `references/man-page-format.md` — Standard man page sections, troff/mdoc macros, writing style; use when writing or reviewing man pages
- `references/gnu-coding-standards.md` — GNU error format, standard options, Makefile targets, C style, shell scripting rules; use for C programs, shell scripts, and build systems

## Tasks

### Review a CLI Tool for Unix Compliance

1. Load `references/cli-conventions.md` and `references/taoup-principles.md`
2. Check option syntax (POSIX short, GNU long, clustering, `--` terminator)
3. Check exit codes against convention (0=success, 1=error, 2=misuse)
4. Verify all errors go to stderr, all data goes to stdout
5. Check error message format: `progname: description` (lowercase, no period)
6. Check `--help` output format and that it exits 0
7. Check `--version` output format and that it exits 0
8. Check for standard reserved options (`-h`, `-V`, `-v`, `-q`, `-n`, `-f`)
9. Assess Unix philosophy: does the tool do one thing? Does it compose?
10. Report each violation with the specific fix needed

### Review or Write a Man Page

1. Load `references/man-page-format.md`
2. Verify all required sections are present in canonical order: NAME, SYNOPSIS, DESCRIPTION, OPTIONS, EXIT STATUS, FILES, ENVIRONMENT, EXAMPLES, SEE ALSO
3. Check NAME: exactly one line, uses `\-` in troff, lowercase description, no period
4. Check SYNOPSIS: program name bold, meta-variables italic/underlined, brackets for optional, ellipsis for repeatable
5. Check OPTIONS: each option in its own `.TP` block, descriptions accurate and complete
6. Check EXIT STATUS: all non-zero codes documented
7. Check SEE ALSO: section numbers in parentheses, alphabetical, comma-separated
8. Check writing style: third person, present tense, terse and precise
9. When writing a new man page, produce complete troff source using `man` macros (`.TH`, `.SH`, `.TP`, `.PP`, `.BR`, `.I`) unless mdoc is requested

### Review Shell Scripts

1. Load `references/cli-conventions.md` and `references/gnu-coding-standards.md`
2. Check shebang: `#!/bin/sh` for portability, `#!/bin/bash` only when bash features are used
3. Check for `set -e`, `set -u` (or equivalent)
4. Check all variable expansions are quoted: `"$var"`, `"$@"`, `"${var}"`
5. Check command substitution uses `$(...)` not backticks
6. Check error messages go to stderr and include the script name
7. Check temporary file handling uses `mktemp` with `trap ... EXIT` cleanup
8. Check exit codes

### Review C Programs

1. Load `references/gnu-coding-standards.md` and `references/cli-conventions.md`
2. Check system call return values are all checked
3. Check error messages use `program_name: description` format
4. Check `program_name` is set from `argv[0]` (path stripped)
5. Check for resource leaks: unclosed file descriptors, unfreed memory, temp files
6. Check signal handling for graceful termination
7. Check option parsing handles `--` correctly

### Review `--help` or `--version` Output

1. Load `references/cli-conventions.md` and `references/gnu-coding-standards.md`
2. Apply the exact format from the reference: `Usage:` line, two-column option list, bug report contact
3. Ensure meta-variables are uppercase: `FILE`, `DIR`, `NUM`, `PATTERN`
4. Ensure `-h`/`--help` and `-V`/`--version` are listed last
5. Format and return corrected output

### Apply Unix Philosophy Review

1. Load `references/taoup-principles.md`
2. Assess the design against each of the 17 Rules
3. Identify violations with clear examples from the code or design
4. Suggest concrete changes, not abstract principles

## Reporting Conventions

When reporting issues, use this format:

```
VIOLATION: [Rule/Convention name]
LOCATION:  [file:line or section]
FOUND:     [what is there now]
EXPECTED:  [what it should be]
FIX:       [exact correction or suggested code]
```

Group violations by severity: errors (must fix), warnings (should fix), suggestions (consider).

## Tone

Be direct and technical. Man pages and Unix tools have a long tradition of precise, terse language. Prefer showing the corrected form over lengthy explanation of why it is wrong.
