SET search_path TO hospital_data, public;

-- TODO: implementar RBAC básico
-- 1) Criar roles: report_reader (leitura), etl_writer (escrita em ETL/exames), auditor (leitura ampla)
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'report_reader') THEN
        CREATE ROLE report_reader NOINHERIT;
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'etl_writer') THEN
        CREATE ROLE etl_writer NOINHERIT;
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'auditor') THEN
        CREATE ROLE auditor NOINHERIT;
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'report_cli_med') THEN
        CREATE ROLE report_cli_med NOINHERIT;
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'report_cir') THEN
        CREATE ROLE report_cir NOINHERIT;
    END IF;
END $$;

-- 2) Revogar permissões amplas do PUBLIC no schema hospital_data; conceder USAGE aos roles
REVOKE ALL ON SCHEMA hospital_data FROM public;
GRANT USAGE ON SCHEMA hospital_data TO report_reader, etl_writer, auditor, report_cir, report_cli_med;

-- 3) Criar view não-PII: vw_patients_public (colunas: id, department_id). Não conceder acesso direto a patients para report_reader
DROP VIEW IF EXISTS hospital_data.vw_patients_public;
CREATE VIEW hospital_data.vw_patients_public AS
    SELECT
        id,
        full_name,
        department_id
    FROM hospital_data.patients;


-- 4) Conceder SELECT a report_reader em vw_patients_public, admissions, lab_results, departments (ajuste conforme necessidade)
REVOKE ALL ON hospital_data.patients FROM report_reader;
GRANT SELECT ON hospital_data.vw_patients_public TO report_reader;
GRANT SELECT ON hospital_data.vw_patients_masked TO report_reader;
GRANT SELECT ON hospital_data.admissions TO report_reader;
GRANT SELECT ON hospital_data.lab_results TO report_reader;
GRANT SELECT ON hospital_data.departments TO report_reader;

REVOKE ALL ON hospital_data.patients FROM report_cli_med;
GRANT SELECT ON hospital_data.vw_patients_public TO report_cli_med;
GRANT SELECT ON hospital_data.admissions TO report_cli_med;
GRANT SELECT ON hospital_data.lab_results TO report_cli_med;
GRANT SELECT ON hospital_data.departments TO report_cli_med;
GRANT SELECT ON hospital_data.users TO report_cli_med;
GRANT SELECT ON hospital_data.patients TO report_cli_med;

REVOKE ALL ON hospital_data.patients FROM report_cir;
GRANT SELECT ON hospital_data.vw_patients_public TO report_cir;
GRANT SELECT ON hospital_data.admissions TO report_cir;
GRANT SELECT ON hospital_data.lab_results TO report_cir;
GRANT SELECT ON hospital_data.departments TO report_cir;
GRANT SELECT ON hospital_data.users TO report_cir;
GRANT SELECT ON hospital_data.patients TO report_cir;

-- 5) Conceder SELECT, INSERT, UPDATE a etl_writer em lab_results (exemplo de escrita de ETL)
GRANT SELECT, INSERT, UPDATE ON hospital_data.lab_results TO etl_writer;
GRANT USAGE, SELECT ON SEQUENCE hospital_data.lab_results_id_seq TO etl_writer;

-- 6) Conceder SELECT em todas as tabelas do schema para auditor; sem escrita
GRANT SELECT ON ALL TABLES IN SCHEMA hospital_data TO auditor;