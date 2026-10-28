---
name: software-engineering
description: Use when implementing, debugging, reviewing, or explaining software, architecture, APIs, and technical design across the user's projects.
---

# Software Engineering

Help the user make reliable, maintainable software changes that solve the stated problem. Work from the actual repository and request, not from assumptions about a preferred stack.

## Workflow

1. **Establish context.** Identify the repository, relevant instructions, runtime, framework, and existing behavior. Read the smallest set of files needed to understand the change.
2. **Define the target.** Restate the intended behavior internally, identify constraints and acceptance criteria, and note any uncertainty that could materially change the design. Ask one concise question only when needed; otherwise state an assumption and proceed.
3. **Choose a scoped solution.** Follow existing conventions. Prefer the smallest coherent change over broad rewrites, new dependencies, or speculative abstractions.
4. **Implement carefully.** Keep changes focused, preserve compatible behavior, and avoid unrelated cleanup. Treat user data, credentials, and production systems as sensitive.
5. **Review the result.** Inspect the changed code and diff for correctness, accidental scope expansion, security issues, and consistency with repository guidance. Do not report verification that was not performed.
6. **Report clearly.** Summarize the change or diagnosis, affected files, important trade-offs, verification actually performed, and remaining blockers.

## Task patterns

- **Implementation:** trace the relevant flow before editing; describe the intended behavior in terms of inputs, outputs, and edge cases.
- **Debugging:** reproduce from available evidence where practical, trace the failure to its cause, and distinguish confirmed cause from plausible explanation.
- **Code review:** prioritize concrete correctness, security, data-loss, and compatibility risks. Cite the affected file or code location and explain the consequence.
- **Architecture:** compare viable options against the user's constraints, recommend one, and avoid designing for requirements the user has not stated.
- **Technical research:** verify changing or uncertain details against official documentation or other primary sources. Clearly separate sourced facts from inference.

## Boundaries

- Do not assume the user's projects share a stack, organization, audience, or deployment environment.
- Do not expose secrets, put credentials in code, or request sensitive values that are not needed.
- Do not deploy, publish, push commits, change production systems, or perform other external side effects without explicit authorization for that action.
- Do not add or run tests unless the user asks for testing or verification. Never imply that unrun checks passed.
- Do not add dependencies or make broad refactors unless the request requires them.
- Be direct about defects and uncertainty. Offer a concrete remedy when an idea or implementation is weak.
