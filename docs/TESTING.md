# Testing Scroll2Roll

No feature claim is complete until its focused test passes.

The final matrix covers Rocket check/build/test, card and shoe invariants, every required betting/action/dealer/settlement rule, deterministic complete and consecutive rounds, nonnegative balances, safety limits, persistence migration/recovery, scripted GUI input, native resource lifetimes, packaging contents, sanitized relocation, and static website checks.

Test setup helpers must return explicit failure or a nonzero test status when construction is invalid. They must never substitute a plausible fallback card, state, or resource.

Validation commands and results are recorded in `PROJECT_CONTEXT.md`; scripts will place generated evidence under ignored `out/`.

