# Rollback Labels

Before each slice, create a textual rollback label:

```text
RB-YYYYMMDD-HHMM-SLICE-001
```

Record it in `requirements.md#Implementation Log` or `optional/rollback/`.

Rollback label record:

```markdown
### RB-YYYYMMDD-HHMM-SLICE-001
- Scope:
- Files expected to change:
- Current git state: <clean / dirty + summary / not a git repo>
- Pre-change evidence:
- Undo plan:
- Do not rollback without user request:
```

Rules:

- Do not create git tags unless the user asks.
- Do not run destructive rollback commands automatically.
- Use labels to make rollback understandable and auditable.
- If the repo is dirty, summarize existing dirty files before starting the slice.
