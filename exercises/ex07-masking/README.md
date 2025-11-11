# Ex07 — Classificação e mascaramento de dados (PII/PHI)

## Objetivo
Expor views para relatórios com PII mascarada, exceto para auditores.

## Passos
1. Crie uma view `vw_patients_masked` que:
   - Mostra `full_name` parcialmente (ex.: apenas primeiro nome)
   - Mascara `ssn` (ex.: `***-**-1234`)
   - Mascara `phone` (ex.: `(***) ****-5555`)
2. Se `current_user` for auditor, mostrar valores completos.

## Critério de aceite
- `report_reader` vê dados mascarados.
- `auditor` vê dados completos.

## Dicas
- Veja `solutions/ex07-masking/masked_views.sql`.

## Nota: PII e PHI
- PII: dados pessoais identificáveis; PHI: PII com saúde.
- Mascaramento reduz exposição de PII/PHI para quem não precisa dos dados completos.

