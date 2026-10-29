---
name: backend-engineering
description: >
  Build and review server-side application logic, APIs, authentication,
  integrations, and data access in the project's existing language and runtime.
  Use when a task affects server code or service behavior.
---

# Backend Engineering

Start with the project's runtime, route/API structure, authentication model, dependency manifests, and existing error-handling patterns. Use JavaScript/TypeScript with Node.js, Python, or the language evidenced in the repository; do not introduce a new stack without a reason.

## Work method

- Define request/response contracts and preserve backward compatibility.
- Validate input at trust boundaries; authorize every resource access server-side.
- Keep secrets in the project's established secret store; never commit credentials.
- Handle errors without leaking tokens, personal data, or internal implementation details.
- Use timeouts, retries, idempotency, and rate limits when the integration requires them; do not add them mechanically.
- Keep external API behavior versioned to official documentation and note assumptions.
- Coordinate persistence and migrations with database-engineer; coordinate auth, PII, and threat-sensitive work with application-security-engineer.
- Keep network calls and side effects out of pure business logic where practical.
- Do not modify live services, send messages, or deploy without explicit authorization.

Follow project conventions and user instructions about tests. Do not add or run tests unless explicitly asked. Report API/schema changes and actual verification.
