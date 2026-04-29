# Change Scope Control

Before edits, establish:

```markdown
## Change Scope Contract
- Active REQ/WP/SLICE:
- Allowed files/directories:
- Forbidden files/directories:
- Allowed behavior changes:
- Explicit non-goals:
- Expected downstream impact:
- Regression points:
```

Rules:

- Do not edit outside allowed files without updating the contract first.
- Do not expand scope just because a nearby issue is visible.
- If a change forces new changes in unrelated files, stop and classify it as a scope cascade.
- If the cascade is required, create a new REQ/WP/slice or ask the user.
- Public/shared modules require listing known callers and regression points before editing.
- Do not modify a file simply because it is visible in app context.

Scope cascade signs:

- A UI change requires backend contract changes that were not in scope.
- A bug fix requires broad refactoring to pass.
- A helper change creates multiple call-site edits.
- A type change leaks across modules.

Response to cascade:

1. Stop editing.
2. Log the cascade.
3. Decide whether to split, ask, or defer.
