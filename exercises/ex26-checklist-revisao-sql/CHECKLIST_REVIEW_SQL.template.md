# Checklist de Revisão de Consultas SQL (Template)

## Segurança e Privacidade
- [ ] Sem `SELECT *` / minimização de colunas
- [ ] PII/PHI necessária e justificada; views mascaradas/anonimização aplicadas
- [ ] RLS/RBAC corretos para os consumidores
- [ ] Sem SQL dinâmico inseguro; whitelists e binds usados quando preciso

## Performance
- [ ] `EXPLAIN ANALYZE` anexado e dentro do orçamento
- [ ] Índices úteis e filtros sargáveis
- [ ] Evita N+1, junções cartesianas, materializações desnecessárias

## Governança
- [ ] Política de export (`DATA_SHARING_POLICY.md`) seguida (se for export)
- [ ] Auditoria e logs previstos quando necessário
- [ ] Checklist de responsabilidade anexada/assinada


