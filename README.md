# Jarvis

Configuração do agente Jarvis e de seus especialistas gerais de marketing e engenharia de software para Codex.

## Conteúdo

- `AGENTS.md`: protocolo de orquestração e revisão do Jarvis.
- `agents/marketing.toml`: definição do subagente de marketing.
- `skills/marketing-general/SKILL.md`: skill de marketing.
- `skills/marketing-general/references/user-profile.md`: contexto de marketing carregado pela skill quando relevante.
- `agents/software-engineer.toml`: definição do subagente de engenharia de software.
- `skills/software-engineering/SKILL.md`: skill de engenharia de software.

## Instalação no Windows

Feche as sessões do Codex antes de instalar. No PowerShell, a partir da raiz deste repositório:

```powershell
$codex = Join-Path $env:USERPROFILE ".codex"
New-Item -ItemType Directory -Force (Join-Path $codex "agents") | Out-Null
New-Item -ItemType Directory -Force (Join-Path $codex "skills") | Out-Null
Copy-Item .\agents\marketing.toml (Join-Path $codex "agents\marketing.toml") -Force
Copy-Item .\skills\marketing-general (Join-Path $codex "skills\marketing-general") -Recurse -Force
Copy-Item .\agents\software-engineer.toml (Join-Path $codex "agents\software-engineer.toml") -Force
Copy-Item .\skills\software-engineering (Join-Path $codex "skills\software-engineering") -Recurse -Force
```

O Codex carrega instruções globais de `AGENTS.md`. Revise o arquivo existente em `$codex\AGENTS.md` e incorpore nele o protocolo deste repositório, preservando as instruções globais que já existirem. Se não houver um arquivo global, copie o `AGENTS.md` da raiz para esse caminho:

```powershell
if (-not (Test-Path (Join-Path $codex "AGENTS.md"))) {
    Copy-Item .\AGENTS.md (Join-Path $codex "AGENTS.md")
}
```

Reinicie o Codex após a instalação para recarregar a configuração. As skills podem ser chamadas pelos nomes `marketing-general` e `software-engineering`; os arquivos TOML definem os agentes especializados como `marketing` e `software-engineer`.

## Instalação em macOS/Linux

A estrutura equivalente fica em `~/.codex/agents/marketing.toml`, `~/.codex/agents/software-engineer.toml`, `~/.codex/skills/marketing-general/`, `~/.codex/skills/software-engineering/` e `~/.codex/AGENTS.md`. Crie os diretórios, copie os arquivos e incorpore o protocolo de `AGENTS.md` às instruções globais existentes sem apagá-las. Reinicie o Codex depois.
