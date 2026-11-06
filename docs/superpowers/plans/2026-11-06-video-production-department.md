# Video Production Department Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [x]`) syntax for tracking.

**Goal:** Replace Jarvis's single video-editor agent with a routed video-production department that handles general production work and a separately scoped custom-tooling lane.

**Architecture:** Keep Jarvis as user-facing coordinator and the current `video-editor` as hands-on Lead Editor. Add five bounded specialists with repo handbooks; update routing and overview docs; install the synchronized agent definitions globally with the existing installer. Preserve the existing media runner and its job contract.

**Tech Stack:** Markdown, TOML custom-agent profiles, PowerShell global installer, existing FFmpeg/ffprobe and Remotion workflows.

**Spec:** `docs/superpowers/specs/2026-11-06-video-production-department-design.md`

## Global Constraints

- Brazilian Portuguese is the default conversation language; use the language requested for each deliverable.
- Never fabricate speech, testimonials, scenes, sources, credits, metrics or product claims.
- Preserve source footage. Use only supplied, original or licensed media/music; document provenance.
- Do not upload or send any source footage or project media to an external service/provider, publish, delete originals or spend paid credits without explicit authorization.
- GitHub Actions queue use requires explicit authorization for sending each named source file to the repository and uploading output/report artifacts; a render request alone is insufficient.
- Keep project-specific `STYLE_GUIDE.md`, assets, briefs and outputs within that project's own workspace.
- Do not claim to use or inspect local Craft apps without actual access to the user's environment and app availability.
- Do not extend the FFmpeg runner without a concrete, validated use case; it currently formats and encodes only.
- Keep Jarvis as the only user-facing orchestrator; specialist agents report to Jarvis.

## Review Focus

- A task unrelated to video production must not trigger the department; inspect routing language in `AGENTS.md` and README.
- An unavailable integration, Craft app or media tool must not be reported as used; inspect all agent profiles and role handbooks for access checks and pending states.
- A media handoff must retain rights/provenance and preserve source files; inspect Lead Editor and Audio/QC responsibilities.
- Cross-project installation must preserve the user's unmanaged global instructions; use only the existing `scripts/install-global.ps1` behavior and verify the managed block boundaries.
- The runner must not imply automatic creative editing; preserve its paths, schema and current capability language.

---

### Task 1: Define production role handbooks and shared workflow

**Files:**
- Modify: `agents/design/video-editor/AGENT.md`
- Modify: `agents/design/video-editor/WORKFLOWS.md`
- Modify: `agents/design/video-editor/SKILLS.md`
- Create: `agents/design/video-editor/roles/video-producer.md`
- Create: `agents/design/video-editor/roles/motion-designer.md`
- Create: `agents/design/video-editor/roles/audio-editor.md`
- Create: `agents/design/video-editor/roles/captions-repurposing-editor.md`
- Create: `agents/design/video-editor/roles/finishing-qc-reviewer.md`

**Interfaces:**
- Consumes: approved design at `docs/superpowers/specs/2026-11-06-video-production-department-design.md`.
- Produces: five single-purpose role briefs referenced by matching agent profiles; the existing `AGENT.md` defines the Lead Editor and shared safeguards; `WORKFLOWS.md` describes intake-to-handoff stages.

- [x] **Step 1: Define the Lead Editor contract** in `AGENT.md`: hands-on editing and final integration; no second editor agent; Jarvis coordinates task routing; roles and safeguards from the spec.
- [x] **Step 2: Define the shared stage handoffs** in `WORKFLOWS.md`: intake, pre-production, media prep, edit/finish, independent read-only QC, handoff; state exact expected artifacts and when to mark work pending.
- [x] **Step 3: Create the five role briefs** with each role's mission, input, output, bounded scope, acceptance criteria and escalation conditions. Keep the QC reviewer read-only and separate from the Lead Editor.
- [x] **Step 4: Align the skill/tool map** in `SKILLS.md` to installed skill folder names; state FFmpeg/ffprobe, Remotion and Craft app availability checks; keep the runner description limited to formatting/encoding.
- [x] **Step 5: Review the role docs together** for duplicate ownership, contradictory handoffs, unverified tool claims, project leakage and rights gaps.

### Task 2: Add the specialist agent profiles

**Files:**
- Modify: `.codex/agents/video-editor.toml`
- Create: `.codex/agents/video-producer.toml`
- Create: `.codex/agents/motion-designer.toml`
- Create: `.codex/agents/audio-editor.toml`
- Create: `.codex/agents/captions-repurposing-editor.toml`
- Create: `.codex/agents/video-qc-reviewer.toml`

**Interfaces:**
- Consumes: role briefs from Task 1.
- Produces: globally installable TOML profiles with exact names matching the five role handbooks; existing `video-editor` profile stays Lead Editor.

- [x] **Step 1: Update `video-editor.toml`** to identify the hands-on Lead Editor, route specialist work through Jarvis and read the shared handbook/workflow.
- [x] **Step 2: Add `video-producer.toml` and `motion-designer.toml`** with bounded deliverables and their relevant installed skill references.
- [x] **Step 3: Add `audio-editor.toml` and `captions-repurposing-editor.toml`** with rights, access and format-specific boundaries.
- [x] **Step 4: Add `video-qc-reviewer.toml`** as a read-only reviewer who inspects real artifacts and returns prioritized findings to Jarvis.
- [x] **Step 5: Inspect all six profiles** for valid TOML, matching handbooks, unique ownership, no instruction to contact the user directly and no unsupported integration claims.

### Task 3: Route and document the department

**Files:**
- Modify: `AGENTS.md`
- Modify: `README.md`
- Modify: `agents/design/video-editor/jobs/README.md`
- No changes: `.github/workflows/video-editor.yml`, `agents/design/video-editor/runner.mjs`

**Interfaces:**
- Consumes: agent profiles and role handbooks from Tasks 1–2.
- Produces: repository-level routing and overview text that accurately describes the team and current runner.

- [x] **Step 1: Update `AGENTS.md` routing** so video tasks call the Lead Editor plus only the relevant specialists, with separate QC at coherent milestones; preserve all non-video routing.
- [x] **Step 2: Update the README** agent list and video section to name the department, explain the production/tool-building lanes, and identify actual runner limits.
- [x] **Step 3: Update the jobs README** to clarify that committed queue jobs only run existing format/encode behavior, may overwrite/re-upload artifacts, and require explicit permission for source and artifact transfers; no new job types or creative automation are introduced.
- [x] **Step 4: Compare the changes with the spec** and confirm that repo docs and TOML profiles agree on team names, boundaries, ArtCraft access, project isolation and runner capability.

### Task 4: Install the department globally

**Files:**
- Execute: `scripts/install-global.ps1`
- Global targets: `~/.codex/AGENTS.md`, `~/.codex/agents/*.toml`, `~/.agents/skills/`

**Interfaces:**
- Consumes: approved repository `AGENTS.md`, `.codex/agents/`, `.agents/skills/`.
- Produces: Jarvis's managed global instruction block updated; all repo agent profiles synchronized to the global agents directory; installed skills copied according to the existing script.

- [x] **Step 1: Run the existing installer** from the Jarvis repository root after Tasks 1–3 are complete.
- [x] **Step 2: Inspect global results**: confirm the managed instruction block is present once, the six video TOMLs are present, and unrelated global instruction text remains outside and intact.
- [x] **Step 3: Record the runtime limitation**: a new Codex session may be required before the newly installed profiles become available; no always-on or automatic job processing is claimed.

### Task 5: Final review and repository delivery

**Files:**
- Review: all files from Tasks 1–3 plus the final design and plan documents.

**Interfaces:**
- Consumes: complete department implementation and global installation result.
- Produces: reviewed diff, one coherent commit and confirmed push to `origin` when the repository is in a safe state to fast-forward.

- [x] **Step 1: Request one read-only review** of the complete diff from the most relevant video specialist; address material findings.
- [x] **Step 2: Inspect final diff and working tree**; stage only files for this team change and preserve unrelated files.
- [x] **Step 3: Create one meaningful commit** for the coherent team change.
- [x] **Step 4: Push to the configured GitHub remote** and confirm the remote branch contains the commit before reporting it.

## Execution Notes

- Do not alter, enqueue or run media jobs as part of this team setup.
- Do not add or run tests as part of this documentation/configuration change unless the user requests testing or implementation verification.
- No production video export, external upload, publication, purchase or release is in scope.
