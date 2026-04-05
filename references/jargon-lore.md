# Jargon File — Hacker Lore

Curated from the Jargon File (Community Edition), maintained by Anthony Giacalone.
Source: `documentation/jargon.md`. Do not add entries not present in the source.

## Koans

### koan

/koh´an/, n. A Zen teaching riddle. Classically, koans are attractive paradoxes to be
meditated on; their purpose is to help one to enlightenment by temporarily jamming normal
cognitive processing so that something more interesting can happen. Hackers are very fond
of the koan form and compose their own koans for humorous and/or enlightening effect.

**Reach for it when:** A design constraint seems paradoxical or self-defeating. Name
it as a koan rather than forcing a resolution — the tension itself may be informative.

### has the X nature

[from Zen Buddhist koans of the form "Does an X have the Buddha-nature?"] adj. Common
hacker construction for 'is an X', used for humorous emphasis: "Anyone who can't even use
a program with on-screen help embedded in it truly has the loser nature!" See also *the X
that can be Y is not the true X*.

**Reach for it when:** A design decision embodies a category so fully it becomes a
defining example — use this form to signal the property is intrinsic, not incidental.

### ha ha only serious

[from SF fandom, orig. as mutation of HHOK, 'Ha Ha Only Kidding'] A phrase (often
abbreviated HHOS) that aptly captures the flavor of much hacker discourse. Applied
especially to parodies, absurdities, and ironic jokes that are both intended and perceived
to contain a possibly disquieting amount of truth. To take hacker culture either too
lightly or too seriously marks a person as an outsider.

**Reach for it when:** A joking framing (e.g., a reductio ad absurdum of a
design) turns out to reveal a genuine problem. Flag it as HHOS so the reader knows the
humor is load-bearing.

### zen

vt. To figure out something by meditation or by a sudden flash of enlightenment.
Originally applied to bugs, but occasionally applied to problems of life in general.
"How'd you figure out the buffer allocation problem?" "Oh, I zenned it." Contrast *grok*,
which connotes a time-extended version of zenning a system.

**Reach for it when:** A review leads to a sudden realization about a design's
structure — introduce it as a zen moment to signal the insight is intuitive but real,
not derived from a checklist.

## Famous Incidents

### Great Worm

The 1988 Internet worm perpetrated by RTM (Robert Tappan Morris). This is a play on
Tolkien; in his Middle Earth books, two dragons powerful enough to lay waste to entire
regions were known as "the Great Worms." This usage expresses that the RTM crack was a
devastating watershed event in hacker history — it did more to make non-hackers nervous
about the Internet than anything before or since. Morris's username on ITS was hacked from
RTM to RTFM after the incident.

**Reach for it when:** Writing about security-critical code where a small mistake
could have disproportionate, irreversible consequences — "This has Great Worm potential."

### Great Renaming

The flag day in 1987 on which all non-local groups on Usenet had their names changed from
the `net.-` format to the current multiple-hierarchies scheme. Used in discussing the
history of newsgroup names. "The oldest sources group is `comp.sources.misc`; before the
Great Renaming, it was `net.sources`."

**Reach for it when:** A rename or namespace reorganization will break existing
references or tooling — a Great Renaming needs a migration plan and a clear flag day.

### Great Internet Explosion

The mainstreaming of the Internet in 1993–1994. Before it, Internet access was expensive
and available only to an elite few through universities, research labs, and well-heeled
corporations; after it, everybody's mother had access. Used in time comparatives: "before
the Great Internet Explosion and after it were very different worlds from a hacker's point
of view."

**Reach for it when:** A system designed for a small trusted community is being
opened to a much larger, less technically sophisticated audience — the design assumptions
may need fundamental revision.

### Halloween Documents

A pair of Microsoft internal strategy memoranda leaked to ESR in late 1998 that confirmed
everybody's paranoia about the then-current Evil Empire. These documents praised the
technical excellence of Linux and outlined a counterstrategy of attempting to lock in
customers by "de-commoditizing" Internet protocols and services. They were extensively
cited on the Internet and in the press.

**Reach for it when:** Writing about a proprietary extension to an open protocol or
standard — deliberate de-commoditization is a documented strategy, not paranoia.

### ITS

Incompatible Time-sharing System, an influential though highly idiosyncratic operating
system written for PDP-6s and PDP-10s at MIT and long used at the MIT AI Lab. Much
AI-hacker jargon derives from ITS folklore, and to have been 'an ITS hacker' qualifies
one instantly as an old-timer of the most venerable sort. The shutdown of the lab's last
ITS machine in May 1990 sent old-time hackers into mourning nationwide.

**Reach for it when:** A beloved system is being decommissioned and its
institutional knowledge is at risk of being lost — the ITS shutdown is the canonical
example of culture lost with a platform.

## Cultural Touchstones

### foo

/foo/ The first on the standard list of metasyntactic variables used in syntax examples.
The word has a convoluted history tracing back to the *Smokey Stover* comic strip of the
1930s, WWII military slang, TMRC at MIT, and FUBAR. The TMRC dictionary (1959) defined
it as the first syllable of the Tibetan chant "FOO MANE PADME HUM." See also *bar*,
*baz*, *qux*, *foobar*.

**Reach for it when:** You need throwaway example names in specs and docs.
Using domain-specific names implies meaning where none is intended.

### bar / baz / foobar / quux

**bar** /bar/: The second metasyntactic variable, after *foo* and before *baz*. "Suppose we
have two functions: FOO and BAR. FOO calls BAR...."

**baz** /baz/: The third metasyntactic variable. Also used as a mild interjection of
annoyance, sometimes drawn out (/baaaaaaz/) for effect.

**foobar** /foo´bar/: [very common] Another widely used metasyntactic variable; the
combination of *foo* and *bar*. Propagated early through DEC manuals. Hackers do not
generally use this to mean FUBAR.

**quux** /kwuhks/: The fourth metasyntactic variable, after foo/bar/baz. Invented by Guy
Steele. Also used as a mild interjection.

The canonical sequence is foo → bar → baz → quux → foobar. Use them in that order for
throwaway names; mixing in domain-specific terms for the first few examples muddies what
is and isn't meaningful.

### RTFM

/R·T·F·M/, imp. [Unix] "Read The Fucking Manual."

1. Used by gurus to brush off questions they consider trivial or annoying — the implication
   being that the answer is already written down somewhere the asker hasn't bothered to look.

2. Used (politely) when *reporting* a problem to signal that you have already done your
   homework: "I can't get this to link, and yes, I have RTFM."

Variants: RTFS ("Read The Fucking Source") when the manual doesn't exist or doesn't help;
RTFB ("Read The Fucking Book") for published references.

**Reach for it when:** Writing about the expectation that users or contributors will do
basic research before escalating — "RTFM culture" is a recognizable shorthand for a
community that values self-sufficiency.

### hacker ethic

1. The belief that information-sharing is a powerful positive good, and that it is an
   ethical duty of hackers to share their expertise by writing open-source code and
   facilitating access to information and computing resources wherever possible.

2. The belief that system-cracking for fun and exploration is ethically OK as long as the
   cracker commits no theft, vandalism, or breach of confidentiality.

The most reliable manifestation is that almost all hackers are actively willing to share
technical tricks, software, and (where possible) computing resources with other hackers.

**Reach for it when:** A design decision around access control or information
hiding conflicts with the culture of openness — name the tension explicitly.

### BOFH

//, n. Acronym: Bastard Operator From Hell. A system administrator with absolutely no
tolerance for lusers. "You say you need more filespace? Seems to me you have plenty
left..." Many BOFHs hang out in `alt.sysadmin.recovery`. The canonical BOFH stories are
by Simon Travaglia.

**Reach for it when:** A design gives administrators unchecked, opaque power
over users with no accountability — the BOFH pattern is a known failure mode.

### cargo cult programming

A style of (incompetent) programming dominated by ritual inclusion of code or structures
that serve no real purpose. A cargo cult programmer will usually explain the extra code as
working around some past bug, but neither the bug nor the reason the code apparently
avoided it was ever fully understood. The term derives from Richard Feynman's
characterization of certain practices as "cargo cult science."

**Reach for it when:** Code includes unexplained workarounds, defensive checks
against impossible conditions, or copy-pasted boilerplate with no rationale —
a Unix person will recognize the pattern immediately.

### cathedral

n.,adj. The 'classical' mode of software engineering: small teams, tight project control,
long release intervals. This term came into use after analysis of the Linux experience
suggested there might be something wrong (or at least incomplete) in the classical
assumptions. Contrast *bazaar*.

**Reach for it when:** Writing about a project's development model — cathedral
assumptions (trusted inner circle, infrequent releases) require explicit justification
when the problem domain or community has changed.

### bazaar

n.,adj. The Linux kernel development model: release early and often, delegate everything
you can, be open to the point of promiscuity. Popularized by ESR's essay "The Cathedral
and the Bazaar." The bazaar model assumes that "given enough eyeballs, all bugs are
shallow" (*Linus's Law*).

**Reach for it when:** A project is considering open-sourcing or moving to
community-driven development — the bazaar model requires different interface stability and
documentation norms than the cathedral model.

## Origin Stories

### TMRC

The Tech Model Railroad Club at MIT, one of the wellsprings of hacker culture. The 1959
*Dictionary of the TMRC Language* compiled by Peter Samson included several terms that
became basics of the hackish vocabulary — including *foo*, *mung*, and *frob*. TMRC's
Signals and Power Committee included many of the early PDP-1 hackers and the people who
later became the core of the MIT AI Lab. When the scram switches on the legendary layout
were triggered, the digital clock stopped and was replaced with the word 'FOO'; these are
still called foo switches. The layout was decommissioned in 1998 before the demolition of
MIT Building 20.

**Reach for it when:** Grounding a discussion of where hacker vocabulary and culture
actually came from — not a mythology, but a documented lineage from a model railroad club
to the AI Lab to Unix.

### physical hacking / vadding

**Hack** (MIT sense): To explore the basements, roof ledges, and steam tunnels of a large
institutional building — to the dismay of Physical Plant workers and Campus Police. The
Jargon File notes the activity is "eerily similar to playing Dungeons and Dragons or Zork."

**Vadding** /vad´ing/: The same activity, named for VAD (a permutation of ADV, the
filename of the game *Adventure*, used to avoid an admin's search-and-destroy sweeps for
it). Some vadders learn locksmithing to synthesize keys. The extreme form is *elevator
rodeo* — wrangling a thousand-pound elevator car with a piece of string and then
"exploiting this mastery in various stimulating ways." At MIT the older term *hacking* is
still used for this.

**Reach for it when:** Writing about the exploratory, boundary-testing spirit of hacker
culture — the same impulse that drives someone to read kernel source or test an API's
undocumented limits drives someone to find what's behind the locked door in the basement.

## Hacker Psychology

### hack mode

n. The Zen-like state of total focus on The Problem achieved when deep in a hacking
session. "More specifically, a Zen-like state of total focus on The Problem that may be
achieved when one is hacking (this is why every good hacker is part mystic). Ability to
enter such concentration at will correlates strongly with wizardliness; it is one of the
most important skills learned during larval stage."

Being yanked out of hack mode is experienced as a physical shock. Hacker etiquette
accommodates this: it is acceptable to hold up a hand to an arriving visitor, without
turning from the screen, and continue coding for quite some time before acknowledging
their presence. The understanding is that you may have a lot of delicate state in your
head that you dare not swap out before reaching a good stopping point.

**Reach for it when:** Explaining why interruptions are genuinely costly to programmers,
or why open offices and hacker culture are at odds — *hack mode* names the phenomenon
precisely and the tradition behind it.

### larval stage

n. A period of monomaniacal concentration on coding apparently passed through by all
fledgling hackers. Common symptoms: more than one 36-hour hacking run per week, neglect
of food and sleep, advanced bleary-eye. Duration: 6 months to 2 years, median around 18
months. "The ordeal seems to be necessary to produce really wizardly (as opposed to merely
competent) programmers." A shorter version (about a month) recurs when learning a new
language or OS.

**Reach for it when:** Writing about the development of expertise — the larval stage is
the canonical account of how someone goes from competent to wizard, and it's more honest
than most learning-curve metaphors.

### Real Programmer

n. A particular sub-variety of hacker: one possessed of a flippant attitude toward
complexity that is arrogant even when justified by experience. The Real Programmer programs
on the bare metal, remembers binary opcodes for every machine they've ever used, considers
HLLs sissy, and uses a debugger to edit code because editors are for wimps. "Real
Programmers never use comments or write documentation: 'If it was hard to write, it should
be hard to understand.'" Their code can awe with its fiendish brilliance even as its
crockishness appalls. The canonical portrait is *The Story of Mel* in `documentation/jargon.md`.

**Reach for it when:** Writing about the tension between craft and maintainability, or
between heroic individual brilliance and sustainable engineering — the Real Programmer
archetype is the extreme case that illuminates both sides.

### The Story of Mel

Posted to Usenet by Ed Nather on May 21, 1983. The canonical account of a Real Programmer:
Mel wrote the blackjack demo for the Royal McBee LGP-30 in raw hexadecimal machine code,
directly on a drum-memory computer. He didn't use an assembler because "an assembler
program would have to have been written in machine code anyway, so what was the point?" His
crowning achievement was an inner loop that exploited the rotational latency of the drum
to place the next instruction precisely where the read head would land — the program
optimized itself by virtue of where its instructions lived in memory. When Nather finally
found the loop while trying to add a feature, he discovered it had no exit condition.
The loop ran forever, or until the power went out. Mel had considered that acceptable.

The story is not about bad programming. It is about a kind of mastery so deep it becomes
alien — code that was correct, efficient, and utterly ungrokable by anyone who hadn't
lived inside the same machine. It ends: "I was awed. To think that, while writing his
program, Mel had thought of the right thing to do — not just thought of it, but coded it —
in such a way that it worked, in hardware that didn't exist yet... I take back every bad
thing I ever said about Real Programmers."

Full text in `documentation/jargon.md` under Appendices.

**Reach for it when:** Writing about the outer edge of technical mastery, or the moment
when cleverness crosses into inscrutability — every hacker knows the story and will
understand the reference immediately.

### OS and JEDGAR

A story about the ITS ethos at the MIT AI Lab. ITS had a program called OS — not
Operating System, but *Output Spy* — that let any user watch what was being printed on
anyone else's terminal, by examining the insides of the monitor system. ITS was designed
with almost no protection between users; surveillance was symmetric.

JEDGAR (/jed´gr/, named after J. Edgar Hoover) was the counterspy: it watched the OS
internals for anyone watching your output and notified you. If you gave it "license to
kill," it would terminate the job of whoever was spying on you. This made life too violent,
especially when tourists discovered it. A systems hacker eventually replaced JEDGAR with a
program that only *pretended* to do its job — every copy had to be patched, and to this day
no one knows how many people never realized JEDGAR had been defanged.

Full text in `documentation/jargon.md` under Appendices.

**Reach for it when:** Writing about surveillance, transparency, and the assumptions baked
into a system's design — ITS's symmetric openness (anyone can watch anyone) produced both
OS and JEDGAR, and the story illustrates how access-control philosophy shapes culture.

## How to Use This Reference

Use this for cultural context — to explain things in terms Unix people and hackers will
immediately recognize, or to write documentation that feels at home in the tradition.
Mentioning that a design repeats the mistakes of "cargo cult programming" or echoes the
"SNAFU principle" communicates something that a purely technical description misses.

This lore is worth preserving. The stories, incidents, and touchstones here accumulated
over decades of a community working at the frontier of computing. As that community
disperses and AI-generated text fills more of the written record, the specific texture of
hacker culture — the jokes, the incidents, the way things were named — is at genuine risk
of being flattened into generic "tech history." Using this vocabulary and invoking these
stories keeps the tradition alive in the work.

For anything not covered here, the full Jargon File is in `documentation/jargon.md`.
Don't invent or misremember entries — the Jargon File is authoritative.
