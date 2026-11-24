# spec-first

A Claude Code plugin for building software **spec first, in slices, with an end**.

You (the *owner*) decide what gets built and approve each step. Claude audits,
asks, debates, mocks up, writes the spec, then builds it one slice at a time,
and brings you only the decisions that are truly yours.

It works for a brand-new project, a reset of an existing one, or a single
feature in a project that already has a spec.

## How it works

```
 A. Define (you approve each step)          B. Build (you hold the gates)       C. Close
 ─────────────────────────────────          ─────────────────────────────       ─────────
 audit → grill → debate → mockups → spec    slice → slice → slice …              done check
                                            each: tests, real-system check,      soak (fixes only)
                                            merge, deploy, DONE, card            lessons, final card
```

| Phase | Command | What happens | You do |
|---|---|---|---|
| A. Define | `/spec-new` | Audit the code, grill you with one question at a time, run a role debate, mock up 2–3 directions, freeze a testable spec | Answer questions; approve each step |
| A. Define (light) | `/spec-feature` | Scoped audit, 3–5 questions, debate and mockup only if needed, a spec delta | Same, faster |
| B. Build | `/spec-build` | One session and one worktree per slice, built to a contract: acceptance tests, a check against the real outside systems, merge, deploy, marked DONE, a slice card | Only the gates you set (money, irreversible or security decisions) |
| C. Close | `/spec-close` | Check the run's definition of done, a short soak with fixes only, lessons, a final review card | Give the verdict: CLOSED or REOPEN |

### What you get in your repo

```
specs/NNN-<slug>/
  audit.md        what exists, what works, what is dead
  brief.md        your requirements, each line marked [owner] or [proposal]
  debate/         one file per role
  decisions.md    D1, D2, … with your own words and dates
  mockups/        2–3 directions, screenshots
  diagrams.md     Mermaid: system, data flow, state machines
  spec.md         requirements AREA-NNN, one SHALL each, Given/When/Then examples
  design.md       architecture, data, UI, API, config, security, testing
  tasks.md        slices, requirement → slice table, definition of done, status
  run-log.md      what happened during the build, including every gate
```

Every acceptance example becomes a test named `test_<AREA>_<NNN>_<short_name>`,
so the spec and the code can be checked against each other.

## Agents

| Agent | Role |
|---|---|
| `auditor` | Read-only audit of one area of the codebase |
| `architect` | Debate: structure, boundaries, reuse vs rewrite, failure and rollback |
| `data-engineer` | Debate: sources, numbers of record, schemas, history, bad data |
| `ux-designer` | Debate: the user's real routine, fewest screens, every state, wording |
| `domain-expert` | Debate: the domain you name, from primary sources |
| `red-team` | Debate: money or data loss, security, outside-system rules, self-deception |
| `reviewer` | The stranger test: could someone build this without asking a single question? |
| `fixer` | Applies review findings, spec first, and logs each resolution |
| `coordinator` | Runs the build: one session per slice, status table, gates, run log |

The debate agents run in parallel; your main session moderates and turns their
positions into a short list of choices for you.

## Install

```
/plugin marketplace add Mahanteshambi/spec-first
/plugin install spec-first@spec-first
```

## Use

1. In your project, run `/spec-new` (or `/spec-feature` if a spec already exists).
2. Answer the questions; approve each step. The spec lands in `specs/NNN-<slug>/`.
3. Before building, paste `templates/CLAUDE.gates.md` into your project's
   `CLAUDE.md` and fill in your gates: what Claude must always ask you first,
   what it may do alone, and what it must never do.
4. Run `/spec-build` for each slice (or let the `coordinator` agent run them).
5. Run `/spec-close` when every slice is done.

### Optional merge guard

List the paths only you may approve, as regexes, in `.spec-first/gated-paths`
in your project:

```
^config/billing/
^db/migrations/.*drop
```

The plugin's hook then blocks `gh pr merge` on any PR that touches them unless
the PR carries the `owner-approved` label, which Claude never adds itself.
Requires the GitHub CLI (`gh`) and Python 3.

## Principles

- **Define before building.** No product code until you approve the spec.
- **One question at a time**, with options and a recommendation.
- **Outcomes, not operations.** Checkpoints are five lines.
- **Gates live in `CLAUDE.md`**, not in chat; a gate changes there first.
- **One slice, one session, one worktree.** Never stack unmerged branches.
- **Done means done**: tested, checked against the real system, merged,
  deployed, marked DONE.
- **Every run has an end**: a soak with fixes only, then CLOSED.

## Templates

`templates/` holds `brief.md`, `decisions.md`, `spec.md`, `tasks.md`,
`slice-card.md`, `review-card.md`, `run-log.md` and `CLAUDE.gates.md`.

## Lessons

[LESSONS.md](LESSONS.md) lists what earlier runs taught and the rule each one
became. If a run teaches you something general, open an issue or a PR.

## License

MIT
