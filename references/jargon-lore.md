# Jargon File — Hacker Lore

Curated from the Jargon File (Community Edition), maintained by Anthony Giacalone.
Source: `documentation/jargon.md`. Do not add entries not present in the source.

## Koans

### koan

/koh´an/, n. A Zen teaching riddle. Classically, koans are attractive paradoxes to be
meditated on; their purpose is to help one to enlightenment by temporarily jamming normal
cognitive processing so that something more interesting can happen. Hackers are very fond
of the koan form and compose their own koans for humorous and/or enlightening effect.

**Design implication:** When a design constraint seems paradoxical or self-defeating, name
it as a koan rather than forcing a resolution — the tension itself may be informative.

### has the X nature

[from Zen Buddhist koans of the form "Does an X have the Buddha-nature?"] adj. Common
hacker construction for 'is an X', used for humorous emphasis: "Anyone who can't even use
a program with on-screen help embedded in it truly has the loser nature!" See also *the X
that can be Y is not the true X*.

**Design implication:** When a design decision embodies a category so fully it becomes a
defining example, cite it with this form to signal that the property is intrinsic, not
incidental.

### ha ha only serious

[from SF fandom, orig. as mutation of HHOK, 'Ha Ha Only Kidding'] A phrase (often
abbreviated HHOS) that aptly captures the flavor of much hacker discourse. Applied
especially to parodies, absurdities, and ironic jokes that are both intended and perceived
to contain a possibly disquieting amount of truth. To take hacker culture either too
lightly or too seriously marks a person as an outsider.

**Design implication:** Use when a joking framing (e.g., a reductio ad absurdum of a
design) turns out to reveal a genuine problem — flag it as HHOS so the reader knows the
humor is load-bearing.

### zen

vt. To figure out something by meditation or by a sudden flash of enlightenment.
Originally applied to bugs, but occasionally applied to problems of life in general.
"How'd you figure out the buffer allocation problem?" "Oh, I zenned it." Contrast *grok*,
which connotes a time-extended version of zenning a system.

**Design implication:** When a review leads to a sudden realization about a design's
structure rather than a checklist finding, introduce it as a zen moment to signal the
insight is intuitive but real.

## Famous Incidents

### Great Worm

The 1988 Internet worm perpetrated by RTM (Robert Tappan Morris). This is a play on
Tolkien; in his Middle Earth books, two dragons powerful enough to lay waste to entire
regions were known as "the Great Worms." This usage expresses that the RTM crack was a
devastating watershed event in hacker history — it did more to make non-hackers nervous
about the Internet than anything before or since. Morris's username on ITS was hacked from
RTM to RTFM after the incident.

**Design implication:** Cite when reviewing security-critical code where a small mistake
could have disproportionate, irreversible consequences — "This has Great Worm potential."

### Great Renaming

The flag day in 1987 on which all non-local groups on Usenet had their names changed from
the `net.-` format to the current multiple-hierarchies scheme. Used in discussing the
history of newsgroup names. "The oldest sources group is `comp.sources.misc`; before the
Great Renaming, it was `net.sources`."

**Design implication:** Cite when a rename or namespace reorganization will break existing
references or tooling — a Great Renaming needs a migration plan and a clear flag day.

### Great Internet Explosion

The mainstreaming of the Internet in 1993–1994. Before it, Internet access was expensive
and available only to an elite few through universities, research labs, and well-heeled
corporations; after it, everybody's mother had access. Used in time comparatives: "before
the Great Internet Explosion and after it were very different worlds from a hacker's point
of view."

**Design implication:** Cite when a system designed for a small trusted community is being
opened to a much larger, less technically sophisticated audience — the design assumptions
may need fundamental revision.

### Halloween Documents

A pair of Microsoft internal strategy memoranda leaked to ESR in late 1998 that confirmed
everybody's paranoia about the then-current Evil Empire. These documents praised the
technical excellence of Linux and outlined a counterstrategy of attempting to lock in
customers by "de-commoditizing" Internet protocols and services. They were extensively
cited on the Internet and in the press.

**Design implication:** Cite when reviewing a proprietary extension to an open protocol or
standard — deliberate de-commoditization is a documented strategy, not paranoia.

### ITS

Incompatible Time-sharing System, an influential though highly idiosyncratic operating
system written for PDP-6s and PDP-10s at MIT and long used at the MIT AI Lab. Much
AI-hacker jargon derives from ITS folklore, and to have been 'an ITS hacker' qualifies
one instantly as an old-timer of the most venerable sort. The shutdown of the lab's last
ITS machine in May 1990 sent old-time hackers into mourning nationwide.

**Design implication:** Cite when a beloved system is being decommissioned and its
institutional knowledge is at risk of being lost — the ITS shutdown is the canonical
example of culture lost with a platform.

## Cultural Touchstones

### foo

/foo/ The first on the standard list of metasyntactic variables used in syntax examples.
The word has a convoluted history tracing back to the *Smokey Stover* comic strip of the
1930s, WWII military slang, TMRC at MIT, and FUBAR. The TMRC dictionary (1959) defined
it as the first syllable of the Tibetan chant "FOO MANE PADME HUM." See also *bar*,
*baz*, *qux*, *foobar*.

**Design implication:** Use `foo`/`bar`/`baz` for throwaway example names in specs and
docs. Using domain-specific names for examples implies meaning where none is intended.

### hacker ethic

1. The belief that information-sharing is a powerful positive good, and that it is an
   ethical duty of hackers to share their expertise by writing open-source code and
   facilitating access to information and computing resources wherever possible.

2. The belief that system-cracking for fun and exploration is ethically OK as long as the
   cracker commits no theft, vandalism, or breach of confidentiality.

The most reliable manifestation is that almost all hackers are actively willing to share
technical tricks, software, and (where possible) computing resources with other hackers.

**Design implication:** Cite when a design decision around access control or information
hiding conflicts with the culture of openness — name the tension explicitly.

### BOFH

//, n. Acronym: Bastard Operator From Hell. A system administrator with absolutely no
tolerance for lusers. "You say you need more filespace? Seems to me you have plenty
left..." Many BOFHs hang out in `alt.sysadmin.recovery`. The canonical BOFH stories are
by Simon Travaglia.

**Design implication:** Cite when a design gives administrators unchecked, opaque power
over users with no accountability — the BOFH pattern is a known failure mode.

### cargo cult programming

A style of (incompetent) programming dominated by ritual inclusion of code or structures
that serve no real purpose. A cargo cult programmer will usually explain the extra code as
working around some past bug, but neither the bug nor the reason the code apparently
avoided it was ever fully understood. The term derives from Richard Feynman's
characterization of certain practices as "cargo cult science."

**Design implication:** Cite when reviewing code that includes unexplained workarounds,
defensive checks against impossible conditions, or copy-pasted boilerplate with no
rationale — name the pattern directly.

### cathedral

n.,adj. The 'classical' mode of software engineering: small teams, tight project control,
long release intervals. This term came into use after analysis of the Linux experience
suggested there might be something wrong (or at least incomplete) in the classical
assumptions. Contrast *bazaar*.

**Design implication:** Cite when reviewing a project's development model — cathedral
assumptions (trusted inner circle, infrequent releases) require explicit justification
when the problem domain or community has changed.

### bazaar

n.,adj. The Linux kernel development model: release early and often, delegate everything
you can, be open to the point of promiscuity. Popularized by ESR's essay "The Cathedral
and the Bazaar." The bazaar model assumes that "given enough eyeballs, all bugs are
shallow" (*Linus's Law*).

**Design implication:** Cite when a project is considering open-sourcing or moving to
community-driven development — the bazaar model requires different interface stability and
documentation norms than the cathedral model.

## How to Use This Reference

When a design pattern, failure mode, or cultural situation matches an entry here,
cite it by name in a DESIGN NOTE. Never invent folklore.

Prefer entries defined here (pre-curated with design implications). For anything not
covered, look it up in `documentation/jargon.md` — do not cite from memory.

> "DESIGN NOTE: This mirrors [entry name] from hacker lore — [one-sentence description from the entry]."
