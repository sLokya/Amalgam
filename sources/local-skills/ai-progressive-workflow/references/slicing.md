# Slicing And Work Packages

Use these levels:

- `REQ`: user-visible requirement or contractual behavior.
- `WP`: independently verifiable work package tied to one main REQ.
- `SLICE`: small vertical step inside one WP.
- `OP`: one file-level or command-level operation.

Rules:

- One active slice at a time.
- One slice must have one primary acceptance check.
- If a slice touches more than 5 files, split it.
- If a slice changes more than one layer and no contract exists, create a contract slice first.
- If a bug fix requires unrelated cleanup, split cleanup into a later slice.
- If the next change is only necessary because of the previous change, stop and re-check scope before continuing.

Template:

```markdown
### SLICE-001 <title>
- REQ:
- WP:
- Goal:
- Allowed files:
- Forbidden files:
- Entry condition:
- Acceptance check:
- Rollback label:
- Status: todo / doing / blocked / done
```

Low-capability guardrails:

- Prefer one slice over a broad plan.
- Prefer explicit tables/templates over prose.
- Prefer reading exact files over relying on memory.
- Ask only when a decision changes scope, behavior, data contract, or risk.
