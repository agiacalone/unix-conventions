# Jargon File Integration — Design Spec

**Date:** 2026-04-04
**Status:** Approved

## Summary

Incorporate the Community Edition of the Jargon File (`agiacalone/jargonfile`) into the unix-conventions skill as a fourth reference source, covering hacker vocabulary and cultural lore.

## Motivation

The Jargon File is the canonical record of hacker culture, vocabulary, and folklore. It complements TAOUP, POSIX, and the GNU Coding Standards by providing:

- **Cultural grounding** — famous incidents, koans, and folklore that explain *why* Unix traditions exist
- **Design vocabulary** — precise terms (kludge, cruft, bletcherous, elegant) for naming design quality signals during review

The cultural/lore dimension is considered the primary value for this skill.

## Artifacts

### New Files

| File | Purpose |
|------|---------|
| `fetch-jargon.sh` | Fetches HTML from `agiacalone.github.io/jargonfile/html/`, converts letter files to Markdown, writes `documentation/jargon.md` |
| `documentation/jargon.md` | Full converted Jargon File text; not loaded at runtime; used for verification and as source for curation |
| `references/jargon-lore.md` | **Primary**: curated koans, famous incidents, hacker folklore, cultural touchstones |
| `references/jargon-terms.md` | **Secondary**: curated vocabulary entries with definitions and design implications |

### Modified Files

| File | Change |
|------|--------|
| `SKILL.md` | New task dispatch rows; new checklist sections for lore and terms |
| `README.md` | Add `fetch-jargon.sh` section; add `documentation/jargon.md` and both reference files to files table |
| `CREDITS.md` | Add Jargon File attribution |

## fetch-jargon.sh

Modeled directly on `fetch-taoup.sh`. Fetches per-letter HTML files (`0.html`, `A.html` … `Z.html`) from `https://agiacalone.github.io/jargonfile/html/`, converts each with `pandoc -f html -t commonmark`, concatenates to output file.

Flags: `-v` (verbose), `-o FILE` (output, default: `documentation/jargon.md`), `-h` (help).
Requires: `wget`, `pandoc`.

## Reference File Content Policy

Both `references/jargon-lore.md` and `references/jargon-terms.md` are hand-curated from `documentation/jargon.md` — never generated or written from model memory. Anthony (maintainer of the Community Edition) is the authoritative reviewer for all entries.

- `jargon-lore.md`: koans, famous incidents, and cultural touchstones drawn directly from the Jargon File text
- `jargon-terms.md`: vocabulary entries covering design quality (positive and negative), complexity signals, interface signals, humor/sarcasm, and cultural terms

## SKILL.md Changes

### Task Dispatch (additions)

| Task | References to load |
|------|--------------------|
| Unix philosophy / design review | `taoup-principles.md`, `worse-is-better.md`, `jargon-lore.md` |
| Code/design quality vocabulary review | `jargon-terms.md`, `taoup-principles.md` |

### New Checklist: Jargon Lore Review

Loaded alongside `taoup-principles.md` for philosophy and design reviews. The skill uses lore entries to provide cultural context — e.g., connecting a design pattern to a known incident or koan. All references must be drawn from `jargon-lore.md`; the skill must not invent folklore.

### New Checklist: Jargon Terms Review

Loaded for code/design quality reviews. The skill uses vocabulary entries to name design smells precisely. Terms may appear in SUGGESTION-level findings; they must not replace structured VIOLATION/WARNING entries for actual convention violations.

## CREDITS.md Addition

```
## The Jargon File (Community Edition)
- Maintainer: Anthony Giacalone (agiacalone/jargonfile)
- Original: Eric S. Raymond
- Online: https://agiacalone.github.io/jargonfile/
- License: see repository
```

## What Is Not In Scope

- Automated filtering or tagging of Jargon entries — curation is manual
- Loading `documentation/jargon.md` at runtime — too large; references files only
- Inventing or paraphrasing Jargon entries not present in the fetched text
