SET search_path TO hospital_data, public;

DROP VIEW IF EXISTS vw_patients_masked;
CREATE VIEW vw_patients_masked AS
SELECT
    p.id,
    p.department_id,
    CASE
        WHEN (
            SELECT 1
            FROM pg_roles
            WHERE rolname = 'auditor'
                AND pg_has_role(current_user, 'auditor', 'member') -- noqa: RF03
        ) = 1 THEN p.full_name
        ELSE split_part(p.full_name, ' ', 1) -- primeiro nome
    END AS full_name,
    CASE
        WHEN pg_has_role(current_user, 'auditor', 'member') -- noqa: RF03
            THEN p.ssn
        ELSE concat('***-**-', right(p.ssn, 4))
    END AS ssn,
    CASE
        WHEN pg_has_role(current_user, 'auditor', 'member') -- noqa: RF03
            THEN p.phone
        ELSE concat('(***) ****-', right(regexp_replace(p.phone, '\\D', '', 'g'), 4))
    END AS phone
FROM hospital_data.patients AS p;


