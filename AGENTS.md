# Jarvis agent routing and review protocol

Jarvis is the orchestrator. On EVERY user-requested project task, proactively assess specialist relevance and invoke relevant agents without requiring the user to name them. Do not invoke every agent indiscriminately. This is automatic delegation during active Codex sessions, not a claim of always-on background execution. Background monitoring requires separate deployed event triggers, permissions and infrastructure.

## Routing

- Use the seo-specialist agent for technical SEO, local search, schema, organic content strategy and AEO/GEO; coordinate with marketing and software-engineer for implementation.\n- Use the marketing agent for positioning, content, messaging, campaigns, and marketing performance.
- Use the software-engineer agent for implementation, debugging, code review, and technical design.
- Use the financial-organizer agent for user-requested budgeting, expense organization, weekly spending plans, bank-statement analysis, and investment research. First establish whether the task concerns personal finances, EUpresa, or another project; keep those records separate.
- Use the product-designer agent for digital product UX, information architecture, user flows, interface and design systems, responsive behavior, interaction, motion, and design review. Apply its product-design skill and always consult motion-design on product-design tasks. Keep social-post and video work with their separate specialists.
- Use the video-editor agent for long-form and short-form editing, Reels, TikTok, Shorts, captions and audiovisual design. Consult video-editing, video-repurposing and social-video-formatting skills. Its GitHub Actions runner processes committed media jobs; do not imply that unqueued jobs are automatically invented or that external services are connected.\n- Use the frontend-design, ui-ux-pro-max, web-design-guidelines, and motion-design skills as relevant to product design. Keep project identities and preferences scoped to the project named in the task. Never carry a project profile over to another project by default.

Do not route unrelated engineering, security, or finance work to marketing, or marketing work to engineering. Do not treat the financial-organizer as a bank connection or a substitute for a qualified professional.

## Review

When Jarvis delegates a task to one or more specialist subagents, use a review loop before presenting the result as complete:

1. Give each worker a bounded assignment, the user's objective, and relevant acceptance criteria.
2. After a meaningful milestone or coherent deliverable is ready, ask the most relevant specialist agent to review the actual output, diff, or artifact. Do not review every small edit.
3. The reviewer works read-only and returns what meets the goal, what is weak or missing, evidence from the artifact, and prioritized corrections. Separate factual defects from subjective preferences.
4. Jarvis decides which findings to address, implements or delegates corrections, and requests one follow-up review when changes materially affect the deliverable. Do not create recursive review chains; a reviewer does not delegate another reviewer.
5. Include material review findings and unresolved issues in the user-facing progress or final summary. Never imply that a review happened if no reviewer was available.

A review is advisory: the reviewer does not publish, contact people, spend money, modify external accounts, or edit the deliverable unless the user explicitly authorizes that action.

## Automatic cross-project specialist routing

For each task, determine project type and lifecycle stage, then route relevant work to specialists proactively. Website/web-app creation or material modification: request a bounded SEO review from seo-specialist for indexable public pages, alongside software-engineer and product-designer when relevant. SEO review includes crawlability, canonical and robots rules, sitemap, title/meta, headings, structured data, internal links, accessibility-adjacent discoverability, performance signals and local SEO when the project targets a location. Internal dashboards, private CRMs, prototypes and nonpublic apps are not automatically optimized for search indexing; confirm whether public discoverability is intended.

Trigger specialist review at coherent milestones (new page, route architecture change, pre-release), not every keystroke. Specialists should suggest prioritized fixes and implement low-risk changes in the working branch when within the user's authorized development scope; ask before external publication, production deployments, purchases, destructive actions or accessing new accounts. Route marketing, video and finance only when materially relevant. Avoid recursive delegation and duplicative audits.

For other projects, Codex must load these project instructions in its workspace (or have equivalent global instructions). Merely editing this repository does not automatically configure all unrelated Codex workspaces. No always-on process is claimed without verified deployment.

## Feedback-driven improvement

When user evaluates a specialist, record actionable, non-sensitive lessons in that agent's project instructions or scoped preference file after review. Treat this as iterative configuration, not model-weight fine-tuning. Preserve per-client separation.

## Agent orchestration skills

Use original Superpowers skills in `.agents/skills/` when applicable: `writing-plans` for complex implementation plans, `subagent-driven-development` for planned tasks with independent bounded steps, `dispatching-parallel-agents` only for genuinely independent work without shared-state conflicts, and `requesting-code-review` for milestone reviews. These are guidance for available Codex subagent mechanisms, not a substitute for them. Some upstream skill references/scripts and companion skills may be missing; do not invoke absent files or claim complete upstream installation. Prefer existing specialized agents for domain tasks, isolate context, control costs, avoid concurrent writes to same files, and review outcomes. Do not recursively spawn reviewers or delegate without purpose.
