# Ex22 — Orçamento de performance (tempo e custo por consulta)

## Objetivo
Definir orçamento de performance para consultas (ex.: < 200 ms e < 10k linhas lidas) e garantir que as consultas atendam ao orçamento usando `EXPLAIN ANALYZE`.

## Passos
1. Defina um orçamento-alvo para a consulta do seu relatório.
2. Rode `EXPLAIN ANALYZE` e registre o tempo/rows lidas.
3. Otimize índices/filtros/joins até atender o orçamento.

## Critério de aceite
- O plano e tempo de execução ficam dentro do orçamento definido.

## Dicas
- Reduza leituras desnecessárias (filtro cedo, índices úteis, evitar funções na coluna).

## Nota: PII e PHI
- Consultas mais eficientes reduzem janelas de exposição e pressão no sistema assistencial.


