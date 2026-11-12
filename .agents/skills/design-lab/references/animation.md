# Receita — Animação / Vídeo / Motion

Peça animada renderizada como HTML. Timeline com transições suaves, controles de playback, storytelling visual.

## Storytelling primeiro — antes de UMA linha de engine
Este é o passo que separa vídeo memorável de "movimento bonito e vazio" (o erro nº1). Antes de codar, **escreva** e mostre ao usuário (pule só se ele já alinhou o roteiro):
- **A mensagem única** do vídeo em uma frase. Se você não consegue, não há vídeo — há uma tela de proteção de tela.
- **A lista de beats** numerada: cada beat = o que aparece na tela + a tensão/mensagem daquele beat + duração aprox. (s). Os beats somados = a duração total.
Sem arco escrito, o resultado é genérico — não improvise a história dentro do código.

## Princípios (Disney) e gramática de cena
Antecipação, easing, follow-through, exagero. Regras concretas:
- **Cada cena compromete-se com UM shot decidido de propósito**, não "coisas na tela". Escolha um: (a) establishing → zoom na ação; (b) corte rápido entre dois elementos em tensão; (c) seguir algo em movimento (cursor, ponto numa curva) com a câmera. Cena sem shot escolhido = deriva. Em animações curtas, a maioria das "cenas" é um único shot, ou uma sequência de shots no mesmo cenário. Cena também pode ser um **slide** (texto/gráfico na tela sendo animado ou **enfatizado** — highlight, destaque — pra chamar atenção pro ponto-chave). **Seja criativo** na escolha do shot.
- **Mostre, não conte.** Título/caption só quando o visual sozinho não comunica — legenda é muleta, não narração. Prefira encenar a explicar.
- Elementos em **contexto realista** (fundo, UI de computador/celular) — nunca flutuando no éter num fundo chapado.
- **Sempre algo em movimento** (câmera, elemento ou transição) exceto num held beat deliberado — frame 100% estático por >0.5s lê como bug/travamento. Imagem parada é o pior caso: **toda** imagem recebe zoom/pan lento (Ken Burns) ou está entrando/saindo/sendo cortada.
- **Cursor/ponteiro é obrigatório fazer via refs** (`getBoundingClientRect` no alvo real — coordenadas chutadas quebram em resize/re-render), dar **zoom** nele, e segui-lo com câmera **amortecida** (damped, estilo Screen Studio). Movimento linear ou teleporte de cursor lê como robô.
- Animação é **código complexo**: um componente reutilizável por elemento e por cena; a timeline se acerta **iterando** (renderize frame determinístico → olhe → ajuste), nunca de primeira.
- Atualize o `data-screen-label` da raiz com o timestamp a cada segundo (facilita comentar por tempo).

## Engine: `assets/animations.jsx`
Copie e componha. Traz `<Stage width height duration>` (auto-escala, scrubber, play/pause, ←/→/espaço/0-reset, persiste playhead), `<Sprite start end>` pra gate temporal, hooks `useTime()`/`useSprite()`, biblioteca `Easing`, `interpolate()`/`animate()`, e `TextSprite`/`ImageSprite`/`RectSprite` com entry/exit embutidos. Só caia pra **Popmotion** (`https://unpkg.com/popmotion@11.0.5/dist/popmotion.min.js`) se a engine genuinamente não fizer o que você precisa. Use a paleta da **marca/projeto** (não invente uma).

**Carregar** (testado): use o boilerplate React+Babel **com versão pinada** de `web-craft.md` (Babel sem pin = tela branca). Ao abrir do `file://`, o Babel não faz fetch do `.jsx` (CORS) — **inline** o `animations.jsx` dentro de um `<script type="text/babel" data-presets="react">` em vez de `src`, ou sirva por servidor local.

**Ver um frame específico** (o playback rAF ao vivo **não** é capturável em screenshot one-shot — congela em `t=0`): dirija o tempo deterministicamente. O `Stage` lê o playhead persistido em `localStorage[persistKey+':t']` no load — então antes do mount, faça `localStorage.setItem('<persistKey>:t', '3.0')` e passe `autoplay={false}`, ou use o padrão `render(t)` + `?t=` da seção de export abaixo. Sempre valide a animação **frame-a-frame determinístico**, nunca por screenshot do playback vivo.

## Números canônicos (padrão entry/hold/exit)
- **Entrada:** 0.4-0.6s, `easeOutBack` (constante Back c1 = 1.70158). O overshoot dá vida; entrada linear lê como transição de PowerPoint.
- **Hold (leitura):** ≥1.5-2s por beat de texto/imagem antes de trocar — abaixo disso o olho não lê nem assenta, e o beat foi desperdiçado. Nunca empilhe dois textos novos no mesmo instante. Durante o hold a imagem não fica parada: Ken Burns escala 1 → 1.08.
- **Saída:** mais curta que a entrada (~0.3-0.4s), `easeIn` — sair rápido mantém o ritmo.
- Displays de tempo a 60fps: `font-variant-numeric: tabular-nums` + largura fixa (senão o relógio reflowa a UI a cada frame).

## Exportar pra vídeo (MP4) — Claude Code
Isto é o que transforma a animação num anúncio real. Faça a animação **determinística por tempo**: um `render(t)` que seta os estilos a partir de `t`, e um param de URL (`?t=SECONDS`) que renderiza UM frame fixo (sem rAF). Aí:
```bash
CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
mkdir -p frames
FPS=15; DUR=6.5; N=$(python3 -c "print(int($FPS*$DUR))")
for i in $(seq 0 $((N-1))); do
  t=$(python3 -c "print($i/$FPS)"); n=$(printf "%03d" $i)
  "$CHROME" --headless --disable-gpu --hide-scrollbars --force-device-scale-factor=1 \
    --window-size=1080,1920 --screenshot="frames/f_$n.png" "file://$PWD/anim.html?export=1&t=$t"
done
ffmpeg -y -framerate $FPS -i "frames/f_%03d.png" -c:v libx264 -pix_fmt yuv420p -movflags +faststart -r 30 saida.mp4
```
Dicas: `?export=1` desliga o scale-to-fit (renderiza 1:1 no tamanho real). Adicione um **scrim** (degradê escuro) atrás de texto que cai sobre imagem clara, pra garantir contraste. Verifique extraindo um frame do MP4 (`ffmpeg -ss <t> -i saida.mp4 -frames:v 1 check.png`). Tamanhos: story/Reels 1080×1920, feed 1080×1080, horizontal 1920×1080.
