# Examples

Real-world code examples demonstrating the four principles. Each example shows what LLMs commonly do wrong and how to fix it.

---

## 1. Think Before Coding

### Hidden Assumptions

**User Request:** "Add a feature to export user data"

**Wrong — silent assumptions:**

```python
def export_users(format='json'):
    users = User.query.all()
    if format == 'json':
        with open('users.json', 'w') as f:
            json.dump([u.to_dict() for u in users], f)
    elif format == 'csv':
        with open('users.csv', 'w') as f:
            writer = csv.DictWriter(f, fieldnames=['id', 'email', 'name'])
            writer.writeheader()
            writer.writerows([u.to_dict() for u in users])
    return f"Exported {len(users)} users"
```

Problems: assumed ALL users, assumed file location, assumed which fields, assumed CSV fieldnames.

**Right — surface assumptions first:**

```
Before implementing, I need to clarify:
1. Scope: Export all users or filtered subset? (privacy implications)
2. Format: Download in browser? Background job? API endpoint?
3. Fields: Which user fields? (some might be sensitive)
4. Volume: How many users typically? (affects approach)

Simplest approach: Add an API endpoint that returns paginated JSON.
What's your preference?
```

---

## 2. Simplicity First

### Over-abstraction

**User Request:** "Add a function to calculate discount"

**Wrong — overengineered (50+ lines with Strategy pattern, ABC, dataclass):**

```python
class DiscountStrategy(ABC):
    @abstractmethod
    def calculate(self, amount: float) -> float: ...

class PercentageDiscount(DiscountStrategy): ...
class FixedDiscount(DiscountStrategy): ...

class DiscountCalculator:
    def __init__(self, config: DiscountConfig): ...
    def apply_discount(self, amount: float) -> float: ...
```

**Right — solve today's problem:**

```python
def calculate_discount(amount: float, percent: float) -> float:
    return amount * (percent / 100)
```

Add complexity only when you actually need multiple discount types.

---

## 3. Surgical Changes

### Drive-by Refactoring

**User Request:** "Fix the bug where empty emails crash the validator"

**Wrong — touched too much:**
- "Improved" email validation beyond the bug fix
- Added username validation nobody asked for
- Changed comments, added docstring

**Right — only fix the bug:**

```diff
  def validate_user(user_data):
      # Check email format
-     if not user_data.get('email'):
+     email = user_data.get('email', '')
+     if not email or not email.strip():
          raise ValueError("Email required")

      # Basic email validation
-     if '@' not in user_data['email']:
+     if '@' not in email:
          raise ValueError("Invalid email")
```

Every changed line traces directly to the reported issue.

### Style Drift

**User Request:** "Add logging to the upload function"

**Wrong:** Changed quote style, added type hints, added docstring, reformatted whitespace.

**Right:** Added only logging calls, matched existing single-quote style and patterns.

---

## 4. Goal-Driven Execution

### Vague vs. Verifiable

**User Request:** "Fix the authentication system"

**Wrong:** "I'll review the code, identify issues, make improvements, and test." (no clear success criteria)

**Right:**

```
Plan for "users stay logged in after password change":
1. Write test: Change password -> verify old session invalidated
   Verify: Test fails (reproduces bug)
2. Implement: Invalidate sessions on password change
   Verify: Test passes
3. Check edge cases: Multiple sessions, concurrent changes
   Verify: Additional tests pass
4. Run full auth test suite
   Verify: No regressions
```

---

## Anti-Patterns Summary

| Principle | Anti-Pattern | Fix |
|-----------|-------------|-----|
| Think Before Coding | Silently assumes format, fields, scope | List assumptions, ask for clarification |
| Simplicity First | Strategy pattern for single calculation | One function until complexity is needed |
| Surgical Changes | Reformats quotes, adds type hints while fixing bug | Only change lines that fix the issue |
| Goal-Driven | "I'll review and improve the code" | "Write test for X -> make it pass -> verify" |

**Key Insight:** The overengineered examples aren't obviously wrong — they follow design patterns. The problem is **timing**: they add complexity before it's needed.
