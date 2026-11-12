# Plano de Testes — skill `design-lab`

Objetivo: garantir que **cada capacidade que a skill promete gera output funcional e de qualidade** — não só que ela muda o comportamento. Organizado em camadas, da mais barata/automatizável à mais cara/humana. Cada item tem **critério de aceite** objetivo.

Legenda: ✅ feito · 🟡 parcial · 🔲 pendente

Gate de release: **Camada 0 = 100% · Camada 2 = 100% render · Camada 3 = todas com assertions verdes + aprovação humana · Camada 1 (triggering) ≥ 90% no held-out.**

---

## Camada 0 — Sanidade estrutural (script, ~1 min) 🔲
Roda com um único script Python; falha aqui bloqueia todo o resto.
- **0.1** Frontmatter do SKILL.md válido: tem `name` e `description`; corpo < 500 linhas. ✅ (91 linhas)
- **0.2** As 10 references existem em `references/` e **todas** aparecem na tabela de roteamento do SKILL.md (nenhuma órfã, nenhum link morto). 🔲
- **0.3** Os 9 assets existem em `assets/` e **batem byte-a-byte** com o `claude.md.bak` (integridade da extração — garante que não truncou). 🔲
- **0.4** `CLAUDE.md` do projeto aponta pra skill; `claude.md.bak` preservado (465KB). ✅
- **0.5** Nenhuma referência interna quebrada (todo `references/x.md` citado existe; todo `assets/y` citado existe). 🔲

## Camada 1 — Triggering (a descrição dispara na hora certa?) 🔲
A `description` é o que faz a skill acordar. Testar com queries realistas.
- **1.1** Montar 20 queries: 10 **should-trigger** (variações de deck/landing/doc/protótipo/anúncio/animação/design system/clone — formais, casuais, sem dizer "design") + 10 **should-not** near-miss (ex: "conserta esse bug no meu CSS", "resume esse PDF", "analisa esses dados numa planilha" — tocam em keywords mas não são design). 🔲
- **1.2** Rodar `run_loop.py` (skill-creator) 3× por query, split train/test. 🔲
- **Aceite:** ≥90% de acerto no held-out; nenhuma should-not disparando. 🔲

## Camada 2 — Componentes (`assets/`) renderizam? 🟡
Harness isolado por componente + inspeção visual.
- **2.1** deck-stage.js — 2 slides, rail, nav, slide ativo. ✅
- **2.2** ios-frame.jsx ✅ · **2.3** android-frame.jsx ✅ · **2.4** macos-window.jsx ✅ · **2.5** browser-window.jsx ✅
- **2.6** animations.jsx — Stage + scrubber ✅; **capturar t=0.5 e t=3.0** pra confirmar que os Sprites (texto/rect) aparecem em movimento, não só o chrome. 🔲
- **2.7** tweaks-panel.jsx — renderiza null até ativar ✅; **testar a adaptação Claude Code**: auto-open sem host + persistir valores em `localStorage` (recarregar mantém). 🔲
- **2.8** image-slot.js — empty state ✅; **testar drop de imagem + persistência** (a versão do host usa `window.omelette.writeFile`; validar a adaptação pra localStorage/IndexedDB). 🔲
- **2.9** metrics-overlay.js — passthrough mode=off ✅; **testar modo mock** (heat/trend renderiza sobre um protótipo com `data-metric-id`, sem host). 🔲
- **Aceite:** todos renderizam sem erro de console; os 3 host-dependent funcionam standalone após adaptação.

## Camada 3 — Entregáveis end-to-end 🟡
Um subagente **segue a skill**, produz o artefato e se verifica. Grading = assertions objetivas (script) **+** review visual humano no viewer.
- **3.1 Deck** ✅ (5/5) — deck-stage, ≥6 slides, sem emoji, fonte distinta, ≥24px.
- **3.2 Doc/Print** ✅ (5/5 estrutura) — `.doc`+doc-frame, @page 0, h1, sem raster. **Falta:** gerar PDF real (`--print-to-pdf --no-pdf-header-footer`) e conferir **1 página, texto selecionável, cores fiéis**. 🔲
- **3.3 Landing/Aesthetics** ✅ (5/5) — direção coesa, fonte distinta, anti-slop, form+benefícios+prova.
- **3.4 Design System** 🔲 — gerar DS de marca fictícia: `styles.css` só com @import, `tokens/` (base+semânticos), ≥3 specimen cards que consomem os tokens, ≥1 componente com .d.ts/doc, `readme.md` com CONTENT+VISUAL FUNDAMENTALS. **Aceite:** estrutura de pastas correta + cards renderizam consumindo os tokens.
- **3.5 Prototype** 🔲 — app multi-tela com device frame + estado real (login → ação → resultado). **Aceite:** interatividade funciona (dirigir via `eval_js`/headless: clicar botão muda tela); frame renderiza; estado persiste em localStorage.
- **3.6 Animation + MP4** 🔲 — animação determinística (`?t=`) → exportar MP4 pelo pipeline (frames headless + ffmpeg). **Aceite:** MP4 no tamanho certo (ex: 1080×1920), duração ≈ alvo, frames **não-idênticos** (`ffmpeg` extrai 3 frames distintos), abre e toca.
- **3.7 Canvas/Wireframe** 🔲 — 3 variações lado a lado. **Aceite:** frames posicionados sem sobreposição, labels presentes, cada variação num eixo distinto.
- **3.8 Anúncios** 🔲 — kit (feed 1:1 + story 9:16 + carrossel). **Aceite:** proporções exatas por formato, margem segura no story, CTA presente.
- **3.9 Export — standalone HTML** 🔲 — pegar uma das landings, embutir imagens base64, abrir **offline** (sem rede). **Aceite:** renderiza idêntico sem assets externos.
- **3.10 Export — handoff dev** 🔲 — gerar `design_handoff_*/README.md`. **Aceite:** autossuficiente (medidas, cores hex, tipo, estados, tokens) — um dev de fora implementaria só com ele.
- **3.11 Export — PPTX** 🔲 — **LIMITAÇÃO conhecida:** o `gen_pptx` do app antigo não existe no Claude Code. Testar caminho alternativo (python-pptx + PNGs renderizados dos slides) OU documentar explicitamente como não-suportado nativo. 🔲

## Camada 4 — Gotchas / regressão 🟡
- **4.1** `.jsx` via Babel do `file://` fica branco (CORS) → recipe do web-craft.md. ✅ (encontrado)
- **4.2** Código de componente colado inline em `<script>` quebra no `</script>` dos comentários → recipe. ✅ (encontrado)
- **4.3** Anti-FOUT: página com fonte 404 **não** fica branca (cap de 2s). 🔲
- **4.4** Print freeze: imprimir um deck com animação de entrada — o conteúdo **aparece** no PDF (não fica no estado hidden). 🔲
- **4.5** Deck >6 slides + slide com `data-deck-skip` + print → 1 página por slide, sem folha em branco no fim. 🔲
- **4.6** Responsivo: landings colapsam pra 1 coluna em ~390px sem overflow horizontal. 🔲

## Camada 5 — Qualidade / anti-slop (humano, no viewer) 🟡
Checklist por entregável (revisão visual):
- **5.1** Sem gradiente roxo-azulado default · sem emoji fora de brand · sem fonte batida (Inter/Roboto/Arial/Fraunces) · sem card "cantos arredondados + borda-esquerda accent". 🟡 (3/10 revisados)
- **5.2** Títulos **introduzem** a seção (não são punchline "Não é X, é Y"). 🔲
- **5.3** Escalas mínimas respeitadas por meio (24px slide / 12pt print / 44px hit target). ✅ (nos 3 testados)
- **5.4** Zero filler / data slop. 🔲

## Camada 6 — Fidelidade / brand-aware 🔲
- **6.1** Clone: dar uma URL e verificar que cores/fontes/estrutura foram **extraídas do real**, não inventadas. 🔲
- **6.2** Brand-aware: com os assets da Escola em `assets/`, produzir uma peça e conferir uso do **logo e paleta reais** (não placeholders). 🔲

---

## Matriz de execução
- **Automatizável (0, 2, 4.1-4.2, parte da 3):** scripts Python + Chrome headless + ffmpeg. Roda sem humano.
- **Subagentes (3.x):** um agente por entregável seguindo a skill; paralelizar. Baseline só onde a comparação interessa (deck/doc/landing já feitos).
- **Humano (1 assinatura, 5, 6):** viewer do skill-creator pra review visual + o loop de triggering.

## Estado atual (resumo)
- ✅ Feito: 0.1, 0.4, componentes 2.1-2.5 (render), 3.1/3.2(estrutura)/3.3, 4.1-4.2, 5.3(parcial).
- 🔲 Falta: sanidade 0.2/0.3/0.5, triggering (camada 1 inteira), 2.6-2.9 (animação em movimento + 3 host-dependent adaptados), 3.4-3.11 (design system, protótipo, MP4-from-skill, canvas, anúncios, standalone, handoff, PPTX), gotchas 4.3-4.6, qualidade 5.1/5.2/5.4, fidelidade 6.

## Ordem sugerida de execução
1. Camada 0 (script rápido — pega problema estrutural antes de gastar em subagente).
2. Camada 2 restante (adaptar+testar os 3 host-dependent; animação em movimento).
3. Camada 3 restante (subagentes paralelos: design system, protótipo, canvas, anúncios, MP4, standalone, handoff).
4. Camada 4 gotchas (scripts).
5. Camada 1 triggering (loop de descrição).
6. Camadas 5/6 (review humano no viewer + fidelidade).
