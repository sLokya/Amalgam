# Requirements And Memory

Default layout:

```text
ai-workflow/projects/<project-key>/
  requirements.md
  optional/
    logs/YYYY-MM-DD-short-topic.md
    contracts/
    handoff.md
    rollback/
```

Use the project root if the repo already has a memory location. Keep one source of truth.

`requirements.md` should contain:

```markdown
# Requirements

## Completion Policy
- The requirements document defines what "done" means.
- A requirement is not complete until its acceptance checks, evidence, and known gaps are updated here.
- Placeholders, mock-only paths, visual approximations, and unverified flows must be marked partial or incomplete.

## Fidelity Policy
- Applies when the user asks for 1:1 recreation, clone, parity, redesign from an existing source, migration parity, or "same as the original".
- Reference source:
- Fidelity surfaces:
- Allowed deviations:
- Required evidence:

## Feature List
| ID | Feature | Surface | Source | Alignment | Status | Completion Definition | Acceptance | Evidence | Gaps | Work Package | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |

## Gap Register
| ID | Related REQ | Type | Description | Impact | Owner/Slice | Status | Evidence |
| --- | --- | --- | --- | --- | --- | --- | --- |

## Work Packages

## Slice Plan

## Change Scope

## Implementation Log

## Error Analysis

## Verification

## Change Log
```

Rules:

- Requirements are the control plane; code, tasks, contracts, and release notes must point back to REQ IDs.
- Completion definitions live in `requirements.md`, not only in chat, plans, or model memory.
- Gap lists live in `requirements.md`. Do not keep material unfinished work only in the final answer.
- If no `requirements.md` exists, create the smallest viable one or ask before development.
- If a requested outcome has no completion definition, add one before implementation.
- If a user requests 1:1/parity/recreation work, add a fidelity policy or REQ-level fidelity contract before implementation.
- Mark assumptions as assumptions. Never silently convert assumptions into facts.
- Requirement changes happen before task/package/code changes.