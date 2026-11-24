---
name: spec-new
description: Start a new project or a full reset of an existing one, spec first. Runs Phase A (audit, grill, debate, see, freeze) with a stop after each step, then hands off to /spec-build for the build and /spec-close to finish. Use when the owner says "new project", "reset", "start from scratch", or invokes /spec-new.
---

# spec-new: define before building

The owner reads outcomes, not operations. Every checkpoint is a 5-line summary,
then one question. No app code, no deletions, until the spec is approved.

## Setup (once)

1. Pick the spec folder: `specs/NNN-<slug>/` (next free number). Every artifact
   of this run lives there, so a new session can build from it alone.
2. Copy the templates from this plugin's `templates/` into it as you reach each
   step (the brief, decisions, spec, design and tasks templates).
3. Check the ground: does CI run (push a no-op branch or read the last run)?
   Is there a test database per session? Note failures in `audit.md`; they
   are owner items, not things to work around silently.

## Phase A: Define (owner approves each step)

### A1 Audit → `audit.md`
- Fan out `spec-auditor` agents in parallel, one per area (backend, data,
  frontend, runtime/infra, docs/specs). Brief each with the area and "what
  exists, what works, what is dead".
- Write: what exists, labels (keep / hide / delete / unknown), data sources
  and where numbers of record come from, 2–3 fresh-start options with a
  recommendation. Stop. 5-line summary.

### A2 Grill → `brief.md`
- Use the superpowers:brainstorming approach, but ask with the answer picker
  (AskUserQuestion): one decision per question, 2–4 options, recommended first.
- Cover: goal and why, success, non-goals and anti-goals, what to keep,
  hide and delete, money and risk limits, who uses it, data sources, how
  often, what the app must never do (for example "no AI inside the app").
- Mark every line `[owner]` or `[proposal]`. Stop for "brief is right".

### A3 Debate → `debate/<role>.md`, then `decisions.md`
- Pick 3–5 roles for the domain (default: architect, data engineer,
  UX designer, domain expert, red team). Run `spec-debater` agents in
  parallel, one per role, each reading `brief.md` and `audit.md`.
- Moderate: merge agreement into "agreed", cut what the brief rules out,
  and reduce the rest to at most ~8 owner choices. Ask them one at a time.
- Record each answer as `D<n>` with the date and the owner's own words.

### A4 See it → `mockups/`, `diagrams.md`
- 2–3 directions, built in parallel with the frontend-design skill,
  realistic but fictional numbers. Serve locally, screenshot, show side
  by side. Offer real swatches for colour choices, not words.
- Iterate until one direction is locked (a `D<n>`). Mermaid diagrams for
  system, data flow, daily routine, state machines; they must parse.
- If a requirement changes here, update `brief.md` and `decisions.md` first.

### A5 Freeze → `spec.md`, `design.md`, `tasks.md`
- `spec.md`: requirements `**AREA-NNN**`, one SHALL each, Given/When/Then
  examples, out of scope, open items. Each example becomes a test named
  `test_<AREA>_<NNN>_<short>`.
- `design.md`: architecture, data, UI, API, config, security, testing.
- `tasks.md`: vertical slices (most valuable first), a dependency diagram,
  requirement→slice table (each ID in exactly one slice), status table,
  and the **run's definition of done** (what must be true to close the run).
- Review: run `spec-reviewer` (the stranger test: "could someone build
  this without asking a single question?"). If the spec is large, split
  the review by area and run reviewers in parallel, then `spec-fixer` agents
  in parallel, one per area. Rule on conflicts yourself and log the rulings.
- Present for approval. On "approve", mark status approved and add a `D<n>`.

## Before Phase B

- Write the gates into the project's CLAUDE.md from
  `templates/CLAUDE.gates.md`. Ask the owner now which gates they keep,
  and record the answer word for word. A gate that changes mid-run is
  updated in CLAUDE.md and decisions.md first, never only in a chat.
- Then run `/spec-build` for the first slice, and `/spec-close` at the end.

## Rules

- One question at a time; never assume what you can ask.
- Parallel agents for independent work; never two writers on one file.
- Temporary files go to the scratchpad, never the repo.
