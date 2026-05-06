# Fidelity Contracts

Use this reference when the task includes 1:1 recreation, cloning, parity, redesign from a reference, migration parity, or matching an existing product/page/flow.

## Requirement-Level Contract

Define fidelity in `requirements.md` before implementation. A vague instruction such as "make it the same", "1:1", "restore the original", or "match the screenshot" is not actionable until it is converted into a contract.

Template:

```markdown
## Fidelity Contract
- Related REQ:
- Reference source: screenshot / live URL / design file / existing app / previous commit / user description
- Reference capture date/version:
- Surfaces to match: desktop / mobile / tablet / API / behavior / data / copy / assets
- Regions or flows:
- Must match exactly:
- Acceptable deviations:
- Forbidden substitutions:
- Required assets:
- Evidence required: screenshots / visual diff / DOM check / API trace / manual checklist
- Completion gate:
```

## UI Recreation Rules

- Identify the reference source at the start. If it is missing, create a discovery slice or ask for it.
- Break UI work into visible regions before coding: header, navigation, main content, cards/tables, forms, empty states, dialogs, loading/error states, and responsive breakpoints.
- Record source assets and brand anchors in requirements before inventing replacements.
- Do not replace a reference with a generic admin layout unless the requirements explicitly allow that deviation.
- Do not call the UI complete until screenshots or equivalent evidence are attached/listed against the REQ.

## Behavior Parity Rules

- Define expected user flows in requirements before implementation.
- For each flow, record the observable result, persisted data, API calls, and failure states.
- Mocked, local-only, or placeholder behavior is partial unless the REQ explicitly defines it as acceptable.

## Gap Handling

When fidelity cannot be met immediately:

1. Add the gap to `requirements.md` under `Gap Register`.
2. Mark the related REQ as partial or blocked.
3. Record what evidence is missing: source asset, screenshot, credentials, API key, environment, or verification tool.
4. Create or defer a follow-up slice tied to the same REQ.
5. Do not downgrade the completion definition silently.