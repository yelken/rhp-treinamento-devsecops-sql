# Ex25 — Monitorar consultas com pg_stat_statements

## Objetivo
Habilitar `pg_stat_statements` e identificar consultas mais custosas para otimização contínua.

## Passos
1. (Local) Habilite a extensão:
   ```sql
   CREATE EXTENSION IF NOT EXISTS pg_stat_statements;
   ```
2. Rode relatórios de top queries por tempo total/execuções/média.
3. Selecione 1 consulta custosa e proponha otimização.

## Critério de aceite
- Relatório com pelo menos 5 linhas, destacando 1 query e plano de ação.

## Nota: PII e PHI
- Priorize otimizar consultas que tocam tabelas com PII/PHI ou que rodam com alta frequência.


