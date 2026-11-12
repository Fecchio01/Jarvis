# Receita — Canvas de opções / Wireframe

## Apresentar várias opções lado a lado
Quando o usuário quer comparar direções/variações/telas, use um **canvas pannable** próprio (no Claude Code não existe o modo canvas do host — role a página, ou faça um pan/zoom simples se pedirem).

Layout: fundo escuro/cinza, cada frame é um filho **direto** do root (não embrulhado em nenhum wrapper/container — o posicionamento absoluto ancora no root):
```html
<div style="position:absolute;left:80px;top:80px;width:360px">
  <div style="position:absolute;top:-22px;font:500 11px system-ui;color:rgba(255,255,255,.7)">Hero centralizado · aposta no impacto, esconde a navegação</div>
  <div style="background:#fff;border-radius:2px;box-shadow:0 1px 3px rgba(0,0,0,.08);padding:16px">…design…</div>
</div>
```
Grid solto com ~80px de gap; labels pequenos acima de cada card branco; section header = texto maior no **topo-esquerdo do grupo**; post-its como sticky-notes rotacionadas (`background:#fef4a8;padding:12px;font:12px/1.4 system-ui;box-shadow:0 1px 3px rgba(0,0,0,.08);transform:rotate(-1deg)`). Mantenha left/top ≥ 0 (coordenada negativa fica fora da área exportável). Frames em `flex` com `overflow-x:auto` também servem pra uma fileira comparável. Cada frame mostra só o suficiente pra sentir a direção (hero + uma seção-assinatura), não a página inteira.

**Quantas e como distinguir** (o que separa exploração de filler):
- **≥3 frames** quando pedem opções/variações (a menos que o número venha dado). Duas opções lêem como "antes/depois" — não mapeiam um espaço de decisão.
- Cada frame explora **UM eixo nomeado e ortogonal**: a diferença tem que estar na *decisão estrutural* (esqueleto de layout, modelo de navegação, hierarquia de conteúdo, modelo de interação), **não** em cor/fonte/copy. Se dois frames só diferem em paleta ou headline, são o mesmo frame — funda os dois. Trocar cor é tweak, não direção; três swatches lado a lado desperdiçam o formato.
- Label = **nome descritivo da direção + uma linha do tradeoff** (o que otimiza / o que sacrifica), nunca "Variante A". O diretor escolhe pelo tradeoff — a letra não carrega informação de decisão.
- **Comprometa cada direção com um EXTREMO nomeável** (ver `aesthetics.md`): cada frame precisa ter uma atitude que um estranho nomeia numa palavra (ousada, luxuosa, crua, editorial…), não uma variação tímida do mesmo. Três opções "de bom gosto porém mornas" é o erro nº1 do canvas — o usuário rejeita o conjunto inteiro. **Calibre pela intensidade que ele pediu:** se pediu "ousado + sofisticado", opções seguras não são cautela, são falha — suba o volume. Se ele disser "nenhuma", quase sempre é falta de compromisso: pergunte o que faltou (mais ousado? mais premium?) e refaça no volume certo, não gere mais 3 mornas.

### Panorama "ver tudo" (pra diretor indeciso que precisa da visão de cima)
Quando pedirem pra ver o range inteiro antes de escolher, monte um canvas maior **agrupado por seção** (section headers como âncora): se o formato ainda não está fixo, uma seção por **formato** (Deck · Site · Ad · Doc · Protótipo), cada uma com 2-3 mini-frames de estilos distintos dentro; se o formato já está fixo, um panorama só de **estilos** (6-10 direções nomeadas). Mantenha os thumbnails baratíssimos (hero + uma seção-assinatura, cores/tipo reais mas conteúdo curto) — o objetivo é amplitude escaneável num olhar, não polir cada um. Deixe claro no topo que é um mapa pra ele apontar, não peças finais.

## Direções de página inteira (redesign / A/B — antes de comprometer com a página toda)
Quando o pedido é uma **página inteira** — redesenhar um site que o usuário mandou, ou uma landing grande nova — **não pule direto pra página completa**. Mostre **3 direções lado a lado em ALTA fidelidade** primeiro: cada uma o **above-the-fold** (hero + 1 seção-assinatura real: oferta/prova/preço) dentro de uma moldura de browser (`assets/browser-window.jsx`), rotulada com nome da direção + a vibe numa linha. Construa **UMA** por inteiro e deixe-a clicável ("PÁGINA PRONTA ↗"); as outras 2 ficam como preview até o usuário escolher — aí você completa a escolhida (evita fazer 3 páginas inteiras à toa). Use **conteúdo real** (a oferta/copy do site), não placeholder. Rotule sempre com o tradeoff e diga qual já abre. Dois modos:
- **Mesma marca (redesign fiel):** extraia a marca real do site (paleta/fonte/logo/tom — ver processo, passo 1) e as 3 direções **compartilham tudo isso**; variam só a *alma* — estrutura, energia, hierarquia (ex.: Editorial-técnico vs. Luminoso-premium vs. Industrial). Padrão de `direcoes-redesign-2026.html`.
- **Almas novas (fora do brand):** quando pedirem "algo novo / fora da marca atual", cada direção ganha **paleta + fonte + humor próprios** (ex.: Scandi silencioso vs. Risograph indie vs. Techno ácido) — some com o brand atual e puxe do repertório de estilos (`assets/menu-estilos.html`). Padrão de `direcoes-novas-almas.html`.

## Wireframe
Ajude o usuário a explorar ideias rápido. **Entreviste primeiro**, depois gere múltiplos wireframes rústicos antes de comprometer com uma direção. **Amplitude sobre polimento: 3-5 abordagens DISTINTAS por ideia** — "distinta" = muda a *estrutura* (quais seções, em que ordem, o padrão de layout primário), de modo que comparar duas seja uma escolha real. Dois wireframes que só mudam espaçamento/copy contam como um.
- **Esforço rústico e IGUAL entre os frames.** Não puxe um pra hi-fi enquanto os outros ficam stub — set desbalanceado pré-decide o vencedor e mata o objetivo de explorar. Teto de fidelidade: cinzas/boxes, sem sistema de cor, sem tipo final.
- Vibe **sketchy**: fontes handwritten mas legíveis (Caveat); P&B com pouca cor; low-fi.
- Formas simples, placeholder text, foco em **estrutura e fluxo** (não visual final): boxes cinza com "imagem/vídeo", linhas cinza pra texto, botões como retângulos rotulados, anotações à mão (setas, "herói aqui").
- Forneça **tweaks simples**; mostre lado a lado (canvas acima) se pequenos, ou num controle de abas se forem grandes.

## Entradas externas (rascunho, .fig, pasta)
- **Rascunho anexado** (imagem/sketch, ex-`.napkin`): leia a **imagem** — o JSON de traços não serve direto.
- **`.fig` ou pasta local**: explore e copie o conteúdo com as ferramentas de arquivo (Read/filesystem); não trabalhe de memória.
- **Precedência**: se a marca tem um **design system com template** pro que você vai construir (deck, landing…), use o **template do DS** — ele é o ponto de partida intencional e completo. Componente/scaffold genérico de `assets/` só quando nenhum template serve.
