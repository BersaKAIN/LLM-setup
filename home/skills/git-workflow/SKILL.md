---
name: git-workflow
description: "Conventional commits, PR creation, and branch management"
---

# Git Workflow Skill

Standardized git practices for commits, branches, and pull requests.

## Commit Messages

Use [Conventional Commits](https://www.conventionalcommits.org/) format:

```
type(scope): short description

Optional body explaining why, not what.

Optional footer (e.g., Closes #123)
```

Types:
- `feat` — New feature or capability
- `fix` — Bug fix
- `refactor` — Code change that neither fixes a bug nor adds a feature
- `docs` — Documentation only
- `test` — Adding or updating tests
- `chore` — Build, CI, dependencies, tooling
- `perf` — Performance improvement
- `style` — Formatting, whitespace (no logic change)

Rules:
- Subject line under 72 characters
- Use imperative mood ("add feature" not "added feature")
- One logical change per commit
- Commit after each completed task, not in bulk

## Branch Naming

```
type/short-description
```

Examples: `feat/user-auth`, `fix/login-redirect`, `refactor/api-client`

## Pull Requests

Structure:
```markdown
## Summary
- 1-3 bullet points describing what changed and why

## Changes
- List of specific changes made

## Test Plan
- How to verify the changes work
- [ ] Checklist of manual test steps if applicable

## Notes
- Breaking changes, migration steps, or deployment considerations
```

Rules:
- Keep PRs focused — one feature or fix per PR
- If a PR is too large (>400 lines changed), break it up
- Reference related issues (`Closes #123`)
- Add reviewers who own the affected code

## Safety

- Never force push to main/master
- Never rebase shared branches without team agreement
- Always pull before pushing
- Use `--force-with-lease` instead of `--force` when force push is necessary
