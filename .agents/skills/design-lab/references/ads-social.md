# Receita — Posts & Anúncios (social/mídia paga)

Criativos pra feed, story e carrossel. O objetivo muda de "explicar" pra **parar o dedo e gerar clique** — hook forte, uma ideia por peça, hierarquia brutal.

## Dimensões canônicas (px exatos — errar reprova a peça)
- **Feed quadrado** 1:1 → 1080×1080
- **Feed retrato** 4:5 → 1080×1350 (melhor alcance no Instagram — **padrão** de feed quando não especificarem)
- **Story / Reels** 9:16 → 1080×1920
- **Anúncio horizontal / link ad** 1.91:1 → 1200×628 (Meta/Google)
- **Carrossel** → várias telas 1080×1080 ou 1080×1350 (mesma proporção em TODAS)
- O elemento **raiz** carrega `width` **e** `height` em px iguais ao alvo (ex.: `width:1080px;height:1350px`), sem `overflow` cortando nem `min-height` — é isso que faz o PNG sair 1:1, não redimensionado.

## Safe zones do Story/Reels (9:16, 1080×1920 — números fixos, não aproximados)
Nada crítico nessas faixas; **hook e CTA vivem no miolo** (y entre 250 e 1600): topo **250px** (UI do sistema), base **320px** (legenda, CTA do sistema, "arrasta", áudio), laterais **64px**. No **Reels**, a coluna direita (~120px) tem os botões de ação — mantenha texto/CTA fora dela. Padding sozinho não garante isso (ver verificação); marque as faixas com um scrim visível enquanto desenha e remova antes do export.

## Ângulos de criativo
Gancho/curiosidade · Oferta (preço + CTA) · Prova social (aluno/cliente + resultado) · Antes→Depois · Educativo (passos do método) · Story com enquete/"arrasta". Escolha **um** por peça.

## CTA obrigatório (o criativo existe pra gerar clique — sem CTA claro, reprova)
Toda peça tem **exatamente um** CTA primário: **verbo + específico** ("Baixe o guia", "Garanta sua vaga" — nunca "Saiba mais" solto nem só a URL), renderizado como **botão/pill** ou linha de alto contraste (não perdido no corpo), toque ≥ 88px de altura em canvas 1080-wide, **dentro da safe zone**. No **carrossel** o CTA fica na **última** tela; as intermediárias levam até ele.

## Regras
- Herda a identidade da direção escolhida (ver `aesthetics.md`) — não invente um visual novo por peça.
- **Teste do thumbnail:** a peça reduzida a ~150px de largura ainda tem que ter o hook legível. Logo o hook é o maior texto (≥ 60px em canvas 1080-wide), ≤ 8 palavras, alto contraste, ancorado no terço superior. Um foco visual só.
- Foto do usuário = `image-slot` ou placeholder; **nunca** desenhe produto/pessoa em SVG à mão.
- Anti-slop vale igual (sem emoji fora de brand, sem fonte batida).
- Carrossel: 3–8 telas; capa (gancho) → conteúdo → CTA. **Layout paralelo**: título, numeração de tela e seta de "arrasta" na mesma posição em todas.

## Render em tamanho fixo (pra exportar PNG pronto pro Gerenciador)
Raiz no tamanho real (width **e** height) e captura 1:1:
```bash
CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
"$CHROME" --headless --disable-gpu --hide-scrollbars --force-device-scale-factor=1 \
  --window-size=1080,1350 --screenshot=post.png "file://$PWD/post.html"
```
Folha com vários criativos: renderize cada um sozinho ou fatie o PNG com PIL. **Vídeo** (story animado): ver `animation.md` (pipeline `?t=` + ffmpeg).

## Verifique DEPOIS de renderizar (padding não impede overflow silencioso — teste real furou a base "com padding")
Após render, cheque no PNG (com PIL):
1. **Dimensões** = px-alvo exatas (senão a raiz não tinha width+height fixos).
2. **Safe zone (só 9:16):** sem tinta não-fundo em topo (y<250), base (y>1600) e laterais (x<64 ou x>1016). Se algo crítico invadir, reposicione e revalide com ~4px de folga.
3. **Hook** no terço superior, destacando do fundo (não some no thumbnail).
4. **CTA** presente, único, dentro da safe zone.
Se travar na leitura, renderize uma versão com as bandas de safe zone destacadas e olhe.
