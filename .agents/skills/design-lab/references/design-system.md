# Receita — Design System / UI Kit

Um design system é uma **pasta** com tipografia, cores, assets, guias de marca/tom, CSS e recriações de UI. Dá ao agente a capacidade de desenhar com a marca do cliente.

## Estrutura (default; siga a convenção do codebase/marca se houver)
- `styles.css` na raiz — entry point de CSS global, só linhas `@import`. **Se a marca vem de um codebase existente e já usa outro nome pra esse arquivo** (`index.css`, `globals.css`, `global.css`, `main.css`, `theme.css`, `tokens.css`), mantenha o nome deles em vez de forçar `styles.css` — é convenção do time, não capricho seu. Tudo que ele importa transitivamente é enviado ao consumidor; `@font-face` em qualquer lugar dessa cadeia declara as webfonts.
- `tokens/` — custom properties, um arquivo por concern (`colors.css`, `typography.css`, `spacing.css`…), cada um `@import`ado do styles.css.
- `components/<grupo>/` — primitivos de UI reutilizáveis.
- `patterns/<grupo>/` — combinações reusáveis de 2+ componentes que aparecem em várias telas (campo de formulário com label/erro, card de preço, item de lista com ação). Sem isso, quem monta uma tela reinventa esses blocos na hora, ad-hoc — a pasta existe pra virar hábito compor a partir daqui antes de desenhar de novo.
- `ui_kits/<produto>/` — recriações de tela cheia click-through de views reais.
- `guidelines/` — specimen cards + prosa.
- `assets/` — logos, ícones, ilustrações.
- `readme.md` (raiz) — o guia + manifesto.

## Tokens em duas camadas
Base (`--fg-1`, `--font-serif-display`) **e** aliases semânticos (`--text-body`, `--surface-card`). O consumidor usa os semânticos.

## Processo (crie um todo com estes passos)
1. Explorar TODOS os materiais (codebase, Figma, decks, prints). Ler cada um. Achar copy de produto, telas core, qualquer DS existente.
2. `readme.md` com o entendimento de alto nível + fontes citadas (links Figma, repos, paths — o leitor pode não ter acesso, guarde mesmo assim). Nomeie o projeto no título do readme (`# {Marca} — Design System`) — é o que faz a pasta ser reconhecível, não um nome genérico tipo "design-system-1".
3. Escrever os tokens CSS a partir do código/Figma. Copiar webfonts + escrever `@font-face`. `styles.css` só com `@import`.
4. **CONTENT FUNDAMENTALS** no readme: como a copy é escrita? tom, casing, "eu vs você", emoji?, a vibe — com **≥3 exemplos verbatim** copiados da copy real (não parafraseados: um exemplo inventado denuncia que você não leu o produto).
5. **VISUAL FOUNDATIONS** no readme — responda TODAS **com valor concreto** (hex, px, ms, nome do easing, raio em px): "sombras suaves" ou "cantos arredondados" não conta — respostas vagas são exatamente o que produz DS genérico. Cubra: cores, tipo, espaçamento, fundos (imagem? full-bleed? ilustração? padrão? gradiente?), animação (easing? fade? bounce? nenhuma?), hover (opacity? mais escuro? mais claro?), press (cor? encolher?), bordas, sistema de sombra inner/outer, protection gradients vs cápsulas, regras de layout, transparência/blur (quando?), vibe de cor das imagens (quente? frio? P&B? grão?), raios de canto, anatomia do card.
6. **ICONOGRAPHY** no readme: copie os ícones REAIS (+ os logos e TODAS as ilustrações que achar) na ordem codebase → CDN (Lucide/Heroicons) → substituto mais próximo **sinalizado**. Nunca desenhe SVG à mão. Responda também: é um **icon font** embutido (tipo Font Awesome) ou SVGs/PNGs soltos? Emoji? unicode? **Não leia o conteúdo de SVGs pra dentro do contexto** (gasta tokens à toa, e um `<path>` de ícone não te diz nada útil) — se já sabe o uso, só copie o arquivo e referencie por `<img src>`/`<use>`.
7. Specimen cards (HTML ~700×150px cada, máx 400 de altura; sem título/moldura interna — o nome renderiza FORA do card) consumindo os tokens reais via link pro `styles.css`. Tag na 1ª linha: `<!-- @dsCard group="…" -->`. Grupos: Type, Colors, Spacing, Brand. **Quantidade importa — faça MUITOS cards pequenos, não poucos densos: mínimo 12, mire 12–20+** (é o que faz o DS parecer completo, não thin). Divida no nível do sub-conceito: cards separados pra cor primária / neutra / semântica; display / corpo / mono; tokens de espaçamento / espaçamento em uso; sombras; raios; etc. 3-4 cards no total = incompleto, refaça.
8. Componentes **autocontidos**: só React + as custom properties dos tokens — **sem CSS-in-JS, sem npm, sem lib de UI** (o `styles.css` é a única fonte de estilo; dependência externa quebra a portabilidade da skill). **Cardápio típico de primitivos** (menu de referência, não checklist obrigatório — construa o que o produto realmente usa, mas não pare em 3-4 óbvios): Button, IconButton, Input, Select, Checkbox, Radio, Switch, Card, Badge, Tag, Avatar, Tabs, Dialog, Toast, Tooltip. Agrupe por concern (`forms/`, `feedback/`, `navigation/` — ou um `core/` só se o conjunto for pequeno). Cada componente é:
   - `<Nome>.jsx` com `export function <Nome>(props) {…}` nomeado — export literal, PascalCase.
   - `<Nome>.d.ts` irmão, com a interface de props em TypeScript — é o contrato formal (tipos, obrigatório/opcional, union de variantes) que complementa a prosa do `.prompt.md`; útil mesmo sem compilador nenhum lendo, porque é a documentação mais precisa que existe pra props e cola direto num codebase real se um dev for portar o componente depois.
   - `<Nome>.prompt.md` — uma frase de "o quê/quando" + exemplo de uso + variantes notáveis.
   - Um `.card.html` (`group="Components"`) **denso**, mostrando os estados-chave lado a lado (primary/secondary/ghost, tamanhos, disabled, com ícone) — nunca um único render default, que esconde o sistema. Duas coisas que o card visual sozinho não mostra e por isso vão **escritas** no `.prompt.md`:
     - **Estados por escrito** (hover, active/press, focus, disabled, loading, error se aplicável): um screenshot congela no estado default — hover/press só existem se você anotar a cor/transform/timing. Reaproveite o que já levantou no VISUAL FOUNDATIONS (passo 5).
     - **Acessibilidade em 1-2 linhas**: role semântico (é um `<button>` real ou uma `<div onClick>`? deveria ser botão), como chega via teclado (Tab/Enter/Espaço), e o que teclado/leitor de tela precisa (`aria-disabled`, `aria-label` quando só ícone). Não é checklist de compliance formal — é a diferença entre um componente "de mentirinha" e um usável de verdade.
9. Patterns (`patterns/<grupo>/`): quando 2+ telas do UI kit forem precisar do mesmo bloco composto (campo de formulário, card de preço, item de lista), construa-o AQUI antes, como os componentes — não como `<div>` cru dentro da tela. Sinal de que você pulou esse passo: uma tela usando `class="fake-input"` ou similar em vez de um componente `Field` versionado no DS.
10. UI kits = recriações **pixel-perfect clicáveis** de views reais — **3-5 telas core por produto** (ex.: login → criar → enviar mensagem, fake), com o `index.html` sendo o fluxo interativo. **Componha os primitivos e patterns que você já criou — não reimplemente Button/Field dentro do kit** (reimplementar duplica e desalinha do sistema). Priorize **cobertura de componentes** sobre replicar cada seção. **Nunca invente** design novo: copie o existente; se não vê, omita ou deixe em branco com aviso. Fonte de verdade = código/Figma; screenshot é lossy e só guia — se há código, nunca recrie só de screenshot.
11. `SKILL.md` da marca (pra virar Agent Skill): frontmatter `name: {brand}-design`, descrição, e instruções pra ler o README e explorar.
12. **Marque os "pontos de partida"** — os componentes/telas que são o melhor molde pra começar um design novo. Não existe picker/UI que leia isso no Claude Code (é feature do app original), mas mantenha a convenção de comentário mesmo assim, como metadado legível por humano e forward-compatible: `<!-- @startingPoint section="<grupo>" subtitle="<uma linha>" viewport="WxH" -->` na primeira linha do `.d.ts`/JSDoc do componente, ou do HTML da tela. Custa uma linha e documenta a intenção ("comece por aqui") pra quem abrir a pasta depois — humano ou outra ferramenta.

Rode independente; só pare em blocker real (recurso-chave citado mas inacessível → **peça, não invente**). Ao fechar: **não resuma** o output — liste só CAVEATS (o que faltou / ficou incerto) e um ASK claro pra iterar até perfeito.

Se faltar fonte, use o match mais próximo no Google Fonts e **sinalize** a substituição.

## Nota do flavor Claude Code
Aqui não há o compilador que gera `_ds_bundle.js` do app original. Então o **card de componente** (`group="Components"`) deve ser **HTML estático** que espelha o componente e consome os tokens via `<link>` pro `styles.css` (não dependa do bundle). Idem specimen cards: sempre linkam o `styles.css` real. Se usar system-font stack no lugar de `@font-face` real (por não ter os arquivos), **sinalize**.

Duas coisas do processo original que **não têm equivalente possível** aqui (não por escolha, por ausência física do recurso — registrado pra não parecer omissão):
- **O "Design System" no menu Share** do app original (pra outros membros do time verem o projeto) — não existe conceito de compartilhamento/multi-usuário num filesystem local.
- **O compilador que auto-descobre tokens/componentes por convenção de arquivo** (sem precisar de `styles.css` fixo, ler qualquer `.jsx`+`.d.ts` como componente automaticamente) — aqui você é o "compilador": monta a estrutura de pastas e os links `<link>`/`<script>` à mão, por isso a Estrutura acima é prescritiva, não uma opção entre várias.

## Verificação
Antes de fechar, rode este checklist — cada item reprovado manda voltar e corrigir, não é sugestão:
- **Hardcode zero:** `grep -rE "#[0-9a-fA-F]{3,6}|font-family:\s*[\"']?[A-Z]" guidelines/ components/ patterns/ ui_kits/` fora dos arquivos de `tokens/` — qualquer hit é cor/fonte que devia ser `var(--…)` e não é.
- **Contagem de cards:** ≥12 em `guidelines/` (passo 7). Menos que isso, parece thin — volte e divida mais.
- **Todo componente** tem `.jsx` + `.d.ts` + `.prompt.md` + card (passo 8), com estados escritos + a11y — não só o card visual.
- **Nenhuma tela do UI kit reimplementa** Button/Card/Field cru — se achar `<div>` fazendo as vezes de um componente que já existe no DS, troque pela composição.
- **CONTENT/VISUAL FUNDAMENTALS** do readme sem nenhuma resposta vaga ("sombra suave", "cantos arredondados") — todo valor é concreto (hex/px/ms).

## Extrair um DS de um site ao vivo (método testado — ganhou de ferramentas dedicadas)
Quando a fonte é um site publicado (sem código/Figma), extraia os tokens assim — este combo bateu uma CLI de 125K installs num teste real (ela pegou 1 cor de 7 e ignorou o `:root`; este pegou as 7 exatas):
1. **Navegador + `getComputedStyle` (fonte da verdade).** Abra o site e rode um script que: (a) lê as **CSS custom properties do `:root`** — é onde a marca real vive; a maioria das ferramentas ignora e erra por isso; (b) `getComputedStyle` de h1/h2/corpo/link/botão/nav (fonte, tamanho, peso, cor, raio, sombra, padding); (c) conta cores/fontes mais frequentes (dominantes); (d) coleta os raios distintos. **Simule hover/focus** nos interativos pra pegar os estados.
2. **Firecrawl `branding`** (`firecrawl_scrape` format `branding`) — complementa com **papéis semânticos** (primary/secondary/accent), componentes, personalidade/tom e o **inventário de assets** (favicon, og image, logo). Combine: o (1) dá os valores exatos, o (2) dá a semântica.
3. **Cluster + normalize:** agrupe cores próximas (distância em oklch), alinhe espaçamento à grade (4/8px), descarte one-offs de baixa frequência.
4. **Não invente:** seção sem evidência (ex.: sombras num site que não usa) fica **de fora**, não preenchida com default. Feche com uma nota de **"o que não deu pra capturar"** (known gaps).
5. **Auth wall?** salve o HTML localmente e extraia do arquivo.
6. **Assets/imagens:** inventarie logo/hero/favicon/og (URLs). **Baixe e reuse os assets reais SÓ se for a marca do próprio usuário ou de um cliente dele** (copyright de terceiro) — em redesign de marca alheia, capture as URLs mas use placeholder/fotos novas, nunca re-suba a foto original.
7. **Extrair DS ≠ clonar a página.** Os tokens dão a *cara*; um **clone fiel** precisa também do **conteúdo real** — puxe (scrape do DOM) a copy **verbatim** (headline, subhead, rótulo de CTA), a **estrutura** (posição da logo — centralizada? à esquerda? —, quais palavras estão no acento, ordem das seções) e os assets. **Nunca improvise a copy do `og:meta`** — dá algo "parecido mas diferente" (o headline sai com casing errado, o CTA vira outro, a logo no lugar errado). Renderize e compare lado a lado com o original antes de entregar.
Fallback pronto (mesmo método headless): Prism, designlang, dembrandt, figsniff. A CLI arvindrk/dembrandt subestimou no teste — prefira o combo acima.

## Exportar como `DESIGN.md` (padrão aberto do Google — interoperável)
`DESIGN.md` (github.com/google-labs-code/design.md · spec: stitch.withgoogle.com/docs/design-md) descreve a marca num **arquivo único**: YAML de tokens (pra máquina) + prosa (o porquê). **Gere junto** com a nossa pasta quando o usuário quer interoperar — o mesmo arquivo é lido por Figma, Tailwind e Stitch, e exporta pra `tokens.json`/CSS vars pela CLI `@google/design.md`. A nossa pasta continua a fonte rica (assets, UI kit, componentes React); o `DESIGN.md` é o **resumo portátil de tokens**. Nossos tokens de 2 camadas mapeiam direto: base → YAML `colors/typography/spacing/rounded`; semânticos → papéis Material-3.

**Front matter YAML** (entre `---`), inspirado no W3C Design Tokens / Material 3:
```yaml
---
name: Nome da Marca
colors:            # papéis Material-3: primary/on-primary/primary-container, secondary…, surface/on-surface, background, outline, error…
  primary: "#F94E03"
  on-primary: "#ffffff"
  surface: "#0a0705"
  on-surface: "#f4f1ec"
typography:        # escala nomeada; cada uma com fontFamily/fontSize/fontWeight/lineHeight/letterSpacing
  display-lg: { fontFamily: Montserrat, fontSize: 72px, fontWeight: "900", lineHeight: 76px, letterSpacing: -0.02em }
  body-md:    { fontFamily: Montserrat, fontSize: 16px, fontWeight: "400", lineHeight: 24px }
rounded: { DEFAULT: 0.5rem, lg: 1rem, pill: 9999px }   # raios estilo Tailwind
spacing: { unit: 8px, container-padding: 24px, section-margin: 40px }
components:        # cada componente COMPÕE tokens por REFERÊNCIA "{grupo.token}" — não repete valor
  button-primary:
    backgroundColor: "{colors.primary}"
    textColor: "{colors.on-primary}"
    rounded: "{rounded.pill}"
---
```

**Corpo em Markdown** (após o front matter), nesta ordem de seções: `## Brand & Style` · `## Colors` · `## Typography` · `## Layout & Spacing` · `## Elevation & Depth` · `## Shapes` · `## Components` (com `###` por grupo). A prosa explica o *porquê* e o *como aplicar* (ex.: "sobre glass, suba o peso da fonte um tier pra legibilidade"). Rode `npx @google/design.md lint` se quiser validar.
