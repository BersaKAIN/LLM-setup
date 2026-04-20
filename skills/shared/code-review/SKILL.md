---
name: code-review
description: "Structured 3-tier code review: critical, important, suggestions"
---

# Code Review Skill

Perform structured code reviews with clear severity tiers and actionable feedback.

## Review Checklist

### 1. Critical (blocks merge)

- **Security**: SQL injection, XSS, auth bypass, hardcoded secrets, insecure deserialization
- **Data integrity**: Missing validation, destructive operations without guards, race conditions
- **Correctness**: Wrong logic, unhandled null/undefined, infinite loops, off-by-one errors
- **Breaking changes**: API contract violations, removed public interfaces, schema changes without migration

### 2. Important (should fix)

- **Error handling**: Swallowed errors (`.catch(() => {})`), missing error boundaries, untyped catch blocks
- **Types**: `any` usage, missing return types on public functions, unsafe type assertions
- **Tests**: Changed code paths without test coverage, brittle tests, missing edge cases
- **Performance**: N+1 queries, unnecessary re-renders, missing database indexes, unbounded list operations
- **Concurrency**: Missing locks, unprotected shared state, promise chains without error handling

### 3. Suggestions (nice to have)

- Naming clarity improvements
- Dead code removal
- Simplification opportunities (complex conditionals, deep nesting)
- Better patterns available elsewhere in the codebase
- Documentation for non-obvious logic

## Review Format

For each finding:

```
**[CRITICAL/IMPORTANT/SUGGESTION]** Short title

File: `path/to/file.ts:42`

Problem: What's wrong and why it matters.

Suggestion:
\`\`\`
// suggested fix
\`\`\`
```

## Patterns That Always Get a Comment

- Empty catch blocks
- Hardcoded URLs or magic numbers
- `// TODO` or `// HACK` without an issue reference
- Console.log left in production code
- Missing error boundaries around async operations
- Functions over 50 lines
- Files over 300 lines
- Disabled tests (`skip`, `xit`, `xdescribe`)

## Final Verdict

End every review with one of:
- **Approve** — Ship it, no issues or only suggestions
- **Approve with comments** — Minor issues, can merge after addressing
- **Request changes** — Critical or important issues must be fixed first
