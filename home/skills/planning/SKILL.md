---
name: planning
description: "Research-Plan-Implement workflow for structured feature development"
---

# Planning Skill

Use the Research → Plan → Implement (RPI) workflow for any non-trivial feature or change.

## Phase 1: Research

Before writing any plan, gather context:

1. Read relevant source files, tests, and configs
2. Search for related patterns in the codebase (`Grep`, `Glob`)
3. Check git history for prior decisions on similar changes
4. Identify dependencies, constraints, and existing conventions
5. If external libraries are involved, verify installed versions and check docs

**Output:** List of findings with file references.

## Phase 2: Plan

Produce a structured implementation plan:

1. **Objective** — One sentence: what are we building and why?
2. **Tasks** — Ordered list with:
   - Short title
   - Size: XS (<15min), S (<1hr), M (<4hr), L (<1day)
   - Dependencies (which tasks must complete first)
   - Acceptance criteria (testable conditions)
   - Files affected
3. **Risks** — What could go wrong, and mitigations
4. **Out of scope** — What we're explicitly not doing

Rules:
- If any task is size L, break it down further
- Tasks should be completable in under 50% context window
- Get user approval on the plan before proceeding to Phase 3

## Phase 3: Implement

Execute the plan task by task:

1. Work through tasks in dependency order
2. After each task: run tests, lint, typecheck
3. Commit after each completed task (conventional commit message)
4. If a task reveals the plan needs adjustment, pause and update the plan
5. At the end: verify all acceptance criteria are met

## When to Skip RPI

- Single-file changes under 20 lines → just do it
- Bug fixes with obvious cause → fix, test, commit
- Documentation-only changes → write directly
