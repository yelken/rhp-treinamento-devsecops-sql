# Ex08 — Trilha de auditoria com triggers

## Objetivo
Auditar alterações em `lab_results` (INSERT/UPDATE/DELETE).

## Passos
1. Crie tabela `lab_results_audit` com colunas: operação, usuário, timestamp, BEFORE/AFTER.
2. Crie função e trigger de auditoria.
3. Valide com operações de teste.

## Critério de aceite
- Alterações em `lab_results` geram registros em `lab_results_audit`.

## Dicas
- Veja `solutions/ex08-auditoria/audit.sql`.

## Nota: PII e PHI
- PII: dados pessoais identificáveis; PHI: PII com saúde.
- Auditoria ajuda a detectar acesso/modificação indevida de dados sensíveis.

