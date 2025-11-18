SET search_path TO hospital_data, public;

ALTER TABLE patients ENABLE ROW LEVEL SECURITY;

CREATE OR REPLACE VIEW current_user_department AS 
SELECT
    u.username,
    u.department_id
FROM hospital_data.users AS u
WHERE u.username = current_user;

DROP POLICY IF EXISTS patient_rls_policy ON patients;

CREATE POLICY patient_rls_policy ON patients
FOR SELECT TO report_reader USING (department_id = (SELECT department_id FROM current_user_department));
-- TODO:
-- 1) ALTER TABLE patients ENABLE ROW LEVEL SECURITY;
-- 2) Criar policy que verifica se o departamento do current_user (em hospital_data.users)
--    bate com o department_id do paciente.
-- 3) Política apenas para SELECT para role report_reader.


