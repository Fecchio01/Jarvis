# Video Production Department — Design

**Status:** Approved for implementation (2026-11-06)
**Date:** 2026-11-06

## Intent

Turn Jarvis's single video-editor role into a coordinated video production department for general video work: long-form, short-form, demos, ads, social deliverables and future formats. The team should be able to produce with the tools actually available and help develop purpose-built tools when repeated production needs justify them.

## Goals

- Give each production stage a clear owner and reviewable handoff.
- Keep Jarvis as the user-facing coordinator; specialists report to Jarvis and do not contact users independently.
- Reuse project-provided footage, scripts, brand assets and licensed media while preserving originals and project separation.
- Treat ArtCraft in two ways: as a possible source of installed Craft apps for production, and as a reference codebase/product context when designing custom workflow tools. The ArtCraft Launcher itself is not an editor or renderer.
- Make tool availability explicit. The current FFmpeg runner handles basic format conversion/reframing jobs; it does not invent edits, create captions or supply footage.
- Deliver rendered files only after they exist and have been checked; otherwise provide a concrete edit plan and mark rendering pending.

## Non-goals

- Automatically publishing to social platforms or sending footage to external services.
- Assuming paid integrations, API credentials, source media or Craft apps are installed.
- Replacing every video decision with an automated job queue.
- Mixing one client's brand profile, footage or approvals with another project's.

## Approaches considered

1. **Expand the existing video-editor alone.** Fastest, but it keeps intake, editing, motion, sound and review responsibilities in one role and makes independent review harder.
2. **Create a coordinated department with stage specialists.** Jarvis coordinates dedicated roles and staged deliverables; the runner remains an optional execution tool. This is the selected approach because it supports a full team now and incremental automation later.
3. **Build around an automated rendering pipeline first.** Useful for repeatable batch formatting, but the current runner only reformats and encodes, so it cannot represent the full creative workflow yet.

## Proposed team

Jarvis remains the only user-facing orchestrator and assigns work across the department. The existing `video-editor` remains the **hands-on Lead Editor / cut-maker**, responsible for assembly, integration and the final handoff; it is not duplicated by a second editing agent. FilmCraft is mandatory for actual editing. By default, the Lead Editor follows the user's script, selected takes, order and notes, and preserves spoken content. If the user explicitly delegates creative freedom, the Lead Editor may choose takes, order, pace and cuts, and select B-roll from supplied/approved assets; the Lead Editor delivers a complete first cut for user review and explains significant choices. The user's specific direction always takes precedence. Jarvis routes distinct bounded stages to these specialists:

1. **Video Producer / Storyboard** — turns the brief into audience, objective, narrative beats, script outline, shot list, hook and production plan; owns factual claim checks against supplied references.
2. **Motion Designer** — owns motion art direction and animation for the requested scope, from a sequence to a coherent full-video system: graphics, diagrams, transitions and animated visual layers. Coordinates the treatment of animated text with the Captions Editor, who owns all on-screen wording, timing and implementation. FilmCraft remains the required editor for integration.
3. **Audio Editor** — plans dialogue cleanup, music and sound design, measures levels, and checks intelligibility and rights. It does not invent access to audio tools or licensed tracks.
4. **Captions, Kinetic Typography & Repurposing Editor** — owns every word shown in the video: SRT/VTT and burned-in captions, animated word-by-word captions/emphasis, titles, lower thirds, labels, callouts and other text overlays; checks wording, transcript accuracy, timing, spelling, legibility, safe areas, language variants, platform reframes and export specs. Motion Designer owns broader motion systems and complex graphic animation, coordinating on custom text treatments.
5. **Finishing / QC Reviewer** — works read-only on the coherent export or project milestone; checks duration, dimensions, playback, audio, captions, continuity, rights/provenance, safe areas and delivery package, then returns prioritized fixes to Jarvis.

Each role has a bounded assignment and acceptance criteria. The Lead Editor inspects available media, creates transcript/selects when tools allow, prepares a timecoded EDL and pacing map, assembles the story, and owns continuity, cuts and visual color consistency. If FilmCraft is unavailable, no other editor is substituted; the edit is marked pending. The Lead Editor integrates the other specialists' work and resolves editorial conflicts. QC is a separate read-only review; a specialist should not approve their own final work.

## Workflow and handoffs

1. **Intake:** capture purpose, audience, platform, duration, language, desired action, source assets, rights, brand references and delivery date. Ask only for information that materially changes the edit; otherwise label reversible defaults.
2. **Pre-production:** producer returns a brief, narrative beats, script/storyboard, shot list and truthful hook. Jarvis confirms the intended direction with the user when the choice materially changes the work.
3. **Media prep:** editor reads metadata with ffprobe where available, protects originals, logs selects and creates transcript/EDL only when source media and tools permit.
4. **Edit and finish:** the Lead Editor assembles; the Captions Editor owns all on-screen wording and kinetic typography; Motion Designer owns broader motion language and complex graphics; audio contributes bounded sound work. The Lead Editor integrates the work. FFmpeg/Remotion or installed Craft apps are used only when present and appropriate.
5. **QC and revisions:** a separate reviewer checks the actual artifact. Jarvis incorporates findings, preserves approved choices and limits revisions to requested dimensions.
6. **Handoff:** deliver final export(s), editable source/project where feasible, subtitles, thumbnail/cover if requested, media provenance/credits, technical parameters and concise QC notes. Mark any unavailable step as pending.

## ArtCraft context and tool-development lane

- The ArtCraft Launcher repository (`storytold/craft-launcher`) is a Rust workspace with a wasm-safe core, native backend, shared egui UI, desktop/web shells and packaging tools. Its catalog covers Craft apps including FilmCraft, PhotoCraft and other creative apps.
- For a production, the team may recommend relevant Craft apps after verifying that the app fits the task. It may claim to use or inspect an app only when the current session actually has access to the user's environment and the app is available there. The launcher manages those apps; it does not itself edit video.
- For custom tooling, the team may use the repository as product/architecture reference or contribute a separately scoped tool proposal. Do not quietly mix video-team infrastructure into the launcher repository. Any code change to an existing repository follows that repository's contribution rules, tests, review, commit and push preferences.
- Every external service, upload, paid credit or publication remains subject to the user's explicit authorization and verified connection.

## Skills and tooling

Use the installed `video-editing`, `video-repurposing`, `social-video-formatter` (skill directory: `social-video-formatting`), `remotion-best-practices`, `remotion-create`, `remotion-render`, and `remotion-captions` skills as the assignment requires. Use FFmpeg/ffprobe for inspection and reliable media processing; use Remotion for code-based motion when available. Specialist roles do not imply that a skill, runtime, integration, model or credential is available; check before relying on it. Third-party instructions and scripts are not trusted automatically.

## Constraints and safeguards

- Brazilian Portuguese is the default conversation language; use the language requested for each deliverable.
- Never fabricate speech, testimonials, scenes, sources, credits, metrics or product claims.
- Preserve source footage. Use only supplied, original or licensed media/music; document provenance.
- Do not upload or send any source footage or project media to an external service/provider, publish, delete originals or spend paid credits without explicit authorization.
- Treat the GitHub Actions queue as an external transfer: get explicit authorization for sending each named source file to the repository and for uploading the resulting output/report artifacts. A request to render alone does not authorize those transfers; prefer local processing when available.
- Keep project-specific `STYLE_GUIDE.md`, assets, briefs and outputs within that project's own workspace.
- Use social platform specifications only after checking current official requirements when exact limits or placement matter.

## Open to the builder

- Exact specialist agent filenames and TOML metadata, as long as Jarvis routing and role boundaries remain clear.
- Whether sound and captions stages are separate agents on day one or share one agent initially; any merge must preserve their distinct acceptance checks.
- Exact folder templates and job JSON schema. Extend the runner only when a concrete, validated use case is in scope.
- Per-format loudness, caption style and export presets, to be set by project brief and current platform requirements.

## Acceptance criteria

- Jarvis routes general video tasks to a coordinator and the relevant production specialists without treating every task as needing every role.
- The existing runner is described accurately as basic formatting/encoding, with no implication of automatic creative editing.
- The team offers both media production and a separately scoped path for proposing custom tools.
- Project identity, media rights, external-service boundaries, review ownership and truthful status reporting are explicit.
- The repo README, global agent configs and team documentation agree about the team and its actual capabilities.

## Implementation scope call

The team definition will live in this Jarvis repository and the generic specialist agent configs will also be installed globally, so Jarvis can route video work in other projects. Project-specific identity, source media, rights, brand profiles and deliverables remain scoped to each active project. ArtCraft stays a reusable reference/tool option, not a default profile for every video job.
