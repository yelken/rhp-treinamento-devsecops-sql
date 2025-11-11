# Ex19 — Locks desnecessários em consultas de relatório

## Objetivo
Evitar bloqueios causados por `FOR UPDATE` ou transações de escrita em relatórios.

## Passos
1. Veja `queries/bad.sql` (usa `FOR UPDATE` sem necessidade).
2. Reescreva removendo bloqueio e, se precisar consistência, use transação read only.
3. Opcional: `SET TRANSACTION ISOLATION LEVEL REPEATABLE READ READ ONLY`.

## Critério de aceite
- Query não adquire bloqueios de linha desnecessários.

## Nota: PII e PHI
- Reduzir bloqueios em relatórios evita retenção prolongada de linhas sensíveis e gargalos em sistemas críticos.


