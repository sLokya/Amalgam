请直接执行，不要只给建议。

请把当前项目里的 `agent-context-router` 提升为本项目的项目级常驻路由入口。

先识别你这个 App 支持的项目级指令文件：Codex/通用 Agent 用 `AGENTS.md`，Claude Code 用 `CLAUDE.md`，Gemini 用 `GEMINI.md`，Cursor 用 `.cursor/rules/agent-context-router.mdc`。如果你有自己的项目级指令文件规范，使用你的规范。

如果文件已存在，只追加或更新 `Agent Context Router Bootstrap` 区块；如果不存在就创建。

不要写入任何本机绝对路径，只使用项目相对路径。不要复制专家全文、workflow 全文或 catalog 全文。

bootstrap 只负责让你在编码、调试、审查、架构、文档、复杂计划、大项目上下文风险时，先判断是否需要使用 `agent-context-router`。不要求用户说固定关键词。若需要路由，先读 `agent-context-router/SKILL.md`，必要时读 `agent-context-router/references/routing.md` 和 `agent-context-router/references/priority.md`，再从 `catalog/` 和 `sources/` 中加载最少量专家/工作流。

非平凡任务应用 `context-budget-guard`。只有中大型、跨模块、回滚、日志、REQ/WP、RCA、规则演进或长周期任务才使用 `ai-progressive-workflow`。广泛、破坏性、含糊、多 slice 的操作前必须先向用户确认。

完成后汇报你修改的文件和确认没有写入绝对路径。
