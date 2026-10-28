# Jarvis

Configuração do orquestrador Jarvis e de seus especialistas de marketing, engenharia de software, planejamento financeiro e design de produto digital para Codex.

## Especialistas e skills

- `.codex/agents/marketing.toml` usa a skill `marketing-general`.
- `.codex/agents/software-engineer.toml` usa a skill `software-engineering`.
- `.codex/agents/financial-organizer.toml` usa a skill `financial-organization`.
- `.codex/agents/product-designer.toml` usa as skills `product-design`, `frontend-design`, `ui-ux-pro-max`, `web-design-guidelines` e `motion-design`.

As skills vivem em `.agents/skills/`; a configuração dos agentes fica em `.codex/agents/`. Essas são as pastas de descoberta de projeto do Codex. Os arquivos de orientação do Jarvis ficam em `AGENTS.md`.

O agente de design atua em produtos digitais. Posts para redes sociais e edição de vídeos continuam em especialidades separadas. Suas preferências de interface e identidade são aplicadas somente ao projeto correspondente. O conjunto de tecnologias de referência inclui HTML, CSS, JavaScript, TypeScript, GLSL e Three.js; a escolha é feita por tarefa e respeita as restrições específicas de cada projeto.

## Carregar no Codex neste projeto

Puxe as alterações com `git pull` e abra uma nova sessão do Codex a partir da raiz deste repositório. Os agentes e as skills ficam disponíveis neste projeto; não é necessário copiá-los para a configuração global. Se a sessão atual já estava aberta, reinicie-a para recarregar as definições.

- [Documentação oficial de agentes personalizados](https://learn.chatgpt.com/docs/agent-configuration/subagents)
- [Documentação oficial de skills](https://learn.chatgpt.com/docs/build-skills)

Os especialistas são acionados pelo Jarvis para tarefas solicitadas pelo usuário. A revisão financeira semanal é feita quando solicitada; não há monitoramento de conta nem execução em segundo plano.

## Usar os especialistas em outros projetos

A configuração versionada aqui é de escopo deste repositório. Para usar os mesmos especialistas globalmente, copie os arquivos de `.codex/agents/` para `~/.codex/agents/` e as pastas de `.agents/skills/` para `~/.agents/skills/` (no Windows, use as pastas equivalentes dentro de `$env:USERPROFILE`). Incorpore o protocolo de `AGENTS.md` às instruções globais existentes, sem apagá-las, e reinicie as sessões do Codex.

## Editor audiovisual

- `.codex/agents/video-editor.toml` defines the video specialist under Design.
- `.agents/skills/video-editing/`, `video-repurposing/`, `social-video-formatting/` contain three locally maintained skills. These are not copies of external SkillMD packages; third-party skill review is still pending.
- `agents/design/video-editor/runner.mjs` is a Node.js + FFmpeg baseline for aspect-ratio formatting, not a complete AI editor.
- `.github/workflows/video-editor.yml` runs on push, manual dispatch and scheduled checks. It requires media + JSON jobs committed to the repo; outputs are workflow artifacts. There are no media jobs yet.
- Runway, Descript and Canva require separate connection, authorization and possibly paid credits. No Cloudflare video rendering service has been deployed.

### Upstream video skills
Original upstream SKILL.md files copied into project: naveedharri/benai-skills video-repurposing, SkillMedev/motion-video-direction social-video-formatter, and remotion-dev/skills remotion-best-practices/create/render/captions. Selected video-repurposing references also copied. Not all referenced upstream support files are present; no third-party install scripts or dependencies were executed. The SkillMD remotion entry is only a stub; official Remotion skills were used instead. Original sources should be reviewed and pinned before executing scripts. External integrations are not connected.

## SEO specialist

- `.codex/agents/seo-specialist.toml` routes SEO work to a dedicated Marketing specialist.
- Installed original upstream SKILL.md files: seo-audit, technical-seo-audit (Semrush MCP required), content-strategy, schema-markup and programmatic-seo. Dependencies and companion files have not been fully verified. No production deployment or scheduled SEO audit is active.

## Copywriter

- `.codex/agents/copywriter.toml` defines the dedicated Marketing copywriter.
- Original upstream skills: `.agents/skills/copywriting/`, `copy-editing/`, `marketing-psychology/`, `cold-email/` from coreyhaines31/marketingskills. External companion assets/dependencies not fully validated. No automatic outbound sending or publishing.
