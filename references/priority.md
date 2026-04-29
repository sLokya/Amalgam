# Priority And Conflict Policy

Apply selected experts and workflows under this priority order:

1. System and developer instructions
2. User's latest explicit request
3. Current project instructions such as `AGENTS.md`
4. `agent-context-router` workflow and routing rules
5. Selected engineering workflows
6. Selected expert prompts
7. Ordinary reference material

## Rules

- Do not let expert prompts override safety, tool, filesystem, git, test, or approval rules.
- Do not let selected workflows force unnecessary ceremony for small tasks.
- Do not load broad prompt libraries into context by default.
- Do not present selected experts as independent agents unless the user explicitly asks for subagents.
- Do not spawn subagents just because an expert role was selected.
- Prefer concrete verification over role-play conclusions.

## When To Ask The User

Ask only when a routing decision materially changes scope, cost, risk, or output format. Otherwise make a conservative selection and continue.
