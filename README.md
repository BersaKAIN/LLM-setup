# Agentic Setup

Ready-to-deploy Claude Code configurations for common development workflows: planning, code review, testing, debugging, and more.

## Quick Start

```bash
# Clone the repo
git clone <your-repo-url> ~/agentic_setup

# Deploy global configs to a new machine
./install.sh home

# Bootstrap a new project
./install.sh project /path/to/myproject

# Or just copy manually
cp -r home/ ~/.claude/
cp -r project/ /path/to/myproject/.claude/
```

## What's Included

### Commands (entry points)

| Command | What it does |
|---------|-------------|
| `/plan` | Structured planning session — spawns planner agent |
| `/review` | Code review — spawns code-reviewer agent |
| `/implement` | Full feature workflow (plan → code → test → review) |
| `/wrap` | Summarize session, create handoff for next session |

### Agents (isolated workers)

| Agent | Skills | Purpose |
|-------|--------|---------|
| `planner` | planning | Decompose features into tasks, create implementation plans |
| `code-reviewer` | code-review | Structured review: security, quality, correctness |
| `architect` | planning | System design, trade-off analysis, data flow |
| `test-writer` | tdd | Generate tests from implementation code |
| `docs-writer` | — | API docs, READMEs, changelogs |
| `researcher` | — | Codebase exploration + external doc lookup |

### Skills (domain knowledge)

| Skill | Wired to agent | Also standalone |
|-------|----------------|-----------------|
| `planning` | planner, architect | — |
| `code-review` | code-reviewer | — |
| `tdd` | test-writer | — |
| `git-workflow` | — | `/git-workflow` |
| `debugging` | — | `/debugging` |
| `security-audit` | — | `/security-audit` |
| `session-handoff` | — | used by `/wrap` |

## Architecture

```
/plan command  ──→  planner agent  ──→  planning skill
/review command ──→  code-reviewer agent ──→  code-review skill
/implement command ──→  planner + test-writer agents
/wrap command  ──→  session-handoff skill (no agent)
```

Commands are thin entry points. Agents run in isolated context with focused tools. Skills provide domain knowledge preloaded into agents.

## Directory Layout

```
home/                          → deploys to ~/.claude/
├── CLAUDE.md                  Global preferences
├── settings.json              Permissions, env vars
├── agents/                    Subagent definitions
├── skills/                    Skill definitions
└── commands/                  Slash commands

project/                       → deploys to yourproject/.claude/
├── CLAUDE.md                  Project template (fill in the blanks)
└── local.md                   Personal overrides (gitignored)
```

`home/` and `project/` are direct mirrors of their targets — no path rewriting needed.

## Install Script

```bash
./install.sh home                        # Deploy global configs
./install.sh project /path/to/project    # Bootstrap a project
./install.sh all /path/to/project        # Both

# Options
./install.sh home --no-clobber           # Skip existing files
```

The script backs up existing configs to a timestamped directory before copying.

## Customization

- Edit `home/CLAUDE.md` to add your personal preferences
- Edit `project/CLAUDE.md` template to match your team's conventions
- Add project-specific agents/skills to `project/` as needed
- Add stack-specific skills (e.g., `react`, `python`) to `home/skills/`

## Cursor Sync

`cursor_sync.py` converts `home/` configs to Cursor's `.cursor/rules/` and `.cursor/commands/` format, so you only maintain one source of truth.

```bash
# Preview all converted output (no files written)
python cursor_sync.py preview

# Deploy to a project
python cursor_sync.py deploy /path/to/myproject

# Deploy to global Cursor config (~/.cursor/)
python cursor_sync.py deploy --global

# Skip files that already exist
python cursor_sync.py deploy /path/to/myproject --no-clobber
```

**What gets generated:**

| Source | Output |
|--------|--------|
| `home/skills/*/SKILL.md` | `.cursor/rules/skill-{name}.mdc` |
| `home/agents/*.md` | `.cursor/rules/agent-{name}.mdc` |
| `home/commands/*.md` | `.cursor/commands/{name}.md` |
| `home/CLAUDE.md` | `.cursor/rules/global-preferences.mdc` |

Requires `pyyaml` (`pip install pyyaml`).

## Resources

See [catalogue/RESOURCES.md](catalogue/RESOURCES.md) for curated links to community configs, awesome lists, and guides.

## Sources

Built from patterns in:
- [shanraisshan/claude-code-best-practice](https://github.com/shanraisshan/claude-code-best-practice) — Command→Agent→Skills architecture
- [zyd14/claude-subagents](https://github.com/zyd14/claude-subagents) — Agent role patterns
- [subinium/subinium-agentic-workflow-config](https://github.com/subinium/subinium-agentic-workflow-config) — Parallelism-first configs
- [abhishekray07/claude-md-templates](https://github.com/abhishekray07/claude-md-templates) — CLAUDE.md templates
- [rohitg00/awesome-claude-code-toolkit](https://github.com/rohitg00/awesome-claude-code-toolkit) — Comprehensive toolkit

## License

MIT
