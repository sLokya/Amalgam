---
name: ai-progressive-workflow
description: Requirements-led progressive AI development workflow with slicing, REQ/WP traceability, rollback labels, strict change-scope control, detailed implementation/error logs, business-flow verification, memory sync, fidelity contracts, and self-correction. Use for medium-to-large features, cross-platform work, long-running projects, fragile refactors, UI recreation/fidelity work, or any task where uncontrolled changes would create cascading risk.
---

# AI Progressive Workflow

Use this workflow when correctness depends on requirements, traceability, controlled scope, rollback, fidelity to a reference, or multi-step implementation. Keep this entrypoint small; load the detailed references only for the step you are performing.

## Hard Order

1. Load context minimally: read `requirements.md` first when it exists.
2. Establish or update requirements before coding. The requirements document is the source of truth for completion definitions, fidelity targets, gap lists, work packages, and slice order.
3. If the work includes recreation, cloning, redesign, migration, parity, or "same as" behavior, define the fidelity contract in `requirements.md` before implementation. Do not treat "1:1" or "match the original" as a style preference.
4. Confirm change scope: allowed files, forbidden files, affected layers, non-goals, and allowed deviations from requirements or references.
5. Slice the work from the requirements document: feature -> REQ -> WP -> SLICE -> OP. Execute one active slice at a time.
6. Create a textual rollback label before each slice.
7. Implement the slice with the smallest verifiable change.
8. Log implementation details and analyze errors from logs before fixing.
9. Verify against the requirement completion definition, business flow, regression points, and requirement/work-package state.
10. Update the requirements document with status, evidence, gaps, partial implementations, placeholders, and unverified risks before reporting completion.
11. Sync memory before reporting completion.

## Load References On Demand

- Requirements and memory layout: [references/memory.md](references/memory.md)
- Fidelity contracts and recreation work: [references/fidelity.md](references/fidelity.md)
- Slicing and work packages: [references/slicing.md](references/slicing.md)
- Rollback labels: [references/rollback.md](references/rollback.md)
- Change scope control: [references/scope.md](references/scope.md)
- Implementation and error logs: [references/logging.md](references/logging.md)
- Verification and self-correction: [references/verification.md](references/verification.md)
- Root cause analysis: [references/root-cause.md](references/root-cause.md)
- Rule evolution: [references/rule-evolution.md](references/rule-evolution.md)

## Required Active State

Before coding, establish:

```text
REQ/WP/SLICE:
Requirement source:
Completion definition:
Fidelity contract: none / required / active
Allowed files:
Forbidden files:
Allowed deviations:
Rollback label:
Acceptance check:
Evidence target:
Gap log target:
Log target:
```

If any field is unknown and changes behavior, scope, data contract, fidelity, completion status, or risk, stop and clarify or create a discovery slice.

## Embedded Coding Guardrails

For each slice, apply these lightweight coding rules without loading a separate coding-guard skill:

- State material assumptions before editing.
- Make the smallest change that satisfies the requirement's completion definition.
- Touch only files allowed by the scope contract.
- Match existing project style and avoid speculative abstractions.
- Define verification before editing and report it after the slice.
- Treat placeholders, mock-only paths, unverified flows, and visual approximations as incomplete unless the requirement explicitly accepts them.

## Non-Negotiables

- Requirements are the control plane; do not invent a weaker completion definition in chat.
- One active slice at a time.
- Do not expand scope just because a nearby issue is visible.
- If one change forces unrelated changes, stop and classify it as a scope cascade.
- Do not fix an error by guessing only; inspect the error log/evidence first.
- When failure repeats or verification fails, load root-cause analysis before making another code change.
- Only evolve workflow rules when evidence shows a reusable process gap.
- Do not run destructive rollback commands automatically.
- Do not report a requirement, UI recreation, or business flow as complete until the requirement document contains matching status and evidence.
- Final chat stays concise; detailed facts belong in `requirements.md` or logs.

## Final Response Shape

```text
REQ/WP/SLICE:
Completion definition:
Fidelity contract:
Rollback label:
Changed files:
Verification/evidence:
Requirements updated:
Gaps/partial implementations:
Unverified risks:
Next slice:
```