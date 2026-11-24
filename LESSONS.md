# Lessons

One line per lesson, from real runs. Each names the rule it led to.

- Fixtures passed, but the first live calls to an outside API were refused
  (formats and validation rules the fixtures did not have).
  → `/spec-build` step 4: a real-system check before a slice is done.
- An instruction given in chat ("don't wait for me") silently overrode a gate
  written in CLAUDE.md. → gates live in CLAUDE.md and change there first.
- Two sessions in one checkout collided on a shared test database.
  → one worktree and one test database per session.
- CI was down for the whole run and merges ran on local checks unnoticed.
  → check CI at setup; say so on every slice card.
- No slice was ever marked done, and fixes trickled in for days.
  → the slice contract plus `/spec-close` with a fixed soak window.
- Slice branches were stacked on unmerged slices; integration merges piled up.
  → every slice branches from main after the one it depends on merges.
