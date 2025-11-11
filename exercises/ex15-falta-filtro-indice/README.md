# Ex15 — Falta de filtro e índice em relatórios

## Objetivo
Evitar full scan desnecessário; aplicar filtro e índice apropriado.

## Passos
1. Veja `queries/bad.sql` (sem filtro).
2. Reescreva filtrando por `department_id` e crie índice adequado.
3. Compare planos com `EXPLAIN ANALYZE`.

## Critério de aceite
- Query filtrada e com uso de índice quando aplicável.

## Nota: PII e PHI
- Limitar colunas e linhas também reduz a exposição desnecessária de PII/PHI.


