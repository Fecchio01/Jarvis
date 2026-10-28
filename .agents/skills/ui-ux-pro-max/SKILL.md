---
name: ui-ux-pro-max
description: Use when designing user flows, interaction patterns, component behavior, or product design systems for digital interfaces.
---

# UI/UX Pro Max

Reason systematically about the complete experience, not just its visual finish.

## Context model

Before recommending a pattern, determine who uses the product and how often; what task they need to finish; which devices and input methods they use; whether the task is operational, time-sensitive, exploratory, or occasional; which existing conventions must remain; and what can go wrong or require recovery.

## Pattern selection

- Use tables when people compare many attributes; prioritized lists for sequence or urgency; card grids for visual browsing; master-detail layouts for inspecting a selected record.
- Use bottom navigation for a few primary mobile destinations and sidebars for deeper app navigation. Use breadcrumbs only for real hierarchy.
- Prefer single-column forms. Use multiple columns only for short, related fields. Split complex flows into steps and preserve progress.
- Keep the next useful action clear. Make destructive and irreversible actions explicit.
- Handle empty, loading, success, validation-error, permission, and network states. Include recovery actions.
- Design for realistic content, long names, dense data, and narrow screens.

Treat these as starting points, not recipes. Inspect existing components and test whether a pattern reduces effort for the actual user. Avoid adding dashboards, navigation, or components simply because they are common in templates.

## System and interaction quality

Keep component hierarchy and states coherent across screens. Define tokens and shared patterns when multiple views need consistency. Make controls usable with keyboard and touch; label icon-only controls; provide visible focus and adequate contrast. Avoid mobile overflow and make touch targets comfortably usable.

Give prompt, specific feedback. Use optimistic updates only when rollback and failure behavior are understood. Prefer understandable copy over system jargon. Errors should say what happened and what the user can do next.

Use transitions to clarify state changes. Keep motion purposeful and account for reduced-motion preferences.

## Review

For a redesign, report current usability issues with evidence, then propose revised structure and interaction. For implementation, review the primary path and edge states. State assumptions, tradeoffs, and checks actually performed.

## Attribution and scope

Tailored for Jarvis from UI UX Pro Max: https://github.com/nextlevelbuilder/ui-ux-pro-max-skill. The full upstream pack contains a searchable design database and scripts; those assets are not included in this focused project skill. Do not claim to have queried that database unless it is installed.
