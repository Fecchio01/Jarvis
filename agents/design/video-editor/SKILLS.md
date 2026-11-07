# Video Production Skill Map

The named skills below are present under `.agents/skills/` in this repository and are copied by `scripts/install-global.ps1`. Read only skills relevant to the current stage; an installed skill is an instruction set, not proof that a runtime or external integration is connected. `motion-foundations` and `motion-patterns` are optional and should be used only when separately installed.

| Production need | Skills |
|---|---|
| Edit planning, media workflow and final quality | `video-editing` |
| Long-form source to short-form clips | `video-repurposing`, `video-editing` |
| Social reframe, safe areas and platform exports | `social-video-formatter` (directory: `social-video-formatting`), `remotion-captions` |
| Captions and subtitle presentation | `remotion-captions`, `social-video-formatter` |
| Dialogue/music balance and sound effects | `video-editing`; route dialogue/music to Audio Editor and SFX design/placement to Sound Designer |
| Motion design and animation choices | `motion-design`; optionally `motion-foundations` or `motion-patterns` when separately installed |
| Color correction, grading and image quality | `video-editing`; use FilmCraft for project integration and verify any available scopes/enhancement tools |
| Remotion project authoring and rendering | `remotion-best-practices`, `remotion-create`, `remotion-render` |
| Campaign/script positioning or persuasive copy | Route to Jarvis's marketing/copywriter specialists as needed |

## Tool checks

- Use `ffprobe` to inspect source and exported media when available; use FFmpeg for reliable cuts, crops, audio processing and encodes.
- Use Remotion only when Node/dependencies and a suitable project are available. Keep source projects reproducible.
- Use a Craft app only when it is relevant, installed/available, and the current session has actual access to the user's environment. The ArtCraft Launcher itself manages apps; it does not edit/render.
- Check live connector state and permission before using Descript, Runway, Canva or any other external service. Do not send any source footage or project media to an external service/provider without explicit user authorization.
- The current committed-job runner only reframes/encodes. Do not describe it as an autonomous editing or caption pipeline.

## Third-party skill handling

Use only the installed skill directories. Do not download, install or execute new third-party skills/scripts as part of a video job without reviewing their source, license, network access, secrets handling, dependencies and destructive behavior. Skills do not fine-tune model weights.
