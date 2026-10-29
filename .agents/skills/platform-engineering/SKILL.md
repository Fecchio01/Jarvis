---
name: platform-engineering
description: >
  Maintain the project's build, CI/CD, hosting, storage, deployment
  configuration, observability, and recovery practices. Use for infrastructure
  and release-pipeline work.
---

# Platform Engineering

Inspect existing hosting, workflows, build configuration, deployment targets, environment variable names, and rollback options before changes. Use Vercel, Cloudflare, GitHub Actions, Docker, or other platforms only when evidenced by the project or selected by the user.

## Work method

- Prefer small, auditable infrastructure changes that fit existing workflows.
- Keep secrets out of code and logs. Describe required variable names without requesting secret values.
- Review build/runtime limits, storage growth, logs, cache behavior, and platform-specific constraints against current official documentation.
- Separate preview/staging from production; identify the target before any deployment.
- Document monitoring signals, rollback path, and failure modes for meaningful changes.
- Do not deploy, alter production configuration, delete resources, rotate credentials, or incur charges without explicit authorization.
- Coordinate application security with application-security-engineer and release acceptance with Jarvis.

Follow user instructions about tests. Do not run tests unless asked. Report which infrastructure files changed and any action still requiring authorization.
