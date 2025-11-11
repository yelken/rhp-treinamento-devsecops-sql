# Ex14 — Junção cartesiana por falta de predicado

## Objetivo
Evitar explosão de linhas por junções sem predicate adequado.

## Passos
1. Execute e observe `queries/bad.sql` (contagem inflada).
2. Corrija adicionando o predicado de junção correto.
3. Compare contagens e plano (`EXPLAIN ANALYZE`).

## Critério de aceite
- Contagem coerente com dados.
- Plano sem nested loop gigante desnecessário.

## Nota: PII e PHI
- PII/PHI podem ser replicadas indevidamente em junções erradas; além de custo, há risco de exposição inadvertida.


