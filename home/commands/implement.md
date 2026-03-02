---
description: "Full feature workflow: plan, implement, test, and review"
---

The user wants to implement a feature end-to-end. Follow this workflow:

## Phase 1: Plan

Spawn the **planner** agent to create an implementation plan:

```
Task(subagent_type="planner", description="Create implementation plan", prompt="Research the codebase and create an implementation plan for: [USER'S REQUEST]. Follow the planning skill's RPI workflow.")
```

Present the plan to the user. Wait for approval before proceeding.

## Phase 2: Implement

Execute the plan task by task:
1. Work through tasks in dependency order
2. After each task: run tests, lint, typecheck
3. Commit after each completed task with a conventional commit message
4. If a task reveals the plan needs adjustment, pause and discuss with the user

## Phase 3: Test

Spawn the **test-writer** agent for any code that lacks test coverage:

```
Task(subagent_type="test-writer", description="Write tests for new code", prompt="Write tests for the code changes made in this session. Follow existing test patterns and the tdd skill. Focus on: [LIST OF CHANGED FILES]")
```

Run all tests to confirm they pass.

## Phase 4: Review

Spawn the **code-reviewer** agent for a final review:

```
Task(subagent_type="code-reviewer", description="Review implementation", prompt="Review all changes made in this session. Check for security, quality, and correctness. Scope: [LIST OF CHANGED FILES]")
```

Address any Critical or Important findings before considering the feature complete.
