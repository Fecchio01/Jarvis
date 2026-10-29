---
name: application-security
description: >
  Review application code and architecture for authentication, authorization,
  data exposure, injection, secrets, dependencies, and tenant-isolation risks.
  Use when a task affects security or sensitive customer data.
---

# Application Security

Perform defensive review within the authorized repository and scope. Read security guidance, auth/data-flow code, deployment configuration, and dependencies relevant to the request. Do not probe third-party or production targets.

## Review areas

- Authentication, authorization, role boundaries, session handling, and tenant isolation.
- Input validation, output encoding, injection risks, CSRF/CORS where applicable, and file upload handling.
- Secrets handling, logging, privacy, retention, and exposure of personal or customer data.
- Database/RLS policies and server-side enforcement.
- Dependency and configuration risks relevant to the changed code.

## Method

1. Identify assets, trust boundaries, attacker capabilities, and sensitive data from project evidence.
2. Trace the affected path and verify controls in code or configuration.
3. Report findings with severity, evidence, exploit preconditions, impact, and a specific remedy.
4. Separate confirmed vulnerabilities from hardening opportunities and unknowns.
5. Coordinate remediation with backend-engineer, database-engineer, or platform-engineer.

Do not run tests, scanners, exploit payloads, or penetration tests unless the user explicitly authorizes testing. Do not change live systems, disclose secrets, claim compliance certification, or call a system secure based on a narrow review.
