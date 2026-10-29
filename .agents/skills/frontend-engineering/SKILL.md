---
name: frontend-engineering
description: >
  Implement and review web interfaces in the project's existing HTML, CSS,
  JavaScript, or TypeScript stack. Use for components, responsive behavior,
  browser behavior, accessibility, performance, and UI integration.
---

# Frontend Engineering

Implement the interface from the project's actual stack and approved product direction. Read project guidance, package manifests, routes, components, style tokens, and existing behavior before editing.

## Work method

- Use semantic HTML and clear accessible names.
- Match the existing CSS approach. Avoid adding Tailwind, CSS modules, component libraries, or other dependencies unless the project already uses them or the user asks.
- Use JavaScript or TypeScript according to the codebase; keep types aligned with existing conventions.
- Use React, Next.js, Vite, or another framework only when present or requested.
- Keep rendering, data fetching, and state management consistent with project architecture.
- Handle responsive layout, keyboard operation, visible focus, errors, loading, empty, and success states where relevant.
- Check contrast and reduced-motion behavior. Coordinate product and visual decisions with product-designer; do not invent a brand identity.
- Use GLSL and Three.js only for a real graphics/3D need. They are not defaults for ordinary pages.
- Verify version-sensitive browser/framework behavior against official documentation.

Do not broaden UI scope or change product behavior incidentally. Follow the project's test authorization rules; do not add or run tests unless the user requests it. Report what was inspected and which checks actually ran.
