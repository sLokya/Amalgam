# Rule Evolution

Use this after root-cause analysis to decide whether to update workflow rules, project memory, requirements, or only implementation.

The goal is learning without making the workflow heavier after every small bug.

## Evolution Gate

Create or update a rule only when at least one is true:

- The same class of issue happened more than once.
- A missing check allowed an expensive mistake.
- A scope cascade happened because boundaries were unclear.
- A requirement/contract ambiguity caused implementation churn.
- A verification gap let wrong behavior look complete.
- A future agent would likely repeat the mistake without a rule.

Do not create a new rule when:

- The issue is a one-off typo.
- Existing rules already covered it but were ignored.
- The fix is purely local and unlikely to recur.
- The rule would be vague, unenforceable, or too broad.

## Rule Patch Template

```markdown
## Rule Evolution

### Trigger
- RCA reference:
- Repeated or high-impact issue:

### Existing Rule
- Where it should have been prevented:
- Why it failed:

### Proposed Rule
- New/updated rule:
- Applies when:
- Does not apply when:
- Required evidence/check:

### Placement
Choose one:
- requirements.md
- requirements.md#Verification
- requirements.md#Change Scope
- optional/logs/
- ai-progressive-workflow reference
- project AGENTS.md

### Cost Check
- Added process cost:
- Expected prevention value:
- Keep / reject / revisit later:
```

## Rule Quality Checklist

A good rule is:

- Triggerable: a future model knows when to apply it.
- Observable: it names evidence or a check.
- Small: it does not slow unrelated tasks.
- Actionable: it changes a step, file, test, or decision.
- Scoped: it says when not to apply.

## Existing Rule Was Ignored

If the process already had a rule but the model skipped it:

1. Do not add another duplicate rule.
2. Move the rule closer to the triggering step.
3. Add a short checklist item or required field.
4. Add a verification gate that exposes the skip.

## Output

Keep final chat short:

```text
RCA category:
Rule evolved: yes/no
Rule location:
Why this rule is worth the cost:
```
