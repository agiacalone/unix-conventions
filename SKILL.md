---
name: unix-conventions
description: Use when reviewing or writing CLI tools, shell scripts, C programs, man pages, --help output, or error messages. Also use when writing documentation or explanations for a Unix/hacker audience, or when the user asks if something "follows Unix conventions" or "Unix philosophy".
---

# Unix Conventions

## Overview

Honor Unix tradition in code, documentation, and design. This skill reviews from within the Unix tradition. It should preserve Unix values such as simplicity, composability, silence, and portability, while distinguishing real defects from differences in convention, target environment, or project style.

Use these five canonical sources together, without flattening them into one ruleset:

- *The Art of Unix Programming* (ESR) — the philosophy and design rules behind Unix tools
- POSIX — the portable baseline for option syntax, streams, shell behavior, and utility conventions
- GNU Coding Standards — common GNU practice for CLI behavior, help/version output, shell scripting, and diagnostics
- "Worse is Better" (R.P. Gabriel) — the case for implementation simplicity when elegance and simplicity diverge
- The Jargon File — hacker vocabulary and cultural context for writing to a Unix-aware audience

## Review Philosophy

Distinguish defects from divergence.

This skill should:

- flag real correctness, safety, and portability problems clearly
- identify convention mismatches without overstating them
- account for stated compatibility targets and local project norms
- preserve Unix values such as simplicity, composability, clarity, and silence
- keep the review moving instead of interrupting on every standards disagreement

A useful Unix review is better than a doctrinaire one.

> A novice was trying to fix a broken Lisp machine by turning the power off and on.
> Knight, seeing what the student was doing, spoke sternly: "You cannot fix a machine by just
> power-cycling it with no understanding of what is going wrong."
> Knight turned the machine off and on. The machine worked.
> — *AI Koans*, The Jargon File

Be Knight: know why the rule exists, then do the pragmatic thing.

## Task Dispatch

| Task | References to load |
|------|--------------------|
| Review CLI tool (options, exit codes, streams) | `cli-conventions.md`, `taoup-principles.md` |
| Review shell script | `cli-conventions.md`, `gnu-coding-standards.md` |
| Review C program | `gnu-coding-standards.md`, `cli-conventions.md` |
| Write or review man page | `man-page-format.md` |
| Review `--help` / `--version` output | `cli-conventions.md`, `gnu-coding-standards.md` |
| Unix philosophy / design review | `taoup-principles.md`, `worse-is-better.md`, `jargon-lore.md`, `jargon-terms.md` |

Load only the references needed for the task. All references are in the `references/` subdirectory of this skill.

## Configuration

Load preferences in this order (highest to lowest precedence):

1. `.unix-conventions` in the project root
2. `~/.config/unix-conventions/config` (user config)
3. Skill defaults

Read whichever files exist and merge them, with higher-precedence files winning.

If no config resolves a standards choice, use the conflict policy below.

### Config Keys

| Key | Values | Meaning |
|-----|--------|---------|
| `standard` | `posix` \| `gnu` \| `ask` | Global tiebreaker when POSIX and GNU conflict |
| `short_h` | `help` \| `domain` \| `ask` | Whether `-h` is reserved for `--help` or available for domain use (e.g., human-readable) |
| `long_options` | `require` \| `optional` \| `none` \| `ask` | Whether GNU-style long options are required alongside short options |
| `options_after_operands` | `yes` \| `no` \| `ask` | `yes` = GNU permutation; `no` = POSIX strict (first non-option ends parsing) |
| `shebang` | `sh` \| `bash` \| `ask` | Preferred shebang for shell scripts |
| `echo_or_printf` | `printf` \| `echo` \| `ask` | Preferred output command in shell scripts |
| `c_indent` | `gnu` \| `kr` \| `linux` \| `ask` | C indentation style (`gnu` = 2 spaces; `kr`/`linux` = 8-space tabs) |
| `glibc_error` | `yes` \| `no` \| `ask` | Whether to use glibc's `error()`/`error_at_line()` in C programs |
| `worse_is_better` | `yes` \| `no` \| `ask` | Whether to apply the Worse is Better design lens |

For any key set to `ask` or absent, apply the conflict policy below.

## Conflict Policy

POSIX, GNU, and Unix lore do not always agree. Do not treat every disagreement as an automatic error.

**Default behavior: report first, ask only when necessary.**

Ask the user only when the disagreement affects one of these:

- correctness
- portability target
- when generating new code or text the user will deploy (man page, script, --help output)
- a project-level compatibility promise

Otherwise:

- note the disagreement
- identify the relevant traditions
- make a recommendation
- classify it as a warning or suggestion rather than stopping the review

### Common Conflicts

| Conflict | POSIX / portable view | GNU / ecosystem view | Default reviewer behavior |
|----------|------------------------|----------------------|---------------------------|
| `-h` option | Not universally reserved | Commonly help | If used for another meaning, note GNU conflict as a warning, not an automatic error |
| Long options | Not required | Often expected | Recommend when useful; do not require unless target or config requires them |
| Options after operands | First non-option may end parsing | Often permuted | Flag only when behavior is surprising or conflicts with stated target |
| Shebang choice | `#!/bin/sh` for portability | `#!/bin/bash` when bash is required | Judge against actual shell features used |
| `printf` vs `echo` | Both exist, but `echo` varies historically | `printf` preferred | Prefer `printf` for portability-sensitive code |
| C indentation | Not standardized | GNU style common in GNU code | Treat as style unless project convention says otherwise |
| `error()` function | Not standard | Common on glibc systems | Treat as portability-sensitive, not inherently wrong |

When asking, use this form:

> "This affects a real standards choice: [describe the conflict].  
> Which target should I optimize for: [option A], [option B], or project style?"

Do not silently assume GNU just because it is common. Do not silently assume POSIX just because it is purer.

## Severity Model

Not every violation has the same weight.

- **Error** — correctness, safety, portability baseline, broken UX contract, or behavior likely to mislead scripts or users
- **Warning** — established convention violated, but behavior may still be acceptable depending on target environment or project norms
- **Suggestion** — style, readability, consistency, or culture-of-the-ecosystem improvement

Prefer accurate weighting over rigid enforcement.

## Checklists

### CLI Tool

1. Option syntax is internally consistent and matches the intended target (POSIX, GNU, or project style)
2. Exit codes are intentional:
   - `0` for success
   - non-zero for failure
   - `2` for usage errors is a common convention, not a universal requirement
3. Streams are correct: errors to stderr, data to stdout
4. Error format should normally be `progname: description`
5. `--help` should be present when the tool is user-facing; it should exit `0`
6. `--version` is recommended for installed or distributed user-facing tools
7. Avoid repurposing `-h/--help`; users and scripts strongly expect it. Other conventional options like `-v/--verbose`, `-q/--quiet`, `-n/--dry-run` and their long forms are defaults, not universal requirements
8. Prefer silence on success unless progress output is part of the tool's contract
9. Favor composition through stdin/stdout where it improves Unix interoperability
10. Check whether the tool does one thing well rather than bundling unrelated modes

### Shell Script

1. Shebang matches the features used:
   - `#!/bin/sh` for POSIX-portable scripts
   - `#!/bin/bash` only when bash features are actually required
2. Shell safety flags match the shell target:
   - portable `sh`: `set -eu`
   - bash/ksh/zsh where supported: `set -euo pipefail`
3. Variable expansions are quoted where needed: `"$var"`, `"$@"`, `"${var}"`
4. Command substitution uses `$()` rather than backticks
5. Error messages go to stderr and include the script name when practical
6. Temp files use `mktemp` and are cleaned up with `trap ... EXIT` where applicable
7. Do not parse `ls` output; use globs, `find`, or safe iteration
8. Exit codes are intentional and stable
9. External utilities are compatible with the claimed portability target (e.g., avoid `grep -P`, `sed -i` without backup suffix, or bash-only builtins in scripts claiming `#!/bin/sh` portability)

### C Program

1. All system call and allocation return values are checked
2. Error messages use `progname: description` format
3. `progname` is derived from `argv[0]` with path stripped when appropriate
4. Resources are released correctly: file descriptors, memory, temp files, child processes
5. Signal handling is reviewed when the program is interactive, long-running, or manages resources that need cleanup
6. Option parsing handles `--` correctly when option parsing is supported
7. Interfaces are simple and unsurprising; avoid needless hidden state or side effects

### Man Page

1. Sections are present in canonical order when applicable: NAME, SYNOPSIS, DESCRIPTION, OPTIONS, EXIT STATUS, FILES, ENVIRONMENT, EXAMPLES, SEE ALSO
2. NAME is one line with `\-` separator, lowercase description, no trailing period
3. SYNOPSIS uses bold for commands, italics for metavariables, brackets for optional parts, and ellipses for repetition where needed
4. OPTIONS entries are clearly separated, usually one `.TP` block each
5. EXIT STATUS documents meaningful non-zero codes
6. SEE ALSO uses section numbers in parentheses and sensible ordering
7. Style is terse, technical, and impersonal

### `--help` / `--version`

1. `Usage:` line clearly shows operands and options
2. Uppercase metavariables like `FILE`, `DIR`, and `NUM` are recommended
3. Two-column option lists are common and easy to scan, but not mandatory
4. Listing `-h` / `--help` and version options near the end is a common GNU convention, not a universal requirement
5. Bug-report contact or project URL is useful for distributed tools, but optional for small or local utilities
6. `--help` and `--version` should exit `0`

### Worse is Better Design Review

Controlled by the `worse_is_better` config key (`yes | no | ask`, default: `ask`).

- `yes` — always apply this lens; flag designs that are needlessly elegant but implementation-heavy
- `no` — skip this checklist entirely
- `ask` — apply it when a real tradeoff appears; ask only if the choice would materially change the recommendation or generated output

When applying the lens:

1. **Implementation simplicity** — if two designs differ substantially in implementation complexity, prefer the simpler one unless it breaks correctness or seriously harms usability
2. **Edge cases pushed outward** — unusual inputs may be rejected cleanly rather than handled with elaborate internal machinery
3. **Completeness last** — a documented limitation is better than a half-implemented feature
4. **Not a bug excuse** — reversed streams, broken exit codes, unchecked failures, and incorrect behavior are bugs, not tradeoffs

When a real tradeoff exists, note it explicitly:

> "DESIGN NOTE: [option A] is simpler to implement; [option B] is cleaner to use. Worse is Better favors [option A], assuming the usability cost is acceptable."

### Jargon File

The Jargon File is background context, not a behavioral template.

Use it for:

- **Vocabulary** — when a Unix-aware audience benefits from precise terms like "kludge", "hairy", "elegant", or "creeping featurism"
- **Analogies** — when a Jargon File analogy clarifies a design smell or cultural pattern immediately
- **Audience fit** — when writing for hackers who genuinely share that context

Use `jargon-terms.md` for design vocabulary and `jargon-lore.md` for cultural references.  
For anything not covered there, `documentation/jargon.md` has the full text.

Do not invent entries. Do not force jargon where plain language is better. Do not use lore as a substitute for technical precision.

## Reporting Format

```text
VIOLATION: [rule or convention name]
SEVERITY:  [error | warning | suggestion]
LOCATION:  [file:line or section]
FOUND:     [current state]
EXPECTED:  [correct state]
FIX:       [exact correction]
RATIONALE: [why this matters in Unix/POSIX/GNU terms]
```

Group findings by severity:

1. **errors** — must fix
2. **warnings** — should fix
3. **suggestions** — consider

Show the corrected form when possible.

## Tone

Direct, technical, and specific. Show the corrected form; do not handwave.

Respect Unix tradition without turning it into cosplay.

Prefer:

- precision over theatrics
- correctness over posturing
- terseness over verbosity
- clear distinctions between bugs, convention mismatches, and style preferences

Use hacker or Unix jargon only when it improves precision for the intended audience. Do not sound smug, sneering, or performatively old-school.
