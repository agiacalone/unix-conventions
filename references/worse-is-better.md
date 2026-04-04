# Worse is Better

Richard P. Gabriel's "Worse is Better" (1989) describes the design philosophy behind Unix and C. Also called the **New Jersey style**, in contrast to the MIT/Stanford **"The Right Thing"**.

## The Four Properties (New Jersey Style)

**Simplicity** — The design must be simple, in both implementation and interface. *Implementation simplicity takes priority over interface simplicity.* When the two conflict, sacrifice the interface.

**Correctness** — The design should be correct, but slightly incorrect behavior is acceptable when correctness would require a significantly more complex implementation.

**Consistency** — The design should not be inconsistent, but consistency may be sacrificed to keep the implementation simple. It is better to drop unusual cases entirely than to complicate the implementation to cover them.

**Completeness** — The design should cover common situations. Completeness is the least important property and may be sacrificed for any of the others.

## Contrast: The Right Thing

| Property | Worse is Better | The Right Thing |
|----------|-----------------|-----------------|
| Simplicity | Implementation first | Interface first |
| Correctness | Good enough | Non-negotiable |
| Consistency | Optional | Strongly valued |
| Completeness | Least important | Important |

## Implications for Unix Tool Design

- A tool that handles 90% of cases simply beats one that handles 100% of cases with complexity.
- Push edge cases to the caller. If handling unusual input requires significant complexity, document the limitation instead.
- A slightly awkward interface is acceptable if the implementation is straightforward.
- "Worse is Better" tools spread: simpler implementations are easier to port, understand, and maintain.

## When to Apply

Use this lens during **design reviews** — when choosing between two architectures, option designs, or feature scopes. It is a priority ordering when tradeoffs must be made, not a license to skip basic correctness. Unchecked system calls, missing exit codes, and reversed streams are bugs, not tradeoffs.
