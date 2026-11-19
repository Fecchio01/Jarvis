# System-building workflow

Jarvis and the engineering team follow this sequence for a new software system or a substantial change. The workflow itself is automatic; **every skill invocation is manual and belongs to the user**.

## Stages

1. **Identify and inspect.** Find the matching Codex project, repository, and existing materials. Read project instructions and relevant docs. If `docs/work/STATUS.md` exists, read it first, then open only the active ticket and the docs it points to. Record remotes, branch, commit, worktrees, and local changes. Preserve existing work.

2. **Organize the workspace.** Reuse the project's folder and Codex project when they exist. For a new system, prepare one canonical folder, separate source code from brand/reference material, and add only useful README/instructions/docs. Create or connect the repository as authorized. If Codex has no project-creation action, prepare the folder and tell the user the one UI action still needed.

3. **Discover before designing or coding.** For new behavior, product/design work, or a nontrivial change, first summarize the understood outcome and ask the smallest set of unanswered questions that could materially change behavior, scope, acceptance, data handling, cost, or external effects (bundle up to three). Wait for the user's answers before settling those decisions. Reuse prior decisions only when the user clearly approved them for this same project and change. If nothing material is unresolved, state the assumptions and acceptance criteria briefly. Completion: the user has answered the material questions, or the remaining assumptions are explicit and low-impact.

4. **Hold the skill gate.** Skills are user-invoked. At the relevant stage, recommend exactly one skill with its exact command and a brief reason; wait for the user to invoke it before work that depends on it. Do not design, draft implementation, edit files, or delegate implementation while this gate is pending. Read-only inspection and research may continue. If the user has already invoked the relevant skill in the current task, proceed. Completion: the skill invocation is visible in the current task, or the task is a small bounded fix for which no skill materially helps.

5. **Specify and create tickets.** For a new system or substantial change, make a concise spec and split implementation into small tickets with acceptance criteria and dependencies. Prefer vertical slices that deliver useful behavior. Use the configured tracker when authorized; also save a concise local record under `docs/work/tickets/` so a new chat can resume from the project folder. If no tracker is configured, keep the tickets there. Keep `docs/work/STATUS.md` as the short index of current milestone, active ticket, next action, blockers, branch, and last commit. Recommend `to-spec` or `to-tickets` at this stage and wait for the user's invocation before work that depends on that skill.

6. **Implement ticket by ticket.** Choose stack from the actual repository. Route only relevant specialists. Finish one coherent ticket at a time; parallelize only independent work. Preserve unrelated changes. After each ticket, update its file with status, changed files, commit, verification actually performed, and the next dependency; update `docs/work/STATUS.md`. Recommend implementation or design skills when they materially help. Testing remains governed by the user's current instruction; do not add or run tests unless requested.

7. **Review each meaningful milestone.** Compare the diff with acceptance criteria and project standards. Recommend a review skill when useful and let the user invoke it. Use specialist review for substantial work when relevant. Report only checks actually performed.

8. **Commit and deliver.** Stage only this change, create one meaningful commit per coherent change, push when the user's standing instructions authorize it, and confirm the remote update. Deploy only under the project's existing authorization. The Atelier Approach instructions authorize production deployment after a code push; other systems need their own applicable authorization.

9. **Checkpoint and close concisely.** Before `/clear`, ending a session, or moving to a new chat, save the current state in `docs/work/STATUS.md` and update the active ticket. Include what is done, what is in progress, exact next action, blockers/decisions, branch and latest commit. Do not make chat history the only record of work. A new chat in the same Codex project resumes by reading the status index and active ticket, not by reconstructing the whole conversation. Report outcome, key files, ticket status, branch/commit/push/deploy status, and unresolved action briefly.

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
- Bundle up to three material discovery questions; wait for answers before design or implementation.
- Recommend at most one skill at a time, exactly when its stage arrives.
- Send progress updates only for a decision, milestone, blocker, or material finding.
- Keep specs and tickets in project files; refer to them instead of repeating them in chat.
- Do not run every specialist, skill, or check on every project.
- Before the user clears context, confirm that the project checkpoint and active ticket are saved. Clearing/restarting the chat does not save files; it only helps focus the next conversation on the persisted project state.
