---
name: spec-build
description: Build one slice of an approved spec in its own session and worktree, to the slice contract (tests, a real-system check, merge, deploy, DONE, card). Also used by the coordinator to start and track slice sessions. Use when the owner says "build the next slice", "start S<n>", or invokes /spec-build.
---

# spec-build: one slice, one session, done means done

## Roles

- **Coordinator** (one session, long-lived, never writes product code):
  keeps the slice status table, starts one build session per slice
  (a new Claude Code session or a worktree-isolated agent, branched from main), checks each
  result, relays owner gates one at a time, keeps `run-log.md`.
- **Builder** (one session per slice, short-lived): builds exactly one slice.

Never stack a slice branch on another unmerged slice. If S(n+1) needs S(n),
wait for S(n) to merge. Never share a checkout or a test database between
two sessions.

## Builder steps

1. Read `tasks.md` for the slice, its requirements in `spec.md`, the gates
   in CLAUDE.md. Mark the slice `IN PROGRESS`.
2. Acceptance tests first, named `test_<AREA>_<NNN>_<short>`, xfail-strict
   until the code lands.
3. Build. Anything that changes behaviour lands in the spec first, same PR.
4. **Real-system check.** Exercise every outside system the slice touches
   for real, at the smallest safe scale: sandbox, read-only call, or a
   recorded real response (field formats, validation rules, rate
   limits, auth expiry). Fixtures alone are not enough. Note what was checked.
5. Run the full local checks (lint, types, tests, spec gate). If CI is down,
   say so on the card; local checks are not a silent substitute.
6. PR. Merge only if no gate in CLAUDE.md covers it; otherwise it goes to
   the coordinator as an owner item with exact steps.
7. Deploy outside any blackout window in CLAUDE.md; verify it is live.
8. Mark the slice **DONE** (or `DONE (soak pending)` with the soak named),
   and write the card from `${CLAUDE_PLUGIN_ROOT}/templates/slice-card.md`.

A slice is not done while any of 4–8 is missing. Later fixes to a DONE
slice are logged in `run-log.md` as fixes, with the slice they belong to.

## Mid-run changes

If the owner changes scope, decisions.md and tasks.md change first (a new
`D<n>`), then the coordinator re-plans. No slice absorbs unplanned scope.
