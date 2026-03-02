---
description: "Summarize the current session and create a handoff note for the next session"
---

The user wants to wrap up the current session. Use the **session-handoff** skill to create a handoff note.

1. Review what was done this session:
   - Check `git log --oneline` for commits made
   - Check `git diff` for uncommitted changes
   - Check `git status` for untracked files
   - Look for TODO comments in recently modified files

2. Produce a handoff note in this format:

```markdown
# Session Handoff — [TODAY'S DATE]

## Completed
- [task]: [files changed]

## Pending
- [ ] [remaining task or TODO found in code]

## Decisions
- [decision]: [rationale]

## Next Steps
1. [specific next action with file/task reference]
```

3. Ask the user if they want to save the handoff note to a file (e.g., `.claude/handoff.md`) or just display it.
