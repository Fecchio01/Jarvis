# System-building workflow

Jarvis and the engineering team follow this sequence for a new software system or a substantial change. The workflow itself is automatic; **every skill invocation is manual and belongs to the user**.

## Stages

1. **Identify and inspect.** Find the matching Codex project, repository, and existing materials. Read project instructions and relevant docs. Record remotes, branch, commit, worktrees, and local changes. Preserve existing work.

2. **Organize the workspace.** Reuse the project's folder and Codex project when they exist. For a new system, prepare one canonical folder, separate source code from brand/reference material, and add only useful README/instructions/docs. Create or connect the repository as authorized. If Codex has no project-creation action, prepare the folder and tell the user the one UI action still needed.

3. **Clarify the outcome.** Inspect the request and project context first. Ask only questions whose answers change product behavior, scope, data handling, architecture, cost, or an external action. Record the expected outcome and acceptance criteria concisely.

4. **Recommend the skill for this stage.** Do not invoke any skill. Name one relevant skill, give its exact command and a one-sentence reason, then wait for the user to invoke it before dependent work. Continue independent inspection or setup. Do not present a long skill menu or ask the user to choose among commands.

5. **Specify and create tickets.** For a new system or substantial change, make a concise spec and split implementation into small tickets with acceptance criteria and dependencies. Prefer vertical slices that deliver useful behavior. Use the configured tracker when authorized; otherwise keep the spec/tickets in the project's docs. Recommend `to-spec` or `to-tickets` at this stage and wait for the user's invocation before work that depends on that skill.

6. **Implement ticket by ticket.** Choose stack from the actual repository. Route only relevant specialists. Finish one coherent ticket at a time; parallelize only independent work. Preserve unrelated changes. Recommend implementation or design skills when they materially help. Testing remains governed by the user's current instruction; do not add or run tests unless requested.

7. **Review each meaningful milestone.** Compare the diff with acceptance criteria and project standards. Recommend a review skill when useful and let the user invoke it. Use specialist review for substantial work when relevant. Report only checks actually performed.

8. **Commit and deliver.** Stage only this change, create one meaningful commit per coherent change, push when the user's standing instructions authorize it, and confirm the remote update. Deploy only under the project's existing authorization. The Atelier Approach instructions authorize production deployment after a code push; other systems need their own applicable authorization.

9. **Close concisely.** Report outcome, key files, ticket status, branch/commit/push/deploy status, and unresolved action. Keep the final update short; link to project docs instead of repeating them.

## Skill recommendations by stage

Recommend only the next relevant skill, not the whole catalog:

- Requirements/domain: `mattpocock-skills:grilling` or `mattpocock-skills:domain-modeling`.
- Spec/tickets: `mattpocock-skills:to-spec` or `mattpocock-skills:to-tickets`.
- Implementation: `mattpocock-skills:implement` or `mattpocock-skills:implement-spec`; mention `mattpocock-skills:tdd` only if the user wants testing.
- Module boundaries: `mattpocock-skills:codebase-design`.
- Difficult bug: `mattpocock-skills:diagnosing-bugs`.
- Review: `mattpocock-skills:code-review`.

Use the exact invocation syntax surfaced by the current Codex plugin. If a skill is unavailable, say so briefly and offer the next manual command that fits. Never claim a skill was applied until the user invokes it.

## Token-efficient communication

- Start with a short status and the next stage, not a full process recap.
- Ask one focused question at a time only when the answer matters.
- Recommend at most one skill at a time, exactly when its stage arrives.
- Send progress updates only for a decision, milestone, blocker, or material finding.
- Keep specs and tickets in project files; refer to them instead of repeating them in chat.
- Do not run every specialist, skill, or check on every project.
