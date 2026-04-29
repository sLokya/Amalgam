# Root Cause Analysis

Use this when a test/build/runtime check fails, the user says the result is wrong, a bug repeats, a fix creates another issue, scope cascades, or requirements and code disagree.

Do not rely on free-form reasoning. Fill the structure.

## Trigger Conditions

- Verification fails.
- Same symptom appears twice.
- User rejects the result.
- A change creates a new required change outside scope.
- Logs contradict the current hypothesis.
- Requirements, work package, code, or memory disagree.

## RCA Template

```markdown
## Root Cause Analysis

### Symptom
- What was observed:
- Where it appeared:
- Who/what reported it:

### Immediate Cause
- Direct failing code/config/data/step:
- Evidence:

### Root Cause Category
Choose one or more:
- requirement-gap
- wrong-slice
- scope-creep
- wrong-layer
- missing-contract
- weak-verification
- implementation-bug
- environment-config
- dependency-change-drift
- logging-gap
- unknown

### System Cause
- Why did the process allow this to happen?
- Which earlier step should have caught it?

### Evidence Table
| Hypothesis | Evidence for | Evidence against | Status |
| --- | --- | --- | --- |

### Exclusions
- What this is not:
- Why:

### Fix Level
Choose the lowest sufficient level:
- requirement
- slice-plan
- scope-contract
- implementation
- verification
- workflow-rule

### Prevention Rule
- New or updated rule:
- Where to record it:
- How it changes the next similar task:

### Confidence
- high / medium / low
- If low, what evidence is needed next:
```

## Hard Rules

- Do not call the visible symptom the root cause.
- Do not write "code bug" as the root cause.
- Do not claim a root cause without evidence.
- If evidence is insufficient, set category to `unknown` and define the next evidence-gathering step.
- Every root cause needs a prevention rule or an explicit reason why no reusable prevention exists.
- Every prevention rule must change a future step; otherwise it is just commentary.

## Three-Question Fallback

If the model is stuck, answer only these:

```text
1. Why was this error able to happen?
2. Why did the existing verification not catch it earlier?
3. Where should the next similar task be stopped or checked?
```
