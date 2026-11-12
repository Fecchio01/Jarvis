# Receita — Documento / PDF imprimível

Documento (currículo, one-pager, memo, relatório, carta, guia, paper) que lê como uma coluna na tela e exporta pra PDF limpo sem setup extra.

## Layout
Todo o corpo dentro de um `<main class="doc">`; o browser pagina no print. O **primeiro elemento é o h1** — nunca um masthead. As linhas marcadas LOAD-BEARING são obrigatórias:
```html
<main class="doc">
  <table class="doc-frame" role="presentation">
    <thead><tr><td class="hdr-space"></td></tr></thead>
    <tbody><tr><td>…corpo inteiro como HTML estático…</td></tr></tbody>
    <tfoot><tr><td class="ftr-space"></td></tr></tfoot>
  </table>
</main>
```
```css
body{ margin:0; background:#fff; }
/* LOAD-BEARING: mesmo fundo em body e .doc (senão pinta uma calha visível
   em janelas largas). border-box + 8.5in + 0.75in padding = coluna de 7in. */
.doc{ box-sizing:border-box; max-width:8.5in; margin:0 auto; background:inherit;
      padding:48px clamp(24px,5vw,0.75in) 96px; }
.doc-frame{ width:100%; border-collapse:collapse; } .doc-frame td{ padding:0; }
.running-hdr,.running-ftr,.hdr-space,.ftr-space{ display:none; }
h1,h2,h3{ text-wrap:balance; } p,li{ text-wrap:pretty; }
@page{ size:letter; margin:0; }  /* margin:0 = Chrome não desenha header de data/URL. Size livre; margin fica 0. */
/* ⚠ Default aqui é letter (US). Fora dos EUA (Brasil → A4): troque size p/ A4 E o .doc max-width p/ 210mm — senão a coluna de 8.5in vaza da folha A4. */
@media print{
  html{ -webkit-print-color-adjust:exact; print-color-adjust:exact; }
  html,body{ margin:0; padding:0; }
  .doc{ max-width:none !important; margin:0 !important; padding:0 0.75in !important;
        box-shadow:none !important; border:none !important; }
  #dc-root,.sc-host{ height:auto !important; }
  .hdr-space,.ftr-space{ display:table-cell; height:0.75in !important; }
  h1,h2,h3,h4,h5,h6{ break-after:avoid; }   /* título nunca fica só no fim da página */
  figure,pre,blockquote,img,svg,tr{ break-inside:avoid; }
  p,li{ orphans:3; widows:3; }              /* nunca 1 linha órfã/viúva */
  .screen-only{ display:none !important; }
}
```
A tabela `.doc-frame` com thead/tfoot repetidos é o que dá margem de topo/base em cada página (já que `@page` margin fica 0). **Higiene de paginação (não pule):** TODO contêiner de bloco que você criar (card, callout, stat tile, grupo multicoluna, tabela inteira) entra na lista de `break-inside:avoid` — senão ele racha na quebra de página e denuncia amadorismo. Header/footer ficam FORA por padrão — o h1 já nomeia o documento; só adicione se pedirem **ou o tipo de doc genuinamente pedir** (relatório formal longo, brief confidencial com marca de classificação em toda página). Quando adicionar: tipo pequeno, mudo, sem régua; título à **esquerda** do header + linha de contexto curta à **direita**; footer com algo **diferente** do header; nunca escreva "Página N" (o counter não renderiza nessa posição). O CSS que os posiciona (padding assimétrico mantém header/footer dentro da faixa de 0.75in, o corpo passa livre):
```css
@media print{
  .running-hdr,.running-ftr{ display:flex !important; justify-content:space-between;
    align-items:baseline; position:fixed !important; left:0; right:0; margin:0 !important;
    font-size:11px; letter-spacing:.05em; text-transform:uppercase; }
  .running-hdr{ top:0; padding:.35in .75in 0 !important; }
  .running-ftr{ bottom:0; padding:0 .75in .35in !important; }
}
```
Se o conteúdo colado pelo usuário começa com uma linha **em forma de header** (masthead/eyebrow), **descarte** essa linha — não a renderize no corpo.

## Tipografia — ranges EXIGIDOS (não sugestões)
O que separa doc profissional de template não é a fonte: é **medida + hierarquia + ritmo** consistentes. Cumpra os cinco:
- **Corpo:** 15-16px, line-height 1.55-1.7 (impresso: mínimo 12pt). Abaixo de 15px cansa no papel; acima de 1.7 as linhas se soltam. Corpo é sempre **alinhado à esquerda** — nunca `justify` (abre "rios" de espaço em coluna larga) nem centralizado.
- **Medida (line length):** 65-80 caracteres por linha — é o que a coluna de 7in entrega a 16px, por isso o `max-width` **não cresce**. Se a linha passar de ~85 caracteres, estreite a coluna; não aumente a fonte. Cheque uma linha cheia no screenshot.
- **Escala de títulos: modular, com passo claro** (razão ~1.25-1.35 entre níveis). Ex.: h1 32-40px · h2 24-28px · h3 19-22px · corpo 16px. Hierarquia vem de **tamanho + peso + espaço, NUNCA de cor**. Níveis quase do mesmo tamanho = vira template.
- **Ritmo vertical:** espaço **acima** de um título > espaço abaixo (cola o título ao próprio bloco). Todo espaçamento sai de UMA escala (ex.: múltiplos de 4/8px), não valores soltos por elemento.
- **Paleta: no máximo 3 tintas** — 1 de texto (quase-preto, ~#1a1a1a, nunca `#000` puro), 1 cinza mudo pra texto secundário, no máx. 1 accent usado com parcimônia. Fundo branco/quase-branco.

Tabelas: algarismos tabulares (`font-variant-numeric:tabular-nums`), bordas hairline (~1px cinza mudo) — nunca fills pesados ou grades escuras; cabeçalho diferenciado por **peso**, não por caixa colorida. Figuras e blocos de código com legenda curta. Links resolvem pra tinta do corpo no print (não azul sublinhado).

## Regras de ouro
- **NUNCA rasterize** o PDF (jsPDF, html2canvas, dom-to-image) — sai borrado, não-selecionável, gigante, e o texto vira imagem (sem busca, sem copiar/colar, sem acessibilidade). O único caminho é print CSS + engine do browser (Cmd/Ctrl+P → Salvar como PDF). No Claude Code, entregue o `.html` e diga pra imprimir; ou gere via headless: `chrome --headless --print-to-pdf=out.pdf --no-pdf-header-footer file://…`.
- Números de página só sob demanda → aí `@page{ size:letter; margin:0.6in; @bottom-right{ content: counter(page) " de " counter(pages); font:10px sans-serif; color:#999; } }`, mova o padding do `.doc` pra 0, e avise pra desmarcar "Headers and footers" no diálogo.
- **Orientação:** portrait é o default; só use `landscape` se o design for mais largo que alto.
- **Layout interativo → estático no print:** todo elemento de página vira `position:static` e visível, tire hover/chrome de nav/`overflow:hidden` que clipa, e congele animações no estado final (ver `web-craft.md`, truque `-99s`) — `animation:none` reverteria fade-ins ao estado escondido. **Mantenha todo o conteúdo visual (imagens, SVGs, cores, tipografia) exatamente como desenhado** — o PDF deve ficar o mais fiel possível ao design.
- **Espere os assets antes de imprimir** (se auto-print ou headless): dispare `window.print()` só depois de `document.fonts.ready` **e** `img.decode()` de todas as imagens (e, se usa Babel, depois do conteúdo aparecer no DOM) — imprimir cedo captura imagem faltando e fonte de fallback.
- A cópia `-print.html` vai no **mesmo diretório** do original, com `-print` antes da extensão (`web/index.html` → `web/index-print.html`) — nunca no root nem com o título do doc como nome: mudar de pasta quebra todo path relativo (`@font-face src`, `<img src>`, `<link href>`, `background:url()`) e o print sai com imagem faltando e fonte de sistema.

## Fixed-canvas (post, banner, pôster, infográfico)
Dê largura (e altura, se fixa) em px explícitos no elemento raiz — o export dimensiona a página do PDF pro tamanho renderizado. Não precisa `@page`.
