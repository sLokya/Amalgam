# Verification And Self-Correction

Completion requires relevant checks:

- Requirement status matches implementation status.
- Requirement completion definition is satisfied as written in `requirements.md`.
- Evidence is attached or listed against the requirement.
- Known gaps, placeholders, partial implementations, and unverified paths are recorded in `requirements.md`.
- Work package and slice status are updated.
- Main business flow is verified.
- Failure/empty/permission/loading states are considered when relevant.
- Cross-surface contract is checked for frontend/backend/miniprogram/API changes.
- Regression points listed in the scope contract are checked or explicitly marked unverified.
- Implementation log and error analysis are updated.
- Final chat does not introduce new material gaps or completion claims that are absent from `requirements.md`.

Build passing is not enough when business flow is unverified.

## Startup Verification

- Startup scripts should make stale output unlikely: clear build/tool caches that are safe to regenerate, then compile/build before launching.
- Do not clear user data, uploaded assets, databases, or secrets unless the requirement explicitly asks for a reset.
- Record script behavior in requirements: what is cleaned, what is preserved, what commands run, ports, URLs, and default credentials.
- If the UI still differs after a rebuild, treat it as an implementation/fidelity gap, not a cache issue.

For fidelity or recreation work, completion additionally requires:

- Reference source is recorded.
- Required surfaces and regions are checked.
- Every visible control is connected to real state, API, navigation, persistence, or an explicit documented gap. Visual parity must not turn functional controls into static demos.
- Allowed deviations are documented before acceptance.
- Screenshots, visual diffs, checklists, or equivalent evidence are recorded.
- Any missing source assets or unverifiable regions are listed as gaps.

Self-correction triggers:

- User says the result is off.
- Same issue repeats.
- Verification fails.
- Scope starts expanding.
- Requirements or memory cannot explain the current work.
- The final result is judged against a reference that was not captured in requirements.
- The implementation is "functionally present" but not aligned with the requirement completion definition.

Process:

1. Stop adding code.
2. Classify cause: requirement gap, missing completion definition, missing fidelity contract, bad slice, scope creep, wrong layer, missing contract, weak verification, or implementation bug.
3. Update requirements/log/rules first.
4. Resume with a smaller requirement-backed slice.
5. Add a prevention rule to error analysis or change log.
