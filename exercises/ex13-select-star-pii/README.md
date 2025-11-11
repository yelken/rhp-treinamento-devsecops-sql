# Ex13 — SELECT * e vazamento de PII em joins

## Objetivo
Evitar `SELECT *` que expõe PII desnecessária e padronizar seleção mínima de colunas.

## Passos
1. Analise `queries/bad.sql` (usa `SELECT *` em join).
2. Reescreva selecionando apenas colunas necessárias ao relatório (sem `ssn`, `phone`, `address`).
3. Opcional: use views mascaradas (Ex07) para consumidores de relatório.

## Critério de aceite
- Query não retorna nenhuma PII direta.
- SQLFluff sem erro.

## Dicas
- Colunas essenciais típicas: `id`, `department_id`, `admitted_at`, `discharged_at`.

## Nota: PII e PHI
- PII: dados pessoais identificáveis (ex.: nome, telefone, endereço, documento).
- PHI: PII com saúde.
- Evite `SELECT *` para não expor PII/PHI desnecessariamente.

