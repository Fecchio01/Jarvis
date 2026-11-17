---
name: system-builder
description: Use for starting a new software system or making a substantial cross-cutting change. Orchestrates project setup, repository and folder organization, skill and specialist selection, specification, implementation, review, Git delivery, and authorized deployment. Skip for small bounded fixes that do not change system structure.
---

# System Builder

Jarvis owns the end-to-end workflow. Select the needed steps and specialists from the actual project; do not make the user choose routine tools or repeat known preferences. Keep the user informed with a short kickoff summary and ask only for decisions that materially change scope, architecture, data handling, cost, or an external action that is not already authorized.

## Workflow

1. **Classify the work.** Decide whether this is a new system, a substantial system change, or a bounded task. Use this workflow for new systems and substantial changes; keep small, contained fixes direct.

2. **Locate and preserve the project.** Find the matching Codex project, repository, and existing local files. Reuse them when they belong to this system. Read all applicable `AGENTS.md`/`CLAUDE.md` instructions, manifests, README files, and relevant docs. Record the remote, current branch and commit, worktrees, and working-tree changes before editing. Keep clients and systems separate. Preserve dirty files, local commits, branches, worktrees, assets, and project history.

3. **Prepare the project workspace.** For a new system, choose one canonical project folder and create or reuse its Codex project and repository when the available Codex actions support that. If the Codex project registry has no creation action, prepare the folder, open it when possible, and tell the user exactly which UI step remains; never claim the registry entry exists. For an existing system, organize only what is needed: keep source repositories, brand/reference materials, and project documentation clearly separated without moving a live checkout or worktree casually. Add concise project instructions and a README when they are missing and useful.

4. **Configure project conventions once.** When first applying Matt Pocock engineering practices in a repository, inspect the repo's setup state and follow the relevant setup guidance where the repository and user instructions determine the choices. `setup-matt-pocock-skills` is explicit-only in this installation: consult its file as reference when useful, but invoke the named skill only when the user explicitly requests it. Reuse an existing issue tracker, label vocabulary, glossary, ADRs, and document structure. Use GitHub Issues when the repo's established setup says so; otherwise follow the project's existing tracker. Do not create external issues, labels, repositories, or services unless the user's standing instructions or the task authorize that action.

5. **Choose the workflow and team.** Select only relevant skills and specialists. For unclear product scope, use a focused grilling/specification flow. For a substantial change, define acceptance behavior and the highest useful verification seam before implementation. Break large work into dependent tickets only when that improves execution. For public, indexable websites, route SEO review; for UI, coordinate product design and frontend; add backend, database, security, QA, and platform roles only when the work touches their areas. Give specialists bounded assignments and avoid parallel work on shared files.

6. **Implement in the safest place.** Follow repository conventions and the approved scope. Use an existing safe branch or worktree; isolate a feature branch when needed. Keep each change focused, preserve unrelated edits, and do not introduce dependencies or reorganize unrelated files without a reason.

7. **Review and verify within authorization.** Review the actual diff against the requirements, project standards, and data/security boundaries. Use a read-only specialist review for a meaningful milestone when available. Follow the user's current testing instructions; do not add or run tests unless the user asks for testing or verification. Report other checks only if actually performed.

8. **Deliver through Git and project rules.** Stage only files for this change. Create one meaningful commit per coherent change, push it to the configured remote when the user's standing instructions authorize that, and verify the remote update. Use the project's deployment instructions and existing authorization: deploy Atelier Approach after a pushed code change as instructed; do not deploy other systems without applicable authorization. Never claim a commit, push, merge, issue closure, or deployment that was not confirmed.

9. **Close the loop.** Summarize what changed, where it lives, the skills/roles used, review or verification actually performed, remaining limitations, and exact branch/commit/push/deployment status. For a new system, confirm the Codex project and canonical folder status separately.

## Skill selection guide

- Requirements or product behavior are unclear: use model-invoked `grilling` and `domain-modeling`, then write the needed spec in the project's established format.
- A coherent spec needs implementation: decompose the work into dependent tasks when useful and implement them through the authorized workflow. Skills marked explicit-only in their own frontmatter, including `to-spec`, `to-tickets`, `implement`, and `implement-spec`, cannot be invoked automatically. Use their named skill only when the user explicitly requests it; otherwise follow compatible process guidance directly, without remote tracker writes unless authorized.
- Code changes: use `tdd` only when testing is authorized; use `codebase-design` when module boundaries matter and model-invoked `code-review` before delivery.
- A difficult defect: `diagnosing-bugs`.
- Architecture maintenance: use `codebase-design` for a concrete module-design problem. `improve-codebase-architecture` is explicit-only and requires the user to request that survey.
- Research, prototypes, and PR writing: use model-invoked `research`, `prototype`, and `pr` when their specific outputs are needed. `triage` and `handoff` are explicit-only; use them only when the user requests those named workflows.

Treat skill names as routing choices, not a mandatory checklist. If a named skill is unavailable in the current Codex session, use the installed skill file when accessible or report the specific limitation.
