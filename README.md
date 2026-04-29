# agent-context-router

`agent-context-router` 是一个给 Codex / 其他 Agent 使用的轻量上下文路由技能。它不启动真正的多 Agent 流程，而是在每次任务开始时，按任务类型选择最少量的专家视角、工程工作流和本地约束，再把它们组装成当前任务需要的上下文。

目标很简单：让 Agent 少带无关上下文，少做越界改动，在复杂任务里能分片、留回退点、看日志、做根因分析，并且在需要用户选择或确认时先停下来。

## 当前能力

- 专家路由：从 `agency-agents-zh` 精简源码中选择最多 3 个专家角色。
- 工程路由：从 `mattpocock/skills` 精简源码和本地技能中选择最多 3 个工程工作流。
- 上下文预算：默认使用 `context-budget-guard` 控制本技能额外加载的上下文。
- 内置编码基线：已经吸收 `karpathy-guidelines` 核心行为，不再单独保留该技能。
- 渐进式开发：通过 `ai-progressive-workflow` 支持 REQ/WP/SLICE、回退标签、变更范围、日志、验证、RCA 和规则演进。
- 执行确认门：当任务是评估/方案选择/高风险改动/大范围操作时，先向用户确认再执行。
- 本地维护脚本：通过 `install.ps1` 重建 catalog 并同步到 Codex skills。

## 目录结构

```text
agent-context-router/
  SKILL.md
  README.md
  install.ps1
  agents/
  catalog/
    experts.jsonl
    coding-skills.jsonl
  references/
    priority.md
    routing.md
    source-layout.md
    route-context-token-report.md
  scripts/
    build_catalog.py
  sources/
    agency-agents-zh/
    mattpocock-skills/
    local-skills/
      ai-progressive-workflow/
      context-budget-guard/
```

`SKILL.md` 是给 Agent 读取的轻量入口；`README.md` 是给人维护和理解项目用的入口。详细规则尽量放在 `references/` 或子技能引用文件中，避免每次触发都加载过多内容。

## 路由流程

每次触发后，路由器按以下顺序工作：

1. 判断任务类型：`clarify`、`implement`、`debug`、`review`、`architecture`、`docs`、`domain`。
2. 对开发任务应用内置编码基线：
   - 明确关键假设
   - 选择最小完整改动
   - 避免 speculative abstraction 和无关清理
   - 先定义验证或成功标准
3. 应用执行确认门，判断是否需要先让用户确认。
4. 对非平凡任务应用 `context-budget-guard`。
5. 必要时读取 `references/routing.md` 和 `references/priority.md`。
6. 最多选择 3 个专家角色、3 个工程工作流。
7. 只加载被选中的源文件。
8. 像普通 Codex 一样继续做事：读代码、改小步、验证、汇报。

## 执行确认门

只有当用户明确要求执行，并且下一步动作窄、可回退、在已说明范围内时，Agent 才应直接执行。

遇到下面情况要先确认：

- 用户是在做评估、设计、比较、可行性判断，或问“要不要”。
- 动作会删除或重构技能、源码目录、catalog、脚本、配置、依赖、安装目标。
- 改动超过一个明确 slice、超过 5 个主要文件，或跨多个独立子系统。
- 操作具有破坏性、难回滚、成本高、依赖网络，或可能让用户意外。
- Agent 提出了多个方案，但用户还没选。
- 需求、允许文件、禁止文件、验收标准不清楚。

确认格式：

```text
Proposed action:
Scope:
Files/commands:
Risks:
Verification:
Need confirmation:
```

用户回复“执行”“加”“按这个做”“go”等明确批准后，只代表批准当前描述的范围。新范围需要重新确认。

## ai-progressive-workflow

`ai-progressive-workflow` 用于中大型功能、跨端改动、脆弱重构、长周期项目、需求追踪、回滚和日志要求明显的任务。

硬顺序：

1. 最小化加载上下文，存在 `requirements.md` 时先读它。
2. 编码前建立或更新需求。
3. 确认变更范围：允许文件、禁止文件、影响层、非目标。
4. 分片：`feature -> REQ -> WP -> SLICE -> OP`，一次只执行一个 active slice。
5. 每个 slice 前创建文本回退标签。
6. 用最小可验证改动实现 slice。
7. 记录实现日志，并根据错误日志分析后再修。
8. 验证业务流、回归点和 REQ/WP 状态。
9. 汇报前同步记忆。

APW 的入口保持较小，细节按需加载：

- `references/memory.md`
- `references/slicing.md`
- `references/rollback.md`
- `references/scope.md`
- `references/logging.md`
- `references/verification.md`
- `references/root-cause.md`
- `references/rule-evolution.md`

`root-cause.md` 只在失败重复、验证失败、用户否定结果、范围蔓延或需求/代码不一致时加载。`rule-evolution.md` 只在 RCA 证明存在可复用流程缺口时加载。

## context-budget-guard

`context-budget-guard` 是默认上下文预算守门员。它只能限制本技能额外选择的上下文，不能删除 Codex App 已经注入的上下文。

核心策略：

- 先看 catalog、路径、文件名、摘要、搜索结果。
- 大项目先用 `rg`、文件树、符号搜索定位。
- 默认最多 5 个主要代码文件进入 active file set。
- 不从一个文件一路追开无关文件。
- 每个新文件都要有加载理由。
- 长日志、生成文件、lockfile、大 diff 默认视为重上下文。

## 专家和工作流选择

默认倾向：

| 任务 | 专家 | 工作流 |
| --- | --- | --- |
| 需求澄清 | 产品经理、软件架构师、领域专家 | `grill-with-docs`、`to-prd` |
| 功能实现 | 相关前端/后端/移动/数据/AI 工程师 | `tdd`、必要时 APW |
| 调试 | 相关工程师、代码审查、SRE | `diagnose`、`tdd` |
| 审查 | 代码审查、安全工程师、领域工程师 | `zoom-out`、可疑行为用 `diagnose` |
| 架构 | 软件/后端/前端/数据库架构角色 | `improve-codebase-architecture`、`zoom-out` |
| 文档 | 技术写作者、相关领域工程师 | `zoom-out`、`grill-with-docs` |
| 非代码领域 | 最具体领域专家 | `grill-me` 或不加载工程流 |

专家是视角和检查清单，不是比系统、用户、项目规则更高的指令来源。

## 优先级

冲突时按下面顺序处理：

```text
system/developer/user > project instructions > agent-context-router > workflows > experts > references
```

如果专家 prompt 和用户指令冲突，用户指令优先。如果工程工作流和安全/文件系统限制冲突，安全和工具限制优先。

## 安装到 Codex

在源目录执行：

```powershell
cd <agent-context-router>
.\install.ps1 -Target codex
```

脚本会：

1. 运行 `scripts/build_catalog.py`
2. 重建 `catalog/experts.jsonl` 和 `catalog/coding-skills.jsonl`
3. 覆盖安装到：

```text
<codex-home>\skills\agent-context-router
```

`<codex-home>` 的解析顺序：

1. 命令参数 `-CodexHome <path>`
2. 环境变量 `$env:CODEX_HOME`
3. 当前用户 home 下的 `.codex` 目录

例如：

```powershell
.\install.ps1 -Target codex -CodexHome <codex-home>
```

安装后需要重启 Codex App 或开启新对话，技能列表和描述才会完全刷新。

## 更新源码

当前采用“复制源码进 sources”的方式，方便后续打包和跨工具分发。

建议流程：

1. 更新或替换 `sources/agency-agents-zh/`、`sources/mattpocock-skills/`、`sources/local-skills/` 中需要的部分。
2. 保持精简，不要把上游完整 Git 项目无差别塞进 `sources/`。
3. 执行：

```powershell
.\install.ps1 -Target codex
```

4. 检查 catalog 数量和技能是否正常。

当前 catalog 大致状态：

```text
experts: 211
coding skills: 18
```

## 兼容其他 Agent

这个目录不是 Codex 专属。其他 Agent 可以读取：

- `SKILL.md`：主入口
- `references/routing.md`：路由规则
- `references/priority.md`：优先级
- `catalog/*.jsonl`：可检索目录
- `sources/**/SKILL.md` 或专家 Markdown：实际上下文来源

`install.ps1 -Target all` 目前只包含 Codex 安装和占位提示。后续可以在脚本里继续添加 Claude Code、Cursor、OpenCode、Qwen、Gemini 等工具的同步方法。

## 维护原则

- 入口要轻，细节按需加载。
- 本地约束优先沉淀成小 reference，而不是塞满 `SKILL.md`。
- APW 只在值得分片、回滚、追踪和记录时触发。
- 小任务只走内置编码基线和必要专家，不启用重流程。
- 删除、重构、批量同步、方案未定时先确认。
- 测试报告记录在 `references/route-context-token-report.md`，用于观察不同场景下路由选择和 token 规模。
