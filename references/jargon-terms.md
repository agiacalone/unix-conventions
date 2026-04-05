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

**Reach for it when:** Describing a fix that works but leaves you feeling unclean.
*Kludge* for ugly with no positive spin; *kluge* when expedience was at least intentional.
Either warrants a comment explaining what was worked around and why a clean fix was deferred.

### cruft / crufty

**cruft** /kruhft/: 1. The results of shoddy construction. 4. Excess; superfluous junk;
used esp. of redundant or superseded code. (Also: the dust under your bed that multiplies
when you try to remove it.)

**crufty** /kruhf´tee/: 1. Poorly built, possibly over-complex. 2. Unpleasant, especially
to the touch, often with encrusted junk. 3. Generally unpleasant.

**Reach for it when:** Code has accumulated patches, dead branches, or superseded
structures — "This module is crufty" communicates the flavor instantly to a Unix person.

### lose / lossage

**lose** /looz/, vi. [very common] To fail. A program loses when it encounters an
exceptional condition or fails to work in the expected manner. Also used as a noun: "That's
a lose." The antonym is *win*.

**lossage** /los´@j/, n. [very common] The result of a bug or malfunction; a mass noun.
"What lossage!" implies a continuing lose of which the speaker is currently a victim. A
temporary hardware failure is a loss; bugs in a critical tool (like a compiler) are serious
lossage.

**Reach for it when:** Something has failed or is actively broken — *lose* as verb or noun
for a specific failure; *lossage* for the accumulated badness of an ongoing problem.

### bletcherous

/blech'@·r@s/, adj. Disgusting in design or function; esthetically unappealing. Applies
to aesthetics of a thing, not objective criteria; contrast *losing* (fails to meet
criteria) and *bogus* (false/incorrect). "This keyboard is bletcherous!"

**Reach for it when:** An interface or structural decision is viscerally off-putting
even if technically functional — names, layout, calling conventions that cause a double-take.

### brain-damaged

adj. 1. Obviously wrong; demented. There is an implication that the person responsible
must have suffered brain damage, because they should have known better. Implies the design
is unusable and its failure is due to poor design rather than accident. "Only six monocase
characters per file name? Now *that's* brain-damaged!" 2. [Mac world] Deliberately
crippled demo software.

**Reach for it when:** A design decision has no plausible rationale — harder than
*bletcherous* (aesthetic) or *losing* (failing); *brain-damaged* implies the designer
actively chose wrong.

### bikeshedding

/bike´shed·ing/, n. [originally BSD, now common] Technical disputes over minor, marginal
issues conducted while more important ones are being overlooked. The implied image is of
people arguing over what color to paint the bicycle shed while the house is not yet
finished.

**Reach for it when:** A discussion has drifted to low-stakes stylistic details while a
harder, more consequential question goes unaddressed — "we're bikeshedding the variable
names" is a precise diagnosis.

### creeping featurism

/kree´ping fee´chr·izm/, n. 1. A systematic tendency to load more chrome and features onto
systems at the expense of whatever elegance they originally had. 2. The tendency for
anything complicated to become more complicated because people keep saying "Gee, it would
be even better if it had this feature too." The result is usually a patchwork because it
grew one ad-hoc step at a time. When it gets out of hand, it's like a cancer.

**Reach for it when:** A change request adds a fourth special case to a three-special-case
system, or a configuration file has grown beyond comprehension.

### misfeature

/mis·fee´chr/, n. A feature that eventually causes lossage, possibly because it is not
adequate for a new situation that has evolved. Not a bug (it was deliberately and properly
implemented); not a simple side effect (it was carefully planned). The long-term
consequences were not accurately predicted. "Well, yeah, it is kind of a misfeature that
file names are limited to six characters, but the original implementors wanted to save
directory space and we're stuck with it for now."

**Reach for it when:** A well-intentioned design decision has become a burden
— distinct from a bug (the logic is correct) and from cruft (it was planned). A
misfeature requires a philosophical change to resolve.

### wart

n. A small, crufty feature that sticks out of an otherwise clean design. Something
conspicuous for localized ugliness, esp. a special-case exception to a general rule. "In
some versions of csh(1), single quotes literalize every character inside them except `!`."
In ANSI C, the `??` trigraph syntax is a wart.

**Reach for it when:** Something sticks out of an otherwise clean design. Name the
specific wart by its behavior — "The `--no-verify` flag is a wart; it breaks the otherwise
clean pipeline model" lands harder than a generic complaint.

## Design Quality — Positive

### win

/win/, vi./n. [MIT; now common everywhere] To succeed. A program wins if no unexpected
conditions arise, or if it is robust enough to take exceptions in stride. As a noun: a
pleasing outcome. "So it turned out I could use a lexer generator instead of hand-coding
my own pattern recognizer. What a win!" Emphatic forms: *moby win*, *super win*,
*hyper-win*. The antonym is *lose*.

**Reach for it when:** Something worked out well, especially unexpectedly so — "what a
win" communicates both the outcome and the pleasure precisely.

### elegant

adj. [common; from mathematical usage] Combining simplicity, power, and a certain
ineffable grace of design. Higher praise than 'clever', 'winning', or even 'cuspy'.

Antoine de Saint-Exupéry: "A designer knows he has achieved perfection not when there is
nothing left to add, but when there is nothing left to take away."

**Reach for it when:** A design is truly irreducible — removing any piece would break
the whole. The highest term of praise; don't dilute it.

### clean

adj. Implies 'elegance in the small': a design or implementation that may not hold any
surprises but does things in a way that is reasonably intuitive and relatively easy to
comprehend from the outside. The antonym is 'grungy' or *crufty*.

**Reach for it when:** Code is correct, unsurprising, and comprehensible — a lower
bar than *elegant* but the right word for most straightforward positive assessments.

### orthogonal

adj. [from mathematics] Mutually independent; well separated; sometimes, irrelevant to.
Used to describe sets of primitives or capabilities that span the entire capability space
of a system and are non-overlapping. For example, the register set of the PDP-11 is
orthogonal because all registers can be used interchangeably in any role. The set {not,
or} is orthogonal; {nand, or, not} is not.

**Reach for it when:** A proposed interface adds a function that is a composition of
existing ones — "This flag is not orthogonal to `--foo` and `--bar`" signals the problem
precisely to anyone who groks the term.

### hack value

n. Often adduced as the reason or motivation for expending effort toward a seemingly
useless goal, the point being that the accomplished goal is a hack. For example, MacLISP
had features for reading and printing Roman numerals, which were installed purely for hack
value. As Louis Armstrong said when asked to explain jazz: "Man, if you gotta ask you'll
never know."

**Reach for it when:** A feature has no practical use but demonstrates mastery or wit —
"this is pure hack value" acknowledges it approvingly without pretending it solves a
user problem.

## Complexity Signals

### bit rot

n. [common] Also *bit decay*. The hypothetical disease deduced from the observation that
unused programs or features will stop working after sufficient time has passed, even if
"nothing has changed." The theory: bits decay as if radioactive. The practical cause is
that everything around the code changes — OS interfaces, compilers, dependencies — while
the code itself stays frozen. *Software rot* is nearly synonymous: software rot is the
effect, bit rot the notional cause.

**Reach for it when:** Code or a feature has stopped working not because it was changed,
but because the world around it moved on — bit rot names the phenomenon memorably.

### magic

adj./n. 1. As yet unexplained, or too complicated to explain. "TTY echoing is controlled
by a large number of magic bits." 2. Characteristic of something that works although no
one really understands why. 3. [Stanford] A feature not generally publicized that allows
something otherwise impossible. 4. The ultimate goal of all engineering: elegance in the
extreme; from Clarke's Third Law: "Any technology distinguishable from magic is
insufficiently advanced."

**Reach for it when:** Unexplained constants need names ("magic numbers"), or when
something works but nobody can say why. Distinguish from sense 4 — truly transcendent
magic should be documented as such, not just left mysterious.

### deep magic

n. An awesomely arcane technique central to a program or system, esp. one neither
generally published nor available to hackers at large; one that could only have been
composed by a true wizard. Trades on arcane *theoretical* knowledge. Compiler optimization
techniques and aspects of OS design used to be deep magic; many cryptography, signal
processing, and AI techniques still are. Found in comments: "Deep magic begins here..."

**Reach for it when:** Code depends on arcane theoretical knowledge that most developers
won't have. Document who wrote it, what property it relies on, and what would break if
changed — deep magic should not be touched without the relevant wizard.

### heavy wizardry

n. Code or designs that trade on particularly intimate knowledge or experience of a
specific OS, language, or complex application interface. Distinguished from *deep magic*
(which trades on arcane theoretical knowledge) — heavy wizardry is about operational
intimacy, not theory. Writing device drivers is heavy wizardry; so is interfacing to X
without a toolkit. Found in comments: "Heavy wizardry begins here."

**Reach for it when:** A section requires intimate knowledge of a specific system —
say which system, not just that it's complex.

### hairy

adj. 1. Annoyingly complicated. 2. Incomprehensible. "[DWIM] is incredibly hairy." Also
used of people: high-powered, authoritative, expert, and/or incomprehensible. In British
usage, "hairy" means dangerous — so hairy code there is complicated *and* risky.

**Reach for it when:** Code is annoyingly complicated or hard to follow — *hairy*
signals that it's a maintenance risk and deserves explanatory comments or a simpler wrapper.

### gnarly

/nar´lee/, adj. Both *obscure* and *hairy* (complicated). From surfer slang. "[Yow!] the
tuned assembler implementation of BitBlt is really gnarly!"

**Reach for it when:** Code is both obscure and complicated — *gnarly* means you can't
easily explain it even if you wrote it. It deserves a dedicated comment block before it,
not just inline notes.

### voodoo programming

n. 1. The use by guess or cookbook of an obscure or hairy system, feature, or algorithm
that one does not truly understand. The implication is that the technique may not work,
and if it doesn't, one will never know why. 2. Things programmers do that they know
shouldn't work but try anyway, and which sometimes actually work, such as recompiling
everything.

**Reach for it when:** Code includes copy-pasted incantations with no rationale, or
techniques applied by guess rather than understanding. Distinct from *cargo cult
programming* (ritual repetition) — voodoo programming includes active guessing.

## Interface / API Signals

### bogus

adj. 1. Non-functional. 2. Useless. 3. False. 4. Incorrect. 5. Unbelievable. 6. Silly.
"Your patches are bogus." "That algorithm is bogus." "You claim to have solved the halting
problem? That's totally bogus."

**Reach for it when:** Something is non-functional, false, incorrect, or just wrong —
the general-purpose pejorative. "This API contract is bogus" is unambiguous.

### losing

adj. Said of anything that is or causes a *lose* or *lossage*. "The compiler is losing
badly when I try to use templates."

**Reach for it when:** Something actively fails to meet its stated purpose — not just
ugly (*bletcherous*) but functionally deficient.

### brain-damaged

(see Design Quality — Negative above; also applies at the interface level)

"Only six monocase characters per file name? Now *that's* brain-damaged!" — an interface
constraint so wrong that the designer must have suffered brain damage.

### broken

adj. 1. Not working according to design (neutral, no blame). 2. Improperly designed —
carries the implication that the designer should have known better. 3. Behaving strangely.

**Reach for it when:** Something isn't working — but be precise about which sense:
a bug (sense 1) can be patched; a broken design (sense 2) requires a compatibility break.

### considered harmful

adj. From Dijkstra's 1968 letter "Goto Statement Considered Harmful" (CACM, March 1968).
Now a productive suffix: any construction of the form *X Considered Harmful* asserts that
X is a design practice whose costs outweigh its benefits. The form has been used both
seriously and as parody since the 1970s.

**Reach for it when:** Asserting that a practice's costs outweigh its benefits — but
be specific about *why* it's harmful and under what conditions, not just that it has a
bad reputation.

## Humor and Sarcasm

### Real Soon Now / RSN

adv. [orig. from SF fanzine community] 1. Supposedly available (or fixed, or cheap, or
whatever) according to somebody, but the speaker is quite skeptical. 2. When the speaker's
gods, fates, or commitments permit them to get to it — i.e., don't hold your breath. Often
abbreviated RSN.

**Reach for it when:** A deadline or delivery is promised but the speaker has no confidence
in it — "that feature is Real Soon Now" communicates appropriate skepticism without
requiring a full argument.

### TANSTAAFL

/tan´stah·fl/, n./interj. [from Robert Heinlein's *The Moon is a Harsh Mistress*]
"There Ain't No Such Thing As A Free Lunch." Invoked when someone is balking at the
complexity, cost, or quality of something as if a better deal were available — "Well,
TANSTAAFL, you know." Popular in hackerdom partly due to its Heinlein provenance and the
high concentration of SF fans and libertarians in the community.

**Reach for it when:** Someone wants the benefits of a design decision without the costs —
TANSTAAFL makes the tradeoff explicit in a way that's instantly recognizable.

### bogosity

/boh·go´s@·tee/, n. The degree to which something is *bogus*. Bogosity is measured with a
*bogometer*; in a seminar, when a speaker says something bogus, a listener might say "My
bogometer just triggered." "You just pinned my bogometer" means you said something so
outrageously bogus it pegged the scale. The agreed-upon unit of bogosity is the microLenat.

**Reach for it when:** A claim deserves scrutiny — "This pegs my bogometer" signals
skepticism without requiring a formal argument up front.

### bogometer

/boh·gom'·@t·er/, n. A notional instrument for measuring bogosity. Compare the Troll-O-Meter.

**Reach for it when:** A finding is qualitative and you want to name the sensation:
"My bogometer triggers on the retry-forever loop — it needs a bound."

### SNAFU principle

/sna´foo prin´si·pl/, n. [from WWII Army acronym 'Situation Normal, All Fucked Up'] "True
communication is possible only between equals, because inferiors are more consistently
rewarded for telling their superiors pleasant lies than for telling the truth." A central
tenet of Discordianism. The effect of the SNAFU principle is a progressive disconnection
of decision-makers from reality.

**Reach for it when:** A known problem was not escalated — "SNAFU principle" names the
dynamic precisely and is immediately recognizable to anyone who has worked in a dysfunctional
org.

### handwave

/hand´wayv/, v./n. To gloss over a complex point; to distract a listener; to support a
(possibly actually valid) point with blatantly faulty logic. "Boy, what a handwave!" If
someone starts a sentence with "Clearly..." or "Obviously..." or "It is self-evident
that...", it is a good bet they are about to handwave.

**Reach for it when:** A spec or design doc glosses over something important — "this
section handwaves the failure mode" is a precise, recognizable complaint.

## Cultural Terms

### hacker

n. [originally, someone who makes furniture with an axe] 1. A person who enjoys exploring
the details of programmable systems and how to stretch their capabilities. 2. One who
programs enthusiastically (even obsessively). 3. A person capable of appreciating hack
value. 7. One who enjoys the intellectual challenge of creatively overcoming or
circumventing limitations. It is better to be described as a hacker by others than to
describe oneself that way.

**Reach for it when:** You want to invoke shared values around craft and openness — the
term implies meritocracy and community membership, and is better earned than claimed.

### wizard

n. 1. Transitively, a person who knows how a complex piece of software or hardware works
(i.e., who groks it); esp. someone who can find and fix bugs quickly in an emergency.
Someone is a *hacker* if they have general hacking ability, but is a *wizard* with respect
to something only if they have specific detailed knowledge of that thing. 2. Intransitively,
someone with extremely high-level hacking or problem-solving ability. 3. A person permitted
to do things forbidden to ordinary people; one who has wheel privileges.

**Reach for it when:** A component requires deep specific knowledge to maintain — "this
requires a TCP/IP wizard" communicates the scope of the dependency clearly.

### guru

n. [Unix] An expert. Implies not only wizard skill but also a history of being a knowledge
resource for others. Less often, used (with a qualifier) for experts on other systems:
"VMS guru".

**Reach for it when:** Someone is not just an expert but a teaching resource — distinct
from *wizard* (can fix it). When a design area has no guru, institutional knowledge is at risk.

### grok

/grok/, /grohk/, vt. [from Heinlein's *Stranger in a Strange Land*, where it is a Martian
word meaning literally 'to drink' and metaphorically 'to be one with'] To understand.
Connotes intimate and exhaustive knowledge. To say you "know" LISP is to assert you can
code in it; to say you "grok" LISP is to claim you have deeply entered its world-view and
spirit, with the implication that it has transformed your view of programming. Contrast
*zen*, which is similar supernal understanding experienced as a single brief flash.

**Reach for it when:** Distinguishing shallow familiarity from deep understanding —
"does anyone grok the memory model here, or are we guessing?" is a fair question to ask.

## How to Use This Reference

These terms exist to communicate precisely with Unix people and hackers. Use them
naturally in documentation, comments, and explanations — not as a checklist to run
against code. "This API is bletcherous" or "the config file has become crufty" conveys
more to the intended audience than a generic description would.

For anything not covered here, the full Jargon File is in `documentation/jargon.md`.
Don't use a term you're not confident about — look it up first.
