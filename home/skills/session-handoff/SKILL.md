---
name: session-handoff
description: "Session wrap-up and context priming for the next session"
---

# Session Handoff Skill

Create structured handoff notes when ending a session or starting a new one.

## Wrapping Up (End of Session)

Produce a handoff note with:

### Progress
- What was completed this session
- Files created or modified (with brief description of changes)
- Tests added or updated

### Pending
- Tasks remaining from the plan (if any)
- Known issues discovered but not yet fixed
- TODOs left in the code

### Key Decisions
- Architecture or design choices made and their rationale
- Trade-offs accepted and why
- Alternatives considered and rejected

### Context for Next Session
- What to work on next (specific task or file)
- Any blockers or dependencies that need resolution
- Commands or steps to get back up to speed

## Priming a New Session (Start of Session)

When starting fresh or continuing prior work:

1. Read the project's CLAUDE.md for conventions
2. Check `git log --oneline -20` for recent activity
3. Check `git status` and `git diff` for uncommitted work
4. Look for TODO comments in recently modified files
5. Read any handoff notes from the previous session

## Format

```markdown
# Session Handoff — [DATE]

## Completed
- [task]: [files changed]

## Pending
- [ ] [remaining task]

## Decisions
- [decision]: [rationale]

## Next Steps
1. [specific next action]
```
