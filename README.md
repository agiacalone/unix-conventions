# unix-conventions

A Claude Code skill for honoring Unix tradition in CLI tools, shell scripts, C programs, and documentation.

## Description

`unix-conventions` provides checklists, reference documents, and reporting conventions drawn from five canonical sources:

- *The Art of Unix Programming* (ESR) — the 17 Rules and Unix philosophy
- POSIX (IEEE Std 1003.1) — option syntax, exit codes, standard streams, filter pattern
- GNU Coding Standards — error format, standard options, shell scripting rules, C style
- "Worse is Better" (R.P. Gabriel, 1989) — implementation simplicity as a design priority
- The Jargon File (Community Edition) — hacker vocabulary and lore; how to write for an audience that groks the tradition

The skill applies to CLI tools, shell scripts, C programs, man pages, `--help`/`--version` output, and anything where writing for hackers matters.

## Installation

```
./install.sh
```

Installs the skill to `~/.claude/skills/unix-conventions/`. Requires Claude Code.

## Usage

Invoke the skill in Claude Code with `/unix-conventions`, or Claude will load it automatically when reviewing CLI tools, shell scripts, or man pages.

The skill loads only the reference documents relevant to the task at hand.

## Files

```
SKILL.md                   skill definition and checklists
references/
  taoup-principles.md      the 17 Rules from TAOUP
  cli-conventions.md       POSIX option syntax, exit codes, streams, error format
  gnu-coding-standards.md  GNU error format, standard options, shell scripting, C style
  man-page-format.md       man page sections, macros, writing style
  worse-is-better.md       Gabriel's four properties and when to apply them
  jargon-lore.md           curated hacker lore: koans, incidents, cultural touchstones
  jargon-terms.md          curated vocabulary: design quality signals and hacker terminology
documentation/
  taoup.md                 The Art of Unix Programming (full text, Markdown)
  jargon.md                The Jargon File, Community Edition (full text, Markdown)
  taoup.pdf                The Art of Unix Programming (PDF)
  posix-conventions.txt    POSIX utility conventions summary (original)
  gnu-coding-standards.txt GNU Coding Standards (fetched from gnu.org)
.unix-conventions.example  config template for per-project preferences
fetch-taoup.sh             fetches and converts TAOUP HTML to Markdown
fetch-gnu-standards.sh     fetches the GNU Coding Standards as plain text
install.sh                 installs the skill to ~/.claude/skills/unix-conventions/
```

## fetch-taoup.sh

Fetches the TAOUP HTML from catb.org and converts it to Markdown.

```
Usage: fetch-taoup [-v] [-o FILE]

  -o FILE    write output to FILE (default: taoup.md)
  -v         verbose output
  -h         display this help and exit
```

Requires `wget`, `pandoc`, `iconv`, and `perl`.

## fetch-gnu-standards.sh

Fetches the GNU Coding Standards plain text from gnu.org.

```
Usage: fetch-gnu-standards [-v] [-o FILE]

  -o FILE    write output to FILE (default: documentation/gnu-coding-standards.txt)
  -v         verbose output
  -h         display this help and exit
```

Requires `wget`.

## fetch-jargon.sh

Fetches the Jargon File (Community Edition) from GitHub Pages and converts it to Markdown. Includes all letter entries, linguistic conventions, speech/writing/email style chapters, and appendices (Story of Mel, AI Koans, J. Random Hacker portrait).

```
Usage: fetch-jargon [-v] [-o FILE]

  -o FILE    write output to FILE (default: documentation/jargon.md)
  -v         verbose output
  -h         display this help and exit
```

Requires `wget` and `pandoc`.

## documentation/posix-conventions.txt

An original summary of the POSIX utility conventions (IEEE Std 1003.1). The
full standard is copyrighted by The Open Group and IEEE and is not freely
redistributable; this file is an independent summary. The authoritative text
is at https://pubs.opengroup.org/onlinepubs/9799919799/ and the POSIX FAQ
is at https://www.opengroup.org/austin/papers/posix_faq.html.

## Conflict Resolution

POSIX, GNU, and TAOUP disagree on several points. The skill will ask the user
when it encounters a conflict rather than silently assuming one standard over
another.

Preferences are loaded in this order (highest precedence first):

1. `.unix-conventions` in the project root
2. `~/.config/unix-conventions/config` (user config)
3. Skill defaults — ask

To set user-wide preferences, edit `~/.config/unix-conventions/config`.
To override per project, copy `.unix-conventions.example` to `.unix-conventions`
in the project root and set values for the relevant keys:

### Options

**`standard = posix | gnu | ask`**
Global tiebreaker when a conflict is not covered by a more specific key.
Use `posix` for tools that must run on any POSIX system (OpenBSD, macOS,
Solaris). Use `gnu` for Linux-only tools or anything targeting GNU/Linux
distributions.

**`short_h = help | domain | ask`**
Controls whether `-h` is reserved for `--help` (GNU) or available for a
domain-specific meaning. Set `domain` when writing a tool where `-h` means
something else — e.g., human-readable output (`df -h`, `ls -h`), host
(`curl -h`), or header. Set `help` for any tool that follows GNU conventions
strictly.

**`long_options = require | optional | none | ask`**
Whether GNU-style long options (`--verbose`, `--output`) are expected
alongside POSIX short options. Use `require` for tools aimed at interactive
users who benefit from readable option names. Use `optional` when long
options are nice to have but not enforced. Use `none` for minimal POSIX
tools where short options are sufficient and long options add no value.

**`options_after_operands = yes | no | ask`**
Whether options may appear after positional arguments (`tool file --verbose`).
GNU `getopt` permutes by default; POSIX stops option parsing at the first
non-option. Use `no` for strict POSIX compatibility or when writing scripts
that must work across platforms. Use `yes` for tools where users are likely
to append flags after filenames.

**`shebang = sh | bash | ask`**
Preferred shebang line for shell scripts. Use `sh` for scripts that must
be portable to systems where `/bin/sh` is dash, ash, or another minimal
shell (Debian, Alpine, most BSDs). Use `bash` when the script uses arrays,
`[[ ]]`, `pipefail`, process substitution, or other bash-specific features.

**`echo_or_printf = printf | echo | ask`**
Preferred command for string output in shell scripts. `printf` is more
portable — `echo` behaviour with `-n` and backslash escapes is
implementation-defined and differs between bash, dash, and /bin/sh on
various systems. Use `echo` only in scripts where portability is not a
concern and readability is preferred.

**`c_indent = gnu | kr | linux | ask`**
Indentation style for C programs. `gnu` uses 2-space indentation (GNU
Coding Standards). `kr` uses 8-space tabs (Kernighan & Ritchie, traditional
Unix). `linux` uses 8-space tabs with the Linux kernel's specific brace and
spacing rules. Match this to the project's existing style or the upstream
project you are contributing to.

**`glibc_error = yes | no | ask`**
Whether to recommend glibc's `error()` and `error_at_line()` functions for
error reporting in C programs. These are non-portable (glibc only) but
produce consistent, well-formatted messages automatically. Use `yes` for
Linux-only C programs. Use `no` for portable C that must compile on macOS,
BSDs, or musl-based systems.

**`worse_is_better = yes | no | ask`**
Whether to apply the "Worse is Better" design lens (R.P. Gabriel, 1989)
during design reviews. `yes` always applies it — implementation simplicity
takes priority over interface elegance, and completeness is sacrificed for
simplicity. `no` skips this lens entirely. `ask` prompts when a design
tradeoff arises where the two approaches would give different answers.

Omitting a key or setting it to `ask` causes the skill to prompt when that
conflict arises.

`.unix-conventions` is listed in `.gitignore` and will not be committed.
`.unix-conventions.example` is tracked and serves as the template.

## License

GPL v3. See LICENSE.

The reference documents are derived from works with their own licenses; see CREDITS.md.
