---
name: agent-context-router
description: Select and assemble minimal task-specific context from a local expert prompt library and engineering skill library before solving coding, debugging, review, architecture, documentation, product, or research tasks. Use when the user asks to route work through experts, combine agency-agents style expert roles with mattpocock/skills style engineering workflows, or create a lightweight alternative to always-on multi-agent frameworks.
---

# Agent Context Router

Use this skill as a lightweight context router. Do not run a multi-agent process. Instead, choose the smallest useful set of expert viewpoints and engineering rules, load only those resources, then solve the user's task normally.

## Workflow

1. Classify the task:
   - `clarify`: vague feature, product, scope, or planning request
   - `implement`: build or modify code
   - `debug`: runtime error, failing test, flaky behavior, performance issue
   - `review`: code review, PR review, security review, quality audit
   - `architecture`: system design, refactor, module boundaries, technical debt
   - `docs`: technical writing, API docs, migration notes, README content
   - `domain`: marketing, finance, legal, sales, operations, or other non-code specialist work
2. Apply the built-in coding baseline for development tasks:
   - state material assumptions
   - choose the smallest complete change
   - avoid speculative abstractions and unrelated cleanup
   - define a concrete verification or success criterion
3. Apply the execution confirmation gate before modifying files, installing/removing skills, running sync scripts, or taking broad project actions.
4. Apply `context-budget-guard` as the default guard for any non-trivial routed task. It limits only the extra context selected by this skill; it cannot remove context already injected by the app.
5. Read [references/routing.md](references/routing.md) when expert or engineering-rule selection is non-obvious.
6. Read [references/priority.md](references/priority.md) before applying any selected prompt that may conflict with system, user, project, or safety instructions.
7. Select at most:
   - 3 expert roles from the local expert catalog
   - 3 engineering workflows from the local coding-skills catalog, including the guard when it is loaded as source
8. Load only the selected source files. Summarize them into a short `Active context` section for yourself before acting.
9. Execute the task with normal Codex behavior: inspect the codebase, make small changes, verify with concrete checks, and report results.

## Execution Confirmation Gate

Proceed without asking only when the user clearly requested execution and the next action is narrow, reversible, and within the stated scope.

Pause and ask for confirmation before acting when any of these are true:

- The user asked for evaluation, design, comparison, feasibility, or "should we" rather than "do it".
- The action removes or restructures skills, source directories, catalog entries, scripts, configuration, dependencies, or generated install targets.
- The change affects more than one bounded slice, more than 5 substantial files, or multiple independent subsystems.
- The action may be destructive, hard to roll back, expensive, network-dependent, or surprising to the user.
- The proposed solution includes alternatives and the user has not chosen one.
- Requirements, allowed files, forbidden files, or acceptance checks are unclear.

When confirmation is needed, present:

```text
Proposed action:
Scope:
Files/commands:
Risks:
Verification:
Need confirmation:
```

If the user replies with an explicit approval such as "go", "加", "按这个做", or "执行", treat that as confirmation for the described scope only. New scope requires a new gate.

## Selection Rules

- Prefer engineering workflows over personas when the task is code-heavy.
- Prefer expert roles when domain judgment materially changes the answer.
- Skip expert roles when the user's request is already narrow and technical.
- Skip engineering workflows when the task is pure writing, brainstorming, or non-code domain work.
- Never copy large prompt files into the answer. Use them as private working context.
- If no catalog exists yet, infer from filenames under `sources/` or proceed with the routing table in [references/routing.md](references/routing.md).

## Active Context Format

Before substantial work, internally establish:

```text
Task type: <one of the route labels>
Experts: <0-3 selected names, or none>
Engineering rules: <0-3 selected names, or none>
Context guard: context-budget-guard for non-trivial routed tasks
Success check: <specific verification or output criterion>
Conflict policy: system/developer/user > project > router > engineering rules > experts > references
```

Show this to the user only when it helps clarify a plan, when the task is broad, or when the selected context may surprise them.

## Source Layout

Use this repository layout when available. The router supports source repositories copied under this skill or checked out beside this skill:

```text
sources/
  agency-agents-zh/
  mattpocock-skills/
catalog/
  experts.jsonl
  coding-skills.jsonl
```

Sibling fallback:

```text
../agency-agents-zh/
../skills/
```

Run `scripts/build_catalog.py` after adding or updating source repositories. See [references/source-layout.md](references/source-layout.md) for details.
