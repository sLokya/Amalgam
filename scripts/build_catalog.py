#!/usr/bin/env python3
"""Build lightweight JSONL catalogs from local expert and skill sources."""

from __future__ import annotations

import json
import os
import re
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
SOURCES = ROOT / "sources"
CATALOG = ROOT / "catalog"


FRONTMATTER_RE = re.compile(r"\A---\s*\n(.*?)\n---\s*\n", re.DOTALL)


def read_frontmatter(path: Path) -> dict[str, str]:
    text = path.read_text(encoding="utf-8-sig", errors="replace")
    match = FRONTMATTER_RE.match(text)
    if not match:
        return {}

    fields: dict[str, str] = {}
    for line in match.group(1).splitlines():
        if ":" not in line:
            continue
        key, value = line.split(":", 1)
        fields[key.strip()] = value.strip().strip('"').strip("'")
    return fields


def tags_for(path: Path) -> list[str]:
    parts = [part.lower() for part in path.parts]
    tags: list[str] = []
    for tag in (
        "academic",
        "engineering",
        "design",
        "marketing",
        "product",
        "project-management",
        "testing",
        "security",
        "finance",
        "legal",
        "debug",
        "review",
        "architecture",
        "productivity",
        "misc",
        "sales",
        "support",
        "supply-chain",
        "game-development",
        "spatial-computing",
        "specialized",
    ):
        if any(tag in part for part in parts):
            tags.append(tag)
    return tags


def first_existing(paths: list[Path]) -> Path | None:
    for path in paths:
        if path.exists():
            return path
    return None


def display_path(path: Path) -> str:
    return Path(os.path.relpath(path, ROOT)).as_posix()


def iter_experts() -> list[dict[str, object]]:
    root = first_existing([SOURCES / "agency-agents-zh", ROOT.parent / "agency-agents-zh"])
    if root is None:
        return []

    records: list[dict[str, object]] = []
    for path in sorted(root.rglob("*.md")):
        if (
            path.name.upper().startswith("README")
            or ".github" in path.parts
            or "integrations" in path.parts
            or "examples" in path.parts
        ):
            continue
        fm = read_frontmatter(path)
        if not fm.get("name") and not fm.get("description"):
            continue
        records.append(
            {
                "name": path.stem,
                "title": fm.get("name", path.stem),
                "description": fm.get("description", ""),
                "path": display_path(path),
                "tags": tags_for(path),
            }
        )
    return records


def iter_coding_skills() -> list[dict[str, object]]:
    repo_root = first_existing([SOURCES / "mattpocock-skills", ROOT.parent / "skills"])
    local_root = SOURCES / "local-skills"
    records: list[dict[str, object]] = []

    if local_root.exists():
        for path in sorted(local_root.rglob("SKILL.md")):
            fm = read_frontmatter(path)
            name = fm.get("name") or path.parent.name
            records.append(
                {
                    "name": name,
                    "description": fm.get("description", ""),
                    "path": display_path(path),
                    "tags": sorted(set(tags_for(path) + ["local", "workflow"])),
                }
            )

    if repo_root is None:
        return records

    root = repo_root / "skills"
    if not root.exists():
        return records

    for path in sorted(root.rglob("SKILL.md")):
        if "deprecated" in path.parts:
            continue
        fm = read_frontmatter(path)
        name = fm.get("name") or path.parent.name
        records.append(
            {
                "name": name,
                "description": fm.get("description", ""),
                "path": display_path(path),
                "tags": tags_for(path),
            }
        )
    return records


def write_jsonl(path: Path, records: list[dict[str, object]]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("w", encoding="utf-8") as handle:
        for record in records:
            handle.write(json.dumps(record, ensure_ascii=False, sort_keys=True) + "\n")


def main() -> None:
    expert_records = iter_experts()
    skill_records = iter_coding_skills()

    write_jsonl(CATALOG / "experts.jsonl", expert_records)
    write_jsonl(CATALOG / "coding-skills.jsonl", skill_records)

    print(f"experts: {len(expert_records)}")
    print(f"coding skills: {len(skill_records)}")


if __name__ == "__main__":
    main()
