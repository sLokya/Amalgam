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

## Feature List
| ID | Feature | Surface | Source | Alignment | Status | Acceptance | Work Package | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |

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
- If no `requirements.md` exists, create the smallest viable one or ask before development.
- Mark assumptions as assumptions. Never silently convert assumptions into facts.
- Requirement changes happen before task/package/code changes.
