#!/usr/bin/env python3
"""cursor_sync.py — Convert Claude Code configs to Cursor .cursor/ format."""

import argparse
import re
import sys
from pathlib import Path

import yaml


class ConversionError(Exception):
    def __init__(self, path: str, reason: str):
        self.path = path
        self.reason = reason
        super().__init__(f"{path}: {reason}")


# All Task() calls are single-line in source
TASK_PATTERN = re.compile(
    r'Task\(\s*subagent_type=["\'](?P<agent>[^"\']+)["\']\s*,\s*'
    r'description=["\'](?P<desc>[^"\']+)["\']\s*,\s*'
    r'prompt=["\'](?P<prompt>.*?)["\']\s*\)',
    re.DOTALL,
)


def parse_frontmatter(text: str) -> tuple[dict, str]:
    """Split YAML frontmatter from body. Returns ({}, text) if no frontmatter."""
    if not text.startswith("---"):
        return {}, text
    parts = text.split("---", 2)
    if len(parts) < 3:
        return {}, text
    try:
        data = yaml.safe_load(parts[1]) or {}
    except yaml.YAMLError:
        return {}, text
    return data, parts[2].lstrip("\n")


def render_frontmatter(data: dict) -> str:
    """Render a dict as a YAML frontmatter block."""
    return "---\n" + yaml.dump(data, sort_keys=False, allow_unicode=True) + "---\n\n"


def transform_task_calls(body: str) -> str:
    """Replace Task(...) calls with blockquote instructions."""
    def replace(m: re.Match) -> str:
        agent = m.group("agent")
        prompt = m.group("prompt")
        return f"> Use the **{agent}** workflow: {prompt}"

    # Remove fenced code blocks wrapping lone Task() calls, replacing with the blockquote
    # Pattern: optional ```\n + Task(...) + \n``` (standalone block)
    fenced = re.compile(
        r'```[^\n]*\n'
        r'(Task\(\s*subagent_type=["\'][^"\']+["\']\s*,\s*'
        r'description=["\'][^"\']+["\']\s*,\s*'
        r'prompt=["\'].*?["\']\s*\))'
        r'\n```',
        re.DOTALL,
    )
    body = fenced.sub(lambda m: TASK_PATTERN.sub(replace, m.group(1)), body)
    # Replace any remaining bare Task() calls
    body = TASK_PATTERN.sub(replace, body)
    return body


def convert_skill(path: Path) -> tuple[str, str]:
    """Convert home/skills/{name}/SKILL.md → .cursor/rules/skill-{name}.mdc"""
    text = path.read_text(encoding="utf-8")
    meta, body = parse_frontmatter(text)
    name = path.parent.name
    out_meta = {"description": meta.get("description", ""), "alwaysApply": False}
    content = render_frontmatter(out_meta) + body
    return f".cursor/rules/skill-{name}.mdc", content


def convert_agent(path: Path) -> tuple[str, str]:
    """Convert home/agents/{name}.md → .cursor/rules/agent-{name}.mdc

    Strips tools/model/permissionMode; prepends skills note if declared.
    """
    text = path.read_text(encoding="utf-8")
    meta, body = parse_frontmatter(text)
    name = path.stem

    # Keep only cursor-relevant fields; strip Claude-specific ones
    strip_keys = {"tools", "model", "permissionMode", "skills"}
    out_meta: dict = {}
    if "description" in meta:
        out_meta["description"] = meta["description"]
    for k, v in meta.items():
        if k not in strip_keys and k != "description" and k != "name":
            out_meta[k] = v
    out_meta["alwaysApply"] = False

    skills = meta.get("skills", [])
    if skills:
        skills_line = "Applies skills: " + ", ".join(skills) + "\n\n"
        body = skills_line + body

    content = render_frontmatter(out_meta) + body
    return f".cursor/rules/agent-{name}.mdc", content


def convert_command(path: Path) -> tuple[str, str]:
    """Convert home/commands/{name}.md → .cursor/commands/{name}.md

    Strips frontmatter and transforms Task() calls to blockquotes.
    """
    text = path.read_text(encoding="utf-8")
    _meta, body = parse_frontmatter(text)
    body = transform_task_calls(body)
    return f".cursor/commands/{path.name}", body


def convert_global_claude_md(path: Path) -> tuple[str, str]:
    """Convert home/CLAUDE.md → .cursor/rules/global-preferences.mdc"""
    text = path.read_text(encoding="utf-8")
    meta, body = parse_frontmatter(text)
    out_meta = {"description": "Global AI preferences", "alwaysApply": True}
    content = render_frontmatter(out_meta) + body
    return ".cursor/rules/global-preferences.mdc", content


def collect_conversions(source_dir: Path) -> list[tuple[str, str]]:
    """Collect all (rel_path, content) pairs from source_dir."""
    results: list[tuple[str, str]] = []

    # Skills
    for skill_file in sorted((source_dir / "home" / "skills").glob("*/SKILL.md")):
        try:
            results.append(convert_skill(skill_file))
        except Exception as e:
            raise ConversionError(str(skill_file), str(e)) from e

    # Agents
    for agent_file in sorted((source_dir / "home" / "agents").glob("*.md")):
        try:
            results.append(convert_agent(agent_file))
        except Exception as e:
            raise ConversionError(str(agent_file), str(e)) from e

    # Commands
    for cmd_file in sorted((source_dir / "home" / "commands").glob("*.md")):
        try:
            results.append(convert_command(cmd_file))
        except Exception as e:
            raise ConversionError(str(cmd_file), str(e)) from e

    # Global CLAUDE.md
    global_md = source_dir / "home" / "CLAUDE.md"
    if global_md.exists():
        try:
            results.append(convert_global_claude_md(global_md))
        except Exception as e:
            raise ConversionError(str(global_md), str(e)) from e

    return results


def deploy(source_dir: Path, target_dir: Path, no_clobber: bool = False) -> None:
    """Write all converted files into target_dir."""
    conversions = collect_conversions(source_dir)
    for rel_path, content in conversions:
        dest = target_dir / rel_path
        if no_clobber and dest.exists():
            print(f"  skip (exists): {dest}", file=sys.stderr)
            continue
        dest.parent.mkdir(parents=True, exist_ok=True)
        dest.write_text(content, encoding="utf-8")
        print(f"  wrote: {dest}")


def preview(source_dir: Path) -> None:
    """Print all converted content to stdout."""
    conversions = collect_conversions(source_dir)
    for rel_path, content in conversions:
        print("=" * 72)
        print(f"# {rel_path}")
        print("=" * 72)
        print(content)


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Convert Claude Code configs to Cursor .cursor/ format"
    )
    parser.add_argument(
        "--source",
        default=str(Path(__file__).parent),
        help="Path to the agentic_setup repo (default: script directory)",
    )

    sub = parser.add_subparsers(dest="command", required=True)

    deploy_p = sub.add_parser("deploy", help="Write converted files to a target directory")
    deploy_target = deploy_p.add_mutually_exclusive_group(required=True)
    deploy_target.add_argument("project_path", nargs="?", help="Write to <project_path>/.cursor/")
    deploy_target.add_argument(
        "--global", dest="global_deploy", action="store_true",
        help="Write to ~/.cursor/"
    )
    deploy_p.add_argument(
        "--no-clobber", action="store_true", help="Skip files that already exist"
    )

    sub.add_parser("preview", help="Print converted output without writing")

    args = parser.parse_args()
    source_dir = Path(args.source).resolve()

    if args.command == "preview":
        try:
            preview(source_dir)
        except ConversionError as e:
            print(f"Error: {e}", file=sys.stderr)
            sys.exit(1)

    elif args.command == "deploy":
        if args.global_deploy:
            target_dir = Path.home()
        else:
            target_dir = Path(args.project_path).resolve()

        try:
            deploy(source_dir, target_dir, no_clobber=args.no_clobber)
        except ConversionError as e:
            print(f"Error: {e}", file=sys.stderr)
            sys.exit(1)


if __name__ == "__main__":
    main()
