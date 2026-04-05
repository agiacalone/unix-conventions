# Jargon File Integration Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add the Jargon File (Community Edition) as a fourth canonical source in the unix-conventions skill, providing hacker vocabulary and cultural lore for design reviews.

**Architecture:** A fetch script mirrors `fetch-taoup.sh`, pulling per-letter HTML from GitHub Pages and converting to `documentation/jargon.md`. Two curated reference files (`references/jargon-lore.md`, `references/jargon-terms.md`) are populated by the maintainer from that full text. SKILL.md, README.md, and CREDITS.md are updated to integrate both files.

**Tech Stack:** bash, wget, pandoc, perl (same as `fetch-taoup.sh`)

---

### Task 1: Write fetch-jargon.sh

**Files:**
- Create: `fetch-jargon.sh`

- [ ] **Step 1: Write the script**

```bash
#!/bin/bash
set -euo pipefail

_TMPDIR=$(mktemp -d)
OUT="documentation/jargon.md"
BASE_URL="https://agiacalone.github.io/jargonfile/html"
VERBOSE=0

usage() {
    printf 'Usage: fetch-jargon [-v] [-o FILE]\n'
    printf 'Fetch the Jargon File (Community Edition) and convert it to Markdown.\n'
    printf '\n'
    printf '  -o FILE    write output to FILE (default: documentation/jargon.md)\n'
    printf '  -v         verbose output\n'
    printf '  -h         display this help and exit\n'
    exit 0
}

while getopts 'o:vh' opt; do
    case "$opt" in
        o) OUT="$OPTARG" ;;
        v) VERBOSE=1 ;;
        h) usage ;;
        *) exit 2 ;;
    esac
done

log() { [[ "$VERBOSE" -eq 1 ]] && printf 'fetch-jargon: %s\n' "$*" >&2 || true; }

cleanup() { rm -rf "$_TMPDIR"; }
trap cleanup EXIT

LETTERS="0 A B C D E F G H I J K L M N O P Q R S T U V W X Y Z"

> "$OUT"
for letter in $LETTERS; do
    url="$BASE_URL/$letter.html"
    f="$_TMPDIR/$letter.html"
    log "downloading $letter.html..."
    if wget -q -O "$f" "$url" 2>/dev/null; then
        log "converting $letter.html..."
        pandoc -f html -t commonmark --wrap=none "$f" \
            | perl -0777 -pe 's/<[^>]+>//g; s/\n{3,}/\n\n/g' >> "$OUT"
        printf '\n---\n\n' >> "$OUT"
    else
        printf 'fetch-jargon: warning: could not fetch %s\n' "$url" >&2
    fi
done
```

- [ ] **Step 2: Make executable**

```bash
chmod +x fetch-jargon.sh
```

- [ ] **Step 3: Verify help output exits 0**

```bash
./fetch-jargon.sh -h
echo "exit: $?"
```

Expected: usage printed, `exit: 0`

- [ ] **Step 4: Run the script**

```bash
./fetch-jargon.sh -v -o documentation/jargon.md
```

Expected: verbose output per letter, `documentation/jargon.md` created

- [ ] **Step 5: Sanity-check the output**

```bash
wc -l documentation/jargon.md
grep -c '---' documentation/jargon.md
```

Expected: thousands of lines; `---` separator count roughly equal to number of letter files fetched

- [ ] **Step 6: Commit**

```bash
git add fetch-jargon.sh documentation/jargon.md
git commit -m "feat: add fetch-jargon.sh and generate documentation/jargon.md"
```

---

### Task 2: Create references/jargon-lore.md

**Files:**
- Create: `references/jargon-lore.md`

This file is curated by hand from `documentation/jargon.md`. Do not invent entries.

- [ ] **Step 1: Create the file with header and section structure**

```markdown
# Jargon File — Hacker Lore

Curated from the Jargon File (Community Edition), maintained by Anthony Giacalone.
Source: `documentation/jargon.md`. Do not add entries not present in the source.

## Koans

<!-- Add entries from documentation/jargon.md: Zen koans and aphorisms -->

## Famous Incidents

<!-- Add entries from documentation/jargon.md: notable historical events in hacker culture -->

## Cultural Touchstones

<!-- Add entries from documentation/jargon.md: recurring cultural references, traditions, myths -->

## How to Use This Reference

When a design pattern, failure mode, or cultural situation matches an entry here,
cite it by name in a DESIGN NOTE. Never paraphrase or invent entries.

> "DESIGN NOTE: This mirrors [entry name] from hacker lore — [one-sentence description from the entry]."
```

- [ ] **Step 2: Populate entries from documentation/jargon.md**

Open `documentation/jargon.md` and add entries to each section. Each entry format:

```markdown
### [Entry Name]

[Definition or summary from the Jargon File, verbatim or closely paraphrased]

**Design implication:** [One sentence on when/how to cite this in a review]
```

- [ ] **Step 3: Commit**

```bash
git add references/jargon-lore.md
git commit -m "feat: add references/jargon-lore.md (curated hacker lore)"
```

---

### Task 3: Create references/jargon-terms.md

**Files:**
- Create: `references/jargon-terms.md`

This file is curated by hand from `documentation/jargon.md`. Do not invent entries.

- [ ] **Step 1: Create the file with header and section structure**

```markdown
# Jargon File — Design Vocabulary

Curated from the Jargon File (Community Edition), maintained by Anthony Giacalone.
Source: `documentation/jargon.md`. Do not add entries not present in the source.

## Design Quality — Negative

<!-- kludge, cruft, bletcherous, crufty, wart, creeping featurism, etc. -->

## Design Quality — Positive

<!-- elegant, clean, orthogonal, tasteful, winning, etc. -->

## Complexity Signals

<!-- magic, gnarly, hairy, abstraction inversion, etc. -->

## Interface / API Signals

<!-- losing, brain-damaged, bogus, broken, ill-formed, etc. -->

## Humor and Sarcasm

<!-- FUBAR, SNAFU, bogosity, bogometer, handwave, cargo cult, voodoo programming, etc. -->

## Cultural Terms

<!-- hacker, wizard, guru, hack (good sense), etc. -->

## How to Use This Reference

Apply terms at SUGGESTION level only. They supplement but do not replace
VIOLATION or WARNING entries for actual convention violations.

> "SUGGESTION: This interface is [term] — [definition from entry]. Consider [alternative]."
```

- [ ] **Step 2: Populate entries from documentation/jargon.md**

Open `documentation/jargon.md` and add entries to each section. Each entry format:

```markdown
### [term]

[Definition from the Jargon File, verbatim or closely paraphrased]

**Design implication:** [One sentence on how to apply this term in a review]
```

- [ ] **Step 3: Commit**

```bash
git add references/jargon-terms.md
git commit -m "feat: add references/jargon-terms.md (curated design vocabulary)"
```

---

### Task 4: Update SKILL.md

**Files:**
- Modify: `SKILL.md`

- [ ] **Step 1: Update the Task Dispatch table**

Find this row:
```
| Unix philosophy / design review | `taoup-principles.md`, `worse-is-better.md` |
```

Replace with:
```
| Unix philosophy / design review | `taoup-principles.md`, `worse-is-better.md`, `jargon-lore.md` |
| Code/design quality vocabulary review | `jargon-terms.md`, `taoup-principles.md` |
```

- [ ] **Step 2: Add the Jargon Lore Review checklist**

After the `### Worse is Better Design Review` section, add:

```markdown
### Jargon Lore Review

Loaded for Unix philosophy and design reviews alongside `taoup-principles.md`.
All references must be drawn from `jargon-lore.md` — never invent folklore.

1. When a design pattern matches a known incident or koan in `jargon-lore.md`, cite it by name
2. Format citations as: "DESIGN NOTE: This mirrors [entry] — [one-sentence description]."
3. Use cultural context to explain *why* a pattern is valued or avoided, not just *that* it is
4. Do not invent or paraphrase entries not present in `jargon-lore.md`
```

- [ ] **Step 3: Add the Jargon Terms checklist**

After the Jargon Lore Review section, add:

```markdown
### Jargon Terms Review

Loaded for code/design quality reviews. Use vocabulary from `jargon-terms.md`
to name design smells precisely. Terms appear at SUGGESTION level only.

1. Apply positive/negative quality terms accurately (elegant, kludge, bletcherous, etc.)
2. Terms supplement but do not replace VIOLATION/WARNING entries for convention violations
3. Format as: "SUGGESTION: This design is [term] — [definition]. Consider [alternative]."
4. Never use a term not defined in `jargon-terms.md`
```

- [ ] **Step 4: Verify SKILL.md structure is intact**

```bash
grep -n '###' SKILL.md
```

Expected: all checklist headers present, two new ones at the end

- [ ] **Step 5: Commit**

```bash
git add SKILL.md
git commit -m "feat: integrate Jargon File into SKILL.md task dispatch and checklists"
```

---

### Task 5: Update README.md

**Files:**
- Modify: `README.md`

- [ ] **Step 1: Add jargon-lore.md and jargon-terms.md to the files table**

Find:
```
  man-page-format.md       man page sections, macros, writing style
  worse-is-better.md       Gabriel's four properties and when to apply them
```

Replace with:
```
  man-page-format.md       man page sections, macros, writing style
  worse-is-better.md       Gabriel's four properties and when to apply them
  jargon-lore.md           curated hacker lore: koans, incidents, cultural touchstones
  jargon-terms.md          curated vocabulary: design quality signals and hacker terminology
```

- [ ] **Step 2: Add documentation/jargon.md to the files table**

Find:
```
  taoup.md                 The Art of Unix Programming (full text, Markdown)
```

Replace with:
```
  taoup.md                 The Art of Unix Programming (full text, Markdown)
  jargon.md                The Jargon File, Community Edition (full text, Markdown)
```

- [ ] **Step 3: Add the fetch-jargon.sh section**

After the `## fetch-gnu-standards.sh` section, add:

```markdown
## fetch-jargon.sh

Fetches the Jargon File (Community Edition) from GitHub Pages and converts it to Markdown.

​```
Usage: fetch-jargon [-v] [-o FILE]

  -o FILE    write output to FILE (default: documentation/jargon.md)
  -v         verbose output
  -h         display this help and exit
​```

Requires `wget` and `pandoc`.
```

- [ ] **Step 4: Commit**

```bash
git add README.md
git commit -m "docs: update README for Jargon File integration"
```

---

### Task 6: Update CREDITS.md

**Files:**
- Modify: `CREDITS.md`

- [ ] **Step 1: Add Jargon File attribution**

After the existing `## Man Page Conventions` section and before the closing `---`, add:

```markdown
## The Jargon File (Community Edition)
- **Maintainer:** Anthony Giacalone — [agiacalone/jargonfile](https://github.com/agiacalone/jargonfile)
- **Original author:** Eric S. Raymond
- **Online:** https://agiacalone.github.io/jargonfile/
- **License:** see repository

The curated entries in `references/jargon-lore.md` and `references/jargon-terms.md`
are drawn from this source. The full text is reproduced in `documentation/jargon.md`.
```

- [ ] **Step 2: Commit**

```bash
git add CREDITS.md
git commit -m "docs: add Jargon File attribution to CREDITS.md"
```

---

### Task 7: Update the PR

**Files:**
- `unix-conventions/SKILL.md` in `agiacalone/awesome-claude-skills` fork

- [ ] **Step 1: Copy updated SKILL.md to the fork**

```bash
cp SKILL.md /tmp/awesome-claude-skills-fork/unix-conventions/SKILL.md
```

- [ ] **Step 2: Commit and push**

```bash
cd /tmp/awesome-claude-skills-fork
git add unix-conventions/SKILL.md
git commit -m "feat: add Jargon File lore and terms checklists to SKILL.md"
git push
```

- [ ] **Step 3: Verify PR reflects changes**

```bash
gh pr view 511 --repo travisvn/awesome-claude-skills
```
