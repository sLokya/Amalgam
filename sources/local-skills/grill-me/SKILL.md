---
name: grill-me
description: Direct user-alignment interview workflow. Use when requirements, plan, design, architecture, product direction, tradeoffs, scope, acceptance criteria, or implementation choices need alignment; ask the user directly instead of producing docs, PRDs, issues, or written plans unless the user explicitly requests those artifacts.
---

# Grill Me

Interview the user about every important branch of a plan, design, or requirement until shared understanding is reached. Resolve dependencies between decisions one by one.

## Trigger Conditions

Use this workflow when the task is primarily about alignment:

- requirements are unclear or competing
- the user wants to align before implementation
- design, architecture, product, or scope decisions are unresolved
- acceptance criteria, non-goals, or tradeoffs need confirmation
- the next coding action depends on user preference or business intent

Do not require the user to say "grill me" or any fixed trigger phrase.

## No Document Output During Alignment

During alignment, do not create or update docs, PRDs, issues, plans, requirements files, or decision records unless the user explicitly asks for those artifacts.

Default behavior: ask the user directly and continue the interview in chat.

If another workflow would normally output a document, defer that workflow until alignment is complete and the user asks for the artifact.

## How To Ask Questions

Ask one question at a time. Wait for the user's answer before moving to the next question.

If the host app provides an ask-user or multiple-choice tool, use it. Otherwise, ask directly in chat.

For each question, provide 2-4 concrete options when choices are predictable. Include a short "Other" option only when useful. Avoid generic "Yes/No" unless the question is genuinely binary.

## Flow

1. Identify the decision branch that blocks progress.
2. Ask the smallest useful question directly to the user.
3. After receiving an answer, briefly acknowledge the decision in 1-2 sentences.
4. Ask the next blocking question.
5. If a question can be answered by reading the codebase or files, inspect those files instead of asking the user.
6. Continue until the next action is clear enough to proceed or until a document-producing artifact is explicitly requested.

## Question Shape

```text
Question:
Options:
- A:
- B:
- C:
Why it matters:
```

Keep the question concise. Do not bundle several unrelated decisions into one question.

## Completion

When alignment is complete, provide a concise decision summary and the next recommended action. Do not write files unless the user explicitly approved that scope.
