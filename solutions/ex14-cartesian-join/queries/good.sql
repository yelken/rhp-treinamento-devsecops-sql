SET search_path TO hospital_data, public;

SELECT COUNT(*)
FROM patients AS p
INNER JOIN admissions AS a ON p.id = a.patient_id
WHERE a.department_id = 1;


