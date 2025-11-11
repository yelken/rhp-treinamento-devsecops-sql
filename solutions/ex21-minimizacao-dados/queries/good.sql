SET search_path TO hospital_data, public;

SELECT
    a.id,
    a.patient_id,
    a.department_id,
    a.admitted_at,
    a.discharged_at
FROM admissions AS a
WHERE
    a.department_id = 1
    AND a.admitted_at >= current_date - INTERVAL '30 days'
ORDER BY
    a.admitted_at DESC;


