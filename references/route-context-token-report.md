# Route Context Token Report

Tokenizer: `tiktoken` `cl100k_base`.

These counts measure only context intentionally selected by `agent-context-router`. They do not include system/developer messages, user chat history, app-injected code context, or files loaded later for the concrete coding task.

| Scenario | Intended Coverage | Files | Tokens |
| --- | --- | ---: | ---: |
| `S1-debug-backend-login-500` | debug + backend architect + code reviewer + context guard + karpathy + diagnose + tdd | 9 | 10890 |
| `S2-cross-platform-requirements-workflow` | implement/clarify + architects + context guard + ai-progressive entry + selected refs + grill-with-docs | 13 | 13783 |
| `S3-large-context-budget-code-containment` | architecture/clarify + context guard + karpathy + software architect + zoom-out | 7 | 6356 |
| `S4-error-log-fix-with-progressive-workflow` | debug + context guard + ai-progressive entry + logging/verification refs + code reviewer + diagnose + tdd | 10 | 8943 |

## S1-debug-backend-login-500

Request: ?????? 500??????????????

Total: `10890` tokens

| File | Tokens | Chars |
| --- | ---: | ---: |
| `SKILL.md` | 804 | 3830 |
| `references/routing.md` | 856 | 4016 |
| `references/priority.md` | 196 | 1005 |
| `sources/local-skills/context-budget-guard/SKILL.md` | 981 | 4638 |
| `sources/local-skills/karpathy-guidelines/SKILL.md` | 239 | 1205 |
| `sources/agency-agents-zh/engineering/engineering-backend-architect.md` | 2718 | 5021 |
| `sources/agency-agents-zh/engineering/engineering-code-reviewer.md` | 2473 | 3441 |
| `sources/mattpocock-skills/skills/engineering/diagnose/SKILL.md` | 1655 | 7116 |
| `sources/mattpocock-skills/skills/engineering/tdd/SKILL.md` | 968 | 4371 |

## S2-cross-platform-requirements-workflow

Request: ? Web ?????????????? requirements.md?REQ/WP?????????????

Total: `13783` tokens

| File | Tokens | Chars |
| --- | ---: | ---: |
| `SKILL.md` | 804 | 3830 |
| `references/routing.md` | 856 | 4016 |
| `references/priority.md` | 196 | 1005 |
| `sources/local-skills/context-budget-guard/SKILL.md` | 981 | 4638 |
| `sources/local-skills/ai-progressive-workflow/SKILL.md` | 558 | 2664 |
| `sources/local-skills/ai-progressive-workflow/references/memory.md` | 221 | 1003 |
| `sources/local-skills/ai-progressive-workflow/references/slicing.md` | 260 | 1147 |
| `sources/local-skills/ai-progressive-workflow/references/scope.md` | 234 | 1082 |
| `sources/local-skills/ai-progressive-workflow/references/rollback.md` | 168 | 692 |
| `sources/agency-agents-zh/engineering/engineering-software-architect.md` | 3188 | 4569 |
| `sources/agency-agents-zh/engineering/engineering-backend-architect.md` | 2718 | 5021 |
| `sources/agency-agents-zh/engineering/engineering-frontend-developer.md` | 2833 | 4429 |
| `sources/mattpocock-skills/skills/engineering/grill-with-docs/SKILL.md` | 766 | 3375 |

## S3-large-context-budget-code-containment

Request: ???????????????????????????????

Total: `6356` tokens

| File | Tokens | Chars |
| --- | ---: | ---: |
| `SKILL.md` | 804 | 3830 |
| `references/routing.md` | 856 | 4016 |
| `references/priority.md` | 196 | 1005 |
| `sources/local-skills/context-budget-guard/SKILL.md` | 981 | 4638 |
| `sources/local-skills/karpathy-guidelines/SKILL.md` | 239 | 1205 |
| `sources/agency-agents-zh/engineering/engineering-software-architect.md` | 3188 | 4569 |
| `sources/mattpocock-skills/skills/engineering/zoom-out/SKILL.md` | 92 | 430 |

## S4-error-log-fix-with-progressive-workflow

Request: ???????????????????????????????

Total: `8943` tokens

| File | Tokens | Chars |
| --- | ---: | ---: |
| `SKILL.md` | 804 | 3830 |
| `references/routing.md` | 856 | 4016 |
| `references/priority.md` | 196 | 1005 |
| `sources/local-skills/context-budget-guard/SKILL.md` | 981 | 4638 |
| `sources/local-skills/ai-progressive-workflow/SKILL.md` | 558 | 2664 |
| `sources/local-skills/ai-progressive-workflow/references/logging.md` | 248 | 996 |
| `sources/local-skills/ai-progressive-workflow/references/verification.md` | 204 | 1051 |
| `sources/agency-agents-zh/engineering/engineering-code-reviewer.md` | 2473 | 3441 |
| `sources/mattpocock-skills/skills/engineering/diagnose/SKILL.md` | 1655 | 7116 |
| `sources/mattpocock-skills/skills/engineering/tdd/SKILL.md` | 968 | 4371 |

## APW Slicing Trigger Matrix

Date: 2026-04-29.

This run focuses on whether `ai-progressive-workflow` triggers only for tasks that need slicing, rollback labels, logs, traceability, or root-cause discipline. `karpathy-guidelines` is treated as covered by APW's embedded coding guardrails when APW is selected, so it does not consume a separate workflow slot in APW scenarios.

| Scenario | APW | Files | Tokens | APW refs | Result |
| --- | --- | ---: | ---: | --- | --- |
| `T1-small-ui-copy` | No | 6 | 6986 | none | APW skipped: no traceability, rollback, slicing, or log requirement. |
| `T2-medium-feature-req-wp` | Yes | 14 | 17026 | memory.md, slicing.md, scope.md, rollback.md, verification.md | APW triggered: medium cross-layer feature with traceability and rollback. |
| `T3-fragile-cross-platform-refactor` | Yes | 14 | 14680 | slicing.md, scope.md, rollback.md, logging.md, verification.md | APW triggered: fragile refactor, cross-platform impact, business-flow verification. |
| `T4-repeated-failing-fix` | Yes + RCA | 12 | 13726 | logging.md, verification.md, root-cause.md | APW triggered and deepened: repeated failure loads root-cause; rule-evolution still skipped. |
| `T5-process-gap-after-rca` | Yes + RCA + evolution | 9 | 9001 | root-cause.md, rule-evolution.md | Rule-evolution loads only after RCA identifies a reusable process gap. |
| `T6-large-codebase-orientation` | No | 7 | 6492 | none | APW skipped: context discovery only, no active delivery slice. |
| `T7-security-review` | No | 8 | 13084 | none | APW skipped: review task unless a controlled fix plan is requested. |
| `T8-production-incident-rollback-log` | Yes + RCA | 13 | 17157 | scope.md, rollback.md, logging.md, verification.md, root-cause.md | APW triggered: incident, rollback, logs, verification, root-cause evidence. |

Observation: APW's own entrypoint and reference files stay small; selected expert prompts dominate token count in larger scenarios. Further budget improvements should prefer stricter expert selection before shrinking APW further.
