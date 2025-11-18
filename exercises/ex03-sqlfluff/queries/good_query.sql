SELECT
    id,
    full_name,
    department_id
FROM hospital_data.patients
WHERE department_id = 1
ORDER BY id ASC;