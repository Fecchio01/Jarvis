# Receita — Protótipo interativo / Mockup de app

Protótipo com sensação de app real. **Barra de "real" — cheque cada item no screenshot/interação antes de fechar; falhar em um vira mockup estático, não protótipo:**
1. **Zero controle morto** — todo botão/link/input muda algo visível ou navega. Um botão que não faz nada é o defeito nº 1 de protótipo IA.
2. **Um happy-path completável de ponta a ponta** sem recarregar a página (ex: login fake → criar item → salvar → vê-lo na lista). Se o fluxo principal não fecha, não é protótipo.
3. **Toda troca de estado transiciona** (≥150ms: fade/slide/height), nunca swap instantâneo que "pisca". Instantâneo denuncia mockup.
4. **Validação rejeita um input inválido concreto** com mensagem inline no campo (email sem `@`, campo vazio, valor fora do range) — não só o `required` do browser.

**Direção estética — carregue `aesthetics.md` JUNTO desta receita.** A barra de "real" acima SOMA em cima da direção estética de lá, não a substitui: protótipo funcional sem direção comprometida é wireframe preenchido, e é o defeito nº 2 de protótipo IA (depois do botão morto). Marca existente entra como **restrição** da direção (cores/fontes do brand alimentam a escolha), nunca como dispensa dela — a exigência de "um estranho nomeia o estilo em uma palavra" vale igual.

## Base
- React (useState/useEffect) pra comportamento; JS vanilla só se for realmente simples. Inclua hover **e** active **e** focus visíveis (os três, não só hover).
- **Frames de dispositivo**: copie de `assets/` em vez de improvisar bezel — `ios-frame.jsx`, `android-frame.jsx` (status bar, dynamic island/punch-hole, teclado), `macos-window.jsx`, `browser-window.jsx` (chrome de janela). Já trazem as métricas canônicas certas (ver `aesthetics.md`). São React puro, estilo/SVG inline, zero dependências além do React; exportam pra `window.*` (monte via `<script type="text/babel" src="ios-frame.jsx">` + referência global). **Carregamento** (gotchas testados — ver `web-craft.md`): nunca cole o `.jsx` inline num `<script>`; e como o Babel faz fetch do arquivo, abrir do `file://` fica em branco (CORS) — sirva por servidor local, ou verifique headless com `--allow-file-access-from-files --virtual-time-budget=8000`, ou inline o transpilado pra entrega final.
- **Mock data plausível E denso** — é o que faz o demo parecer produto, não protótipo vazio:
  - Nomes/valores/datas **reais do domínio** (pessoas, produtos, preços em R$, timestamps que fazem sentido). NUNCA "Item 1/2/3", "Lorem ipsum", "Usuário Teste".
  - **Variado**: dados que se repetem denunciam gerador. Nomes diferentes, valores diferentes, estados diferentes (lido/não-lido, pago/pendente).
  - **Denso o bastante pra mostrar o layout sob carga**: listas com ≥6 linhas, incluindo 1 caso-extremo (nome longo que quebraria, valor 0/negativo, texto que trunca) pra provar que o layout aguenta.
- O demo roda standalone (login fake → criar → enviar → ver estado), sem backend. Persista o estado relevante em `localStorage` com `try/catch` (nunca limpe entries que você não escreveu nesta sessão).

## Tweaks / controles (se pedir "tweakável")
`assets/tweaks-panel.jsx` traz `useTweaks(defaults)` + controles prontos (slider, toggle, radio segmentado, select, number scrubbável, color swatches). **Portabilidade**: a UI é portátil, mas ele originalmente abre/persiste via protocolo do host — no Claude Code, adapte pra auto-open + persistir em `localStorage`. Regras:
- **2-4 knobs de alto impacto** — cada um muda algo em MUITOS lugares de uma vez (cor-chave, variante de layout, uma flag de comportamento, headline que se repete). Se o knob só edita um texto/cor isolado, corte: edição direta já cobre, e o knob vira ruído.
- **Cor = 3-4 swatches curados** (ou uma paleta inteira de 2-5 cores por opção) — NUNCA color picker livre: picker convida cor fora do sistema, que é exatamente o que o tweak deveria prevenir.
- Segmented control só pra 2-3 opções curtas (~16 chars com 2, ~10 com 3); acima disso, dropdown (preservando o tipo do valor no fallback).
- Controles prontos são piso, não teto: se um ajuste pede UI que o kit não cobre, construa custom.
- Painel discreto que **some por completo** quando off (passthrough perfeito — nenhum resquício visível).

## Estados (o que separa protótipo bom — construa os TRÊS, não só o estado cheio feliz)
Toda superfície que lista dados OU depende de async precisa de vazio, carregando e erro construídos. Pular qualquer um é bug, não simplificação — o estado "cheio feliz" é o único que um mockup também tem.
- **Empty state acionável**: diz exatamente o que falta E traz o botão que resolve, na própria tela. Tela vazia genérica ("Nada aqui") é bug.
- **Loading / stale**: skeleton/hachura no lugar do conteúdo — nunca branco, nunca layout que "pula" quando o dado chega (reserve o espaço).
- **Generation counter** contra async stale: se uma ação lenta (upload, fetch) pode ser cancelada/substituída no meio, marque uma "geração" e descarte resultados de gerações antigas quando o await retornar.
- **Erro recuperável**: mensagem clara + ação de saída (retry, desfazer, voltar). Beco sem saída não conta.

## Overlay de métricas (opcional)
`assets/metrics-overlay.js` sobrepõe heat-map/trend/real-estate + funis a um protótipo com elementos marcados `data-metric-id` (e `data-metric-scope`). Importante (testado): o **"modo mock" embutido sintetiza apenas resultados de FUNIL** — pra glifos de **heat/trend/real-estate** um **snapshot estático é obrigatório** (sem ele, `mode="heat"` cai em empty state). Forneça o snapshot via `window.<GLOBAL>` + atributo `global="<GLOBAL>"` **sem** `src`. Shape mínimo:
```js
window.MeuSnap = { asOf:'2026-06-24', days:['2026-06-18',…,'2026-06-24'],
  viewersDaily:[1200, …],                          // 1 int por dia
  elements:[ { id:'cta', label:'Entrar', daily:[80, …] }, … ] }; // daily alinhado a days[]
```
Os loops de refetch/save dependem de protocolo do host — mantenha estático/mock. Padrões de dataviz úteis lá dentro: deadband ±4% em setas de tendência, **click-share ÷ area-share** pra julgar se um elemento merece seu espaço.

## Copy da interface (o texto É parte do protótipo)
- **Rótulo = ação específica:** todo botão nomeia o resultado — "Criar conta", "Salvar alterações", "Baixar relatório" — nunca "Enviar/OK/Confirmar" solto. Comece por verbo; o rótulo casa com o que acontece ao clicar.
- **Erro = o que aconteceu + por quê + como resolver**, nessa ordem ("Pagamento recusado. Seu banco recusou o cartão. Tente outro ou fale com o banco.") — nunca só "Algo deu errado".
- **Diálogo de confirmação:** título nomeia ação + objeto ("Excluir 3 arquivos?", não "Tem certeza?"); descreva a consequência ("não pode ser desfeito"); botões rotulados com a ação ("Excluir" / "Manter"), nunca "OK"/"Cancelar".
- **Tom por estado:** sucesso comemora sem exagero; erro é empático e mostra a saída; aviso é claro e acionável; neutro só informa.
- **Tooltip:** curto e útil; nunca repita o que o rótulo já diz.

## Chamar Claude de dentro do protótipo (`window.claude.complete`)
Protótipos que precisam de IA ao vivo (ex.: um chat fake que responde de verdade) podem chamar `window.claude.complete` — **sem SDK, sem API key**:
```js
(async () => {
  const text = await window.claude.complete("Resuma isto: …");
  // ou com array de mensagens:
  const text2 = await window.claude.complete({ messages: [{ role: 'user', content: '…' }] });
})();
```
Usa `claude-haiku-4-5`, cap **fixo de 1024 tokens** de output, rate-limit por usuário (artifacts compartilhados rodam sob a quota de quem vê).
**⚠ Ressalva de ambiente (Claude Code):** esse helper é injetado só no ambiente de **Artifacts do claude.ai** (e no app de design antigo) — num HTML aberto via `file://` ou num standalone offline, `window.claude` **não existe** e a chamada quebra. Então: use-o apenas se o protótipo for publicado como Artifact; caso contrário, mocke a resposta (dados fixos plausíveis) e sinalize que a IA ao vivo só funciona publicado.

## Nota das molduras de dispositivo
`IOSDevice`/`AndroidDevice` **sem** a prop `title` (nav bar embutida) não reservam inset no topo — a status bar é `position:absolute` e o conteúdo começa em `y=0`, então um header custom colide com a barra de status. Use a prop `title` embutida, ou reserve ~54px de inset no topo do seu conteúdo.
