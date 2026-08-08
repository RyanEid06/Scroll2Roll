# Scroll2Roll Repository Guidance

Before planning or changing Scroll2Roll, read `docs/MASTER_PLAN.md` and `docs/PROJECT_CONTEXT.md` completely, then read the relevant project documentation.

- Treat `docs/MASTER_PLAN.md` as the authoritative product mandate.
- Keep all casino work in this repository; never place it in the Rocket repository.
- Use frozen Rocket 2.0 and the pinned Windows x64 raylib 6.0 integration without changing Rocket syntax, compiler contracts, runtime ABI, or tooling protocols.
- Keep Blackjack rules independent from rendering and back every completed rule with passing tests.
- Preserve user work and keep generated, downloaded, experimental, cached, packaged, and machine-specific files out of Git.
- Update `docs/PROJECT_CONTEXT.md` after every meaningful milestone and run the relevant validation before handoff.
- Do not push, publish, deploy, or claim signing without explicit owner approval.
