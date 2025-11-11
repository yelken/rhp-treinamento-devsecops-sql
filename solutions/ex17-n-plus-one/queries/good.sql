SET search_path TO hospital_data, public;

-- Opção A: window function
WITH ranked AS (
    SELECT
        lr.patient_id,
        lr.test_name,
        lr.result_date,
        ROW_NUMBER() OVER (PARTITION BY lr.patient_id ORDER BY lr.result_date DESC) AS rn
    FROM lab_results AS lr
)

SELECT
    p.id,
    r.test_name AS last_test_name
FROM patients AS p
LEFT JOIN ranked AS r ON p.id = r.patient_id AND r.rn = 1
ORDER BY p.id;


