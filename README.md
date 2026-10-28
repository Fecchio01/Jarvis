# Jarvis

Configuração do Jarvis como orquestrador global de especialistas para Codex. O Jarvis avalia cada tarefa, aciona automaticamente os agentes relevantes, coordena o trabalho autônomo deles e entrega o resultado. Os especialistas trabalham dentro do escopo autorizado e reportam ao Jarvis.

## Agentes

- `.codex/agents/marketing.toml`: estratégia, posicionamento, campanhas e desempenho.
- `.codex/agents/copywriter.toml`: redação e revisão de copy para páginas, anúncios, e-mails, conteúdo social, ofertas e conversão.
- `.codex/agents/sales-consultant.toml`: prospecção, qualificação, descoberta, demonstrações, propostas, objeções e próximos passos comerciais.
- `.codex/agents/seo-specialist.toml`: SEO técnico, conteúdo orgânico, busca local e AEO/GEO. O Jarvis solicita diagnóstico de SEO quando identifica páginas públicas e indexáveis em qualquer projeto.
- `.codex/agents/software-engineer.toml`: implementação, depuração, revisão de código e desenho técnico.
- `.codex/agents/financial-organizer.toml`: orçamento, fluxo de caixa, planejamento e pesquisa financeira com dados autorizados.
- `.codex/agents/product-designer.toml`: UX de produtos digitais e sistemas de interface.
- `.codex/agents/video-editor.toml`: edição e adaptação de conteúdo audiovisual.

O Jarvis decide quais especialistas são relevantes para cada solicitação. Os agentes executam autonomamente as partes delegadas e devolvem achados e entregáveis ao Jarvis. Não há execução contínua em segundo plano para os agentes de projeto.

## Skills de copy

O agente copywriter escolhe e aplica as skills pertinentes ao formato e à etapa da tarefa. O conjunto inclui copywriting, copy-editing, marketing-psychology, cold-email, content-strategy, emails, social, ad-creative, cro, customer-research, offers e product-marketing. As skills originais e seus arquivos de referência estão em `.agents/skills/`; nem toda skill é carregada em toda tarefa.

Os arquivos foram copiados de [coreyhaines31/marketingskills](https://github.com/coreyhaines31/marketingskills) no commit `0cd9b3a0ef4c411a1d690419ce843f2a1da32cce`. Consulte `THIRD-PARTY-NOTICES.md` para licença e atribuição.

## Skills de vendas e apresentação do usuário

O agente comercial usa `sales-enablement`, `prospecting` e, quando houver uma necessidade de inteligência competitiva, `competitor-profiling`; também reaproveita `customer-research`, `offers` e `cold-email` quando pertinentes. Os dados e integrações que não estiverem disponíveis são declarados, nunca presumidos. A skill de perfil competitivo usa Firecrawl/DataForSEO somente se esses conectores estiverem instalados; sem eles, o agente limita-se a pesquisa qualitativa em fontes públicas.

O perfil compartilhado em `.agents/skills/marketing-general/references/user-profile.md` contém um rascunho de apresentação profissional do João Fecchio, derivado do contexto já registrado sobre a Arvello, desenvolvimento de software, demonstrações e propostas. O texto está marcado como não aprovado: o agente deve confirmar antes de enviá-lo ou publicá-lo e nunca misturá-lo com a apresentação de um cliente.

## Instalação neste repositório

Puxe as alterações e abra uma nova sessão do Codex na raiz do repositório. Assim, os agentes e as skills ficam disponíveis neste projeto.

## Instalação global para todos os projetos

Arquivos versionados no repositório não passam a valer automaticamente em outros repositórios. Para habilitar o mesmo Jarvis em qualquer projeto do usuário, execute na raiz deste repositório:

```bash
bash scripts/install-global.sh
```

No PowerShell do Windows, execute `./scripts/install-global.ps1`. O instalador adiciona o protocolo Jarvis a `~/.codex/AGENTS.md`, instala os agentes em `~/.codex/agents/` e as skills em `~/.agents/skills/`. Ele mantém as instruções globais existentes fora do bloco gerenciado pelo Jarvis. Reinicie a sessão do Codex após instalar.

## Revisão financeira semanal

A revisão financeira é obrigatória e ocorre em uma automação semanal separada, com conversa própria no ChatGPT. Ela usa apenas extratos ou dados atuais fornecidos pelo usuário ou por uma conexão explicitamente autorizada e somente de leitura. Se os dados não estiverem disponíveis, solicita o material necessário; não afirma monitorar contas sem uma conexão ativa. O organizador financeiro mantém separadas as finanças pessoais, da EUpresa e de outros projetos.

O protocolo no repositório define o comportamento do agente. A automação recorrente é uma configuração separada do ChatGPT e precisa estar habilitada para executar a revisão semanal.

## SEO, produto e vídeo

- O diagnóstico de SEO é acionado pelo Jarvis quando o projeto contém páginas públicas indexáveis. Painéis internos, CRMs privados e protótipos não são tratados como páginas de busca.
- O agente de produto usa `product-design`, `frontend-design`, `ui-ux-pro-max`, `web-design-guidelines` e `motion-design` quando pertinentes.
- O editor de vídeo usa `video-editing`, `video-repurposing` e `social-video-formatting`. O runner FFmpeg existente formata mídia já preparada; serviços externos exigem conexão própria.
