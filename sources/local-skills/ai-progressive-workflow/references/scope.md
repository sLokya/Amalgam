# Change Scope Control

Before edits, establish:

```markdown
## Change Scope Contract
- Active REQ/WP/SLICE:
- Requirement source:
- Completion definition:
- Fidelity contract:
- Allowed files/directories:
- Forbidden files/directories:
- Allowed behavior changes:
- Allowed deviations from requirement/reference:
- Explicit non-goals:
- Expected downstream impact:
- Regression points:
```

Rules:

- Do not edit outside allowed files without updating the contract first.
- Do not weaken the requirement completion definition in the scope contract.
- Do not invent fidelity deviations during implementation; add them to requirements first.
- Do not expand scope just because a nearby issue is visible.
- If a change forces new changes in unrelated files, stop and classify it as a scope cascade.
- If the cascade is required, create a new REQ/WP/slice or ask the user.
- Public/shared modules require listing known callers and regression points before editing.
- Do not modify a file simply because it is visible in app context.

Scope cascade signs:

- A UI change requires backend contract changes that were not in scope.
- A recreation task lacks reference assets or visual evidence.
- A bug fix requires broad refactoring to pass.
- A helper change creates multiple call-site edits.
- A type change leaks across modules.

Response to cascade:

1. Stop editing.
2. Log the cascade in requirements or the implementation log.
3. Decide whether to split, ask, or defer.
4. If deferred, add a gap/follow-up slice tied to a REQ.