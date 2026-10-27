# Jarvis

Configuração do agente Jarvis e de seu especialista geral de marketing para Codex.

## Conteúdo

- `AGENTS.md`: protocolo de orquestração e revisão do Jarvis.
- `agents/marketing.toml`: definição do subagente de marketing.
- `skills/marketing-general/SKILL.md`: skill de marketing.
- `skills/marketing-general/references/user-profile.md`: contexto de marketing carregado pela skill quando relevante.

## Instalação no Windows

Feche as sessões do Codex antes de instalar. No PowerShell, a partir da raiz deste repositório:

```powershell
$codex = Join-Path $env:USERPROFILE ".codex"
New-Item -ItemType Directory -Force (Join-Path $codex "agents") | Out-Null
New-Item -ItemType Directory -Force (Join-Path $codex "skills") | Out-Null
Copy-Item .\agents\marketing.toml (Join-Path $codex "agents\marketing.toml") -Force
Copy-Item .\skills\marketing-general (Join-Path $codex "skills\marketing-general") -Recurse -Force
```

O Codex carrega instruções globais de `AGENTS.md`. Revise o arquivo existente em `$codex\AGENTS.md` e incorpore nele o protocolo deste repositório, preservando as instruções globais que já existirem. Se não houver um arquivo global, copie o `AGENTS.md` da raiz para esse caminho:

```powershell
if (-not (Test-Path (Join-Path $codex "AGENTS.md"))) {
    Copy-Item .\AGENTS.md (Join-Path $codex "AGENTS.md")
}
```

Reinicie o Codex após a instalação para recarregar a configuração. A skill pode ser chamada pelo nome `marketing-general`; a configuração define o agente especializado como `marketing`.

## Instalação em macOS/Linux

A estrutura equivalente fica em `~/.codex/agents/marketing.toml`, `~/.codex/skills/marketing-general/` e `~/.codex/AGENTS.md`. Crie os diretórios, copie os arquivos e incorpore o protocolo de `AGENTS.md` às instruções globais existentes sem apagá-las. Reinicie o Codex depois.