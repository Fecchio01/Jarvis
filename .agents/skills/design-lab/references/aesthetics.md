# Receita — Direção estética (frontend fora de brand)

Use em todo trabalho que precisa de direção estética — landing nova, "algo foda do zero", exploração visual, e também protótipos/mockups de produto (junto com `prototype.md`). Com brand/design system existente, o brand entra como **restrição** (cores, fontes e tom alimentam a direção) — a exigência de direção comprometida continua valendo igual. Crie HTML distinto com atenção excepcional a detalhe estético.

## Pense antes de codar
- **Propósito**: que problema a interface resolve? quem usa?
- **Tom** — escolha UM extremo e comprometa até doer: minimal brutal, maximalista, retro-futurista, orgânico, luxo refinado, playful/toy, editorial/revista, brutalist/cru, art déco geométrico, pastel, industrial… **Teste de compromisso**: um estranho vendo a tela deve nomear a direção em UMA palavra ("brutalist", "editorial", "luxo"). Se a descrição que cabe é "moderno / clean / profissional", você caiu no atrator genérico — recomece. O meio-termo é o que denuncia IA.
- **Calibre em 3 eixos (1-10)** — dá um vocabulário preciso pra "extremo", em vez de adivinhar a intensidade:
  - *Densidade*: 1-3 "galeria de arte" (silêncio, 1 elemento por tela) → 4-7 "app do dia a dia" (equilibrado) → 8-10 "painel de cockpit" (compacto, tudo à vista).
  - *Variância*: 1-3 simétrico previsível → 4-7 assimétrico com offset → 8-10 caótico artístico (quebra de grid deliberada).
  - *Motion*: 1-3 estático/restrito → 4-7 fluido em CSS → 8-10 coreografia cinematográfica.
  Escolha um número por eixo antes de codar (ou pergunte ao usuário) — "densidade 8, variância 3" já é mais acionável que "denso e organizado".
- **Diferencial** — antes de codar, escreva UMA frase: o elemento-assinatura que a pessoa vai lembrar (um tipo gigante, um grid quebrado, uma cor chocante, uma entrada orquestrada). Ele TEM que aparecer protagonista no resultado — não como decoração de canto.

Minimalismo e maximalismo ambos funcionam; o morno tímido no meio, não. **Intencionalidade** > intensidade. A lista de tons acima é **inspiração, não catálogo fechado** — desenhe uma direção *fiel* ao aesthetic escolhido, não pegue a mais próxima da prateleira.

## Diretrizes (concretas, não vagas)
- **Tipografia**: display com caráter real (serif de alto contraste, grotesca condensada, display expressiva) + corpo legível. Carregue por `@font-face`/`<link>` (Google Fonts) — não conte com fonte de sistema pra dar "caráter". **PROIBIDO como display: Inter, Roboto, Arial, Fraunces, Poppins** — são o atrator que grita "IA". Escala com salto real: o display aparece **≥ 3× o corpo** em pelo menos um ponto (hero/título). Sem esse salto, vira wireframe.
- **Cor**: UMA dominante ocupando a maior parte da superfície + **1 acento afiado usado em < 10% da área** (CTA/destaque), tudo em CSS vars. Paleta de 5 cores distribuídas por igual = sopa tímida, evite. Fora do brand, derive harmonia em **oklch** — não chute hex no olho.
- **Motion**: CSS-first. Concentre num **load orquestrado com reveals escalonados** (o pico de deleite) em vez de micro-interações espalhadas. Estado animado tem que sobreviver a re-render (isole o elemento).
- **Composição**: assimetria, sobreposição, fluxo diagonal, quebra de grid. Hero centrado-simétrico é o default de todo template — só use se a direção pedir. Negative space generoso OU densidade controlada; nunca o morno no meio.
- **Fundo**: NUNCA `#fff`/cinza chapado como default preguiçoso — atmosfera é obrigatória (mesh de gradiente, noise, grão, padrão geométrico, transparências em camadas, sombra dramática, bordas decorativas). Única exceção: quando o extremo escolhido **é** branco brutalista — aí o vazio é decisão consciente, não default. Do lado escuro, **nunca `#000000` puro** — é o preto "não estilizado", estoura contraste e lê como falta de acabamento; use um preto com tintura (quente `#0a0705`-ish, frio `#0b0e14`-ish, ou zinc/charcoal) que harmonize com a paleta.

Complexidade proporcional à visão: maximalista pede animação elaborada; minimalista pede restrição milimétrica no espaçamento. Varie light/dark e fontes a cada peça.

## Não convergir — o atrator a evitar
Sem direção forte, todo modelo colapsa no MESMO visual: **Inter + gradiente roxo-azulado suave + cards de canto arredondado + hero centrado + emoji**. Se o rascunho tem ≥ 2 desses, você convergiu — troque antes de entregar. "Não convergir" é fugir ATIVO desse pacote, não só "variar" no vago.

## Receita "Liquid Glass" (vidro fosco tipo Apple, CSS puro)
Três camadas: (1) blur+tint — `backdrop-filter: blur(12-40px) saturate(180%)` com fundo translúcido (`rgba(255,255,255,.5)` claro / `rgba(120,120,128,.28)` escuro); (2) shine — `box-shadow` inset assimétrica (`inset 1.5px 1.5px 1px rgba(255,255,255,.7)`) + borda hairline `0.5px`; (3) sombra externa suave.

## Métricas canônicas de chrome de OS (errar denuncia o mock)
- iOS: hora **9:41**, dynamic island **126×37 r:24**, home indicator **139×5**, rows 52px / texto 17px / letter-spacing −0.43.
- macOS Tahoe: traffic lights **#ff736a / #febc2e / #19c332**, 14px.
- Chrome dark: URL bar, scoops de aba em SVG, paleta escura exata.
- Android: Material 3 tokens, punch-hole, gesture pill.
Os componentes prontos em `assets/*-frame.jsx` já embutem tudo isso — prefira copiá-los a redesenhar.
