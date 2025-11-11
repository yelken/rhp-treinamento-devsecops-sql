# Política de Compartilhamento de Dados (Exemplo)

## 1. Objetivo do compartilhamento
Export mensal para pesquisa interna do Comitê de Qualidade.

## 2. Escopo dos dados
- Views: `hospital_data.vw_patients_masked`, `hospital_data.vw_admissions_monthly` (quando disponível)
- Colunas: apenas id/pseudo-id, department_id, datas de internação/alta
- Período: último mês

## 3. PII/PHI
- PII/PHI: reduzida; nomes/ssn/telefone não incluídos (view mascarada).
- Medidas: minimização + mascaramento.

## 4. Segurança
- Acesso: somente `report_reader` e auditoria.
- Transferência: canal seguro (SFTP interno).
- Criptografia: em repouso no servidor de relatórios.

## 5. Auditoria
- Registro de export com usuário, timestamp, comando usado e destino.
- Retenção: 90 dias; eliminação segura após.

## 6. Aprovação
- Responsável técnico: dados-rhp-core
- Aprovado em: 2025-01-01


