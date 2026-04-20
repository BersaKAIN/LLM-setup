---
name: debugging
description: "Systematic 8-step debugging protocol — stops guessing, forces evidence-based fixes"
---

# Debugging Skill

Follow this protocol instead of guessing. Every step produces evidence.

## The 8-Step Protocol

### 1. Reproduce
- Get the exact error message, stack trace, or unexpected behavior
- Identify the minimal steps to trigger it
- Note the environment (OS, runtime version, config)

### 2. Isolate
- Narrow down to the smallest code path that exhibits the bug
- Is it in our code, a dependency, or configuration?
- Can you reproduce in a test?

### 3. Trace the Data Flow
- Start from the entry point (API request, user action, event)
- Follow the data through each transformation
- Log or inspect values at each step
- Find where actual behavior diverges from expected

### 4. Form a Hypothesis
- State clearly: "I believe the bug is caused by X because Y"
- The hypothesis must be falsifiable — you should know what evidence would disprove it

### 5. Verify the Hypothesis
- Write the smallest possible test or check that confirms/denies the hypothesis
- If denied, return to step 3 with new information
- If confirmed, proceed

### 6. Fix with Minimal Change
- Change only what's necessary to fix the root cause
- Don't refactor unrelated code in the same fix
- Prefer the fix that's closest to the bug's location

### 7. Confirm the Fix
- Run the reproduction steps — the bug should be gone
- Run the full test suite — nothing else should break
- If the bug was in a common pattern, search for similar instances

### 8. Prevent Recurrence
- Add a test that catches this exact bug
- If the bug came from a missing type/validation, add it
- If the pattern is error-prone, note it for code review

## Anti-Patterns

- Changing multiple things at once (can't tell what fixed it)
- Fixing symptoms instead of root cause
- Assuming the bug is in the code you most recently changed
- Adding try/catch to hide errors instead of fixing them
- "Works on my machine" without checking environment differences
