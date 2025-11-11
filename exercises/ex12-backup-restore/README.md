# Ex12 — Backup e restauração (DR)

## Objetivo
Ter um procedimento repetível de backup e restauração do banco.

## Passos
1. Complete `backup.sh` usando `pg_dump` (formato custom `-Fc`).
2. Complete `restore.sh` usando `pg_restore` (em banco limpo).
3. Teste restaurando e validando contagens de tabelas.

## Critério de aceite
- Arquivo de backup gerado com timestamp.
- Restauração reproduz os dados com sucesso.

## Dicas
- Veja `solutions/ex12-backup-restore/backup.sh` e `restore.sh`.

## Nota: PII e PHI
- PII: dados pessoais identificáveis; PHI: PII com saúde.
- Proteja backups: criptografia em repouso, controle de acesso, retenção e testes de restauração.

