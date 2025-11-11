# Ex11 — CI para SQL (lint, scan, migração)

## Objetivo
Fazer o pipeline de CI passar executando:
- Lint (SQLFluff)
- Scan de segredos (Gitleaks)
- Carga de schema/dados
- Checagens simples com psql

## Passos
1. Confira `.github/workflows/ci.yml`.
2. Garanta que os exercícios anteriores não quebrem o lint/scan.
3. Abra um PR e verifique a execução no GitHub.

## Critério de aceite
- CI verde no PR.

## Dicas
- Se o lint falhar, ajuste as queries ou altere regras em `.sqlfluff` de forma consciente.

## Nota: PII e PHI
- PII: dados pessoais identificáveis; PHI: PII com saúde.
- O CI ajuda a bloquear vazamento de segredos e práticas que expõem PII/PHI sem querer.

