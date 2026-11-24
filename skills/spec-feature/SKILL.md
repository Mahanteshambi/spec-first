---
name: spec-feature
description: Add a feature to a project that already has a spec, using the light path of the framework (scoped audit, short grill, optional debate and mockup, a spec delta, then slices and close). Use when the owner asks for a new feature, change or improvement in an existing project, or invokes /spec-feature.
---

# spec-feature: the light path

Same discipline as /spec-new, scaled down. Reports are 5 lines; questions one
at a time with the answer picker.

1. **Scope audit.** Read the project's spec folder and the code the feature
   touches. One or two `auditor` agents at most. Write
   `specs/NNN-<slug>/audit.md` (short): what exists, what changes, risks.
2. **Grill, 3–5 questions.** Why, what success looks like, what it must not
   break, any money or data impact. Write `brief.md`.
3. **Debate only if risky** (money, data of record, security, a migration that
   drops anything): 2–3 of the role agents (red team always, plus the roles the feature touches), owner choices into
   `decisions.md`. Otherwise record your calls there as `[proposal]`.
4. **Mockup only if there is a screen.** One direction plus one alternative.
5. **Spec delta.** New or changed `**AREA-NNN**` requirements with examples,
   in a new numbered spec folder or as a dated amendment to the live spec
   (spec first, then tests, then code, in the same PR). Slices in `tasks.md`
   with the definition of done. Run `reviewer` once.
6. **Owner approves**, then `/spec-build` per slice and `/spec-close`.

If it grows past ~3 slices or touches the core model, stop and say it is
a project: switch to /spec-new.
