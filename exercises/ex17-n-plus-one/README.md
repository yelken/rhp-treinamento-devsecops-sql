# Ex17 — Padrão N+1 e correlação ineficiente

## Objetivo
Eliminar múltiplas subconsultas correlacionadas substituindo por join lateral ou window functions.

## Passos
1. Analise `queries/bad.sql` (subquery por linha).
2. Reescreva usando `JOIN LATERAL` ou `ROW_NUMBER()` para pegar o último exame por paciente.
3. Compare plano e tempo.

## Critério de aceite
- Uma única consulta eficiente sem N subconsultas.

## Nota: PII e PHI
- Padrões N+1 podem amplificar a quantidade de PII/PHI lida e movimentada; otimize para ler o mínimo necessário.


