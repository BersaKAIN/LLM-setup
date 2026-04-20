# CLAUDE.md

This repo contains reusable AI coding configurations for both Claude Code and Cursor.

## Structure

- `skills/` — shared and platform-specific skills (symlinked into both platforms)
  - `shared/` — works in both Cursor and Claude Code
  - `cursor-only/` — depends on Cursor features (e.g., MCP tools)
  - `claude-only/` — depends on Claude Code features
- `home/` mirrors `~/.claude/` — Claude Code global configs (agents, commands, settings)
- `project/` mirrors `.claude/` — project-level configs deployed per-repo

## Architecture

Commands → Agents → Skills (layered delegation):
- Commands (`home/commands/`) are user-facing entry points (`/plan`, `/review`, etc.)
- Agents (`home/agents/`) are isolated subagents spawned by commands via Task tool
- Skills (`skills/`) are domain knowledge preloaded into agents via `skills:` frontmatter

## Conventions

- Agent files use YAML frontmatter with `name`, `description`, `tools`, `model`, `skills` fields
- Skill files are `SKILL.md` with YAML frontmatter (`name`, `description`)
- Command files are markdown with `description` frontmatter
- Skills are symlinked (not copied) so edits are live immediately
