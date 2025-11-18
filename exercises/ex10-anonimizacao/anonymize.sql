SET search_path TO hospital_data, public;

-- TODO: criar vw_patients_anon
-- 1) pseudônimo = digest(id || salt, 'sha256')
-- 2) idade por faixas: 0-12, 13-17, 18-39, 40-64, 65+

SET search_path TO hospital_data, public;

-- Sal para hash determinístico (exemplo didático; em produção, proteger)
DO $$
BEGIN
    PERFORM set_config('app.anon_salt', 'rhp_salt_demo', true);
END
$$;

DROP VIEW IF EXISTS vw_patients_anon;
CREATE VIEW vw_patients_anon AS
SELECT
    p.department_id,
    CASE
        WHEN p.dob IS NULL THEN 'unknown'
        WHEN age(current_date, p.dob) < interval '13 years' THEN '0-12'
        WHEN age(current_date, p.dob) < interval '18 years' THEN '13-17'
        WHEN age(current_date, p.dob) < interval '40 years' THEN '18-39'
        WHEN age(current_date, p.dob) < interval '65 years' THEN '40-64'
        ELSE '65+'
    END AS age_bucket,
    encode(
        digest(
            p.id::text
            || COALESCE(current_setting('app.anon_salt', true), 'rhp_salt_demo')
            , 'sha256'
        ),
        'hex'
    ) AS patient_pseudo_id
FROM hospital_data.patients AS p;


