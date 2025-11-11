# Responsabilidade sobre Consultas SQL (Exemplo)

## Compromissos
- Minimização de dados (sem `SELECT *`, sem PII desnecessária).
- Views mascaradas para leitores e anonimização em compartilhamentos externos.
- RLS/RBAC verificados conforme perfis.
- Orçamento de performance: < 200 ms / < 10k linhas lidas (ajustável).
- Execução fora de pico para consultas pesadas.

## Checklist por PR
- [x] PII/PHI revisadas e minimizadas
- [x] RLS/RBAC/mascaramento verificados
- [x] `EXPLAIN ANALYZE` anexado
- [x] Export segue `DATA_SHARING_POLICY.md`
- [x] Logs/auditoria previstos (quando aplicável)

## Assinatura
Autor: dados-rhp-core   Data: 2025-01-01


