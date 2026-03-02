# CLAUDE.md

This repo contains reusable Claude Code configurations (agents, skills, commands, settings).

## Structure

- `home/` mirrors `~/.claude/` — global configs deployed per-machine
- `project/` mirrors `.claude/` — project-level configs deployed per-repo
- `catalogue/` — curated links to community resources (not deployed)

## Architecture

Commands → Agents → Skills (layered delegation):
- Commands (`home/commands/`) are user-facing entry points (`/plan`, `/review`, etc.)
- Agents (`home/agents/`) are isolated subagents spawned by commands via Task tool
- Skills (`home/skills/`) are domain knowledge preloaded into agents via `skills:` frontmatter

## Conventions

- Agent files use YAML frontmatter with `name`, `description`, `tools`, `model`, `skills` fields
- Skill files are `SKILL.md` with YAML frontmatter (`name`, `description`)
- Command files are markdown with `description` frontmatter
- Keep CLAUDE.md templates lean: global under 30 lines, project under 80 lines
