SET search_path TO hospital_data, public;

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
END $$;

-- Restringe acesso amplo
REVOKE ALL ON SCHEMA hospital_data FROM public;
GRANT USAGE ON SCHEMA hospital_data TO report_reader, etl_writer, auditor;

-- View mínima sem PII para leitores de relatório
DROP VIEW IF EXISTS hospital_data.vw_patients_public;
CREATE VIEW hospital_data.vw_patients_public AS
SELECT
    id,
    department_id
FROM hospital_data.patients;

-- Permissões mínimas (least privilege)
-- report_reader: NÃO tem acesso direto a patients; usa a view não-PII
REVOKE ALL ON hospital_data.patients FROM report_reader;
GRANT SELECT ON hospital_data.vw_patients_public TO report_reader;
GRANT SELECT ON hospital_data.admissions TO report_reader;
GRANT SELECT ON hospital_data.lab_results TO report_reader;
GRANT SELECT ON hospital_data.departments TO report_reader;

-- etl_writer: escrita somente em lab_results (exemplo)
GRANT SELECT, INSERT, UPDATE ON hospital_data.lab_results TO etl_writer;

-- auditor: leitura ampla sem escrita
GRANT SELECT ON ALL TABLES IN SCHEMA hospital_data TO auditor;
ALTER DEFAULT PRIVILEGES IN SCHEMA hospital_data GRANT SELECT ON TABLES TO auditor;


