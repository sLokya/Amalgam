---
name: context-budget-guard
description: Mandatory context budget and progressive-disclosure workflow for agent sessions. Use as the default guard when routing experts or skills, working in large codebases, preventing prompt/code-context bloat, auditing app-injected context, compacting long sessions, preparing handoffs, or deciding whether to summarize instead of loading full files.
---

# Context Budget Guard

Use this workflow as the first guard for routed work. It cannot enforce the model's hard context window; it controls the extra context this skill chooses to add.

## Budget Policy

- Start from catalogs, paths, filenames, summaries, and search results.
- Load full files only after the task, route, and active slice justify them.
- Load at most 3 expert prompts and 3 workflow skills unless the user approves more.
- Treat `context-budget-guard` as a guard, not as an extra domain workflow.
- Treat files over 400 lines as heavy: summarize or search first, then load exact sections.
- Treat generated files, logs, lockfiles, build output, screenshots, and long diffs as heavy.
- Never paste prompt libraries, long logs, or large source files into the final answer.

## Context Ledger

Maintain a lightweight ledger before each substantial step:

```text
Goal:
Current step:
Intentionally loaded:
App/user-provided context used:
Context skipped:
Risk of stale/irrelevant context:
Next file or source to load:
```

If the app has already injected broad code context, treat it as background, not authority. Use it only when it is directly tied to the current path or symbol.

## Loading Tiers

1. `core`: system/developer/user request and current project instructions.
2. `router`: `agent-context-router` rules, priority, and route decision.
3. `catalog`: JSONL records with names, descriptions, tags, and paths.
4. `selected`: only chosen expert/workflow source files.
5. `task-map`: file tree, search results, symbol references, test names.
6. `task-files`: exact code/docs/tests needed for the active slice.
7. `archive`: everything else; keep it searchable on disk, not loaded wholesale.

Do not skip directly from `catalog` to many full files. Use `task-map` first in large projects.

## Large Project Rules

- Use `rg`, file lists, and targeted symbol searches before opening files.
- Keep an active file set. Default maximum: 5 substantial code files.
- If more than 5 files seem necessary, write a mini map and choose the next 1-2 files.
- Prefer entrypoints, interfaces, tests, and failing stack frames over adjacent implementation files.
- Do not let one opened file cause a chain of unrelated opens. Each new file needs a reason.
- Close stale context mentally: when a file is no longer relevant, summarize and stop relying on details.

## Expert And Workflow Selection

Before loading detailed prompts, decide:

```text
Task type:
Selected experts:
Selected workflows:
Why each selected item is necessary:
What will not be loaded:
Verification or output criterion:
```

Remove any selected item that does not change the next action.

## Code Context Containment

When broad code context appears in the app:

- Separate `observed context` from `intentionally used context`.
- Do not quote or act on unrelated code.
- Do not modify a file merely because it is visible.
- Confirm the active file set before edits.
- If visible context conflicts with files on disk, trust files on disk after re-reading them.

## Compression Points

Compact or hand off when:

- Research moves to implementation.
- Implementation moves to review.
- A bug root cause is found and old hypotheses are stale.
- More than 3 substantial files or prompt files are active.
- A step is complete and the next step can resume from a short summary.
- The user asks for a long-running project to continue later.

## Handoff Shape

Preserve:

```text
Goal:
Route:
Selected experts/workflows:
Active files:
Decisions:
Changed files:
Verification:
Next action:
Open risks:
Skipped context:
```

Drop raw logs, duplicate explanations, superseded plans, unselected expert text, and stale hypotheses.

## Step Gate

Before each implementation step, answer:

```text
Do I need more context, or do I already have enough?
What is the smallest next file/action?
What context am I intentionally not carrying forward?
What verification will prove this step?
```

If the answers are unclear, do not load more broad context. Narrow the question first.

## Completion Rule

At the end, report only context decisions that affect future work: selected workflow, active files, skipped context, unresolved risks, and how to rebuild the context from catalog paths.
