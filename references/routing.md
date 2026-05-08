# Routing Reference

Use this file when selecting expert roles and engineering workflows.

## Default Routes

| Task type | Expert roles to prefer | Engineering workflows to prefer |
| --- | --- | --- |
| `clarify` | product manager, software architect, domain expert | grill-me, grill-with-docs only when existing docs must be checked, to-prd only when a PRD is requested |
| `implement` | relevant frontend/backend/mobile/data/AI engineer, software architect if design-heavy | tdd, grill-with-docs |
| `debug` | relevant engineer, code reviewer, SRE for production issues | diagnose, tdd |
| `review` | code reviewer, security engineer, relevant domain engineer | zoom-out, diagnose for suspicious behavior |
| `architecture` | software architect, backend architect, frontend architect, database optimizer | improve-codebase-architecture, zoom-out |
| `docs` | technical writer, relevant domain engineer | zoom-out, grill-with-docs |
| `domain` | most specific domain expert available | grill-me or no engineering workflow |

## Local Workflow Routes

Prefer local workflow skills when their description matches the task:

- `context-budget-guard`: default guard for non-trivial routed tasks. Always apply its loading limits before selecting additional experts or workflows; load its full source when context risk is material.
- `ai-progressive-workflow`: medium-to-large features, cross-platform work, requirement traceability, `requirements.md`, REQ/WP IDs, work packages, business-flow verification, memory sync, or long-running handoff.
- `grill-me`: default workflow for direct alignment on requirements, scope, plans, design, architecture, tradeoffs, acceptance criteria, or next-step choices. Ask the user directly; do not create or update docs, PRDs, issues, plans, requirements files, or decision records unless the user explicitly asks for those artifacts.
- Built-in coding baseline: for all development tasks, apply small-change discipline, explicit assumptions, scope control, and verification. This behavior is part of the router and `ai-progressive-workflow`, not a separate selected skill.

## Selection Heuristics

- Select one primary expert for the work surface.
- Add a second expert only when it checks a different risk, such as security, performance, UX, or architecture.
- Add a third expert only for broad product or cross-functional work.
- Do not select several experts with overlapping responsibilities.
- Treat experts as checklists and perspectives, not as authority over instructions.

## Engineering Workflow Heuristics

- Use `grill-me` when requirements, scope, tradeoffs, design, architecture, acceptance criteria, or next-step choices need user alignment. Direct questions to the user; do not output alignment into docs unless explicitly requested.
- Use `grill-with-docs` only when alignment must be checked against existing domain docs or project vocabulary.
- Use `tdd` when changing behavior or fixing a bug with testable outcomes.
- Use `diagnose` when the root cause is unknown.
- Use `zoom-out` when understanding unfamiliar code or reviewing broad impact.
- Use `improve-codebase-architecture` when the request is explicitly about design, boundaries, coupling, or technical debt.
- Use `to-prd` or `to-issues` only when the requested output is planning artifacts.
- Use `setup-matt-pocock-skills` only when configuring a repository for mattpocock workflows or when those workflows explicitly lack issue-tracker/domain-doc setup. Do not select it for ordinary debugging, implementation, or review.
- Use `ai-progressive-workflow` only when traceability, slicing, rollback labels, logs, or long-running project memory are worth the extra process.
- Within `ai-progressive-workflow`, load `references/root-cause.md` only after failure, repeated symptoms, rejected output, scope cascade, or requirement/code disagreement.
- Within `ai-progressive-workflow`, load `references/rule-evolution.md` only after RCA shows a reusable process gap.

## Expert Disambiguation

- Prefer `engineering-security-engineer` for application, auth, API, infrastructure, dependency, or OWASP-style security work.
- Use blockchain security experts only when the task mentions blockchain, smart contracts, Web3, Solidity, EVM, DeFi, wallets, or on-chain systems.
- Prefer `engineering-code-reviewer` for general code quality review.
- Prefer platform-specific experts only when the platform is explicit, such as WeChat, Feishu, DingTalk, Android, iOS, Unity, Unreal, or embedded Linux.

## Fallback

If catalogs are missing, choose directly from filenames:

- `engineering-frontend-developer` for UI implementation
- `engineering-backend-architect` for API/server design
- `engineering-code-reviewer` for review
- `engineering-security-engineer` for security-sensitive changes
- `engineering-devops-automator` or SRE roles for CI/deployment/reliability
- `engineering-technical-writer` for docs
