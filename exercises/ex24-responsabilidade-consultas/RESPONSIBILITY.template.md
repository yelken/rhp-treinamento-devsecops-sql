# Responsabilidade sobre Consultas SQL (Template)

## Compromissos
- Minimização de dados (sem `SELECT *`, sem PII desnecessária).
- Uso de views mascaradas/anonimização quando aplicável.
- RLS/RBAC verificados para consumidores do relatório.
- Orçamento de performance atendido (tempo/linhas lidas).
- Execução fora do horário de pico quando pesado.

## Checklist por PR
- [ ] PII/PHI revisadas e minimizadas
- [ ] RLS/RBAC/mascaramento verificados
- [ ] `EXPLAIN ANALYZE` anexado (resultados dentro do orçamento)
- [ ] Export segue `DATA_SHARING_POLICY.md` (se houver)
- [ ] Auditoria/logs planejados (se houver manipulação de sensíveis)

## Assinatura
Autor: ____________________   Data: ____/____/______ 


