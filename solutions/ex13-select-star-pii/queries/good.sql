SET search_path TO hospital_data, public;

SELECT
    p.id,
    p.department_id,
    a.admitted_at,
    a.discharged_at
FROM patients AS p
INNER JOIN admissions AS a ON p.id = a.patient_id
WHERE a.department_id = 1
ORDER BY a.admitted_at DESC;


