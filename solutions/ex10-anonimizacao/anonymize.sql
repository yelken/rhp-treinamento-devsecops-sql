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
    encode(digest((p.id::text || current_setting('app.anon_salt')), 'sha256'), 'hex') AS patient_pseudo_id,
    CASE
        WHEN age(current_date, p.dob) < interval '13 years' THEN '0-12'
        WHEN age(current_date, p.dob) < interval '18 years' THEN '13-17'
        WHEN age(current_date, p.dob) < interval '40 years' THEN '18-39'
        WHEN age(current_date, p.dob) < interval '65 years' THEN '40-64'
        ELSE '65+'
    END AS age_bucket
FROM patients AS p;


