# Implementation And Error Logs

For coding tasks, leave detailed logs. Logs should be factual and useful for a future agent; keep final chat concise.

Minimum log entry:

```markdown
### LOG-YYYYMMDD-HHMM <slice>
- Intent:
- Files inspected:
- Files changed:
- Commands run:
- Result:
- Evidence:
- Assumptions:
- Open risks:
```

When any command, test, build, runtime check, or manual verification fails, add error analysis:

```markdown
### ERR-YYYYMMDD-HHMM <symptom>
- Trigger:
- Exact error:
- Reproduction command:
- Expected behavior:
- Observed behavior:
- Hypotheses:
  1. ...
  2. ...
  3. ...
- Evidence for/against each hypothesis:
- Root cause:
- Fix applied:
- Regression test/check:
- Prevention rule:
```

Hard rules:

- Do not fix an error by guessing only.
- Analyze the log first, then choose the smallest fix.
- If there is no reproducible signal, say so and ask for logs, traces, screenshots, or access.
- Do not hide failed commands; record them with the final diagnosis.
