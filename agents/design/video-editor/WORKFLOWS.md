# Production workflows

## Routing and ownership

Jarvis owns intake, user communication, specialist selection and delivery coordination. It asks the Lead Editor to own the edit. It brings in a specialist only when that stage is relevant; a simple cut does not need every role.

| Stage | Owner | Handoff |
|---|---|---|
| Intake and scope | Jarvis + Lead Editor | Confirmed brief, assets/rights inventory, target formats and any explicitly labeled assumptions |
| Story and pre-production | Video Producer / Storyboard | Audience/objective, narrative spine, storyboard, scene/shot list, visual evidence plan, timing and factual source map; sends script briefs to Copywriter |
| Media prep and assembly | Lead Editor (FilmCraft) | ffprobe metadata when available, selects/transcript if possible, timecoded EDL, editable FilmCraft project and first cut |
| Motion design, full-video when requested | Motion Designer | Motion concept/style frames, timeline motion map, transitions, diagrams and animated graphic layers/source; text wording/timing remains with Captions Editor |
| Color and image quality | Colorist / Image Quality Specialist | Shot-matching map, correction/grade notes, source-quality diagnosis and editable FilmCraft grade |
| Dialogue and music mix | Audio Editor | Dialogue cleanup plan, music balance, measured audio review and mix notes |
| Sound effects | Sound Designer / SFX Editor | Sound palette, timecoded effects cue sheet, approved/licensed SFX assets, placed effects and provenance |
| All on-screen words, captions and versions | Captions, Kinetic Typography & Repurposing Editor | SRT/VTT or caption JSON, word-level timing, animated word captions, titles/overlay text inventory and timing, aspect/crop plan, safe-area notes and per-platform export list |
| Independent review | Finishing / QC Reviewer | Read-only findings against the actual project/export and prioritized corrections |
| Final integration and handoff | Lead Editor + Jarvis | Actual files, editable source when possible, credits/provenance, technical details and QC status |

## Stage sequence

1. **Intake.** Record goal, audience, platform(s), duration, language, CTA, source materials, brand kit, media rights and delivery needs. Keep project context scoped to the current workspace. If a missing answer would materially change the edit, ask; otherwise write down a reversible assumption.
2. **Pre-production.** Producer returns a concise brief, narrative spine, storyboard, shot list, visual evidence plan, timing and source map. The producer preserves supplied script and user direction. When a spoken script needs writing or revision, the Copywriter drafts it from the producer's brief. Jarvis gets user direction for choices that materially change the deliverable; claims are grounded in supplied references.
3. **Media prep.** Lead Editor checks available metadata with `ffprobe`, preserves originals, notes missing/corrupt/unreadable inputs and prepares selects/transcript/EDL only when tools and source material support them. FilmCraft is mandatory; if unavailable, do not switch editors and mark the edit pending.
4. **Assembly and finish.** Lead Editor makes the cut in FilmCraft. By default, follow the user's script, selected takes, order and notes; preserve speech, and do not trim pauses, repetitions or mistakes unless asked. When the user explicitly delegates creative control, the Lead Editor may choose takes, order, pace, cuts and B-roll from supplied/approved assets, then delivers a complete first cut for user review with a short rationale. User choices override those decisions. The Captions Editor owns all video text: subtitles, kinetic word captions, titles and labels. Motion Designer owns broader motion systems and complex graphic animation, coordinating custom animated text. Colorist applies the approved grade and image-quality corrections. Sound Designer creates and places SFX; Audio Editor balances dialogue and music and coordinates the mix. The Lead Editor integrates the work; QC remains independent and read-only.
5. **QC.** Jarvis assigns a read-only reviewer who did not make the final edit. The reviewer checks the real artifact: playback, start/middle/end continuity, duration, frame size/aspect ratio, safe areas, dialogue intelligibility, clipping, caption spelling/timing, color consistency, image artifacts from grading/enhancement, rights/provenance and delivery completeness. A finding must point to the artifact and timecode when possible.
6. **Revision and handoff.** Lead Editor applies agreed corrections. Deliver final media only if it exists and has been checked; also include editable source where feasible, subtitles, thumbnail/cover if requested, credits, parameters and QC notes. Otherwise state exactly what is pending and provide the strongest completed intermediate (such as EDL or render spec).

## Routing by request

- **Basic trim or cleanup:** Lead Editor; Audio Editor if dialogue/music treatment is needed; Sound Designer if effects are requested; QC when there is an export.
- **Sound-effects-led video or custom transition/UI effects:** Lead Editor + Sound Designer / SFX Editor; Audio Editor joins for dialogue/music balance; QC checks sync, masking, clipping and SFX provenance.
- **Color grading or image-quality repair:** Lead Editor + Colorist / Image Quality Specialist; QC independently reviews the corrected export for consistency and artifacts.
- **Scripted explainer, ad or product demo:** Producer/Storyboard + Copywriter + Lead Editor; Marketing supports positioning/campaign strategy when relevant; add motion/audio/captions as needed; separate QC before final. If the user supplies the finished script, the producer storyboards around it without rewriting.
- **Long-form source to social clips:** Lead Editor + Captions, Kinetic Typography & Repurposing Editor; producer only if story selection is unclear; add motion/audio selectively; QC the final variants.
- **Motion-heavy explainer or video-wide animation request:** Producer/Storyboard + Lead Editor + Motion Designer for the visual motion system and requested full-timeline animation + Captions Editor for all on-screen wording/word timing; add audio as needed; QC rendered output.
- **Kinetic-text edit:** Captions Editor owns all wording, word timing and text implementation + Motion Designer supplies/implements coordinated visual treatment and complex animation; Lead Editor integrates in FilmCraft and QC reviews the rendered output.
- **Audio-led interview/podcast:** Lead Editor + Audio Editor; Captions, Kinetic Typography & Repurposing Editor for verbatim subtitles and clip variants; QC final exports.
- **Workflow/tooling request:** Lead Editor documents the repeated production need and desired outcome. Jarvis routes technical design/implementation to software-engineer, and product design to product-designer when the tool has a user interface. Keep proposed tooling in its own repository/scope unless the user chooses an existing repo. ArtCraft can provide product/architecture context or a relevant installed Craft app, but it is not the renderer itself.

## Project handoff structure

Within the active project's authorized workspace, organize what exists under a single video project folder:

```text
video-project/
  BRIEF.md
  STYLE_GUIDE.md            # only when the user/project has approved one
  assets-manifest.md        # source, owner, license/permission, usage
  edit/EDL.md
  captions/                 # SRT/VTT as requested
  source-project/           # editable timeline/Remotion project when feasible
  outputs/                  # rendered exports only
  QC.md
```

Do not create empty placeholders for files that are not needed. Keep source footage outside generated output paths; never overwrite or delete originals.

## Existing job runner

The GitHub Actions runner accepts committed JSON jobs under `agents/design/video-editor/jobs/` with `id`, an input path beneath `agents/design/video-editor/media/`, and `format` (`short` or `long`). Using it transfers the named source file to the GitHub repository and uploads the rendered output/report as workflow artifacts retained for seven days. Get explicit user authorization for both transfers before adding/committing media or a job; a request to render does not itself authorize them. Prefer local processing when available. Each workflow run invokes every committed job; FFmpeg writes with overwrite enabled, so an existing output can be rendered again and replaced. It reframes/encodes with FFmpeg and probes basic output metadata. It does not transcribe, choose clips, edit narrative, generate captions, add motion graphics, or perform creative QC. No job is implied by this department design.
