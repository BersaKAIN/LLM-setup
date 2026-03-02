# Claude Code Resources

Curated collection of community configs, tools, and guides.

## Awesome Lists

| Repository | Stars | Description |
|-----------|-------|-------------|
| [awesome-agent-skills](https://github.com/VoltAgent/awesome-agent-skills) | 8.7k | 380+ agent skills from official teams and community |
| [awesome-claude-skills](https://github.com/travisvn/awesome-claude-skills) | 7.9k | Curated skills, resources, and tools for Claude workflows |
| [claude-code-best-practice](https://github.com/shanraisshan/claude-code-best-practice) | 6.1k | Best practices, subagent patterns, orchestration workflows |
| [claude-code-showcase](https://github.com/ChrisWiles/claude-code-showcase) | 5.2k | Real-world Claude Code examples |
| [awesome-claude-code-toolkit](https://github.com/rohitg00/awesome-claude-code-toolkit) | 607 | 135 agents, 35 skills, 42 commands, 121 plugins |
| [awesome-claude-code](https://github.com/subinium/awesome-claude-code) | 58 | Curated tools requiring 1000+ stars for inclusion |

## Template Repositories

| Repository | Description |
|-----------|-------------|
| [claude-md-templates](https://github.com/abhishekray07/claude-md-templates) | Starter CLAUDE.md files for Next.js, Python/FastAPI, and generic projects |
| [subinium-agentic-workflow-config](https://github.com/subinium/subinium-agentic-workflow-config) | Battle-tested `~/.claude/` config with parallelism, security, and structured skills |
| [claude-subagents](https://github.com/zyd14/claude-subagents) | Framework for planning, code review, and Linear integration workflows |

## Guides

| Guide | Author | Description |
|-------|--------|-------------|
| [Claude Code Best Practices](https://code.claude.com/docs/en/best-practices) | Anthropic | Official guidance, include/exclude table |
| [Effective Context Engineering](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents) | Anthropic | Context rot, attention budget, just-in-time context |
| [Writing a Good CLAUDE.md](https://www.humanlayer.dev/blog/writing-a-good-claude-md) | HumanLayer | Instruction limits, progressive disclosure |
| [The Ultimate Guide to CLAUDE.md](https://www.buildcamp.io/guides/the-ultimate-guide-to-claudemd) | Buildcamp | Comprehensive CLAUDE.md setup guide |
| [CLAUDE.md Complete Guide](https://serenitiesai.com/articles/claude-md-complete-guide-2026) | Serenities AI | 2026 edition with latest features |
| [CLAUDE.md Guide](https://www.claudedirectory.org/blog/claude-md-guide) | Claude Directory | Configure Claude Code for any project |
| [Using CLAUDE.md Files](https://www.claude.com/blog/using-claude-md-files) | Anthropic | Official blog post on CLAUDE.md usage |

## Official Documentation

| Topic | Link |
|-------|------|
| Skills | [docs.anthropic.com/en/docs/claude-code/skills](https://docs.anthropic.com/en/docs/claude-code/skills) |
| Subagents | [docs.anthropic.com/en/docs/claude-code/subagents](https://docs.anthropic.com/en/docs/claude-code/subagents) |
| Memory (CLAUDE.md) | [code.claude.com/docs/en/memory](https://code.claude.com/docs/en/memory) |
| Hooks | [code.claude.com/docs/en/hooks](https://code.claude.com/docs/en/hooks) |
| Settings | [code.claude.com/docs/en/settings](https://code.claude.com/docs/en/settings) |
| MCP Servers | [code.claude.com/docs/en/mcp](https://code.claude.com/docs/en/mcp) |
| GitHub Actions | [github.com/anthropics/claude-code-action](https://github.com/anthropics/claude-code-action) |

## Tools

| Tool | Description |
|------|-------------|
| [AgentLinter](https://github.com/anthropics/agentlinter) | Scores your `.claude/` config across 8 categories (Structure, Clarity, Security, etc.) |
| [claude-code-action](https://github.com/anthropics/claude-code-action) | GitHub Actions integration for code review, issue fixing, and PR automation |
| [Context7 MCP](https://github.com/upstash/context7) | Fetches up-to-date library docs into context |
| [Playwright MCP](https://github.com/microsoft/playwright-mcp) | Browser automation for testing and verification |

## MCP Servers for Daily Use

| Server | What It Does |
|--------|-------------|
| [Context7](https://github.com/upstash/context7) | Fetches current library docs — prevents hallucinated APIs |
| [Playwright](https://github.com/microsoft/playwright-mcp) | Browser automation — test and verify UI changes |
| [Claude in Chrome](https://github.com/nicobailon/claude-code-in-chrome-mcp) | Inspect real Chrome console, network, DOM |
| [DeepWiki](https://github.com/devanshusemwal/deepwiki-mcp) | Wiki-style documentation for any GitHub repo |

## Key Principles

From community experience:

- Keep CLAUDE.md under 80 lines (global under 30)
- Use commands for workflows, not standalone agents
- Create feature-specific subagents over general-purpose ones
- Manual `/compact` at ~50% context usage
- Always start complex tasks with plan mode
- Break subtasks small enough for <50% context
- Commit after each completed task
- Use the self-improvement loop: "Update CLAUDE.md so you don't make that mistake again"
