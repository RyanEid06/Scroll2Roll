# Ryan and Eddie Codex Coordination

## Purpose and authority

Ryan's and Eddie's Codex agents use the private `Scroll2Roll-Coordination`
GitHub repository as an asynchronous mailbox and handoff layer. It works when
either person or Codex session is offline and requires no laptop to run a
server. The coordination repository contains messages and references only; it never contains copied
Scroll2Roll source. The Scroll2Roll repository and its Git history remain the
authority for source, branches, commits, and tests.

Use one primary issue for each active development phase, titled
`[SYNC] Phase <letter> — <phase name>`. Both lanes leave short messages on
that issue. Do not create issues for every status update or open future phase
issues before those phases begin. The active issue should be pinned or otherwise
made easy to find when GitHub supports it. The Android roadmap defines the
phase names and gates in `ANDROID_WORK_PACKAGES.md`.

Standard message types:

- `[START]` — a Codex session is beginning work.
- `[STATUS]` — meaningful progress worth sharing.
- `[QUESTION]` — one lane needs information or a decision from the other.
- `[BLOCKER]` — work cannot safely continue.
- `[INTERFACE]` — a shared contract, API, or schema changed or is proposed to
  change.
- `[HANDOFF]` — work is ready for the other lane or integration.
- `[BREAKAGE]` — previously working behavior failed, regressed, or changed
  unexpectedly.
- `[END]` — a Codex session is ending or pausing before work is ready to
  integrate.
- `[ACK]` — the other lane has read and acknowledged an important message.

## Start of every Codex work session

Before meaningful changes, every Codex must:

1. Read the current repository instructions, `docs/PROJECT_CONTEXT.md`, the
   authoritative Android roadmap, and this document.
2. Identify its lane (Ryan or Eddie), active phase, and WP/subtask. If identity
   is unclear, stop before posting under either person's name and ask the
   owner.
3. Check the active `[SYNC]` issue in `Scroll2Roll-Coordination` and read all
   messages since the last known handoff, especially `[BLOCKER]`, `[BREAKAGE]`,
   `[INTERFACE]`, and `[HANDOFF]`.
4. Inspect local Git status, preserve user changes, and fetch remote updates.
   Never overwrite another lane's work or treat a message as a substitute for
   source commits.
5. Post one concise `[START]` message before meaningful modifications. One
   START per session/chat is enough; do not spam it.

If the other person is offline, GitHub retains the message. Continue only when
the roadmap and current contracts allow it. No reply means no approval.

## Message format

Keep messages to a few lines. Use:

```text
[TYPE] Ryan
WP/subtask: ...
Branch: ...
Status or message: ...
Commit/PR: ...
Blocker/question or what the other lane needs: ...
```

Omit fields that do not apply. Refer to source branches, commits, and PRs;
never paste patches or duplicate source into issue comments. Examples:

```text
[START] Ryan
WP0 signal analysis
Branch: ryan/phase-a-signal-analysis
Starting validation-harness work. I own analysis/test tooling; I will not
modify Eddie's AccessibilityService files.
```

```text
[INTERFACE] Eddie
WP0 diagnostic envelope
ObservedSwipe v1 proposed: package, monotonicTimestamp, feedType, confidence.
Ryan: please ACK before depending on this contract.
```

```text
[BREAKAGE] Ryan
WP3 wallet restart test regressed after integration of commit abc123.
Pause wallet-dependent work until the failure is reproduced and resolved.
```

## During work

- Post `[BLOCKER]` immediately when a missing dependency, failed shared
  contract, unresolved integration issue, unavailable device/tool, required
  owner decision, or other-lane dependency makes it unsafe to continue. State
  what is blocked and who must act.
- Post `[BREAKAGE]` immediately when shared behavior regresses, an integration
  breaks a gate, a shared interface becomes unexpectedly incompatible, or a
  prior acceptance may no longer be valid. Say what broke and which downstream
  work must pause.
- Post `[INTERFACE]` before changing an interface used by the other lane.
  This includes earning signals, wallet APIs, persistence schemas,
  permission-state contracts, game-host contracts, public engine states, and
  other agreed cross-lane contracts. Describe the proposed version and impact.
  Where practical, wait for the affected lane's `[ACK]` before depending on a
  breaking change. Silence is not ACK.
- Use `[QUESTION]` for a technical dependency the other lane can resolve, not
  for trivial chatter.
- `[STATUS]` is optional for meaningful milestones. Do not post minute-by-
  minute updates or after every commit.

## Breakage procedure

For serious breakage:

1. Stop dependent work when continuing could compound the failure.
2. Reproduce it before changing code.
3. Post `[BREAKAGE]` to the active phase issue with the WP/component, last
   known good commit if known, suspected bad commit if known, failing test or
   reproduction, and whether Ryan, Eddie, or both should pause.
4. Fix it in the lane that owns the affected component unless integration
   ownership requires another owner.
5. After repair, post `[STATUS]` with evidence or `[HANDOFF]` when ready for
   integration.
6. Resume dependent work only after the relevant gate is healthy again.

Do not hide a regression because one lane's own tests still pass.

## End of a session and handoff

Before a meaningful session ends or pauses, post `[END]` if the work is
incomplete, or `[HANDOFF]` if it is ready for integration. Keep it short.

An END records the WP/subtask, branch, current state, last commit, next step,
and blockers (or explicitly says there are none). A HANDOFF records the branch,
commit SHA, focused test result, changed shared-interface version (if any),
known limitations, and the next action for the other lane or integrator.

The phase integration owner follows the order and exit gate in
`ANDROID_WORK_PACKAGES.md`. The roadmap's WP0–WP8 sequence remains authoritative;
phases A–F organize collaboration and do not replace, shorten, or waive any WP.

## Git, branches, and ownership

Each phase uses one accepted integration base and temporary Ryan/Eddie
implementation branches or worktrees, with explicit module ownership and a
scoped integration checkpoint. Keep both lanes off the same working checkout.
Prefer separate files/modules; coordinate any unavoidable shared-file edit on
the phase issue first. The integration owner applies lane commits in roadmap
order, runs affected integration gates, records the accepted commit, and
retires temporary branches only after integration is confirmed. Do not create
permanent branch clutter. Preserve unfinished work. The Scroll2Roll source
repository remains authoritative; issue messages reference commits rather than
carrying source or patches.

## Offline behavior

Messages are durable GitHub comments, so either person may post while the other
is offline. The returning lane reads outstanding messages before starting. A
lane may continue independent work only if doing so cannot depend on an
unacknowledged interface or blocked gate. Never infer approval from silence.
For breaking shared-interface changes, wait for acknowledgement or an
explicitly assigned integration owner unless the roadmap gives that lane
exclusive ownership.

## Phase issue names

The active phase is A. Create its issue as
`[SYNC] Phase A — WP0–WP1 risk validation`. Open each later issue only when its
phase begins:

- Phase B — WP2 platform decision
- Phase C — WP3 wallet
- Phase D — WP4–WP5 MVP
- Phase E — WP6 game migration
- Phase F — WP7–WP8 acceptance

Use the issue template, if present, to record the phase/WPs, both lane branches,
shared contracts, current integration branch, and gate status. The issue is a
signal channel, not a replacement for repository documentation or test
evidence.
