---
description: "Run a structured code review on recent changes or specified files"
---

The user wants a code review. Follow this workflow:

1. Determine the scope:
   - If the user specified files, review those files
   - If no files specified, check `git diff` for uncommitted changes
   - If no uncommitted changes, check `git diff HEAD~1` for the last commit
   - Ask the user to clarify if the scope is still unclear

2. Spawn the **code-reviewer** agent:

```
Task(subagent_type="code-reviewer", description="Review code changes", prompt="Review the following code changes for security, quality, and correctness. Follow the code-review skill's 3-tier format (Critical/Important/Suggestions). Scope: [FILES OR DIFF DESCRIPTION]")
```

3. Present the review findings to the user.

4. If there are Critical or Important findings, offer to help fix them.
