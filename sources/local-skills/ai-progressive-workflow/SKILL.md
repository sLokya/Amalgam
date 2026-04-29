---
name: ai-progressive-workflow
description: Requirements-led progressive AI development workflow with slicing, REQ/WP traceability, rollback labels, strict change-scope control, detailed implementation/error logs, business-flow verification, memory sync, and self-correction. Use for medium-to-large features, cross-platform work, long-running projects, fragile refactors, or any task where uncontrolled changes would create cascading risk.
---

# AI Progressive Workflow

Use this workflow when correctness depends on requirements, traceability, controlled scope, rollback, or multi-step implementation. Keep this entrypoint small; load the detailed references only for the step you are performing.

## Hard Order

1. Load context minimally: read `requirements.md` first when it exists.
2. Establish or update requirements before coding.
3. Confirm change scope: allowed files, forbidden files, affected layers, and non-goals.
4. Slice the work: feature -> REQ -> WP -> SLICE -> OP. Execute one active slice at a time.
5. Create a textual rollback label before each slice.
6. Implement the slice with the smallest verifiable change.
7. Log implementation details and analyze errors from logs before fixing.
8. Verify business flow, regression points, and requirement/work-package state.
9. Sync memory before reporting completion.

## Load References On Demand

- Requirements and memory layout: [references/memory.md](references/memory.md)
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
Allowed files:
Forbidden files:
Rollback label:
Acceptance check:
Log target:
```

If any field is unknown and changes behavior, scope, data contract, or risk, stop and clarify or create a discovery slice.

## Embedded Coding Guardrails

For each slice, apply these lightweight coding rules without loading a separate coding-guard skill:

- State material assumptions before editing.
- Make the smallest change that satisfies the slice acceptance check.
- Touch only files allowed by the scope contract.
- Match existing project style and avoid speculative abstractions.
- Define the verification before editing and report it after the slice.

## Non-Negotiables

- One active slice at a time.
- Do not expand scope just because a nearby issue is visible.
- If one change forces unrelated changes, stop and classify it as a scope cascade.
- Do not fix an error by guessing only; inspect the error log/evidence first.
- When failure repeats or verification fails, load root-cause analysis before making another code change.
- Only evolve workflow rules when evidence shows a reusable process gap.
- Do not run destructive rollback commands automatically.
- Final chat stays concise; detailed facts belong in `requirements.md` or logs.

## Final Response Shape

```text
REQ/WP/SLICE:
Rollback label:
Changed files:
Verification:
Logs updated:
Unverified risks:
Next slice:
```
