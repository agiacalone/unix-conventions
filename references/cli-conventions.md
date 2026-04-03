# CLI Conventions — POSIX and Unix Tradition

Reference: IEEE Std 1003.1 (POSIX), https://pubs.opengroup.org/onlinepubs/9799919799/ (XBD Ch. 12)
Reference: GNU Coding Standards, https://www.gnu.org/prep/standards/
Reference: Eric S. Raymond, *The Art of Unix Programming*, Addison-Wesley, 2003

---

## Option Syntax

### Short Options (POSIX)
- Single character, preceded by a single hyphen: `-v`, `-o`, `-f`
- May be clustered: `ls -la` is equivalent to `ls -l -a`
- Options that take arguments: `-o file` or `-ofile` (no space or adjacent)
- Options should precede non-option arguments
- `--` signals the end of options; everything after is a positional argument

### Long Options (GNU extension, widely adopted)
- Two hyphens followed by a word: `--verbose`, `--output`, `--force`
- Arguments: `--output=file` or `--output file`
- Long options should be named for clarity, not brevity
- Long options should parallel short options when both exist: `-v` / `--verbose`

### Option Naming Conventions
- Use lowercase for option names
- Use hyphens, not underscores, to separate words in long options: `--dry-run`, not `--dry_run`
- Avoid single-letter ambiguity: if `-v` is verbose, don't also use it for version
- Reserve these standard options consistently:
  - `-h` / `--help`: print help and exit (exit 0)
  - `-V` / `--version`: print version and exit (exit 0)
  - `-v` / `--verbose`: increase verbosity (may be repeated: `-vvv`)
  - `-q` / `--quiet` / `--silent`: suppress output
  - `-n` / `--dry-run`: show what would be done without doing it
  - `-f` / `--force`: bypass safety checks
  - `-r` / `-R` / `--recursive`: operate recursively
  - `-o` / `--output`: specify output file
  - `-i` / `--input`: specify input file

---

## Exit Codes

Following POSIX and GNU conventions:

| Code | Meaning |
|------|---------|
| 0    | Success |
| 1    | General error (catch-all for minor failures) |
| 2    | Misuse of shell command or invalid arguments |
| 126  | Command cannot execute (permission problem) |
| 127  | Command not found |
| 128+n | Fatal signal n received (e.g., 130 = SIGINT, 143 = SIGTERM) |

Tools with domain-specific semantics may use:
- `grep`: 0 = match found, 1 = no match, 2 = error
- `diff`: 0 = identical, 1 = different, 2 = error

Always document non-zero exit codes in the man page and `--help` output.

---

## Standard Streams

- **stdin (fd 0):** Input data. Tools should read from stdin when no file argument is given (filter pattern).
- **stdout (fd 1):** Output data. Normal program output goes here.
- **stderr (fd 2):** Diagnostic output. All error messages, warnings, and progress indicators go here — never to stdout.

### The Filter Pattern
A well-behaved Unix filter:
1. Reads from stdin if no file arguments are given
2. Reads from each file argument in sequence if given
3. Writes results to stdout
4. Writes errors and warnings to stderr
5. Returns 0 on success, non-zero on failure

---

## Error Messages

### Format
```
progname: description of error
progname: filename: description of error
progname: filename:lineno: description of error
```

Rules:
- Begin with the program name (use `argv[0]` or a hardcoded name, not the full path)
- Do not capitalize the error description (it follows the colon)
- Do not end with a period
- Include the filename and line number when the error relates to input data
- Perror-style messages: `progname: operation: strerror(errno)` (e.g., `cp: foo.txt: No such file or directory`)
- Write all errors to stderr, never stdout

### Tone
- Describe what went wrong, not what the user did wrong
- Avoid blame ("invalid input" is better than "you provided invalid input")
- Be specific enough to diagnose; avoid "an error occurred"

---

## `--help` Output Format

```
Usage: progname [OPTION]... [FILE]...
One-sentence description of what the program does.

  -s, --short          short description of option
  -o, --output=FILE    write output to FILE
  -v, --verbose        explain what is being done
  -h, --help           display this help and exit
  -V, --version        output version information and exit

Long description of behavior, edge cases, defaults, etc.
One paragraph per major concept.

Report bugs to: <email or URL>
Home page: <URL>
```

Rules:
- First line: `Usage:` line(s) showing the invocation pattern
- Uppercase meta-variables: `FILE`, `DIR`, `NUM`, `PATTERN`
- Bracket optional elements: `[OPTION]`, `[FILE]`
- Ellipsis for repeatable: `[OPTION]...`, `FILE...`
- Align option descriptions in two columns
- `-h`/`--help` and `-V`/`--version` always listed last
- Exit with code 0 after printing help

---

## `--version` Output Format

```
progname 1.2.3
Copyright (C) 2024 Author Name
License GPLv3+: GNU GPL version 3 or later <https://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
```

Minimal acceptable:
```
progname 1.2.3
```

Rules:
- First line: program name, space, version number
- No decoration, no banners
- Exit with code 0

---

## Environment Variables

- Document all environment variables the program reads in the man page under `ENVIRONMENT`
- Prefer `PROGNAME_VAR` naming for program-specific variables (e.g., `GREP_OPTIONS`, `GIT_EDITOR`)
- Respect standard variables: `HOME`, `PATH`, `TMPDIR`, `EDITOR`, `PAGER`, `TERM`, `LANG`, `LC_*`
- Command-line options should override environment variables; environment variables override compiled-in defaults

---

## Configuration Files

Precedence order (highest to lowest):
1. Command-line options
2. Environment variables
3. Per-user config (`~/.config/progname/config` or `~/.prognamerc`)
4. System-wide config (`/etc/progname.conf`)
5. Compiled-in defaults

---

## Common Anti-Patterns to Flag

- Errors written to stdout instead of stderr
- Program name not included in error messages
- Mixing option and non-option parsing after a positional argument (breaks POSIX)
- Outputting data to stderr or progress to stdout
- Exit 0 on failure, or non-zero on success
- `--help` that exits non-zero
- Options using underscores instead of hyphens
- Noisy success output that clutters pipeline composition
- No support for `--` to terminate option parsing
