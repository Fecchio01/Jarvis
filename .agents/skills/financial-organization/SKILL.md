---
name: financial-organization
description: Use for an on-demand weekly finance review, spending plan, bank-statement analysis, budgeting, or current investment research. The weekly review happens when the user asks; it is not a scheduled or background task.
---

# Financial Organization and Weekly Planning

Help the user understand their financial position for the coming week and compare investment options using records and current sources. Work only when the user invokes Jarvis for a task.

## Weekly review

1. **Confirm scope and date range.** Determine whether the user means personal finances, EUpresa, or another project. Set the week boundaries, currency, and relevant accounts. Do not mix personal and business cash.
2. **Gather verifiable inputs.** Use a current balance or statement, transactions, confirmed income dates, essential bills, card payments, existing commitments, and the user's minimum reserve. Use only a bank connection that is actually available and explicitly authorized, or records the user provides. Never ask for credentials or authentication codes. If balance data is absent, do not claim to know the account balance.
3. **Reconcile and classify.** Separate confirmed from pending transactions, recurring from one-time expenses, and essential from discretionary spending. Flag duplicate, ambiguous, or missing records. Do not treat credit limits or unconfirmed income as cash.
4. **Calculate a safe discretionary amount.** Show the period and arithmetic. A starting point is: current liquid balance + confirmed income arriving before the week ends - essential bills due - committed spending - the user's protected minimum reserve. Adjust only when records support it. If the result is negative or uncertain, say so directly; do not manufacture a positive spending allowance.
5. **Plan the week.** State how much is available for discretionary spending, identify upcoming due dates and unusual expenses, and optionally break the limit into a daily guide. Distinguish the spending limit from a recommendation to spend it all.
6. **Compare with recent history.** If prior-week data is available, show material changes by category and separate observed changes from possible explanations.

## Investment research

- Confirm the objective, time horizon, liquidity needs, existing exposure, financial capacity for loss, investment knowledge, and risk tolerance before tailoring a comparison. If material details are missing, ask one concise question or keep the answer general.
- Verify current rates, fees, liquidity, tax treatment, guarantees, and product terms using current primary sources, including official regulators, the Tesouro Direto/Tesouro Nacional, B3, or the relevant institution. Cite sources and identify the date checked.
- Compare options against the user's stated profile and goals. Explain downside scenarios, credit or market risk, early withdrawal limits, fees, and tax assumptions. Distinguish verified terms from estimates and unknowns.
- Provide decision support and a shortlist for the user to evaluate. Do not promise performance or claim an option is universally “best.” A personalized professional securities recommendation is a regulated service in Brazil; do not present this assistant as a CVM-registered consultant or replace the suitability process of the user's institution. Suggest consulting a CVM-registered professional when the user wants formal individualized advice.

## Boundaries

- Weekly planning is on demand. Do not schedule the review, monitor bank accounts, create reminders, or run in the background unless the user separately asks for an automation.
- Never make payments or transfers, submit filings, trade, buy or sell assets, alter account settings, or contact financial institutions.
- Never ask for bank passwords, login credentials, security codes, or full card numbers. Treat statements and account information as sensitive; use only data necessary for the requested analysis.
- Do not invent balances, transactions, income, fees, exchange rates, or investment performance. Show source data, calculation steps, assumptions, and uncertainty.
- Do not give tax, legal, or accounting conclusions as professional advice. Verify current rules from official sources when they materially affect analysis.

## Output

Return a concise, auditable weekly report to Jarvis:

- Scope, dates, currency, and data source
- Current liquid balance only if verified
- Essential bills and confirmed inflows/commitments
- Discretionary amount and calculation
- Investment comparison and dated sources, if requested
- Assumptions, risks, missing data, and next steps
