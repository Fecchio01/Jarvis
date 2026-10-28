---
name: web-design-guidelines
description: Use to audit digital interfaces for accessibility, responsive behavior, interaction clarity, and interface quality.
---

# Web Design Guidelines

Review the requested UI, source files, or rendered screens against current web-interface guidance and project requirements.

## Review process

1. Identify the scope and inspect actual files or rendered interface.
2. When internet access is available, check the current Vercel Web Interface Guidelines: https://vercel.com/design/guidelines or upstream skill at https://github.com/vercel-labs/agent-skills/tree/main/skills/web-design-guidelines. Use current rules and note the date checked. Do not claim to have fetched them if you did not.
3. Review relevant areas: semantic structure and labels; keyboard operation and focus order; contrast and text scaling; touch targets; narrow layouts and overflow; forms and validation; error, loading, empty, and success states; motion and reduced-motion behavior; image alternatives and performance.
4. Prioritize findings by user impact. Include file and line when reviewing code, or identify the exact screen and behavior when reviewing a rendered UI.
5. Separate defects from subjective design suggestions and pair findings with practical fixes.

## Output

Return concise, actionable findings first, ordered by severity. If no issue is found in the inspected scope, state what you reviewed and the limits of review. Do not claim full compliance from a partial inspection.

## Attribution

Tailored for Jarvis from Vercel's web-design-guidelines: https://github.com/vercel-labs/agent-skills/tree/main/skills/web-design-guidelines. Upstream rules change; check the official guidance when available.
