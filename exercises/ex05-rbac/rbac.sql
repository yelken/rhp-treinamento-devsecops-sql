SET search_path TO hospital_data, public;

-- TODO: implementar RBAC básico
-- 1) Criar roles: report_reader (leitura), etl_writer (escrita em ETL/exames), auditor (leitura ampla)
-- 2) Revogar permissões amplas do PUBLIC no schema hospital_data; conceder USAGE aos roles
-- 3) Criar view não-PII: vw_patients_public (colunas: id, department_id). Não conceder acesso direto a patients para report_reader
-- 4) Conceder SELECT a report_reader em vw_patients_public, admissions, lab_results, departments (ajuste conforme necessidade)
-- 5) Conceder SELECT, INSERT, UPDATE a etl_writer em lab_results (exemplo de escrita de ETL)
-- 6) Conceder SELECT em todas as tabelas do schema para auditor; sem escrita


