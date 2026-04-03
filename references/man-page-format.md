# Man Page Format and Conventions

Reference: groff man(7), https://man7.org/linux/man-pages/man7/man.7.html
Reference: groff mdoc(7), https://man7.org/linux/man-pages/man7/mdoc.7.html
Reference: Linux man-pages project, https://www.kernel.org/doc/man-pages/

---

## Manual Sections

| Section | Contents |
|---------|----------|
| 1 | User commands (programs run by users) |
| 2 | System calls (kernel interface) |
| 3 | Library functions (C library, etc.) |
| 4 | Special files (devices in `/dev`) |
| 5 | File formats and conventions |
| 6 | Games |
| 7 | Miscellaneous (overview pages, conventions, protocols) |
| 8 | System administration commands (usually run as root) |

Most CLI tools belong in section 1. Config file formats belong in section 5. Daemons and admin tools belong in section 8.

---

## Standard Sections (in order)

Every man page should have these sections in this order:

### NAME (required)
```
.SH NAME
progname \- one-line description of what the program does
```
- One line only
- Use `\-` (escaped hyphen) not `-` in troff — this prevents line-breaking
- No period at end
- Lowercase description

### SYNOPSIS (required)
```
.SH SYNOPSIS
.B progname
[\fIOPTION\fR]...
[\fIFILE\fR]...
```
- Bold the program name
- Italic (or underlined in terminal) for meta-variables
- Brackets for optional elements
- Ellipsis for repeatable elements
- List all invocation forms

### DESCRIPTION (required)
- Full description of what the program does
- Multiple paragraphs as needed
- Use `.PP` between paragraphs in troff
- Do not repeat the SYNOPSIS; describe behavior

### OPTIONS
```
.SS "Option Category (if grouping)"
.TP
.BR \-v ", " \-\-verbose
Enable verbose output. May be repeated for increased verbosity.
```
- `.TP` introduces a tagged paragraph (option + description)
- `.BR` for bold+regular mixing
- List in alphabetical order within groups, or short options before long
- Each option gets its own `.TP` entry
- Describe defaults when relevant

### EXIT STATUS
```
.SH EXIT STATUS
.TP
.B 0
Success.
.TP
.B 1
An error occurred.
```
- List all possible exit codes and their meanings

### FILES
List configuration files, data files, or other filesystem resources:
```
.SH FILES
.TP
.I ~/.config/progname/config
Per-user configuration file.
```

### ENVIRONMENT
List all environment variables consulted:
```
.SH ENVIRONMENT
.TP
.B PROGNAME_CONFIG
Path to configuration file. Overrides default location.
```

### EXAMPLES (strongly recommended)
```
.SH EXAMPLES
.TP
Run progname on all text files:
.B progname *.txt
```
- Provide realistic, useful examples
- Show common invocations, not contrived ones
- One example per `.TP` block

### SEE ALSO
```
.SH SEE ALSO
.BR grep (1),
.BR sed (1),
.BR awk (1)
```
- Related commands, in alphabetical order
- Include section number in parentheses
- Comma-separated, final entry has no comma

### BUGS
Document known limitations and bugs. If none, omit this section.

### AUTHOR / AUTHORS
```
.SH AUTHOR
Written by Author Name <email>.
```

### COPYRIGHT / LICENSE
```
.SH COPYRIGHT
Copyright \(co 2024 Author Name.
License GPLv3+: GNU GPL version 3 or later.
```

---

## Troff Macros (mdoc vs. man)

### man macros (traditional, most common)
```
.TH PROGNAME 1 "April 2024" "progname 1.0" "User Commands"
.SH NAME
.SH SYNOPSIS
.B bold text
.I italic text
.BR bold\-then\-regular alternating
.TP
.PP  (paragraph break)
```

`.TH` arguments: `NAME SECTION DATE SOURCE MANUAL`
- DATE: "Month YYYY" format
- SOURCE: package name and version
- MANUAL: section title (e.g., "User Commands", "System Calls")

### mdoc macros (BSD tradition, semantic)
```
.Dd April 3, 2024
.Dt PROGNAME 1
.Os
.Sh NAME
.Nm progname
.Nd one-line description
.Sh SYNOPSIS
.Nm
.Op Fl v
.Op Ar file
```
- More semantic than `man` macros; preferred on BSDs
- Handles formatting automatically
- Use `.Op` for optional, `.Ar` for arguments, `.Fl` for flags, `.Nm` for program name

---

## Writing Style

- Write in the third person: "The program reads from stdin" not "Read from stdin"
- Use present tense: "prints" not "will print"
- Be terse and precise — man pages are reference documents, not tutorials
- Avoid marketing language, superlatives, and subjective claims
- Refer to the user as "the user", not "you"
- Define all terms on first use
- Cross-reference related options within the OPTIONS section

---

## Common Violations to Flag

- Missing NAME, SYNOPSIS, or DESCRIPTION sections
- Description in NAME longer than one line
- Sections out of canonical order
- No EXIT STATUS section for a tool that exits non-zero
- Examples section missing or contrived
- Using `-` instead of `\-` in troff (breaks hyphenation)
- Bare `-` or `--` options not formatted in bold in SYNOPSIS
- SEE ALSO entries missing section numbers
- Files or environment variables used but not documented
