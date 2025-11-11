# Ex16 — Predicados não sargáveis (funções na coluna)

## Objetivo
Escrever filtros que aproveitem índices evitando funções na coluna filtrada.

## Passos
1. Rode `queries/bad.sql` e veja o plano de execução.
2. Reescreva para intervalo fechado/aberto (>= e <) em vez de `date_trunc`/`::text`.
3. Opcional: crie índice em `admitted_at`.

## Critério de aceite
- Plano com uso de índice quando apropriado.

## Nota: PII e PHI
- Consultas eficientes ajudam a evitar acessos longos a tabelas com PII/PHI, reduzindo janelas de exposição.


