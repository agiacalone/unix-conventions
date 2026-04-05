# Jargon File — Design Vocabulary

Curated from the Jargon File (Community Edition), maintained by Anthony Giacalone.
Source: `documentation/jargon.md`. Do not add entries not present in the source.

## Design Quality — Negative

### kludge / kluge

**kludge** /kluhj/: An ill-assorted collection of poorly matching parts, forming a
distressing whole; something that works (sense 2: a crock that works). v. To use a kludge
to get around a problem.

**kluge** /klooj/: 1. A Rube Goldberg device, whether in hardware or software. 2. A
clever programming trick intended to solve a particular nasty case in an expedient, if not
clear, manner. 3. Something that works for the wrong reason. 5. [WPI] A feature that is
implemented in a rude manner.

Note: 'kluge' has positive connotations (clever, expedient); 'kludge' does not.

**Design implication:** Use *kludge* for an ugly-but-working fix with no positive spin;
use *kluge* when expedience was at least intentional. Either warrants a comment explaining
what was worked around and why a clean fix was deferred.

### cruft / crufty

**cruft** /kruhft/: 1. The results of shoddy construction. 4. Excess; superfluous junk;
used esp. of redundant or superseded code. (Also: the dust under your bed that multiplies
when you try to remove it.)

**crufty** /kruhf´tee/: 1. Poorly built, possibly over-complex. 2. Unpleasant, especially
to the touch, often with encrusted junk. 3. Generally unpleasant.

**Design implication:** Apply to code that has accumulated patches, dead branches, or
superseded structures. "SUGGESTION: This module is crufty — [specific issue]. Consider
extracting or deleting [what]."

### bletcherous

/blech'@·r@s/, adj. Disgusting in design or function; esthetically unappealing. Applies
to aesthetics of a thing, not objective criteria; contrast *losing* (fails to meet
criteria) and *bogus* (false/incorrect). "This keyboard is bletcherous!"

**Design implication:** Use for interface or structural decisions that are viscerally
off-putting even if technically functional — names, layout, calling conventions that
cause a double-take.

### brain-damaged

adj. 1. Obviously wrong; demented. There is an implication that the person responsible
must have suffered brain damage, because they should have known better. Implies the design
is unusable and its failure is due to poor design rather than accident. "Only six monocase
characters per file name? Now *that's* brain-damaged!" 2. [Mac world] Deliberately
crippled demo software.

**Design implication:** Use for design decisions with no plausible rationale — harder than
*bletcherous* (aesthetic) or *losing* (failing); *brain-damaged* implies the designer
actively chose wrong.

### creeping featurism

/kree´ping fee´chr·izm/, n. 1. A systematic tendency to load more chrome and features onto
systems at the expense of whatever elegance they originally had. 2. The tendency for
anything complicated to become more complicated because people keep saying "Gee, it would
be even better if it had this feature too." The result is usually a patchwork because it
grew one ad-hoc step at a time. When it gets out of hand, it's like a cancer.

**Design implication:** Cite when reviewing a change request that adds a fourth special
case to a three-special-case system, or when a configuration file has grown beyond
comprehension.

### misfeature

/mis·fee´chr/, n. A feature that eventually causes lossage, possibly because it is not
adequate for a new situation that has evolved. Not a bug (it was deliberately and properly
implemented); not a simple side effect (it was carefully planned). The long-term
consequences were not accurately predicted. "Well, yeah, it is kind of a misfeature that
file names are limited to six characters, but the original implementors wanted to save
directory space and we're stuck with it for now."

**Design implication:** Cite when a well-intentioned design decision has become a burden
— distinct from a bug fix (the logic is correct) and from cruft (it was planned). A
misfeature requires a philosophical change to resolve.

### wart

n. A small, crufty feature that sticks out of an otherwise clean design. Something
conspicuous for localized ugliness, esp. a special-case exception to a general rule. "In
some versions of csh(1), single quotes literalize every character inside them except `!`."
In ANSI C, the `??` trigraph syntax is a wart.

**Design implication:** Name a specific wart by its behavior, not just its presence:
"SUGGESTION: The `--no-verify` flag is a wart — it breaks the otherwise clean pipeline
model. Consider [alternative]."

## Design Quality — Positive

### elegant

adj. [common; from mathematical usage] Combining simplicity, power, and a certain
ineffable grace of design. Higher praise than 'clever', 'winning', or even 'cuspy'.

Antoine de Saint-Exupéry: "A designer knows he has achieved perfection not when there is
nothing left to add, but when there is nothing left to take away."

**Design implication:** The highest term of praise. Reserve it for designs where removing
any piece would break the whole — not just clean, but irreducible.

### clean

adj. Implies 'elegance in the small': a design or implementation that may not hold any
surprises but does things in a way that is reasonably intuitive and relatively easy to
comprehend from the outside. The antonym is 'grungy' or *crufty*.

**Design implication:** A lower bar than *elegant* — correct, unsurprising, comprehensible.
Appropriate for most positive assessments of straightforward code.

### orthogonal

adj. [from mathematics] Mutually independent; well separated; sometimes, irrelevant to.
Used to describe sets of primitives or capabilities that span the entire capability space
of a system and are non-overlapping. For example, the register set of the PDP-11 is
orthogonal because all registers can be used interchangeably in any role. The set {not,
or} is orthogonal; {nand, or, not} is not.

**Design implication:** Cite when a proposed interface adds a function that is a
composition of existing ones — "SUGGESTION: This flag is not orthogonal to `--foo` and
`--bar`; consider whether the combination should be a separate command."

### hack value

n. Often adduced as the reason or motivation for expending effort toward a seemingly
useless goal, the point being that the accomplished goal is a hack. For example, MacLISP
had features for reading and printing Roman numerals, which were installed purely for hack
value. As Louis Armstrong said when asked to explain jazz: "Man, if you gotta ask you'll
never know."

**Design implication:** When a feature has no practical use but demonstrates mastery or
wit, name it: "SUGGESTION: This is pure hack value — no user need, but worth preserving
as an example of [what]."

## Complexity Signals

### magic

adj./n. 1. As yet unexplained, or too complicated to explain. "TTY echoing is controlled
by a large number of magic bits." 2. Characteristic of something that works although no
one really understands why. 3. [Stanford] A feature not generally publicized that allows
something otherwise impossible. 4. The ultimate goal of all engineering: elegance in the
extreme; from Clarke's Third Law: "Any technology distinguishable from magic is
insufficiently advanced."

**Design implication:** "Magic bits" or "magic numbers" in code are a smell — unexplained
constants need names. Distinguish from sense 4 (deliberate, documented, transcendent).

### deep magic

n. An awesomely arcane technique central to a program or system, esp. one neither
generally published nor available to hackers at large; one that could only have been
composed by a true wizard. Trades on arcane *theoretical* knowledge. Compiler optimization
techniques and aspects of OS design used to be deep magic; many cryptography, signal
processing, and AI techniques still are. Found in comments: "Deep magic begins here..."

**Design implication:** When code depends on deep magic, document it explicitly — who
wrote it, what property it relies on, and what would break if changed. Deep magic should
not be touched without the relevant wizard.

### heavy wizardry

n. Code or designs that trade on particularly intimate knowledge or experience of a
specific OS, language, or complex application interface. Distinguished from *deep magic*
(which trades on arcane theoretical knowledge) — heavy wizardry is about operational
intimacy, not theory. Writing device drivers is heavy wizardry; so is interfacing to X
without a toolkit. Found in comments: "Heavy wizardry begins here."

**Design implication:** Flag sections that require a specific expert; document *which*
system knowledge is required, not just that it's complex.

### hairy

adj. 1. Annoyingly complicated. 2. Incomprehensible. "[DWIM] is incredibly hairy." Also
used of people: high-powered, authoritative, expert, and/or incomprehensible. In British
usage, "hairy" means dangerous — so hairy code there is complicated *and* risky.

**Design implication:** Hairy code is a maintenance risk; cite it to justify adding
explanatory comments or a simplified wrapper.

### gnarly

/nar´lee/, adj. Both *obscure* and *hairy* (complicated). From surfer slang. "[Yow!] the
tuned assembler implementation of BitBlt is really gnarly!"

**Design implication:** Stronger than *hairy* alone — gnarly means you can't easily
explain it even if you wrote it. Gnarly code requires a dedicated comment block before it,
not just inline notes.

### voodoo programming

n. 1. The use by guess or cookbook of an obscure or hairy system, feature, or algorithm
that one does not truly understand. The implication is that the technique may not work,
and if it doesn't, one will never know why. 2. Things programmers do that they know
shouldn't work but try anyway, and which sometimes actually work, such as recompiling
everything.

**Design implication:** Cite when a code review reveals copy-pasted incantations with no
rationale. Distinct from *cargo cult programming* (ritual repetition) — voodoo programming
includes active guessing. Both are warning signs in production code.

## Interface / API Signals

### bogus

adj. 1. Non-functional. 2. Useless. 3. False. 4. Incorrect. 5. Unbelievable. 6. Silly.
"Your patches are bogus." "That algorithm is bogus." "You claim to have solved the halting
problem? That's totally bogus."

**Design implication:** The general-purpose pejorative. Use in SUGGESTION: "This API
contract is bogus — [what it claims] vs. [what it actually does]."

### losing

adj. Said of anything that is or causes a *lose* or *lossage*. "The compiler is losing
badly when I try to use templates."

**Design implication:** Use for designs that actively fail to meet their stated purpose —
not just ugly (*bletcherous*) but functionally deficient.

### brain-damaged

(see Design Quality — Negative above; also applies at the interface level)

"Only six monocase characters per file name? Now *that's* brain-damaged!" — an interface
constraint so wrong that the designer must have suffered brain damage.

### broken

adj. 1. Not working according to design (neutral, no blame). 2. Improperly designed —
carries the implication that the designer should have known better. 3. Behaving strangely.

**Design implication:** Distinguish sense 1 (bug) from sense 2 (design error). A *broken*
interface in sense 2 is harder to fix than a bug because it requires a compatibility break.

### considered harmful

adj. From Dijkstra's 1968 letter "Goto Statement Considered Harmful" (CACM, March 1968).
Now a productive suffix: any construction of the form *X Considered Harmful* asserts that
X is a design practice whose costs outweigh its benefits. The form has been used both
seriously and as parody since the 1970s.

**Design implication:** When citing this pattern, be specific about *why* the practice is
harmful and under what conditions, not just that it has a bad reputation.

## Humor and Sarcasm

### bogosity

/boh·go´s@·tee/, n. The degree to which something is *bogus*. Bogosity is measured with a
*bogometer*; in a seminar, when a speaker says something bogus, a listener might say "My
bogometer just triggered." "You just pinned my bogometer" means you said something so
outrageously bogus it pegged the scale. The agreed-upon unit of bogosity is the microLenat.

**Design implication:** Use informally in reviews to signal that a claim deserves scrutiny:
"This pegs my bogometer — what's the actual benchmark?"

### bogometer

/boh·gom'·@t·er/, n. A notional instrument for measuring bogosity. Compare the Troll-O-Meter.

**Design implication:** The instrument metaphor is useful when a review finding is
qualitative: "My bogometer triggers on the retry-forever loop — it needs a bound."

### SNAFU principle

/sna´foo prin´si·pl/, n. [from WWII Army acronym 'Situation Normal, All Fucked Up'] "True
communication is possible only between equals, because inferiors are more consistently
rewarded for telling their superiors pleasant lies than for telling the truth." A central
tenet of Discordianism. The effect of the SNAFU principle is a progressive disconnection
of decision-makers from reality.

**Design implication:** Cite in post-mortems where a known problem was not escalated:
"This is SNAFU principle in action — the team knew about the issue but had no safe path to
report it."

### handwave

/hand´wayv/, v./n. To gloss over a complex point; to distract a listener; to support a
(possibly actually valid) point with blatantly faulty logic. "Boy, what a handwave!" If
someone starts a sentence with "Clearly..." or "Obviously..." or "It is self-evident
that...", it is a good bet they are about to handwave.

**Design implication:** Name handwaves in specs and design docs: "This section handwaves
the failure mode — what happens when [X] returns an error?"

## Cultural Terms

### hacker

n. [originally, someone who makes furniture with an axe] 1. A person who enjoys exploring
the details of programmable systems and how to stretch their capabilities. 2. One who
programs enthusiastically (even obsessively). 3. A person capable of appreciating hack
value. 7. One who enjoys the intellectual challenge of creatively overcoming or
circumventing limitations. It is better to be described as a hacker by others than to
describe oneself that way.

**Design implication:** The term implies meritocracy and community membership. Invoking it
in a design discussion connotes shared values around craft and openness.

### wizard

n. 1. Transitively, a person who knows how a complex piece of software or hardware works
(i.e., who groks it); esp. someone who can find and fix bugs quickly in an emergency.
Someone is a *hacker* if they have general hacking ability, but is a *wizard* with respect
to something only if they have specific detailed knowledge of that thing. 2. Intransitively,
someone with extremely high-level hacking or problem-solving ability. 3. A person permitted
to do things forbidden to ordinary people; one who has wheel privileges.

**Design implication:** When design depends on a wizard, say so: "This component requires
a TCP/IP wizard to maintain — document who holds the wizard hat and what they know."

### guru

n. [Unix] An expert. Implies not only wizard skill but also a history of being a knowledge
resource for others. Less often, used (with a qualifier) for experts on other systems:
"VMS guru".

**Design implication:** Distinct from *wizard* (can fix it) — a *guru* is also a teaching
resource. Note when a design area has no guru: institutional knowledge is at risk.

### grok

/grok/, /grohk/, vt. [from Heinlein's *Stranger in a Strange Land*, where it is a Martian
word meaning literally 'to drink' and metaphorically 'to be one with'] To understand.
Connotes intimate and exhaustive knowledge. To say you "know" LISP is to assert you can
code in it; to say you "grok" LISP is to claim you have deeply entered its world-view and
spirit, with the implication that it has transformed your view of programming. Contrast
*zen*, which is similar supernal understanding experienced as a single brief flash.

**Design implication:** Use to distinguish shallow familiarity from deep understanding in
review context: "Does anyone on the team grok the memory model here, or are we guessing?"

## How to Use This Reference

Apply terms at SUGGESTION level only. They supplement but do not replace
VIOLATION or WARNING entries for actual convention violations.

Prefer terms defined here (pre-curated with design implications). For anything not
covered, look it up in `documentation/jargon.md` — do not use terms from memory alone.

> "SUGGESTION: This interface is [term] — [definition from entry]. Consider [alternative]."
