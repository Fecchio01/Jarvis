# Jarvis

Configuração do orquestrador Jarvis e de seus especialistas de marketing, engenharia de software e planejamento financeiro para Codex.

## Especialistas e skills

- `.codex/agents/marketing.toml` usa a skill `marketing-general`.
- `.codex/agents/software-engineer.toml` usa a skill `software-engineering`.
- `.codex/agents/financial-organizer.toml` usa a skill `financial-organization`.

As skills vivem em `.agents/skills/`; a configuração dos agentes fica em `.codex/agents/`. Essas são as pastas de descoberta de projeto do Codex. Os arquivos de orientação do Jarvis ficam em `AGENTS.md`.

## Carregar no Codex neste projeto

Puxe as alterações com `git pull` e abra uma nova sessão do Codex a partir da raiz deste repositório. Os agentes e as skills ficam disponíveis neste projeto; não é necessário copiá-los para a configuração global. Se a sessão atual já estava aberta, reinicie-a para recarregar as definições.

- [Documentação oficial de agentes personalizados](https://learn.chatgpt.com/docs/agent-configuration/subagents)
- [Documentação oficial de skills](https://learn.chatgpt.com/docs/build-skills)

Os especialistas são acionados pelo Jarvis para tarefas solicitadas pelo usuário. A revisão financeira semanal é feita quando solicitada; não há monitoramento de conta nem execução em segundo plano.

## Usar os especialistas em outros projetos

A configuração versionada aqui é de escopo deste repositório. Para usar os mesmos especialistas globalmente, copie os arquivos de `.codex/agents/` para `~/.codex/agents/` e as pastas de `.agents/skills/` para `~/.agents/skills/` (no Windows, use as pastas equivalentes dentro de `$env:USERPROFILE`). Incorpore o protocolo de `AGENTS.md` às instruções globais existentes, sem apagá-las, e reinicie as sessões do Codex.
