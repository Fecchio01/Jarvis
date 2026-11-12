# Receita — Export & Handoff

## PDF
Via print do browser — ver `doc-print.md`. NUNCA rasterizar (jsPDF/html2canvas): sai borrado, não-selecionável e pesado. Headless: `chrome --headless --print-to-pdf=out.pdf --no-pdf-header-footer "file://$PWD/x.html"` (docs A4/letter: defina `@page` conforme a receita). Antes de exportar, **congele animações no estado final** no `@media print` (`animation-delay:-99s; animation-fill-mode:both; transition-duration:0s`) e, em deck, marque `data-deck-active` em TODOS os slides — senão entradas com fade imprimem no estado escondido (invisível no PDF).

## PPTX (a partir de um deck HTML)
No Claude Code não há exportador de shapes nativos — o caminho confiável é **1 PNG full-bleed por slide → montar o `.pptx`** (ex.: `python-pptx`, uma imagem por slide no tamanho exato: 1920×1080px = 13.333in×7.5in @96dpi). Se pedirem PPTX **editável** (texto/shapes nativos), avise que aqui sai como imagem. **Conheça o deck antes de capturar:** o seletor do slide, como navega (nome da função? toggle de classe?), quais fontes usa, se há wrapper com `transform:scale`. Checklist que decide se presta:
- **Troque as fontes ANTES de capturar**, nunca depois — senão o layout é medido com uma fonte e o arquivo nomeia outra, e o texto reflowa errado. Fallback web-safe: serif→Georgia, sans→Arial, mono→Courier New; fontes de sistema (Arial/Helvetica/Georgia/Times/Courier) deixe como estão.
- **Zere o `transform: scale()`** do wrapper e force o tamanho de design antes de capturar (o `deck-stage` honra o atributo `noscale`). Rect capturado ≠ WxH de design = transform não resetado → refaça.
- Capture **um slide por vez** (nav real ou `?slide=`; no `deck-stage` é 0-indexed), `delay` ≥600ms por transição (suba se o CSS for mais lento), e esconda o chrome de nav.
- **Gate antes de entregar**: confirme que há N PNGs *distintos* = N slides do deck. Dois adjacentes idênticos = navegação falhou (função/índice errado ou delay curto) → conserte e recapture, **não entregue**. PNG em branco = decode não esperado (aguarde `img.decode()` antes do print).
- Diagnóstico técnico **nunca** vaza verbatim ao usuário — traduza em linguagem simples ("uns slides saíram iguais, vou ajustar a navegação"). Se tudo saiu como esperado, **não mencione validação nenhuma** — só confirme que o arquivo está pronto.

## Vídeo MP4 (anúncios, aberturas)
Ver `animation.md` → seção "Exportar pra vídeo". Resumo: animação determinística por `?t=`, loop de frames com Chrome headless, `ffmpeg` pra juntar. Tamanhos: story 1080×1920, feed 1080×1080, horizontal 1920×1080.

## HTML standalone (arquivo único offline)
A meta é **idêntico** sem rede — não "parecido". No Claude Code, sem bundler, embuta tudo à mão:
1. Trabalhe numa **CÓPIA**. Se a página chama API externa (Anthropic, `fetch` a servidor), offline quebra — **pare e avise** antes de exportar.
2. **Imagens → base64 data-URI** no HTML, inclusive as referenciadas como string em JS/JSX (`<img src={url}>`, `background:url()`, CSS-in-JS), **e** assets carregados por `fetch()`/XHR ou áudio/vídeo setados programaticamente — o olho não pega essas, ache-as por grep no código. Redimensione antes (PIL/canvas): hero a ~680px ≈ 500KB em vez de 3MB.
3. **Fontes → `@font-face` base64** (subset latin+latin-ext, só os pesos usados). `<link>` do Google Fonts funciona **só online**: offline cai pro fallback do sistema e muda letterforms/quebras de linha — não é idêntico. Se mantiver o `<link>`, diga ao usuário que offline não fica idêntico.
4. **Gate**: `grep -oE '(src|href)="[^"]*"|url\([^)]*\)' final.html` — toda ocorrência tem que ser `data:`, `#` ou âncora interna; **zero** `http(s)://`, `assets/`, `./`, `../`. Depois renderize **com a rede desligada** e olhe, **e cheque o console por erro de runtime** (exceção JS, decode de imagem falho). Sobrou uma ref externa = não terminou.

O deliverable é o próprio arquivo único no filesystem — diga o caminho e que abre offline com dois cliques.

## Enviar pro Canva (design editável)
O Canva importa um HTML autocontido **via URL**. Fluxo: (1) confirme que o Canva está conectado — procure uma ferramenta de import do Canva nas tools disponíveis (MCP `import-design-from-url`/`create-design-import-job`); se não achar, **pare** e peça pro usuário conectar o Canva pelo painel de Conectores, e ofereça enquanto isso o standalone baixável. (2) Gere o **standalone** (seção acima). (3) Exponha num **URL público** — no Claude Code, publique o HTML como Artifact pra obter a URL. (4) Chame a ferramenta de import do Canva com essa URL + um nome de design; preencha os params opcionais do schema que der pra derivar, **nunca** inclua conteúdo da conversa/outros projetos nos argumentos; se retornar job ID, faça poll até completar e mostre o link do design ao usuário. A URL pública é **efêmera** — chame o import logo após obtê-la. Falha 4xx/auth → não re-bundle, peça pra reconectar e ofereça o standalone baixável como fallback.

## Handoff pra dev (Claude Code)
Pasta `design_handoff_<feature>/` com `README.md` **autossuficiente**: o teste é um dev que não estava na conversa implementar SÓ pelo README, sem abrir o HTML. Por isso **copy verbatim** (títulos, bullets, FAQ, labels — palavra por palavra) e **valores literais extraídos do HTML** (hex, px, font-stack, radius, sombra) — nunca "veja no arquivo". Copie os HTML de referência pra pasta como apoio. Gate antes de entregar: (a) `grep -iE 'veja no|ver no|no arquivo|no código|see the' README.md` = zero; (b) toda cor/tamanho/fonte citada é valor literal, não remissão; (c) cada tela e cada componente distinto do HTML tem sua entrada. Ao especificar comportamento não óbvio (o que colapsa no mobile, por que um estado existe), inclua o **porquê** em uma linha — ajuda o dev a decidir bem nos casos que o README não previu. Esqueleto:
```markdown
# Handoff — <feature>
## Overview            — o que é, objetivo
## Sobre os arquivos   — HTML = referência de design, recriar no ambiente do app (não shippar o HTML)
## Fidelidade          — hifi (pixel-perfect c/ as libs do codebase: hex/tipo/spacing finais) | lofi (só estrutura/fluxo; estilo vem do design system do codebase)
## Design Tokens       — cores hex, escala de tipo, spacing, radius, sombras
## Tipografia          — famílias + pesos + tamanhos
## Componentes         — cada um: variantes, estados (hover/active/focus/disabled), medidas exatas, copy
## Telas / Seções      — por tela: layout, ordem, copy VERBATIM
## Interações          — clicks, navegação, gestos touch (swipe/pinch/long-press), animações (duração/easing), validação
## Estado              — variáveis, transições/gatilhos, dados
## Responsividade      — breakpoints e como colapsa
## Estados de conteúdo — por tela com dado dinâmico: empty (copy do placeholder), loading (skeleton/spinner), error (aparência + mensagem), limite de caracteres + regra de truncamento
## Casos-limite        — conteúdo mín/máx (0 / 1 / 100 itens), strings longas / i18n que estouram, conexão lenta, dado ausente/nulo — o comportamento em cada
## Acessibilidade      — ordem de foco (tab), ARIA por componente interativo, teclado (Enter/Esc/setas), o que o leitor de tela anuncia em mudança de estado, contraste dos pares
## Assets              — imagens/ícones/fontes usados e origem
## Arquivos            — os HTML/CSS/JS do projeto que contêm o design, pra o dev referenciar
```
Depois de criar: use **brand system do próprio codebase** se o design usa assets de marca (não shippe os do protótipo). **Pergunte** ao usuário se quer screenshots dos designs incluídos — **não** inclua por padrão. Dê ao pacote um nome humano amigável.
