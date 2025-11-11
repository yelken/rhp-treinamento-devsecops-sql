# Ex05 — Privilégios mínimos e RBAC

## Objetivo
Criar papéis (roles) e permissões mínimas para leitura de relatórios e escrita de ETL, evitando acesso direto a PII/PHI quando não necessário.

## Contexto e tabelas
Schema: `hospital_data`
- `patients(id, full_name, ssn, dob, address, phone, department_id)` — contém PII (full_name, ssn, address, phone, dob)
- `admissions(id, patient_id, department_id, admitted_at, discharged_at)`
- `lab_results(id, patient_id, test_name, result_value, result_unit, result_date)`
- `departments(id, name)`

Meta para o público de relatórios (report_reader):
- Não ter acesso direto a PII em `patients`. Consumir dados de pacientes via view “não-PII”.

## Passos
1. Crie roles:
   - `report_reader` (somente leitura)
   - `etl_writer` (leitura + escrita em tabelas de ETL/exames)
   - `auditor` (leitura ampla, sem escrita)
2. Revogue permissões públicas desnecessárias e conceda `USAGE` no schema para esses roles.
3. Crie uma view mínima não-PII (ex.: `vw_patients_public` com apenas `id`, `department_id`) e NEGUE acesso direto à tabela `patients` para `report_reader`.
4. Conceda:
   - `report_reader`: `SELECT` em `vw_patients_public`, `admissions`, `lab_results`, `departments` (ajuste conforme necessidade de negócio).
   - `etl_writer`: `SELECT, INSERT, UPDATE` em `lab_results` (exemplo de escrita de ETL).
   - `auditor`: `SELECT` em todas as tabelas do schema (sem `INSERT/UPDATE/DELETE`).
5. (Opcional) Crie usuários de teste e atribua as roles, depois valide com `SET ROLE` ou fazendo login.

## Critério de aceite
- `report_reader` consegue consultar relatórios sem acesso direto à PII de `patients` (apenas via view não-PII).
- `etl_writer` consegue inserir/atualizar onde necessário (ex.: `lab_results`), sem ampliar acesso à PII de `patients`.
- `auditor` tem leitura ampla, sem escrita.

## Validação rápida (exemplos)
```sql
-- Como superuser ou dono:
SET ROLE report_reader;
SELECT * FROM hospital_data.vw_patients_public LIMIT 5; -- OK
SELECT * FROM hospital_data.patients LIMIT 5;           -- Deve falhar (sem permissão)
RESET ROLE;

SET ROLE etl_writer;
INSERT INTO hospital_data.lab_results (patient_id, test_name, result_value, result_unit, result_date)
VALUES (1, 'Glicose', '101', 'mg/dL', CURRENT_DATE);
RESET ROLE;
```

## Dicas
- Use `REVOKE` no schema e tabelas antes de `GRANT` específicos.
- Em exercícios posteriores (Ex07), troque a view mínima por `vw_patients_masked` com mascaramento condicional por role.
- Veja `solutions/ex05-rbac/rbac.sql` para uma implementação de referência.

## Nota: PII e PHI
- PII: dados pessoais identificáveis (ex.: `full_name`, `ssn`, `address`, `phone`, `dob` em `patients`).
- PHI: PII associada a saúde.
- RBAC limita quem vê o quê; combine com RLS e views mascaradas para proteger PII/PHI.
