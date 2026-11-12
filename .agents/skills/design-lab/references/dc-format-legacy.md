# Legado — Formato `.dc.html` (app de design antigo)

**Quando ler isto:** só quando o usuário pedir pra **ler, editar ou converter** um arquivo `.dc.html` existente (ex: `Lookbook - Estúdio.dc.html`, exports do app de design anterior). Para criar peças novas no Claude Code, **ignore** — use HTML puro (as outras receitas).

## O que é
Um `.dc.html` ("Design Component") é HTML + tags especiais que só ganham vida com um runtime `support.js` que acompanha o arquivo. Sem esse `support.js` na mesma pasta, as tags especiais ficam mudas e os `{{ }}` aparecem como texto cru. É um formato proprietário daquele app — não roda "sozinho" como o HTML que fazemos aqui.

## Anatomia (pra você entender ao editar)
- Envelope: `<x-dc> … </x-dc>` dentro de `<body>`, com `<script src="./support.js">` no `<head>`.
- `<helmet>` no topo do template: `@font-face`, `@keyframes`, `<link>` de fonte, `<script>` — monta quando fecha.
- **Holes**: `{{ path.dotado }}` — lookup dotado só (nunca expressão). Resolvido em `renderVals()` da classe de lógica.
- **Atributos**: `x="{{ path }}"` = valor cru; `x="a {{p}} b"` = string interpolada; eventos em camelCase JSX (`onClick="{{ handler }}"`).
- **Controle de fluxo**: `<sc-for list="{{ items }}" as="item" hint-placeholder-count="3">`, `<sc-if value="{{ x }}" hint-placeholder-val="{{ true }}">` — sempre com os `hint-*` (é o que renderiza durante o streaming).
- **Componentes filhos**: `<dc-import name="Card" item="{{ it }}" hint-size="100%,120px">` (monta `Card.dc.html` irmão); `<x-import component="Chart" from="./Chart.jsx" hint-size="…">` (React/JS externo); `component-from-global-scope="tag-ou-Global"` pra web component / global. Sempre com `hint-size`.
- **Lógica**: `class Component extends DCLogic { state={…}; renderVals(){ return {…} } }` — JS clássico, sem import/export; `DCLogic` e `React` injetados.
- **Estilo**: inline only (sem classes CSS) — porque no app o arquivo faz streaming e classes atrasariam o paint. **No Claude Code essa restrição não vale** (você escreve o arquivo inteiro antes de abrir) — mas ao editar um `.dc.html`, mantenha o estilo do arquivo.

## Editar com segurança
- Prefira str-replace cirúrgico a reescrever o arquivo.
- Um bloco `<style id="__om-edit-overrides">` guarda edições diretas do usuário como `!important` — ao mudar o estilo de um elemento que uma dessas regras mira, edite/remova a regra (inline sozinho não vence o `!important`).
- `data-comment-anchor="…"` fixa um comentário de review a um elemento; ao reestruturar, mova o atributo pro equivalente semântico, não invente valores.
- Nunca use `scrollIntoView` (quebra o app).

## Ouro de design que veio DESTAS regras (já promovido pro núcleo da skill)
As regras acima são encanamento do runtime. Mas os **princípios** por trás delas são universais e já estão no `SKILL.md`/outras receitas: um-arquivo-por-padrão + barreira alta pra componentizar; UI como markup estático editável (repetição por extenso); tweaks só pro que edição direta não alcança; estado de animação sobrevivendo a re-render; dependências de render no topo; HTML canônico. Não precisa deste arquivo pra aplicá-los.
