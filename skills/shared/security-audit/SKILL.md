---
name: security-audit
description: "OWASP-based security audit with secret scanning and dependency checks"
---

# Security Audit Skill

Systematic security review based on OWASP Top 10 and common vulnerability patterns.

## Audit Checklist

### 1. Injection
- [ ] SQL queries use parameterized statements (no string concatenation)
- [ ] User input is validated/sanitized before use
- [ ] No `eval()`, `exec()`, `Function()` with user-controlled input
- [ ] Template rendering escapes output by default
- [ ] Command execution uses arrays, not shell strings

### 2. Authentication & Authorization
- [ ] Passwords hashed with bcrypt/argon2 (not MD5/SHA)
- [ ] Session tokens are cryptographically random
- [ ] Auth checks on every protected endpoint (not just UI)
- [ ] Role/permission checks are server-side
- [ ] Rate limiting on login endpoints

### 3. Sensitive Data
- [ ] No secrets in source code (API keys, passwords, tokens)
- [ ] No secrets in git history
- [ ] .env files are gitignored
- [ ] Sensitive data encrypted at rest and in transit
- [ ] Logs don't contain PII or credentials

### 4. API Security
- [ ] CORS configured restrictively (not `*`)
- [ ] Input validation on all endpoints (type, length, range)
- [ ] Rate limiting and request size limits
- [ ] Error responses don't leak internal details
- [ ] HTTPS enforced

### 5. Dependencies
- [ ] No known vulnerabilities (`npm audit` / `pip audit`)
- [ ] Dependencies pinned to specific versions
- [ ] No unnecessary dependencies with broad access

## Secret Scanning Patterns

Search the codebase for these patterns:
- `AKIA[0-9A-Z]{16}` — AWS access keys
- `sk-[a-zA-Z0-9]{48}` — OpenAI API keys
- `ghp_[a-zA-Z0-9]{36}` — GitHub personal access tokens
- `password\s*=\s*["'][^"']+["']` — Hardcoded passwords
- `BEGIN (RSA|DSA|EC) PRIVATE KEY` — Private keys

## Output Format

For each finding:
- **Severity**: Critical / High / Medium / Low
- **Category**: Which OWASP category
- **Location**: File path and line number
- **Description**: What's wrong
- **Remediation**: How to fix it
- **References**: Relevant OWASP or CWE links
