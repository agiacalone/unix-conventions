# GNU Coding Standards — Relevant Conventions

Reference: GNU Coding Standards (https://www.gnu.org/prep/standards/)

---

## Program Behavior

### Avoid Arbitrary Limitations
Do not impose arbitrary limits on input length, file size, number of objects, or recursion depth. Use dynamic allocation. If a limit exists, report it clearly when exceeded.

### Portability
- Write portable C; target POSIX unless there is a documented reason not to
- Do not use extensions unavailable in C99/C11 without a configure check
- Do not assume a specific locale; use `LC_*` categories correctly

### Robustness
- Check the return value of every system call that can fail
- Free allocated memory; close file descriptors; clean up temp files on exit
- Handle signals (SIGINT, SIGTERM, SIGHUP) gracefully
- Write to a temp file, then rename atomically, when updating files in place

---

## Error Handling

### Error Message Format
```c
fprintf(stderr, "%s: %s\n", program_name, error_description);
fprintf(stderr, "%s: %s: %s\n", program_name, filename, strerror(errno));
```

Rules:
- Always include `program_name` (set from `argv[0]` at startup, stripping path)
- Do not capitalize the error message
- Do not end with a period
- Append `strerror(errno)` for system call failures
- Use `error()` / `error_at_line()` from `<error.h>` when available (glibc)

### Warning vs. Error
- Use "warning:" prefix for non-fatal conditions: `progname: warning: ignoring unknown option '--foo'`
- Fatal errors should exit immediately with a non-zero status

---

## Standard Options

The following options must behave consistently across all GNU programs:

| Option | Behavior |
|--------|----------|
| `--help` | Print help summary to stdout, exit 0 |
| `--version` | Print version info to stdout, exit 0 |
| `--verbose` / `-v` | Enable verbose output |
| `--quiet` / `--silent` / `-q` | Suppress normal output |
| `--dry-run` / `-n` | Show what would be done without doing it |

Never use `-h` for anything other than `--help`. Never use `-V` for anything other than `--version`.

---

## `--help` Output (GNU Standard)

```
Usage: progname [OPTION]... [FILE]...
Short description of the program.

Mandatory arguments to long options are mandatory for short options too.

  -o, --output=FILE    write output to FILE instead of stdout
  -v, --verbose        explain what is being done
      --long-only      an option with no short form
  -h, --help           display this help and exit
  -V, --version        output version information and exit

Additional explanatory text about behavior, environment, or notes.

Report bugs to: <bug-email@example.com>
progname home page: <https://example.com/progname>
```

Notes:
- Include the line "Mandatory arguments to long options are mandatory for short options too." when relevant
- Options with no short form: indent the long option to align with others
- Group related options with blank lines or sub-headings for large option sets
- End with bug-reporting contact

---

## `--version` Output (GNU Standard)

```
progname (GNU coreutils) 9.1
Copyright (C) 2022 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <https://gnu.org/licenses/gpl.html>.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Written by Author Name.
```

For non-FSF projects:
```
progname 1.2.3
Copyright (C) 2024 Author Name
License: MIT <https://opensource.org/licenses/MIT>
```

---

## Makefile Conventions

Standard targets every Makefile should support:

| Target | Purpose |
|--------|---------|
| `all` | Build the default targets (usually the program) |
| `install` | Install the program, man page, and data files |
| `uninstall` | Reverse of install |
| `clean` | Delete build artifacts (object files, binaries) |
| `distclean` | Delete everything not in the source distribution |
| `check` / `test` | Run the test suite |
| `dist` | Create a distribution tarball |

Standard variables:
- `prefix` (default `/usr/local`), `bindir`, `mandir`, `datadir`, `sysconfdir`
- `CC`, `CFLAGS`, `LDFLAGS`, `LIBS`
- `INSTALL`, `INSTALL_PROGRAM`, `INSTALL_DATA`

---

## C Code Style (GNU)

- Indent with 2 spaces (GNU style; differs from K&R/Linux kernel 8-space tabs)
- Opening brace of function body on its own line
- Opening brace of control statement on the same line
- Space before `(` in control statements: `if (cond)`, `while (cond)`, `for (...)`
- No space before `(` in function calls: `foo(bar)`
- Comment style: `/* ... */` for block comments; `//` for single-line (C99+)
- Global functions and variables: lowercase with underscores

---

## Shell Script Conventions

- Start with `#!/bin/sh` for POSIX portability, or `#!/bin/bash` if bash features are required
- `set -e` to exit on unhandled error (but understand its limitations)
- `set -u` to error on unset variables
- Quote all variable expansions: `"$var"`, `"$@"`, `"${var}"`
- Use `$(...)` not backticks for command substitution
- Check the exit status of commands that can fail
- Write error messages to stderr: `echo "progname: error message" >&2`
- Use `mktemp` for temporary files; clean up with `trap ... EXIT`
- Prefer `printf` over `echo` for portability

---

## Common GNU Standards Violations to Flag

- `--help` exits non-zero or writes to stderr
- `--version` output doesn't include the program name on the first line
- Error messages don't include the program name
- Error messages capitalized or ending with a period
- System call return values not checked
- Files or state not cleaned up on abnormal exit
- Makefile missing standard targets (`install`, `clean`, `check`)
- Shell scripts using unquoted variable expansions
- Backtick command substitution instead of `$(...)`
