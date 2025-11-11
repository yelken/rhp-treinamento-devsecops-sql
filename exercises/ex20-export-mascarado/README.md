# Ex20 — Export seguro: usar views mascaradas

## Objetivo
Evitar export de PII acidental usando `COPY`/export em tabelas cruas.

## Passos
1. Veja `queries/bad.sql` (export a partir de `patients`).
2. Reescreva export para usar view mascarada (Ex07: `vw_patients_masked`) ou seleção sem PII.
3. Valide as colunas exportadas.

## Critério de aceite
- Export não contém PII direta (ssn, phone, address).

## Nota: PII e PHI
- Garanta que exports públicos não incluam PII/PHI; prefira views mascaradas e colunas mínimas.


