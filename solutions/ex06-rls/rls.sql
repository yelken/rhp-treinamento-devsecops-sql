SET search_path TO hospital_data, public;

ALTER TABLE patients ENABLE ROW LEVEL SECURITY;

-- Supõe que o current_user existe em hospital_data.users com department_id
CREATE OR REPLACE VIEW current_user_department AS
SELECT
    u.username,
    u.department_id
FROM hospital_data.users AS u
WHERE u.username = current_user;

DROP POLICY IF EXISTS patient_rls_policy ON patients;
CREATE POLICY patient_rls_policy
ON patients
FOR SELECT
TO report_reader
USING (
    department_id = (SELECT department_id FROM current_user_department)
);


