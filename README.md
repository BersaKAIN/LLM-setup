# Agentic Setup

Unified AI coding configs for Claude Code and Cursor. One repo, one install, both platforms.

## Quick Start

```bash
git clone <your-repo-url> ~/dev/agentic_setup
./install.sh home
```

## What It Does

`install.sh home` does two things:

1. **Symlinks skills** into both platforms (edits are live immediately):
   - `skills/shared/*` → `~/.cursor/skills/` and `~/.claude/skills/`
   - `skills/cursor-only/*` → `~/.cursor/skills/` only
   - `skills/claude-only/*` → `~/.claude/skills/` only

2. **Copies Claude Code configs** to `~/.claude/`:
   - `CLAUDE.md`, `settings.json`, `agents/`, `commands/`

## Directory Layout

```
skills/                          Skills (symlinked, shared across platforms)
├── shared/                      → both ~/.cursor/skills/ and ~/.claude/skills/
│   ├── code-review/
│   ├── debugging/
│   ├── git-workflow/
│   ├── karpathy-guidelines/
│   ├── notebooklm/
│   ├── paper-reader/
│   ├── planning/
│   ├── security-audit/
│   ├── session-handoff/
│   └── tdd/
├── cursor-only/                 → ~/.cursor/skills/ only
│   ├── glean-deep-read/
│   └── pi-planning/
└── claude-only/                 → ~/.claude/skills/ only

home/                            Claude Code specific (copied to ~/.claude/)
├── CLAUDE.md                    Global preferences
├── settings.json                Permissions
├── agents/                      Subagent definitions
│   ├── architect.md
│   ├── code-reviewer.md
│   ├── docs-writer.md
│   ├── planner.md
│   ├── researcher.md
│   └── test-writer.md
└── commands/                    Slash commands
    ├── implement.md
    ├── plan.md
    ├── read-paper.md
    ├── review.md
    └── wrap.md

project/                         Project templates (deployed per-repo)
├── CLAUDE.md
└── local.md
```

## Commands

| Command | What it does |
|---------|-------------|
| `/plan` | Structured planning session — spawns planner agent |
| `/review` | Code review — spawns code-reviewer agent |
| `/implement` | Full feature workflow (plan → code → test → review) |
| `/wrap` | Summarize session, create handoff for next session |
| `/read-paper` | Read and analyze an academic paper |

## Agents

| Agent | Purpose |
|-------|---------|
| planner | Decompose features into tasks, create implementation plans |
| code-reviewer | Structured review: security, quality, correctness |
| architect | System design, trade-off analysis, data flow |
| test-writer | Generate tests from implementation code |
| docs-writer | API docs, READMEs, changelogs |
| researcher | Codebase exploration + external doc lookup |

## Install Options

```bash
./install.sh home                        # Deploy global configs
./install.sh project /path/to/project    # Bootstrap a project
./install.sh all /path/to/project        # Both

# Options
./install.sh home --no-clobber           # Skip existing files
```

## Adding a New Skill

1. Create a directory in the appropriate bucket:
   - `skills/shared/` — works in both Cursor and Claude Code
   - `skills/cursor-only/` — depends on Cursor features (e.g., MCP tools)
   - `skills/claude-only/` — depends on Claude Code features
2. Add a `SKILL.md` with YAML frontmatter (`name`, `description`)
3. Re-run `./install.sh home` to create the symlink

## Sources

Built from patterns in:
- [shanraisshan/claude-code-best-practice](https://github.com/shanraisshan/claude-code-best-practice)
- [zyd14/claude-subagents](https://github.com/zyd14/claude-subagents)
- [subinium/subinium-agentic-workflow-config](https://github.com/subinium/subinium-agentic-workflow-config)
- [abhishekray07/claude-md-templates](https://github.com/abhishekray07/claude-md-templates)
- [rohitg00/awesome-claude-code-toolkit](https://github.com/rohitg00/awesome-claude-code-toolkit)

## License

MIT
