---
name: tdd
description: "Test-Driven Development: red-green-refactor cycle"
---

# TDD Skill

Write tests first, then implement. Follow the red-green-refactor cycle.

## The Cycle

### 1. RED — Write a Failing Test

- Write one test that describes the expected behavior
- Run it — it must fail (if it passes, the test is wrong or the feature already exists)
- The test name should read as a specification: `"returns empty array when no items match filter"`

### 2. GREEN — Make It Pass

- Write the minimum code to make the test pass
- Don't over-engineer — ugly code is fine at this stage
- Don't write code for cases you haven't tested yet
- Run the test — it must pass

### 3. REFACTOR — Clean Up

- Now improve the code: remove duplication, improve names, simplify logic
- Run all tests after each refactoring step — nothing should break
- The behavior stays the same, only the implementation improves

### Repeat

Go back to step 1 for the next behavior.

## Test Structure

```
describe("[Unit Under Test]", () => {
  describe("[method or scenario]", () => {
    it("[expected behavior]", () => {
      // Arrange — set up inputs and dependencies
      // Act — call the function or trigger the behavior
      // Assert — verify the result
    });
  });
});
```

## What to Test First

1. Happy path (the main success case)
2. Edge cases (empty input, null, zero, boundary values)
3. Error cases (invalid input, missing dependencies, timeouts)
4. Integration points (API calls, database queries, file I/O)

## Rules

- One assertion per test (or one logical assertion group)
- Tests must be independent — no shared mutable state between tests
- Mock external dependencies, not internal modules
- Test behavior (what it does) not implementation (how it does it)
- If you can't write a test, the interface needs simplifying
- Never skip the RED step — a test that never failed might not test anything
