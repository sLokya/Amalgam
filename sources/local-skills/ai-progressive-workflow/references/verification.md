# Verification And Self-Correction

Completion requires relevant checks:

- Requirement status matches implementation status.
- Work package and slice status are updated.
- Main business flow is verified.
- Failure/empty/permission/loading states are considered when relevant.
- Cross-surface contract is checked for frontend/backend/miniprogram/API changes.
- Regression points listed in the scope contract are checked or explicitly marked unverified.
- Implementation log and error analysis are updated.

Build passing is not enough when business flow is unverified.

Self-correction triggers:

- User says the result is off.
- Same issue repeats.
- Verification fails.
- Scope starts expanding.
- Requirements or memory cannot explain the current work.

Process:

1. Stop adding code.
2. Classify cause: requirement gap, bad slice, scope creep, wrong layer, missing contract, weak verification, or implementation bug.
3. Update requirements/log/rules first.
4. Resume with a smaller slice.
5. Add a prevention rule to error analysis or change log.
