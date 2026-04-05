# Credits and Attributions

This skill draws directly from the following authoritative sources:

## The Art of Unix Programming
- **Author:** Eric S. Raymond
- **Publisher:** Addison-Wesley Professional, 2003
- **ISBN:** 0-13-142901-9
- **Online:** https://www.catb.org/esr/writings/taoup/html/
- **License:** Creative Commons Attribution-NoDerivs 1.0

The seventeen rules compiled in `references/taoup-principles.md` are ESR's
distillation of Unix tradition, drawn from Chapter 1 ("Philosophy") of TAOUP.

## POSIX (IEEE Std 1003.1)
- **Full title:** The Open Group Base Specifications Issue 8 (IEEE Std 1003.1-2024)
- **Online:** https://pubs.opengroup.org/onlinepubs/9799919799/
- **Publisher:** The Open Group / IEEE

Option syntax, exit code conventions, standard streams, and the filter pattern
in `references/cli-conventions.md` are drawn from the POSIX Utility Conventions
(XBD Chapter 12) and related specifications.

## GNU Coding Standards
- **Author:** Richard Stallman and the GNU Project
- **Online:** https://www.gnu.org/prep/standards/
- **Plain text:** https://www.gnu.org/prep/standards/standards.txt
- **License:** GNU Free Documentation License v1.3 or later

The full text is reproduced in `documentation/gnu-coding-standards.txt` under
the terms of the GNU FDL. Error message format, standard options (`--help`,
`--version`), Makefile targets, and shell scripting rules in
`references/gnu-coding-standards.md` are derived from this document.

## Man Page Conventions
- **UNIX System V man macros:** AT&T / Bell Labs tradition
- **mdoc macros:** BSD tradition, originally Tim Robbins and others
- **groff man(7) reference:** https://man7.org/linux/man-pages/man7/man.7.html
- **groff mdoc(7) reference:** https://man7.org/linux/man-pages/man7/mdoc.7.html

Section ordering, macro usage, and writing style in `references/man-page-format.md`
follow the conventions established by these sources and the Linux man-pages project.

## The Jargon File (Community Edition)
- **Maintainer:** Anthony Giacalone — [agiacalone/jargonfile](https://github.com/agiacalone/jargonfile)
- **Original author:** Eric S. Raymond
- **Online:** https://agiacalone.github.io/jargonfile/
- **License:** see repository

The curated entries in `references/jargon-lore.md` and `references/jargon-terms.md`
are drawn from this source. The full text is reproduced in `documentation/jargon.md`.

---

This skill was assembled to codify these traditions in a form usable by AI-assisted
development workflows. No claim is made to original authorship of the conventions
documented here.
