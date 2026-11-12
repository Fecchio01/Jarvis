# Web craft — gotchas de engenharia (garimpados dos starters)

Receitas de plataforma que aparecem repetidas no código dos componentes. Valem em qualquer stack (Chrome MCP, Playwright, React puro).

## Render / paint
- **Anti-FOUT**: segure o primeiro paint até `document.fonts.ready`, com `Promise.race` num cap de ~2s (uma fonte 404 não pode deixar a tela branca pra sempre). Rode um `requestAnimationFrame` ANTES de ler `fonts.ready` — senão ele resolve prematuramente, antes do layout iniciar os fetches de fonte.
- Dependências críticas de render (fontes, `@keyframes`, resets) no **topo** do documento; conteúdo tardio sempre com placeholder/tamanho mínimo (evita layout shift).
- Slides/painéis que saem de vista: **esconда com `visibility:hidden`+`opacity:0`, não desmonte** — preserva estado de vídeos/iframes/inputs/árvore React.

## Animação
- Estado de animação deve **sobreviver a re-render**: isole o elemento animado (a animação não pode reiniciar a cada render).
- Entrada animando **de** um estado escondido, com a base sendo o estado final visível — e gate em `@media (prefers-reduced-motion:no-preference)`, pra print e acessibilidade mostrarem o conteúdo.
- **FLIP** (reorder suave): grave posições, aplique o transform invertido, force um **reflow** (`void el.offsetHeight`) e SÓ ENTÃO ligue a transition — sem o reflow o browser coalesce os writes e nada anima.

## Viewport
- **Seção full-height: `min-height:100dvh`, nunca `100vh`/`h-screen`.** No Safari mobile, a barra de endereço esconde/aparece ao rolar e muda a altura da viewport em tempo real — `100vh` é calculado no valor errado e a seção "pula" ou deixa uma faixa vazia. `dvh` (dynamic viewport height) acompanha o tamanho real.
- **Placeholder de foto**: nunca linke Unsplash direto (a API antiga `source.unsplash.com` foi descontinuada — link comumente quebrado). Use `picsum.photos/SEED/W/H` (estável, sem chave) ou um avatar gerado em SVG quando a foto for de pessoa.

## Acessibilidade (embutir no HTML — barato, não é burocracia)
Vale em landing/site/protótipo/dashboard/doc (menos em slide/ad estático). Não é auditoria — é markup que você já escreve, só do jeito certo:
- **Foco visível — a regra que mais se viola por estética.** Nunca `outline:none` sem repor. `:focus-visible{ outline:2px solid var(--focus); outline-offset:2px }` (anel ≥2px, contraste ≥3:1) em TODO interativo. O `:focus` que `design-system.md` pede "por escrito" tem que existir renderizado.
- **Contraste (alvo, não olhômetro):** texto normal ≥ **4.5:1**; texto grande (≥24px, ou ≥18.7px/14pt bold) ≥ **3:1**; não-texto (borda de input, ícone informativo, série de gráfico, anel de foco) ≥ **3:1**. Vale sobre imagem/gradiente — se o fundo varia, scrim/overlay ou escolha por luminância. **Valide os pares reais ao fixar a paleta** (passo 3 do processo): ex. laranja `#F94E03` sobre branco dá ~3.6:1 → reprova pra corpo, passa só como título/bold.
- **Alt text:** `<img>` com significado leva `alt` descritivo; decorativa leva `alt=""` (vazio, não ausente); ícone-só clicável leva `aria-label`. Nunca o nome do arquivo.
- **Semântica:** um `<h1>` por página; hierarquia de heading sem pular nível por tamanho (tamanho é CSS); listas em `<ul>/<ol>`; interação em `<button>/<a>` reais, nunca `<div onClick>`; estruture com landmarks `<header> <nav> <main>` (um só) `<footer>`.
- **Formulário:** todo input com `<label for>` (placeholder NÃO é label — some ao digitar); obrigatório em texto + `required`; erro em **texto** (cor sozinha reprova) amarrado via `aria-describedby` + `aria-invalid="true"`.
- **Modal/dialog:** foco entra no dialog, Tab circula dentro (resto `inert`/`aria-hidden`), `Escape` fecha, foco **volta** pro gatilho ao fechar — `<dialog>` nativo dá de graça.
- **Ordem de foco = ordem do DOM** (= leitura visual); sem `tabindex` positivo; receber foco não muda contexto (não submete/navega sozinho). Mídia sem autoplay com áudio; movimento contínuo tem pausa.

## Print
- `@page` tem que estar no **documento**, não em shadow DOM (é no-op lá dentro).
- Congele animações no **estado final**: `animation-delay:-99s; animation-duration:.001s; animation-fill-mode:both` — **nunca** `animation:none` (isso imprime o estado base, geralmente invisível).
- Tire o `break-after` do **último slide visível** (não `:last-child` — um slide pulado/oculto ainda seria o last-child e sobraria folha em branco).

## Interação / mídia
- **DnD**: `preventDefault` no dragover (senão o `drop` nunca dispara) + contador de profundidade pra `dragenter`/`dragleave` não piscarem ao cruzar filhos.
- **Crop persistido em % do frame** (sobrevive a resize/export), com geometria de arraste em **px de viewport** via `getBoundingClientRect` (robusta a um ancestral com `transform:scale`, tipo o deck escalado).
- **Downscale de upload**: redimensione a 2× a largura renderizada, cap 1200px, encode WebP q0.85 — retina sem arquivo gigante.
- Thumbnails: materialize sob demanda com `IntersectionObserver`, e neutralize custom-elements no clone (não deixe `connectedCallback` rodar N vezes).
- Glifo/checkmark sobre cor variável: escolha claro/escuro por **luminância relativa** da cor de fundo.
- Labels que colidem: distribua em **lanes** anti-colisão.
- Teclado completo (ignorando inputs), confirm pra ação destrutiva, context menu clampado ao viewport, `inert` em painéis off-screen.

## Scripts (find-replace, escrita em massa)
- **Replace literal**, não `String.replace()` do JS — ele interpreta `$&`, `$1` etc. no replacement e corrompe silenciosamente valores como `$23.8M`.
- Overwrite que encolhe um arquivo em >50% = suspeita de bug de truncamento; escreva em lote atômico.
- Batch de checagens: N verificações num snippet que retorna um objeto; N capturas numa chamada com steps. Cada chamada separada custa um round-trip inteiro.

## Carregando os `assets/` sem quebrar (gotchas confirmados em teste)
- **Nunca cole o código-fonte de um componente inline dentro de `<script>…</script>`.** Vários (`deck-stage.js`, e os `.jsx`) têm exemplos de uso com um literal `</script>` nos comentários — isso **fecha a tag do script antes da hora** e o resto do arquivo vaza como texto na página (sintoma: você vê o comentário do código renderizado e o componente não monta). Sempre **referencie o arquivo externo**: `<script src="deck-stage.js"></script>` (vanilla) ou `<script type="text/babel" src="ios-frame.jsx"></script>` (React).
- **`.jsx` via Babel + `file://` = tela branca.** Componentes React carregados com `<script type="text/babel" src="…jsx">` dependem do Babel **fazer fetch** do arquivo; abrindo o HTML direto do disco (`file://`), o fetch é bloqueado por CORS e a página fica em branco. Opções: (a) servir por um servidor local (`python3 -m http.server`); (b) pra verificação headless, adicionar a flag `--allow-file-access-from-files`; (c) pra **entrega**, gerar HTML self-contained (inline o React já transpilado ou bundle). O `deck-stage.js` e outros `.js` vanilla não têm esse problema (não usam Babel).
- Verificação headless de página com `.jsx`: dê tempo pro Babel transpilar — use `--virtual-time-budget=8000` (ou um sleep) e a flag acima; sem isso o screenshot sai antes do mount e você acha que quebrou quando não quebrou.
- **Cuidado com animação sob `--virtual-time-budget`:** o rAF do `<Stage>`/animações **não avança** nesse modo — a captura sai no frame 0, então sprites com fade-in de entrada ficam invisíveis (falso "quebrado"). Pra verificar animação, semeie o playhead (`localStorage['<persistKey>:t']` + `autoplay={false}`) ou ponha um elemento estático dentro do `<Sprite>` só pra confirmar o mount.
- **⚠ FIXE A VERSÃO DO BABEL (blocker confirmado).** `unpkg.com/@babel/standalone/babel.min.js` sem versão hoje resolve **Babel 8**, cujo preset React usa o **JSX runtime automático** → emite `import "react/jsx-runtime"` → `Cannot use import statement` → **tela branca**. Sempre pine e/ou force o runtime clássico. Boilerplate canônico pros componentes React (`ios-frame`, `animations`, etc.):
  ```html
  <script src="https://unpkg.com/react@18/umd/react.production.min.js"></script>
  <script src="https://unpkg.com/react-dom@18/umd/react-dom.production.min.js"></script>
  <script src="https://unpkg.com/@babel/standalone@7.26.4/babel.min.js"></script>
  <div id="root"></div>
  <script type="text/babel" data-presets="react" src="ios-frame.jsx"></script>
  <script type="text/babel" data-presets="react">
    ReactDOM.createRoot(document.getElementById('root')).render(<IOSDevice title="Ajustes">…</IOSDevice>);
  </script>
  ```
  (`@7` ou `@7.26.4` — qualquer pin no major 7. `data-presets="react"` = runtime clássico, sem `import`.) Pra entrega final, prefira inline do transpilado / self-contained.

## Verificação headless de responsivo (não confie no screenshot da janela)
`--screenshot --window-size=390,…` **não** fixa a largura CSS quando a página tem `<meta name="viewport" content="width=device-width">` — o layout renderiza largo e a captura só corta, dando **falso negativo** de overflow. Para checar de verdade se colapsa a 1 coluna sem overflow horizontal, meça no DOM: carregue num iframe de largura CSS fixa (ou emule via CDP) e compare `scrollWidth` vs `clientWidth` com `eval`/JS — baseie o veredito no número, não na imagem da janela.

## Portabilidade dos `assets/` (o que reescrever no Claude Code)
- `deck-stage.js`, `ios/android-frame.jsx`, `macos/browser-window.jsx`, `animations.jsx` — **portáteis como estão** (IIFE/React puro, degradam sem host). Só pode podar os hooks de host (mensagens `__omelette_*`/`dc-op`) na cópia.
- `tweaks-panel.jsx` — UI portátil (testado ✓), mas fica invisível até o host mandar `__activate_edit_mode` e persiste via host. Adaptação Claude Code: **auto-open** = `window.postMessage({type:'__activate_edit_mode'},'*')` logo após o mount; **persistência** = semeie os defaults já mesclados com o que está no `localStorage` ao chamar `useTweaks`, e escute o CustomEvent `tweakchange` — cujo `detail` traz **só as chaves alteradas (delta)** — fazendo `setItem` do **merge**, não do delta.
- `image-slot.js` — render/DnD/crop/re-encode WebP são web padrão (testado ✓). Persiste via `window.omelette.writeFile`. Adaptação exige os **dois** caminhos: (1) escrita → redirecionar `writeFile` pra `localStorage`/IndexedDB; (2) **leitura** → interceptar o `fetch('.image-slots.state.json')` do `load()` (senão grava mas o reload não hidrata). O shim de `fetch`/`writeFile` também reativa o `data-editable` (que é gated em `window.omelette.writeFile`).
- `metrics-overlay.js` — passthrough (`mode="off"`) e render de **snapshot estático** funcionam (testado ✓). Atenção: o "modo mock" embutido sintetiza **apenas resultados de FUNIL**, não heat/trend/real-estate — pra estes, um **snapshot estático é obrigatório** (`mode="heat"` sem snapshot cai em empty state). Ver `prototype.md` pro shape mínimo do snapshot.
