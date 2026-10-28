---
name: motion-design
description: Use whenever designing or reviewing motion in a digital product, including interaction feedback, transitions, scroll effects, 3D, shaders, and reduced-motion behavior.
---

# Motion Design

Apply motion design thinking to every product-design task. This means considering whether motion supports the experience; it does not mean adding animation to every screen. If stillness is clearer, state that choice.

## Motion brief

Before implementation, define:

1. Intent: what user action, state, hierarchy, or feeling does this motion support?
2. Story: what changes, and what should the user notice?
3. Character: what motion personality fits this project's identity?
4. Property: which minimum properties communicate the change?
5. Timing and easing: how fast should it respond, enter, settle, or exit?
6. Accessibility and performance: what happens with reduced motion, keyboard, touch, low-power devices, and interrupted animations?

## Practical principles

- Give interactive controls immediate feedback. Use short transitions for buttons and toggles, and longer transitions only when spatial context or a meaningful scene change needs them.
- Use eased movement rather than linear spatial motion. Choose easing and duration to fit the mass, distance, and character of the object.
- Establish a clear primary action; stagger only when it improves comprehension. Avoid multiple competing movements and decorative loops that draw attention away from work.
- Make state changes understandable when motion is disabled. Honor prefers-reduced-motion and provide a complete non-animated interaction.
- Keep animation interruptible, non-blocking, and performant. Prefer transform and opacity where appropriate. Consider frame rate, battery, and input latency.
- Do not treat numerical timing ranges or animation formulas as laws. Inspect the interface, existing identity, and platform conventions.
- For Three.js or GLSL work, keep animation purposeful, responsive, and bounded; provide a non-WebGL fallback when the task requires broad device support.

## Review checklist

Check the reason for each motion, trigger, duration, easing, hierarchy, overlap, interruption, reduced-motion behavior, and performance. Ask whether removing it would harm understanding or feedback; if not, simplify or remove it.

## Attribution

Adapted for Jarvis from LottieFiles' motion-design skill: https://github.com/LottieFiles/motion-design-skill. Project-specific preferences and accessibility take precedence over upstream examples.
