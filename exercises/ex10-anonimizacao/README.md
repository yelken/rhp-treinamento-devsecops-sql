# Ex10 — Anonimização para compartilhamento

## Objetivo
Gerar uma visão/tabela anonimizada de pacientes para análises externas.

## Passos
1. Crie `vw_patients_anon` com:
   - Remoção de identificadores diretos (ssn, phone, address).
   - Pseudônimo determinístico (ex.: hash de id com salt).
   - Generalização de data de nascimento para faixas de idade.
2. Opcional: materializar em tabela.

## Critério de aceite
- Nenhuma coluna com PII direta.
- Pseudônimo consistente por paciente.

## Dicas
- Veja `solutions/ex10-anonimizacao/anonymize.sql`.

## Nota: PII e PHI
- PII: dados pessoais identificáveis; PHI: PII com saúde.
- Anonimização e pseudonimização permitem compartilhamento para análises sem expor identidades.

