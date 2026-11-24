---
name: spec-close
description: Close a build run - check the run's definition of done, run a short soak with fixes only, write the final owner review card, and mark the run closed so new work starts as a feature. Use when all slices are merged, when the run keeps stretching with fix after fix, or when the owner invokes /spec-close.
---

# spec-close: give the run an end

1. **Check the definition of done** in `tasks.md`. List each item as met,
   not met, or soak. Every slice must be DONE or DONE (soak pending).
2. **Soak.** A fixed window (default 3 working days of real use). Fixes only:
   each one logged in `run-log.md` with its cause and the slice it belongs
   to. No new features; anything new goes to a list for /spec-feature.
3. **Lessons.** For each fix, ask "would a test or a real-system check in
   /spec-build have caught it?" Write the answer as a one-line lesson.
   Lessons that apply to any project are worth sending back to the
   framework (an issue or PR on the spec-first repo).
4. **Final review card** from `${CLAUDE_PLUGIN_ROOT}/templates/review-card.md`: what the owner
   opens, what changed, every gated PR merged on their behalf, open items,
   the soak result, the teach-back question.
5. Owner verdict: CLOSED, or REOPEN with notes. On CLOSED, the spec
   status says closed with the date; later changes are features.
