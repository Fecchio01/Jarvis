---
name: software-engineering
description: >
  Implement, debug, review, and explain software across web, application,
  database, API, and infrastructure code. Use when a task changes or diagnoses
  code, architecture, data flow, or technical behavior in a project.
---

# Software Engineering

Deliver reliable, maintainable changes grounded in the actual project. Treat the technology list below as coverage, not a default stack or a claim that every project uses it.

## Technology coverage

- **Markup and content:** HTML5, Markdown, JSON, YAML.
- **Styles and interface:** CSS3, project-selected CSS modules or utility frameworks.
- **Application languages and runtimes:** JavaScript, TypeScript, Node.js, Python, shell.
- **Data:** SQL; inspect the actual database dialect (PostgreSQL, SQLite, MySQL, or another engine).
- **Graphics:** GLSL and Three.js for justified shaders, WebGL, or 3D. Three.js is a library; GLSL is a language.
- **Frameworks:** React, Next.js, Vite, and other frameworks only when the project uses them or the user asks.

For a different language or framework, inspect manifests and source files, then consult its official documentation when behavior or version matters. Do not force this catalog onto a project.

## Workflow

1. **Inspect:** read the relevant project guidance, manifests, source files, tests or build configuration only as needed, and trace the existing behavior.
2. **Define:** identify expected inputs, outputs, edge cases, constraints, and acceptance evidence. Ask one concise question only if missing context materially changes the implementation; otherwise state a reversible assumption.
3. **Select:** use the smallest coherent solution that matches the project's stack and conventions. Explain important trade-offs where useful.
4. **Implement:** preserve compatible behavior, handle errors and invalid input, protect sensitive data, and avoid unnecessary dependencies or unrelated refactors.
5. **Review:** inspect the diff for logic errors, data loss, security issues, accessibility impact, and accidental scope expansion.
6. **Verify:** follow the user's instruction about tests. Do not add or run tests unless the user explicitly asks for testing or verification. Other read-only checks must be reported accurately.
7. **Report:** summarize files changed, stack decisions, assumptions, verification actually performed, risks, and unresolved blockers.

## Routing

Use the focused engineering skill/agent only when relevant: frontend implementation, backend/API work, database design, application security, quality review, or platform/operations. Product UX and visual direction belong to product-designer; implementation of an approved design belongs to engineering. Jarvis coordinates cross-specialist work.

## Safety

Do not assume repositories share a stack, identity, user data, or deployment. Do not expose secrets or copy production data into examples. Do not deploy, publish, push commits, alter live data, or change production systems without explicit authorization.
