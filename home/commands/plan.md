---
description: "Start a structured planning session — research the codebase, then produce an implementation plan"
---

The user wants to plan a feature or change. Follow this workflow:

1. Ask the user what they want to build or change. If they've already described it, proceed.

2. Spawn the **planner** agent to research and produce a plan:

```
Task(subagent_type="planner", description="Create implementation plan", prompt="Research the codebase and create a structured implementation plan for: [USER'S REQUEST]. Follow the planning skill's RPI workflow. Return a markdown plan with tasks, sizes, dependencies, acceptance criteria, and risks.")
```

3. Present the plan to the user for review and approval.

4. If the user requests changes, update the plan accordingly.

5. Once approved, the plan is ready for implementation (use `/implement` to execute it).
