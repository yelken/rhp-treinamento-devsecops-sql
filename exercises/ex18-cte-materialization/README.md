# Ex18 — Uso inadequado de CTE e materialização

## Objetivo
Evitar materialização desnecessária que impede otimizações do planner.

## Passos
1. Analise `queries/bad.sql` (CTE MATERIALIZED com filtro tardio).
2. Reescreva removendo `MATERIALIZED` e/ou usando subquery inline com filtro precoce.
3. Compare plano e custo.

## Critério de aceite
- Plano otimizado com pushdown de filtro.

## Nota: PII e PHI
- Evite materializar conjuntos grandes com PII/PHI quando não necessário; filtre cedo para minimizar exposição.


