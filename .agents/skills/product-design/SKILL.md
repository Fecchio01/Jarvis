---
name: product-design
description: Use for digital product design, UX, information architecture, user flows, UI, responsive design systems, interaction and motion. Excludes social posts and video editing.
---

# Digital Product Design

Use this skill for digital products and interfaces. This role is separate from the specialists for social posts, video, and marketing.

## Workflow

1. Understand the product, audience, primary task, platform, existing behavior, constraints, and how success will be recognized. Inspect the project's current UI, design tokens, components, and design notes first.
2. Keep context scoped. Apply only the identity and preferences relevant to the named project. The profiles below are conditional examples, never defaults. For an unnamed or new project, use its brief and assets only. Never import another project's palette, layout, motion, or product decisions.
3. Choose a direction grounded in the product's subject matter. Define hierarchy, palette, type, layout, components, and motion briefly. Avoid interchangeable generated UI patterns; use cards, gradients, decoration, or animation only when they serve this product.
4. Design the experience. Map the main user path and important states. Prefer clear labels, visible system status, error prevention, progressive disclosure, and consistent actions. Include realistic data and empty, loading, error, success, and recovery states where applicable.
5. Always consult the motion-design skill for product-design work. Provide a motion proposal or explicitly state why stillness is the better design choice. Respect reduced-motion settings and keep motion purposeful.
6. Implement in the existing stack and conventions. The user's preferred toolkit is HTML, CSS, JavaScript, TypeScript, GLSL, and Three.js. Choose tools based on the task; use Three.js and GLSL for justified 3D or shader work, not as a default for ordinary UI. Respect explicit project-level exclusions; for example, Casa Fiaes has a standing constraint against Three.js and GSAP.
7. Review phone and desktop states, keyboard access, visible focus, contrast, responsive overflow, and important interface states. Inspect rendered output if visual-review tools are available. Report only checks actually performed.
8. Summarize decisions and tradeoffs directly. Separate usability defects from aesthetic preferences and identify unresolved assumptions.

## Focus skills

Use frontend-design for distinctive visual direction and implementation; ui-ux-pro-max for flows, interaction patterns, and design-system reasoning; web-design-guidelines for focused code and accessibility reviews; motion-design for timing, easing, choreography, and motion behavior. These skills complement each other and do not override the product brief or established project conventions.

## Project context profiles

Profiles are conditional and must not be mixed across projects.

### Arvello

- Spell the name Arvello (two l's).
- Its known identity is black and lime green. It has used mobile-first responsive layouts and subtle motion in scroll, buttons, and cards.
- Confirm the task and current assets before extending these choices. Do not apply them to unrelated work.

### Casa Fiaes

- Preserve Casa Fiaes's own visual identity; do not borrow Arvello's palette or style.
- The product prioritizes an operational Fila as the primary view and a complementary Jornada view for management. Support phone and desktop.
- Existing preferences: avoid Three.js and GSAP; motion should serve a purpose, remain accessible, respect reduced-motion settings, and usually be brief (100–300ms). Avoid horizontal overflow; mobile fields should be at least 16px and touch targets around 44px where practical.
- Recheck the current repository and task before assuming these decisions still apply.

## Scope

This specialist designs digital products. Social media graphics and post concepts belong to the posts specialist; video editing and cinematic direction belong to the video specialist. Do not turn this skill into a universal brand profile.

## Sources

Tailored for Jarvis from Anthropic's frontend-design, UI UX Pro Max, Vercel's web-design-guidelines, and LottieFiles' motion-design skill. The local skills preserve selected workflows; this project does not claim to include UI UX Pro Max's searchable data pack.
