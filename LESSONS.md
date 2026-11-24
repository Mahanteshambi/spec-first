# Lessons

- 2026-11 Financing: exchange tick sizes and broker order rules broke the first
  live orders; fixtures had passed. → spec-build step 4, real-system check.
- 2026-11 Financing: an owner's "no dependency on me" in one session overrode a
  CLAUDE.md gate. → gates live in CLAUDE.md and change there first.
- 2026-11 Financing: two sessions in one checkout clashed on the test database.
  → one worktree and one test database per session.
- 2026-11 Financing: CI was blocked by billing; merges ran on local checks.
  → check CI at setup; say so on every card.
- 2026-11 Financing: no slice was ever marked DONE; fixes kept trickling in.
  → slice contract plus /spec-close with a soak window.
