# unix-conventions

A Claude Code skill for reviewing CLI tools, shell scripts, C programs, and documentation against Unix tradition.

Five sources: *The Art of Unix Programming* (ESR), POSIX (IEEE Std 1003.1), GNU Coding Standards, "Worse is Better" (R.P. Gabriel, 1989), and The Jargon File (Community Edition).

## Install

```
./install.sh
```

Copies the skill to `~/.claude/skills/unix-conventions/`. Requires Claude Code.

## Use

Claude loads the skill automatically when reviewing CLI tools, shell scripts, or man pages. Invoke it directly with `/unix-conventions`.

Only the references relevant to the task are loaded.

## Updating references

```
./fetch-taoup.sh [-v] [-o FILE]          # requires wget, pandoc, iconv, perl
./fetch-gnu-standards.sh [-v] [-o FILE]  # requires wget
./fetch-jargon.sh [-v] [-o FILE]         # requires wget, pandoc
```

Each script writes to its default output file under `documentation/`; use `-o` to redirect. All support `-h`.

`fetch-jargon.sh` pulls the Jargon File (Community Edition) from GitHub Pages and includes all letter entries, linguistic conventions, style chapters, and appendices (Story of Mel, AI Koans, J. Random Hacker portrait).

`documentation/posix-conventions.txt` is an original POSIX utility conventions summary. The full standard is copyrighted by The Open Group and IEEE; authoritative text at https://pubs.opengroup.org/onlinepubs/9799919799/

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
.unix-conventions.example  per-project config template
fetch-taoup.sh             fetches and converts TAOUP HTML to Markdown
fetch-gnu-standards.sh     fetches the GNU Coding Standards as plain text
fetch-jargon.sh            fetches the Jargon File and converts it to Markdown
install.sh                 installs the skill to ~/.claude/skills/unix-conventions/
```

## Configuration

Copy `.unix-conventions.example` to `.unix-conventions` at your project root to set per-project preferences. For user-wide defaults, edit `~/.config/unix-conventions/config`. Project file takes precedence. `.unix-conventions` is gitignored.

When POSIX, GNU, and TAOUP disagree, the skill checks config first. Unset keys default to `ask`.

**`standard = posix | gnu | ask`**  
Global tiebreaker. `posix` for tools that must run on any POSIX system (OpenBSD, macOS, Solaris); `gnu` for Linux-only.

**`short_h = help | domain | ask`**  
Whether `-h` is reserved for `--help` or free for domain use (human-readable sizes, host, header, etc.).

**`long_options = require | optional | none | ask`**  
Whether GNU long options (`--verbose`, `--output`) are expected alongside short ones.

**`options_after_operands = yes | no | ask`**  
`yes` = GNU permutation (options anywhere); `no` = POSIX strict (first non-option ends option parsing).

**`shebang = sh | bash | ask`**  
`sh` for scripts that must run on dash, ash, or other minimal shells. `bash` when the script actually uses bash-specific features: arrays, `[[ ]]`, `pipefail`, process substitution.

**`echo_or_printf = printf | echo | ask`**  
`printf` is portable. `echo` behavior with `-n` and backslash escapes is implementation-defined across bash, dash, and `/bin/sh`.

**`c_indent = gnu | kr | linux | ask`**  
`gnu` = 2 spaces. `kr` = 8-space tabs (Kernighan & Ritchie). `linux` = 8-space tabs with Linux kernel brace rules.

**`glibc_error = yes | no | ask`**  
Whether to recommend `error()`/`error_at_line()`. Non-portable (glibc only); use `no` for code targeting macOS, BSDs, or musl.

**`worse_is_better = yes | no | ask`**  
Whether to apply the Worse is Better design lens during reviews.

## License

GPL v3. See LICENSE.

Reference documents are derived from works with their own licenses; see CREDITS.md.
