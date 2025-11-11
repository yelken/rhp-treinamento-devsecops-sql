# Ex03 — Qualidade de SQL com lint (SQLFluff)

## Objetivo
Usar SQLFluff para padronizar estilo e detectar problemas básicos.

## Passos
1. Rode `sqlfluff lint exercises/ex03-sqlfluff/queries/bad_query.sql`.
2. Corrija os problemas apontados.
3. Confirme com `sqlfluff lint` que não há erros.

## Critério de aceite
- Query corrigida e lint sem falhas.

## Dicas
- Veja `solutions/ex03-sqlfluff/queries/good_query.sql` como referência.

## Nota: PII e PHI
- PII: dados pessoais identificáveis (ex.: nome, CPF/RG, endereço, telefone, e-mail, data de nascimento, IP, biometria).
- PHI: PII com informações de saúde.
- Padronizar SQL ajuda a evitar `SELECT *` e outras práticas que vazam PII sem necessidade.

