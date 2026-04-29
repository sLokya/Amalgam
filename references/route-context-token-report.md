# Route Context Token Report

Tokenizer: `tiktoken` `cl100k_base`.

These counts measure only context intentionally selected by `agent-context-router`. They do not include system/developer messages, user chat history, app-injected code context, or files loaded later for the concrete coding task.

Date: 2026-04-29.

## Current Router Shape

- `karpathy-guidelines` is no longer a selected skill inside `agent-context-router`.
- Its core behavior is absorbed into the router's built-in coding baseline and `ai-progressive-workflow` embedded coding guardrails.
- `ai-progressive-workflow` should trigger only when slicing, rollback labels, logs, traceability, business-flow verification, RCA, or long-running memory are worth the extra process.
- APW reference files are loaded progressively; `root-cause.md` and `rule-evolution.md` are not loaded during normal successful implementation.

## Core File Sizes

| File | Tokens |
| --- | ---: |
| `SKILL.md` | 1119 |
| `references/routing.md` | 899 |
| `sources/local-skills/ai-progressive-workflow/SKILL.md` | 703 |

## APW Slicing Trigger Matrix

| Scenario | APW | Files | Tokens | APW refs | Result |
| --- | --- | ---: | ---: | --- | --- |
| `T1-small-ui-copy` | No | 5 | 6969 | none | APW skipped: no traceability, rollback, slicing, or log requirement. |
| `T2-medium-feature-req-wp` | Yes | 14 | 17248 | memory.md, slicing.md, scope.md, rollback.md, verification.md | APW triggered: medium cross-layer feature with traceability and rollback. |
| `T3-fragile-cross-platform-refactor` | Yes | 14 | 14902 | slicing.md, scope.md, rollback.md, logging.md, verification.md | APW triggered: fragile refactor, cross-platform impact, business-flow verification. |
| `T4-repeated-failing-fix` | Yes + RCA | 12 | 13948 | logging.md, verification.md, root-cause.md | APW triggered and deepened: repeated failure loads root-cause; rule-evolution still skipped. |
| `T5-process-gap-after-rca` | Yes + RCA + evolution | 9 | 9223 | root-cause.md, rule-evolution.md | Rule-evolution loads only after RCA identifies a reusable process gap. |
| `T6-large-codebase-orientation` | No | 6 | 6475 | none | APW skipped: context discovery only, no active delivery slice. |
| `T7-security-review` | No | 7 | 13067 | none | APW skipped: review task unless a controlled fix plan is requested. |
| `T8-production-incident-rollback-log` | Yes + RCA | 13 | 17379 | scope.md, rollback.md, logging.md, verification.md, root-cause.md | APW triggered: incident, rollback, logs, verification, root-cause evidence. |

Observation: APW entry and references stay small. Token pressure still mostly comes from selected expert prompts, not APW itself. Further budget improvements should tighten expert selection before shrinking APW further.
