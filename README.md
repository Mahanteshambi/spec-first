# claude-frame

A Claude Code plugin for building a project, or a feature, spec first:

| Phase | Skill | What happens | Owner does |
|---|---|---|---|
| A. Define | `/frame-new` or `/frame-feature` | audit → grill → debate → mockups → spec freeze | answers one question at a time; approves each step |
| B. Build | `/frame-slice` | one session and worktree per slice; tests, real-system check, merge, deploy, DONE | only money settings and big decisions |
| C. Close | `/frame-close` | definition of done, soak (fixes only), lessons, final card | gives the verdict |

Agents: `frame-auditor`, `frame-debater`, `frame-spec-reviewer`, `frame-fixer`,
`frame-coordinator`. Templates in `templates/`.

## Install (once)

In Claude Code:

    /plugin marketplace add /Users/mahantesh/data/git_workspace/claude-frame
    /plugin install claude-frame@claude-frame-local

## Per project

1. `/frame-new` (or `/frame-feature` in a project that has a spec).
2. Before building, copy `templates/CLAUDE.gates.md` into the project's
   CLAUDE.md and fill in the gates.
3. Optional merge guard: list gated paths as regexes in `.frame/gated-paths`
   (e.g. `^config/rules/`, `migrations/.*drop`). `gh pr merge` on a PR touching
   them is blocked unless it has the `owner-approved` label.

## Where it came from

Financing spec 001 (Nov 2026): the define phase and the gated build worked;
the run stretched because nothing defined "done", fixtures never met the real
broker, and one session held the whole build. Phases B and C fix those.

## Lessons

`LESSONS.md` collects one-line lessons from each run (frame-close step 3).
