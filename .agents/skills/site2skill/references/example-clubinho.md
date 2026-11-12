# Exemplo trabalhado — Clubinho (surf + bundle + autenticado headless)

Caso real do fluxo completo do site2skill num site **difícil**: Clubinho de Ofertas (`clubinhodeofertas.com.br`) — Laravel + Inertia.js, atrás de **Cloudflare**, com área logada. Mostra as três peças (surf, varredura de bundle, autenticação) trabalhando juntas.

## A jornada, passo a passo

**1. Captura (sem HAR manual).** Com a extensão chrome-MCP, o Claude navegou no **Chrome real** do usuário (trust score do Cloudflare já resolvido), abriu um produto e leu o tráfego. Descobriu os endpoints públicos:
```
GET /api/rio-de-janeiro/price/{id}
GET /api/products/{id}/variations/single/available-months?city_id=1
GET /api/products/{id}/variations/single/range?city_id=1&start_date=...&end_date=...
GET /api/products/{id}/variations/single/{YYYY-MM-DD}?city_id=1
```

**2. Parser → modo `surf`.** Cloudflare presente (`cf-ray`, `server: cloudflare`), auth só por cookie. Prova cabal do modo:
```
curl comum        → HTTP 403 (challenge do Cloudflare)
curl_cffi chrome  → HTTP 200 + JSON   ← só muda o TLS fingerprint
```

**3. Varredura de bundle — o achado.** O HAR só vê o que foi clicado. A `bundle_scrape.py` baixou o JS e **seguiu os chunks de code-splitting** (Vite), achando a superfície **autenticada** que nenhum clique alcançava:
```
/api/my-account/orders/{id}          (detalhe de pedido)
/api/my-account/orders/{id}/tickets  (ingressos)
/api/checkout/order, /apply-discount-code, /installment-options  (escrita — mapeados, NÃO disparados)
```

**4. Geração (modo surf).** `surf.py` (curl_cffi) + `.venv` self-bootstrap (`curl_cffi` + `browser_cookie3`) + `.env`. Endpoints públicos rodam **headless, sem browser, sem cookie**.

**5. Autenticado headless.** O cookie de sessão veio do cookie store do Chrome via `browser_cookie3` (com autorização + Keychain) → escrito no `.env`. Aí o `surf.py` roda os `/api/my-account/*` no terminal puro. A **lista** de pedidos não tem API JSON — é SSR (Inertia `data-page` no HTML); parseia-se de lá.

**6. Auto-refresh.** Ao levar 401/403, o `surf.py` relê os cookies do Chrome e repete a chamada sozinho.

## Os 3 bugs que o teste real pegou (e o eval não pegaria)

1. **Falso-positivo de challenge:** marcava qualquer página HTML como bloqueio só porque toda página via Cloudflare referencia `challenge-platform`. Fix: só conta se o **status** for 403/429/503.
2. **PEP 668:** `pip install curl_cffi` global quebra em Mac moderno. Fix: `.venv` próprio + `surf.py` se re-executa nele (sentinel anti-loop — o 1º guard tinha bug de `resolve()` seguir symlink).
3. **Extensão bloqueia cookie:** `document.cookie` volta `[BLOCKED]` — por isso o cookie do surf vem de HAR/cookie-store, nunca da extensão.

## Exemplos de uso — pra mostrar pra galera

Depois de gerada, conversa em português (o Chrome nem precisa estar aberto pros públicos):

| Você pede | Roda (headless) | Resposta real |
|---|---|---|
| "Qual o preço do produto 2682?" | `GET /api/rio-de-janeiro/price/2682` | R$ 60 (de R$ 120, 50% off) |
| "Quais datas o Fantasy tem em julho?" | `range?start=...&end=...` | 7 datas: sáb 04,11,18,25 · dom 12,19,26 |
| "Horários e preços do dia 4" | `.../single/2026-07-04` | 16h, Teatro Clara Nunes, Plateia/Balcão R$ 60 |
| "Meus pedidos" *(logado)* | SSR `/minha-conta/pedidos` + `/orders/{id}` | lista + status/valor/ingressos por pedido |

## A lição

O eixo do site2skill: **superfície pequena** (HAR basta) vs **grande/escondida** (bundle acha) e **local headless** (surf) vs **browser vivo** (CDP). Clubinho exercita quase tudo: Cloudflare→surf, endpoints escondidos→bundle, área logada→cookie do Chrome, tudo **headless e auto-curável** enquanto o Chrome estiver logado. **Nunca** disparar os endpoints de escrita (checkout/estorno) sem intenção explícita.
