# Source Layout

This skill expects source material to be local and versioned separately from generated catalogs.

## Preferred Layout For Packaging

```text
sources/
  agency-agents-zh/
    engineering/
    design/
    marketing/
    ...
  mattpocock-skills/
    skills/
      engineering/
      productivity/
      misc/
  local-skills/
    ai-progressive-workflow/
      SKILL.md
    context-budget-guard/
      SKILL.md
catalog/
  experts.jsonl
  coding-skills.jsonl
```

Use this layout when the skill should be portable or packaged as a single directory. Copy source working-tree files into `sources/`, but exclude upstream `.git/` directories.

## Sibling Repository Layout

When the upstream repositories are checked out beside this skill during development, the catalog builder can also read them without copying:

```text
agent-context-router/
agency-agents-zh/
skills/
```

`scripts/build_catalog.py` searches both layouts, preferring bundled sources:

- `sources/agency-agents-zh/`, then `../agency-agents-zh/`
- `sources/mattpocock-skills/`, then `../skills/`
- `sources/local-skills/`

Catalog paths are written relative to the `agent-context-router/` root. Sibling sources appear as `../agency-agents-zh/...` and `../skills/...`.

## Catalog Records

`catalog/experts.jsonl`:

```json
{"name":"engineering-code-reviewer","title":"Code Reviewer","description":"Code review, security audit, quality checks","path":"../agency-agents-zh/engineering/engineering-code-reviewer.md","tags":["engineering","review","quality"]}
```

`catalog/coding-skills.jsonl`:

```json
{"name":"tdd","description":"Test-driven development with red-green-refactor loop","path":"../skills/skills/engineering/tdd/SKILL.md","tags":["engineering","testing","implementation"]}
```

Local workflow skills are indexed into `catalog/coding-skills.jsonl` alongside upstream engineering skills.

## Updating Sources

Keep upstream content in `sources/` or sibling repositories. Rebuild catalogs after pulling updates:

```powershell
python .\scripts\build_catalog.py
```

The catalog is an index, not the source of truth.

## Installing The Packaged Skill

From the `agent-context-router/` root, install or refresh the Codex copy:

```powershell
.\install.ps1 -Target codex
```

The script rebuilds catalogs in the source repository, then syncs `<codex-home>/skills/agent-context-router` as a git checkout. Existing install targets must be clean git repositories and are refreshed with `git pull --ff-only`; missing targets are cloned from the source repository remote. `<codex-home>` is resolved from `-CodexHome`, then `CODEX_HOME`, then the current user's default `.codex` directory. It is the intended maintenance entrypoint for future app targets.
