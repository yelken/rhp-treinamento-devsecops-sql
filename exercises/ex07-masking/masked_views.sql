SET search_path TO hospital_data, public;

-- TODO: criar view vw_patients_masked com mascaramento condicional por role
DROP VIEW IF EXISTS vw_patients_masked;

CREATE VIEW vw_patients_masked AS
SELECT
    p.id,
    p.department_id,
    CASE
        WHEN (
            SELECT 1
            FROM pg_roles
            WHERE rolname = 'auditor' AND pg_has_role(current_user, 'auditor', 'member')
        ) = 1 THEN full_name
        ELSE split_part(p.full_name, ' ', 1)
        END AS full_name,
    CASE
        WHEN pg_has_role(current_user, 'auditor', 'member') THEN p.ssn
        ELSE concat('***-**-', RIGHT(p.ssn, 4))
        END AS ssn,
    CASE
        WHEN pg_has_role(current_user, 'auditor', 'member') THEN p.phone
        ELSE concat('(***) ****-', RIGHT(regexp_replace(p.phone, '\\D', '', 'g'), 4)) END as phone
FROM hospital_data.patients AS p;



