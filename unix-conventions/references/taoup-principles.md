# The Art of Unix Programming — Core Principles

Reference: Eric S. Raymond, *The Art of Unix Programming* (Addison-Wesley, 2003)

---

## The Seventeen Rules

These rules distill decades of Unix tradition. Apply them when reviewing code, documentation, and tool design.

### Rule of Modularity
Write simple parts connected by clean interfaces. Complexity is the enemy of reliability. Each component should do one thing and expose a minimal, well-defined interface.

### Rule of Clarity
Clarity is better than cleverness. Write code for the next programmer (or the next instance of yourself). Avoid "clever" solutions that sacrifice readability.

### Rule of Composition
Design programs to be connected with other programs. A tool that reads from stdin and writes to stdout can be combined with anything. Avoid hardcoding paths, formats, or assumptions about the calling environment.

### Rule of Separation
Separate policy from mechanism. Separate interfaces from engines. A tool that enforces decisions on the user is poorly designed; expose controls, let the user (or a wrapper) set policy.

### Rule of Simplicity
Design for simplicity; add complexity only where you must. Ask whether each feature earns its complexity cost. Complexity that isn't strictly necessary is a bug.

### Rule of Parsimony
Write a big program only when nothing else will do. Prefer composing small programs over building monoliths.

### Rule of Transparency
Design for visibility to make inspection and debugging easier. Programs should be transparent about what they are doing. Avoid hidden state. When something goes wrong, make it easy to understand why.

### Rule of Robustness
Robustness is the child of transparency and simplicity. A program that is easy to understand is easier to make robust. Fail loudly and early rather than silently and late.

### Rule of Representation
Fold knowledge into data so program logic can be stupid and robust. Data structures should carry meaning; code should be dumb. Prefer declarative data over procedural logic where possible.

### Rule of Least Surprise
In interface design, always do the least surprising thing. A user encountering your tool for the first time should find that it behaves as expected. Consistency with Unix conventions reduces surprise.

### Rule of Silence
When a program has nothing surprising to say, it should say nothing. Avoid noisy, chatty output. Diagnostic output belongs on stderr; stdout is for data. A program that succeeds silently composes better with other tools.

### Rule of Repair
Repair what you can — but when you must fail, fail noisily and as soon as possible. Validate inputs early. Report errors at the point of detection, not several stack frames removed. Silent failure is worse than loud failure.

### Rule of Economy
Programmer time is expensive; conserve it in preference to machine time. Do not prematurely optimize. Write clear code first; optimize only when profiling confirms a bottleneck.

### Rule of Generation
Avoid hand-hacking; write programs to write programs when you can. Repetitive structures in code or data are a sign that a generator is needed.

### Rule of Optimization
Prototype before polishing. Get it working before you optimize it. Premature optimization is the source of most programming evil. Measure before you tune.

### Rule of Diversity
Distrust all claims for one true way. Unix is not monolithic; it thrives on diversity of tools and approaches. Be skeptical of any approach that claims to solve all problems.

### Rule of Extensibility
Design for the future, because it will be here sooner than you think. Make protocols and formats extensible. Leave room for options and flags you haven't thought of yet.

---

## The Unix Philosophy in One Sentence

**"Write programs that do one thing and do it well. Write programs to work together. Write programs to handle text streams, because that is a universal interface."** — Doug McIlroy

---

## Common Violations to Flag

- Tool that does too many unrelated things (violates Modularity, Parsimony)
- Silent failure or swallowed errors (violates Repair, Robustness)
- Mixing policy into a library or engine (violates Separation)
- Verbose success output sent to stdout (violates Silence)
- Hard-coded paths, formats, or assumptions (violates Composition)
- "Clever" code that obscures intent (violates Clarity)
- Features added without clear justification (violates Simplicity)
